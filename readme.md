# Retail SQL Analytics

## Project Overview

This project analyzes transactional retail data using SQL and Python to uncover key business insights related to revenue, customer behavior, and product performance.

The workflow includes:

- Data ingestion from Excel files
- Data cleaning and transformation
- Relational schema creation
- SQL-based business analysis
- Data visualization in Jupyter Notebook

The goal of the project is to simulate a real-world analytics workflow using a reproducible data pipeline and structured SQL analysis.

---

## Dataset

The dataset used in this project is the **Online Retail Dataset**, containing transactional data from a UK-based online retailer.

The dataset includes:

- Customer purchases
- Product information
- Invoice data
- Transaction timestamps
- Geographic information

---

## Tech Stack

- **Python**
  - pandas
  - sqlite3
  - matplotlib

- **SQL**
  - SQLite
  - JOINs
  - Aggregations
  - Window Functions

- **Jupyter Notebook**
  - Exploratory analysis
  - Visualizations
  - Business insights

---

## Project Structure

```text
retail-sql-analytics/
│
├── data/
│   └── raw/
│       └── Online Retail.xlsx
│
├── docs/
│   ├── Monthly Revenue Trend.png
│   ├── Top 10 Customers by Spending.png
│   └── Top 10 Products by Revenue.png
│
├── notebooks/
│   └── analysis.ipynb
│
├── scripts/
│   └── load_and_clean.py
│
├── sql/
│   ├── 01_cleaning.sql
│   ├── 02_schema.sql
│   ├── 03_kpis.sql
│   └── 04_ranking.sql
│
├── retail.db
│
├── requirements.txt
│
└── README.md
```

## Data Cleaning Pipeline

The ETL pipeline was built using Python and SQLite.

Main cleaning steps included:

- Removing returns and invalid transactions
- Filtering null customer IDs
- Removing duplicate records
- Creating clean analytical tables

The pipeline automatically:

1. Loads the raw Excel dataset
2. Cleans the data
3. Creates a relational schema
4. Stores the processed data in SQLite
5. Relational Schema

---

The cleaned dataset was transformed into a relational model composed of:

- customers
- products
- sales

This structure allows for more efficient analytical queries and business reporting.

---

## SQL Analysis

The project includes multiple SQL analysis files covering:

## KPI Analysis
- Total revenue
- Total orders
- Average order value
- Revenue trends
## Ranking Analysis
- Top customers
- Top products
- Revenue contribution analysis

---

### Visualizations

The analysis notebook includes visualizations such as:

- Monthly revenue trends
- Top-performing products
- Customer spending distribution

These visualizations help transform raw SQL outputs into actionable business insights.

---

## Key Insights

Some of the main findings from the analysis include:

- Revenue is highly concentrated among a relatively small group of customers.
- A limited number of products generate a significant share of total revenue.
- Monthly sales patterns suggest possible seasonality effects.
- Ranking analysis highlights the importance of high-value customers and best-selling products.

--- 

## How to Run
1. Clone the repository
git clone <your-repository-url>

2. Install dependencies
pip install -r requirements.txt

3. Run the data pipeline
python scripts/load_and_clean.py

4. Open the notebook
Launch Jupyter Notebook and open:

notebooks/analysis.ipynb


---

## Future Improvements
- Interactive dashboards (Power BI / Tableau)
- Customer segmentation analysis
- Cohort retention analysis
- Advanced forecasting models

## Key Results

- Identified revenue concentration in top customers
- Analyzed product-level performance
- Built full ETL + analytics pipeline using SQL + Python