-- ============================================================
--  PROJECT  : Customer Dimension Analysis
--  DATABASE : Microsoft SQL Server (gold schema)
--  TABLE    : gold.dim_customers
--  AUTHOR   : https://github.com/deepak015?tab=repositories
--  DATE     : May 2026
-- ============================================================
-- ============================================================
------ 1 Find total number of customers
-- ============================================================

SELECT 
	COUNT(*) as Total_Customers
FROM gold.dim_customers

-- ============================================================
-- 2 Show all unique customer countries
-- ============================================================

SELECT
	DISTINCT country
from gold.dim_customers

-- ============================================================
-- 3 Find number of customers in each country
-- ============================================================

SELECT
	country,
	COUNT(*) AS Total_Customers
from gold.dim_customers
GROUP BY country

-- ============================================================
-- 4 Find male and female customer count
-- ============================================================

SELECT
	gender,
	COUNT(*) as Total_Customers
FROM gold.dim_customers
GROUP BY gender

-- ============================================================
-- 5 Find married and single customers count.
-- ============================================================

SELECT
	marital_status,
	COUNT(*) as Total_Customers
FROM gold.dim_customers
GROUP BY marital_status

-- ============================================================
-- 6 Find top 10 oldest customers.
-- ============================================================

SELECT
TOP 10
	customer_id,
	first_name,
	last_name,
	birthdate
FROM gold.dim_customers
WHERE birthdate IS NOT NULL
order by birthdate ASC

-- ============================================================
-- 7 Find customers born after 1968.
-- ============================================================

SELECT
	customer_id,
	first_name,
	last_name,
	birthdate
FROM gold.dim_customers
WHERE birthdate > '1968'

-- ============================================================
--8 Find average customer age
-- ============================================================

SELECT
	first_name,
	last_name,
	AVG(DATEDIFF(year,birthdate, GETDATE())) as Average_Age
FROM gold.dim_customers
WHERE birthdate IS NOT NULL
GROUP BY first_name,
last_name

-- ============================================================
-- 9 Find customers whose first name starts with 'A'
-- ============================================================

SELECT
	first_name
FROM gold.dim_customers
WHERE first_name LIKE 'A%'

-- ============================================================
--10 Find country having maximum customers
-- ============================================================

SELECT
TOP 1
	country,
	COUNT(*) as total_customers
FROM gold.dim_customers
GROUP by country
ORDER BY COUNT(*) desc


