# 📊 SQL Analytics Portfolio — Retail Sales Data Warehouse
> **MS SQL Server | Gold Schema | Data Analysis | Window Functions | CTEs**


## 👨‍💻 About This Project

This project showcases **real-world SQL analysis** on a Retail Sales Data Warehouse using **Microsoft SQL Server**.  
The database follows a **Gold Layer schema** (Star Schema) with three core tables:

| Table | Description |
|---|---|
| `gold.dim_customers` | Customer dimension — demographics, geography, marital status |
| `gold.dim_products` | Product dimension — categories, cost, product lines |
| `gold.fact_sales` | Sales fact table — orders, quantities, revenue, dates |

The project is divided into **7 modules**, each focusing on a different analysis domain — from basic aggregations to advanced window functions.

---

## 📁 Project Structure

```
sql-analytics-portfolio/
│
├── 01_customers_project.sql          # Customer dimension analysis
├── 02_product_project.sql            # Product dimension analysis
├── 03_sales_project.sql              # Core sales metrics
├── 04_customer_and_sales_project.sql # Customer + Sales joined analysis
├── 05_product_sales_project.sql      # Product + Sales joined analysis
├── 06_date_and_sales_project.sql     # Time-series & date-based analysis
└── 07_window_functions.sql           # Advanced window function queries
```

---

## 📌 Module Breakdown

---

### 📂 Module 1 — Customer Dimension Analysis
**File:** `01_customers_project.sql`

Exploratory analysis of the customer master data.

| # | Query | Concepts Used |
|---|---|---|
| 1 | Total number of customers | `COUNT(*)` |
| 2 | All unique countries | `DISTINCT` |
| 3 | Customers per country | `GROUP BY`, `COUNT` |
| 4 | Male vs Female customer count | `GROUP BY gender` |
| 5 | Married vs Single count | `GROUP BY marital_status` |
| 6 | Top 10 oldest customers | `ORDER BY birthdate ASC`, `TOP` |
| 7 | Customers born after 1968 | `WHERE`, date filter |
| 8 | Average customer age | `DATEDIFF`, `GETDATE()`, `AVG` |
| 9 | Customers whose name starts with 'A' | `LIKE` pattern matching |
| 10 | Country with maximum customers | `TOP 1`, `ORDER BY COUNT DESC` |

---

### 📂 Module 2 — Product Dimension Analysis
**File:** `02_product_project.sql`

Analysis of the product catalog — categories, pricing, and product lines.

| # | Query | Concepts Used |
|---|---|---|
| 1 | Total number of products | `COUNT(*)` |
| 2 | All product categories | `COUNT(DISTINCT category)` |
| 3 | Products in each category | `GROUP BY category` |
| 4 | Most expensive product | `ORDER BY cost DESC`, `TOP 1` |
| 5 | Least expensive product | `ORDER BY cost ASC`, `TOP 1` |
| 6 | Products requiring maintenance | `WHERE maintenance = 'Yes'` |
| 7 | Products launched after 2010 | `WHERE start_date > '2010-12-31'` |
| 8 | Products per product line | `GROUP BY product_line` |
| 9 | Average product cost | `AVG(cost)` |
| 10 | Category with highest products | `TOP 1`, `ORDER BY COUNT DESC` |

---

### 📂 Module 3 — Core Sales Metrics
**File:** `03_sales_project.sql`

Fundamental KPIs and trend analysis from the fact sales table.

| # | Query | Concepts Used |
|---|---|---|
| 1 | Total sales amount | `SUM(sales_amount)` |
| 2 | Total quantity sold | `SUM(quantity)` |
| 3 | Total number of unique orders | `COUNT(DISTINCT order_number)` |
| 4 | Average sales amount | `AVG(sales_amount)` |
| 5 | Highest single sales amount | `MAX(sales_amount)` |
| 6 | Lowest single sales amount | `MIN(sales_amount)` |
| 7 | Monthly sales trend | `YEAR()`, `MONTH()`, `GROUP BY` |
| 8 | Yearly sales trend | `YEAR()`, `GROUP BY` |
| 9 | Sales for each calendar month | Aggregated by month number |
| 10 | Busiest sales month | `TOP 1`, `ORDER BY monthly_sales DESC` |

---

### 📂 Module 4 — Customer & Sales Analysis (JOIN)
**File:** `04_customer_and_sales_project.sql`

Deep-dive into customer behaviour by joining `dim_customers` with `fact_sales`.

| # | Query | Concepts Used |
|---|---|---|
| 1 | Top 10 customers by total spending | `LEFT JOIN`, `SUM`, `TOP 10` |
| 2 | Customer with maximum orders | `COUNT(order_number)`, `TOP 1` |
| 3 | Average revenue per customer | `AVG(sales_amount)` per customer |
| 4 | Country-wise sales revenue | `GROUP BY country` |
| 5 | Gender-wise sales analysis | `GROUP BY gender` |
| 6 | Married vs Single sales comparison | `GROUP BY marital_status` |
| 7 | Customer who purchased most quantity | `SUM(quantity)`, `TOP 1` |
| 8 | Top spending female customer | `WHERE gender = 'female'`, `TOP 1` |
| 9 | Customers with more than 5 orders | `COUNT(order_number)`, filter |
| 10 | Customer contribution % in total sales | `SUM() OVER()` window function |

---

### 📂 Module 5 — Product & Sales Analysis (JOIN)
**File:** `05_product_sales_project.sql`

Product performance analysis by joining `dim_products` with `fact_sales`.

| # | Query | Concepts Used |
|---|---|---|
| 1 | Top 10 best-selling products | `SUM(quantity)`, `TOP 10` |
| 2 | Least-selling products | `ORDER BY quantity ASC` |
| 3 | Category-wise revenue | `GROUP BY category` |
| 4 | Subcategory-wise revenue | `GROUP BY subcategory` |
| 5 | Total quantity sold per product | `SUM(quantity)` per product |
| 6 | Highest revenue generating category | `TOP 1`, `ORDER BY revenue DESC` |
| 7 | Top 5 products by sales amount | `TOP 5`, `SUM(sales_amount)` |
| 8 | Products never sold | `LEFT JOIN ... WHERE IS NULL` |
| 9 | Average sales per product | `AVG(sales_amount)` per product |
| 10 | Category % contribution to total sales | Subquery for total, division |

---

### 📂 Module 6 — Date & Time-Series Analysis
**File:** `06_date_and_sales_project.sql`

Time-based sales analysis using SQL date functions.

| # | Query | Concepts Used |
|---|---|---|
| 1 | Year-wise total sales | `YEAR()`, `GROUP BY` |
| 2 | Quarter-wise total sales | `DATEPART(QUARTER, ...)` |
| 3 | Month-wise total sales | `MONTH()`, `GROUP BY` |
| 4 | Orders placed on weekends | `DATEPART(WEEKDAY, ...)` |
| 5 | Orders placed in December | `WHERE MONTH() = 12` |
| 6 | First order date | `MIN(order_date)` |
| 7 | Latest order date | `MAX(order_date)` |
| 8 | Average orders per month | `AVG(sales_amount)` per month |
| 9 | Year-over-year sales growth | `CTE` + `LAG()` window function |
| 10 | Running total of sales | `SUM() OVER (ORDER BY order_date)` |

---

### 📂 Module 7 — Advanced Window Functions
**File:** `07_window_functions.sql`

Advanced analytical queries using SQL window functions.

| # | Query | Concepts Used |
|---|---|---|
| 1 | Rank customers by total spending | `RANK() OVER (ORDER BY ...)` |
| 2 | Rank products by revenue | `RANK() OVER (ORDER BY ...)` |
| 3 | Previous month sales | `CTE` + `LAG()` |
| 4 | Next month sales | `CTE` + `LEAD()` |
| 5 | Top 3 products per category | `RANK() OVER (PARTITION BY category)` |
| 6 | Dense rank of countries by sales | `DENSE_RANK()` |
| 7 | Cumulative sales | `SUM() OVER (ORDER BY order_date)` |
| 8 | Moving average of sales (3-month) | `AVG() OVER (ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)` |
| 9 | Customer order sequence number | `RANK() OVER (PARTITION BY customer_id)` |
| 10 | Highest sales product in each year | `RANK() OVER (PARTITION BY order_year)` |

---

## 🛠️ SQL Concepts Covered

| Category | Topics |
|---|---|
| **Aggregations** | `SUM`, `COUNT`, `AVG`, `MIN`, `MAX` |
| **Filtering** | `WHERE`, `LIKE`, `IN`, `IS NULL`, `TOP N` |
| **Grouping** | `GROUP BY`, `HAVING`, `DISTINCT` |
| **Joins** | `LEFT JOIN` across fact and dimension tables |
| **Date Functions** | `YEAR()`, `MONTH()`, `DATEPART()`, `DATEDIFF()`, `GETDATE()` |
| **Window Functions** | `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `LAG()`, `LEAD()`, `SUM() OVER()`, `AVG() OVER()` |
| **CTEs** | `WITH ... AS (...)` for multi-step logic |
| **Subqueries** | Inline and scalar subqueries for percentage calculations |

---

## 🗄️ Schema Overview

```sql
-- Fact Table
gold.fact_sales
  ├── order_number
  ├── customer_key     → FK to dim_customers
  ├── product_key      → FK to dim_products
  ├── order_date
  ├── sales_amount
  └── quantity

-- Dimension: Customers
gold.dim_customers
  ├── customer_key
  ├── customer_id
  ├── first_name / last_name
  ├── gender
  ├── marital_status
  ├── birthdate
  └── country

-- Dimension: Products
gold.dim_products
  ├── product_key
  ├── product_id
  ├── product_name
  ├── category / subcategory
  ├── product_line
  ├── cost
  ├── start_date
  └── maintenance
```

---

## 🚀 How to Use

1. **Clone this repository**
   ```bash
   git clone https://github.com/deepak015/sql-analytics-portfolio.git
   ```

2. **Open in SQL Server Management Studio (SSMS)**

3. **Run files in order** — Modules 1 & 2 are standalone; Modules 3–7 work best after loading sample data.

4. **Explore and modify** — Each query is numbered and commented for easy reading.

---

## 👤 Author

**Deepak Dubey**  
📍 West Bengal, India  
🔗 [GitHub Profile](https://github.com/deepak015?tab=repositories)  
💼 Aspiring SQL Developer & Data Analyst

---

## 📄 License

This project is open-source and free to use for learning and portfolio purposes.

---

> ⭐ *If this project helped you, consider giving it a star on GitHub!*
