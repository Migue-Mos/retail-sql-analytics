-- =========================================
-- 04_ranking.sql
-- Ranking analysis using window functions
-- =========================================

-- Top customers ranked by total spend

SELECT
    customer_id,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS rank_position
FROM (
    SELECT
        customer_id,
        SUM(quantity * price) AS total_spent
    FROM sales
    GROUP BY customer_id
);

-- top products ranked
SELECT
    product_id,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS rank_position
FROM (
    SELECT
        product_id,
        SUM(quantity * price) AS total_revenue
    FROM sales
    GROUP BY product_id
);

-- Dense rank example (handles ties differently)

SELECT
    product_id,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS dense_rank_position
FROM (
    SELECT
        product_id,
        SUM(quantity * price) AS total_revenue
    FROM sales
    GROUP BY product_id
);

-- Top 10 products by revenue

SELECT
    product_id,
    total_revenue
FROM (
    SELECT
        product_id,
        SUM(quantity * price) AS total_revenue
    FROM sales
    GROUP BY product_id
)
ORDER BY total_revenue DESC
LIMIT 10;

-- Percentage contribution of each customer to total revenue

WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(quantity * price) AS total_spent
    FROM sales
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_spent,
    ROUND(
        100.0 * total_spent / SUM(total_spent) OVER(),
        2
    ) AS revenue_percentage
FROM customer_revenue
ORDER BY total_spent DESC;