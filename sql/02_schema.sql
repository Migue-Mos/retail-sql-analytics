-- =========================================
-- 02_schema.sql
-- Create relational schema from cleaned data
-- =========================================

-- 1. CUSTOMERS TABLE

DROP TABLE IF EXISTS customers;

CREATE TABLE customers AS
SELECT DISTINCT
    CustomerID as customer_id,
    Country as country
FROM retail_final;

-- 2. PRODUCTS TABLE

DROP TABLE IF EXISTS products;

CREATE TABLE products AS
SELECT DISTINCT
    StockCode AS product_id,
    Description AS product_name
FROM retail_final;

-- 3. SALES TABLE (FACT TABLE)
DROP TABLE IF EXISTS sales;

CREATE TABLE sales AS
SELECT
    ROW_NUMBER() OVER() AS sale_id,
    CustomerID AS customer_id,
    StockCode AS product_id,
    Quantity AS quantity,
    UnitPrice AS price,
    InvoiceDate AS sale_date,
    InvoiceNo AS invoice_no
FROM retail_final;

-- 4. OPTIONAL: CREATE INDEXES (performance)

CREATE INDEX idx_sales_customer ON sales(customer_id);
CREATE INDEX idx_sales_product ON sales(product_id);

-- 5. VALIDATION QUERIES
-- total sales rows
SELECT COUNT(*) AS total_sales FROM sales;
-- total unique customers
SELECT COUNT(DISTINCT customer_id) FROM customers;
-- total unique products
SELECT COUNT(DISTINCT product_id) FROM products;