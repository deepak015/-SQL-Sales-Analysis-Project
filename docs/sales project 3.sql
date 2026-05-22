-- 1 Find total sales amount.
	
	SELECT
		SUM(sales_amount) AS total_sales_amount
	FROM
		gold.fact_sales;

	-- 2 Find total quantity sold

	SELECT
		SUM(quantity) AS total_quantity_sold
	FROM
		gold.fact_sales;

	-- 3 Find total number of orders.

	SELECT
		COUNT(DISTINCT order_number) AS total_orders
	FROM
		gold.fact_sales;

	-- 4 Find average sales amount

	SELECT
		AVG(sales_amount) AS average_sales_amount
	FROM
		gold.fact_sales;

	-- 5 Find highest sales amount.

	SELECT
		MAX(sales_amount) AS highest_sales_amount
	FROM
		gold.fact_sales;

	--6 Find lowest sales amount.

	SELECT
		MIN(sales_amount) AS lowest_sales_amount
	FROM
		gold.fact_sales;

	-- 7 Find monthly sales trend.

	SELECT
		YEAR(order_date) as sales_year,
		MONTH(order_date) as sales_month,
		SUM(sales_amount) AS monthly_sales
	FROM
		gold.fact_sales
	GROUP BY
		YEAR(order_date),
		MONTH(order_date)
	ORDER BY
	sales_year,
		sales_month;

	-- 8 Find yearly sales trend.

	SELECT
		YEAR(order_date) as sales_year,
		SUM(sales_amount) AS yearly_sales
	FROM
		gold.fact_sales
	GROUP BY
		YEAR(order_date)
	ORDER BY
		sales_year;

	-- 9 Find sales for each month.

	SELECT
		MONTH(order_date) as sales_month,
		SUM(sales_amount) AS monthly_sales
	FROM
 		gold.fact_sales
	GROUP BY
		MONTH(order_date)
	ORDER BY
		sales_month;

	-- 10 Find busiest sales month.

	SELECT
	TOP 1
		MONTH(order_date) as sales_month,
		SUM(sales_amount) AS monthly_sales
	FROM
		gold.fact_sales
	GROUP BY
		MONTH(order_date)
	ORDER BY
		monthly_sales DESC;