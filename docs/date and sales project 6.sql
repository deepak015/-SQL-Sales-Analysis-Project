-- 1 Find total sales year-wise.

	SELECT
		YEAR(order_date) AS SalesYear,
		SUM(sales_amount) AS TotalSales
	FROM
		gold.fact_sales
	GROUP BY
		YEAR(order_date)
	ORDER BY
		SalesYear;

	-- 2 Find total sales quarter-wise.

	SELECT
		YEAR(order_date) AS SalesYear,
		DATEPART(QUARTER, order_date) AS SalesQuarter,
		SUM(sales_amount) AS TotalSales
	FROM
		gold.fact_sales
	GROUP BY
		YEAR(order_date),
		DATEPART(QUARTER, order_date)
	ORDER BY
		SalesYear,
		SalesQuarter;

		-- 3 Find total sales month-wise.

		SELECT
			YEAR(order_date) AS SalesYear,
			MONTH(order_date) AS SalesMonth,
			SUM(sales_amount) AS TotalSales
		FROM
			gold.fact_sales
		GROUP BY
			YEAR(order_date),
			MONTH(order_date)
		ORDER BY
			SalesYear,
			SalesMonth;

		--4 Find orders placed on weekends

		SELECT
			YEAR(order_date) AS SalesYear,
			DATEPART(WEEKDAY, order_date) AS Weekday,
			SUM(sales_amount) AS TotalSales
		FROM
			gold.fact_sales
		WHERE
			DATEPART(WEEKDAY, order_date) IN (1, 7) -- Assuming 1 = Sunday and 7 = Saturday
		GROUP BY
			YEAR(order_date),
			DATEPART(WEEKDAY, order_date)
		ORDER BY
			SalesYear,
			Weekday;

		-- 5 Find orders placed in December.
	
		SELECT
			YEAR(order_date) AS SalesYear,
			MONTH(order_date) AS SalesMonth,
			SUM(sales_amount) AS TotalSales
		FROM
			gold.fact_sales
		WHERE
			MONTH(order_date) = 12
		GROUP BY
			YEAR(order_date),
			MONTH(order_date)
		ORDER BY
			SalesYear,
			SalesMonth;

		-- 6 Find first order date.

		SELECT
			MIN(order_date) AS FirstOrderDate
		FROM
			gold.fact_sales;
		
	-- 7 Find latest order date.

	SELECT
			MAX(order_date) AS LatestOrderDate
		FROM
			gold.fact_sales;

	-- 8 Find average orders per month

	SELECT
		YEAR(order_date) AS SalesYear,
		MONTH(order_date) AS SalesMonth,
		AVG(sales_amount) AS AverageSales
	FROM
		gold.fact_sales
	GROUP BY
		YEAR(order_date),
		MONTH(order_date)	
	ORDER BY
		SalesYear,
		SalesMonth;

	-- 9 Find sales growth year by year

	WITH YearlySales AS (
	SELECT 
		YEAR(order_date) AS SalesYear,
		SUM(sales_amount) AS TotalSales
	FROM 
		gold.fact_sales
	GROUP BY 
		YEAR(order_date)
	)

	SELECT
		SalesYear,
		TotalSales,
		LAG(TotalSales) OVER (ORDER BY SalesYear) AS PreviousYearSales,
		TotalSales- LAG(TotalSales) OVER (ORDER BY SalesYear) AS SalesGrowth,
		ROUND(
			((LAG(TotalSales) OVER (ORDER BY SalesYear)) * 100.)/ Lag(TotalSales) OVER (ORDER BY SalesYear),2 ) AS SalesGrowthPercentage
		FROM
			YearlySales 
		
	--	10 Find running total of sales.
		
		SELECT
		order_date,
			sales_amount,
			SUM(sales_amount) OVER (ORDER BY order_date) AS RunningTotal
		FROM
			gold.fact_sales