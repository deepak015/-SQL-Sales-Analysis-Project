-- 1 Find total number of products.

SELECT
	 COUNT(*) AS TotalProducts
FROM gold.dim_products;

	--2 Find all product categories

	SELECT
		COUNT(DISTINCT category) AS TotalCategories
	FROM gold.dim_products;

	-- 3 Find number of products in each category

	SELECT
	category,
		COUNT(*) AS ProductsInCategory
	FROM gold.dim_products
	GROUP BY category;

	--4 Find most expensive product.

	SELECT TOP 1
		product_name,
		cost
	FROM gold.dim_products
	ORDER BY cost DESC;

	-- 5 Find least expensive product

	SELECT
	 TOP 1
		product_name,
		cost
	FROM gold.dim_products
	ORDER BY cost ASC;

	-- 6 Find products that require maintenance

	SELECT
		product_name,
		maintenance
	FROM gold.dim_products
	WHERE maintenance = 'Yes';

	--7 Find products launched after 2010

	SELECT
		product_name,
		start_date
	FROM gold.dim_products
	where start_date > '2010-12-31';

	-- 8 Find total products in each product line

	SELECT
	product_line,
		COUNT(*) AS TotalProductsInLine
	FROM gold.dim_products
	GROUP BY product_line;

	--9 Find average product cost.
	SELECT
		AVG(cost) AS AverageProductCost
	FROM gold.dim_products;

	-- 10 Find category with highest products

	SELECT TOP 1
	category,
		COUNT(*) AS ProductsInCategory
	FROM gold.dim_products
	GROUP BY category
	ORDER BY ProductsInCategory DESC;









	