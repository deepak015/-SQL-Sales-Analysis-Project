-- 1 Rank customers based on total spending.

	SELECT
		customer_id,
		first_name,
		SUM(sales_amount) AS total_spending,
		RANK() OVER (ORDER BY SUM(sales_amount) DESC) AS spending_rank
	FROM 	
		gold.fact_sales fs
	LEFT JOIN 
		gold.dim_customers dc ON fs.customer_key = dc.customer_key
	GROUP BY 
		customer_id,
		first_name

	-- 2 Rank products based on revenue.

	SELECT
		product_id,
		product_name,
		SUM(sales_amount) AS total_revenue,
		RANK() OVER (ORDER BY SUM(sales_amount) DESC) AS revenue_rank
	FROM 	
		gold.fact_sales fs
	LEFT JOIN 
		gold.dim_products dc ON fs.customer_key = dc.product_key
	GROUP BY 
		product_id,
		product_name	
		
	-- 3 Find previous month sales using 
		
	
	WITH PreviousMonthSales AS (
		SELECT
			YEAR(order_date) AS order_year,
			MONTH(order_date) AS order_month,
			SUM(sales_amount) AS total_sales
		FROM 	
			gold.fact_sales
		GROUP BY 
			YEAR(order_date),
			MONTH(order_date)
			)

			SELECT
				order_year
				order_month,
				total_sales,
				LAG(total_sales) OVER (ORDER BY order_year, order_month) AS previous_month_sales
			FROM 
				PreviousMonthSales

		-- 4 Find next month sales using LEAD().
	
		WITH NextMonthSales AS (
		SELECT
			YEAR(order_date) AS order_year,
			MONTH(order_date) AS order_month,
			SUM(sales_amount) AS total_sales
		FROM 	
			gold.fact_sales
		GROUP BY 
			YEAR(order_date),
			MONTH(order_date)
			)

		SELECT
			order_year,
			order_month,
			total_sales,
			LEAD(total_sales) OVER (ORDER BY order_year, order_month) AS next_month_sales
		FROM 
			NextMonthSales

	-- 5 Find top 3 products in each category.

	WITH RankedProducts AS (
		SELECT
		product_id,
		category,
		product_name,
		SUM(sales_amount) AS total_revenue
	FROM 
		gold.fact_sales fs
	LEFT JOIN 
		gold.dim_products dp ON fs.product_key = dp.product_key
	GROUP BY 
		product_id,
		category,
		product_name
		)
	,products_with_rank AS (
	SELECT
		product_id,
		category,
		product_name,
		total_revenue,
		RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS category_rank
	FROM 
		RankedProducts)
		
		SELECT *
		FROM products_with_rank
		WHERE category_rank <= 3

	-- 6 Find dense rank of countries by sales.

		WITH CountrySales AS (
		SELECT
			country,
			SUM(sales_amount) AS total_sales
		FROM 
			gold.fact_sales fs
		LEFT JOIN
			gold.dim_customers dc ON fs.customer_key = dc.customer_key
		GROUP BY 
			country
		)

		SELECT
			country,
			total_sales,
			DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
		FROM 
			CountrySales

	 -- 7 Find cumulative sales using SUM() OVER().

		SELECT
			order_date,
			SUM(sales_amount) AS daily_sales,
			SUM(SUM(sales_amount)) OVER (ORDER BY order_date) AS cumulative_sales
		FROM 
			gold.fact_sales
		GROUP BY 
			order_date
		
	-- 8 Find moving average of sales.

		WITH DailySales AS (
		SELECT
			YEAR(order_date) AS order_year,
			MONTH(order_date) AS order_month,
			SUM(sales_amount) AS total_sales
		FROM
			gold.fact_sales
		GROUP BY 
			YEAR(order_date),
			MONTH(order_date)
			)

		SELECT
			order_year,
			order_month,
			total_sales,
			AVG(total_sales) OVER (ORDER BY order_year, order_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average
		FROM 
			DailySales

		-- 8 Find customer order sequence number

		SELECT
			customer_id,
			order_number,
			RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_sequence
		FROM 
			gold.fact_sales fs
			LEFT JOIN
				gold.dim_customers dc ON fs.customer_key = dc.customer_key
		GROUP BY 
			customer_id,
			order_number,
			order_date

		-- 10 Find highest sales in each year

		WITH YearlyProductSales AS (
		SELECT
			YEAR(order_date) AS order_year,
			product_key,
			SUM(sales_amount) AS highest_sales
			FROM 
				gold.fact_sales
			GROUP BY
				YEAR(order_date),
				product_key
				)
		, RankedYearlySales AS (
			SELECT
				order_year,
				product_key,
				highest_sales,
				RANK() OVER (PARTITION BY order_year ORDER BY highest_sales DESC) AS sales_rank
			FROM 
				YearlyProductSales
				)

			SELECT * 
				FROM RankedYearlySales
				WHERE sales_rank = 1