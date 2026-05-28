-- =========================================
-- 01_cleaning.sql
-- Cleaning the retail dataset by removing invalid records and duplicates.
-- =========================================
-- Objective::
-- Create a clean table by removing invalid records and duplicates:
-- - returns (quantity < 0)
-- - invalid prices
-- - null customers
-- - possible duplicates

-- 1. Create clean table

DROP TABLE IF EXISTS retail_clean;

CREATE TABLE retail_clean AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM retail
WHERE
    Quantity > 0
    AND UnitPrice > 0
    AND CustomerID IS NOT NULL;

-- 2. Eliminate duplicates (optional but recommended)

-- Note: depends on the SQL engine
-- Generic example using ROW_NUMBER

DROP TABLE IF EXISTS retail_clean_dedup;

CREATE TABLE retail_clean_dedup AS
SELECT *
FROM (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY InvoiceNo, StockCode, Quantity, UnitPrice, CustomerID
            ORDER BY InvoiceDate
        ) AS rn
    FROM retail_clean
) t
WHERE rn = 1;

-- 3. Save final cleaned data to a new table

DROP TABLE IF EXISTS retail_final;

CREATE TABLE retail_final AS
SELECT *
FROM retail_clean_dedup;