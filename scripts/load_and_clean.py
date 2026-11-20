# load_and_clean.py

import pandas as pd
import sqlite3
from pathlib import Path

# -----------------------------------------

# 1. Paths

# -----------------------------------------

BASE_DIR = Path(__file__).resolve().parent.parent

DATA_PATH = BASE_DIR / "data" / "raw" / "online_retail_II.xlsx"
DB_PATH = BASE_DIR / "retail.db"
SQL_PATH = BASE_DIR / "sql" / "01_cleaning.sql"

# -----------------------------------------

# 2. Load Excel

# -----------------------------------------

print("Loading Excel file...")
sheets = pd.read_excel(DATA_PATH, sheet_name=None)
df = pd.concat(sheets.values(), ignore_index=True)


# -----------------------------------------

# 3. Basic Cleaning in Python

# -----------------------------------------

print("Initial cleaning...")

# Column names may have leading/trailing spaces, so we strip them
df.columns = df.columns.str.strip()

# If the column "Customer ID" exists and "CustomerID" does not, rename it
if "Customer ID" in df.columns and "CustomerID" not in df.columns:
    df = df.rename(columns={"Customer ID": "CustomerID"})
# Drop rows without customer

df = df.dropna(subset=["CustomerID"])


# Fix data types

df["CustomerID"] = df["CustomerID"].astype(int)

# Convert date

df["InvoiceDate"] = pd.to_datetime(df["InvoiceDate"])

# -----------------------------------------

# 4. Load into SQLite

# -----------------------------------------

print("Loading data into SQLite...")

conn = sqlite3.connect(DB_PATH)

df.to_sql("retail", conn, if_exists="replace", index=False)

# -----------------------------------------

# 5. Execute SQL Cleaning

# -----------------------------------------

print("Running SQL cleaning script...")

with open(BASE_DIR / "sql" / "01_cleaning.sql", "r") as file:
    sql_script = file.read()

try:
    conn.executescript(sql_script)
    print("SQL executed successfully.")
except Exception as e:
    print("Error in SQL:", e)
# -----------------------------------------

# 6. Validation

# -----------------------------------------
# check tables

# validation
result = pd.read_sql("SELECT COUNT(*) as rows FROM retail_final", conn)
print(result)

# schema
with open("sql/02_schema.sql", "r") as file:
    schema_sql = file.read()
conn.executescript(schema_sql)


# check tables
tables = pd.read_sql(
    "SELECT name FROM sqlite_master WHERE type='table';",
    conn
)

print(tables)


print("Pipeline finished successfully.")

with open(BASE_DIR / "sql" / "02_schema.sql", "r") as file:
    schema_sql = file.read()

conn.executescript(schema_sql)

pd.read_sql("SELECT name FROM sqlite_master WHERE type='table';", conn)

conn.close()
