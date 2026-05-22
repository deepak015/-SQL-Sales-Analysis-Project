-- 1 Find top 10 best-selling products.

	SELECT 
		TOP 10
		p.product_id,
		p.product_name,
		SUM(o.quantity) AS best_selling_product
	FROM gold.dim_products p 
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	GROUP BY p.product_id,
			p.product_name 
		ORDER BY best_selling_product desc

	-- 2 Find least-selling products.

		SELECT 
		TOP 10
		p.product_id,
		p.product_name,
		SUM(o.quantity) AS least_selling_product 
	FROM gold.dim_products p 
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	GROUP BY p.product_id,
			p.product_name 
		ORDER BY least_selling_product asc

	-- 3 Find category-wise revenue

	SELECT
		p.category,
		SUM(o.sales_amount) category_wise_revenue
	FROM gold.dim_products p 
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	GROUP BY p.category
		ORDER BY category_wise_revenue desc

	-- 4 Find subcategory-wise revenue

	SELECT
		p.subcategory,
		SUM(o.sales_amount) category_wise_revenue
	FROM gold.dim_products p 
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	GROUP BY p.subcategory
		ORDER BY category_wise_revenue desc

	-- 5 Find total quantity sold for each product

	SELECT
		p.product_id,
		p.product_name,
		SUM(o.quantity) total_quantity_sold
	FROM gold.dim_products p
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	GROUP BY p.product_id,
			p.product_name
		ORDER BY total_quantity_sold desc

	-- 6 Find highest revenue generating category.

	SELECT
		p.category,
		SUM(o.sales_amount) category_wise_revenue
	FROM gold.dim_products p
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	GROUP BY p.category
		ORDER BY category_wise_revenue desc

	-- 7 Find top 5 products by sales amount.

	SELECT
		TOP 5
		p.product_name,
		SUM(o.sales_amount) total_sales_amount
	FROM gold.dim_products p
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	GROUP BY p.product_name
	ORDER BY total_sales_amount desc

	-- 8 Find products never sold

	SELECT
		p.product_name
	FROM gold.dim_products p
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	WHERE o.product_key IS NULL

	-- 9 Find average sales per product

	SELECT
		p.product_name,
		AVG(o.sales_amount) average_sales_per_product
	FROM gold.dim_products p
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	GROUP BY p.product_name
	ORDER BY average_sales_per_product desc

	-- 10 Find percentage contribution of each category in total sales.

	SELECT 
		p.category,
		SUM(o.sales_amount) category_sales,
		SUM(o.sales_amount) * 100.0 / (SELECT SUM(sales_amount) FROM gold.fact_sales) AS percentage_contribution
		FROM 
			gold.dim_products p
	LEFT JOIN 
		gold.fact_sales  o on p.product_key=o.product_key
	GROUP BY p.category
	ORDER BY percentage_contribution desc