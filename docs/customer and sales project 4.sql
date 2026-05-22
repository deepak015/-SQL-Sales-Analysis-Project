-- 1 Find top 10 customers by total spending.

	SELECT
		TOP 10
		c.customer_id,
		c.first_name,
		c.last_name,
		SUM(o.sales_amount) AS total_spending
	FROM
		gold.dim_customers c
	LEFT JOIN
		gold.fact_sales o ON c.customer_id = o.customer_key
	GROUP BY
		c.customer_id,
		c.first_name,
		c.last_name
	ORDER BY
		total_spending DESC;

	-- 2 Find customers who placed maximum orders

	SELECT top 1
		c.customer_id,
		c.first_name,
		COUNT(o.order_number) AS max_orders
	FROM
		gold.dim_customers c
	LEFT JOIN
		gold.fact_sales o ON c.customer_id = o.customer_key
	GROUP BY
		c.customer_id,
		c.first_name
	ORDER BY
		max_orders DESC

	-- 3 Find average revenue per customer.
	SELECT
		c.customer_id,
		c.first_name,
		AVG(o.sales_amount) AS avg_revenue
	FROM
		gold.dim_customers c
	LEFT JOIN
		gold.fact_sales o ON c.customer_id = o.customer_key
	GROUP BY
		c.customer_id,
		c.first_name
	ORDER BY
		avg_revenue DESC;

	-- 4 Find country-wise sales revenue.
	SELECT
		c.country,
		SUM(o.sales_amount) AS country_sales_revenue
	FROM
		gold.dim_customers c
	LEFT JOIN
		gold.fact_sales o ON c.customer_id = o.customer_key
	GROUP BY
		c.country
	ORDER BY
		country_sales_revenue DESC;

	-- 5 Find gender-wise sales analysis
	SELECT
		c.gender,
		SUM(o.sales_amount) AS gender_wise_sales
	FROM
		gold.dim_customers c
	LEFT JOIN
		gold.fact_sales o ON c.customer_id = o.customer_key
	GROUP BY
		c.gender
	ORDER by 
		gender_wise_sales desc;

	-- 6 Find married vs single customer sales

	SELECT
		c.marital_status,
		SUM(o.sales_amount) AS marital_status_sales
	FROM
		gold.dim_customers c
	LEFT JOIN
		gold.fact_sales o ON c.customer_id = o.customer_key
	GROUP BY
		c.marital_status
	ORDER BY
		marital_status_sales DESC;

	-- 7 Find customers who purchased most quantity
	
	SELECT top 1
		c.customer_id,
		c.first_name,
		SUM(o.quantity) AS total_quantity
	FROM
		gold.dim_customers c
	LEFT JOIN
		gold.fact_sales o ON c.customer_id = o.customer_key
	GROUP BY
		c.customer_id,
		c.first_name
	ORDER BY
		total_quantity DESC;

	-- 8 Find top spending female customers.

		SELECT 
			TOP 1
			c.customer_key,
			c.first_name,
			c.gender,
			SUM(o.sales_amount) AS total_spending
		FROM
			gold.dim_customers c
		LEFT JOIN
			gold.fact_sales o ON c.customer_id = o.customer_key
		WHERE c.gender ='female'
		GROUP BY c.customer_key,c.gender,c.first_name
		ORDER BY total_spending DESC;

	-- 9 Find customers with more than 5 orders

		SELECT 
			TOP 5
			c.customer_id,
			c.first_name,
			COUNT(o.order_number) AS total_orders
		FROM
			gold.dim_customers c
		LEFT JOIN
			gold.fact_sales o ON c.customer_id = o.customer_key
		GROUP BY
			c.customer_id,
			c.first_name
		ORDER BY
			total_orders DESC

		-- 10 Find customer contribution percentage in total sales.
		
		SELECT
			c.customer_id,
			c.first_name,
			SUM(o.sales_amount) AS customer_sales,
			ROUND
				(
				(SUM(o.sales_amount) *100.0 / SUM(SUM(o.sales_amount)) OVER ()) ,2) AS contribution_percentage
			FROM
				gold.dim_customers c
			LEFT JOIN
				gold.fact_sales o ON c.customer_id = o.customer_key
			GROUP BY
				c.customer_id,
				c.first_name
			ORDER BY
				contribution_percentage DESC;