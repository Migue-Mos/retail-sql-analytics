-- =========================================
-- 03_kpis.sql
-- Business KPIs and exploratory analysis
-- =========================================

-- 1. TOTAL REVENUE

SELECT
ROUND(SUM(quantity * price), 2) AS total_revenue
FROM sales;

-- 2. TOTAL ORDERS

SELECT
COUNT(DISTINCT invoice_no) AS total_orders
FROM sales;

-- 3. TOTAL CUSTOMERS

SELECT
COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

-- 4. AVERAGE ORDER VALUE

SELECT
ROUND(
SUM(quantity * price) /
COUNT(DISTINCT invoice_no),
2
) AS average_order_value
FROM sales;

-- 5. REVENUE BY COUNTRY

SELECT
c.country,
ROUND(SUM(s.quantity * s.price), 2) AS revenue
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.country
ORDER BY revenue DESC;

-- 6. TOP 10 PRODUCTS BY REVENUE

SELECT
p.product_name,
ROUND(SUM(s.quantity * s.price), 2) AS revenue
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 10;

-- 7. MONTHLY REVENUE TREND

SELECT
strftime('%Y-%m', sale_date) AS month,
ROUND(SUM(quantity * price), 2) AS revenue
FROM sales
GROUP BY month
ORDER BY month;

-- 8. BEST CUSTOMERS BY SPENDING

SELECT
customer_id,
ROUND(SUM(quantity * price), 2) AS total_spent
FROM sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;