---------------------------------------------------
-- change over time

-- Q1) For each month in the dataset, count how many new customers created their accounts. 
-- Return the year-month and the count of customers, ordered chronologically.

select to_char(acc_created, 'yyyy-mm') as year_month, count(*) from gold.dim_customers dc
where to_char(acc_created, 'yyyy-mm') is not null
group by 1;

-- Q2) Calculate the month-over-month percentage change in total sales. 
-- Return the year-month, total sales, and percent change from the previous month. 
-- Exclude the first month (no prior for comparison).
with cte as(
select year_month, total_sales,
lag(total_sales) over (order by year_month) as prev_month_sales from
(
select to_char(order_date, 'yyyy-mm') as year_month, sum(sales_amount) as total_sales 
from gold.fact_sales
group by 1
) as monthly_sales 
)
select year_month, total_sales, 
round(((total_sales - prev_month_sales)/nullif(prev_month_sales,0))*100, 2) as percent_change
from cte
WHERE prev_month_sales IS NOT NULL
ORDER BY year_month;


--  q3) Identify products launched in the last 6 months of the dataset. 
-- For each, calculate the total sales amount they generated in their first 30 days after launch. 
-- List product name, launch date, and 30-day sales.
select dp.product_name, dp.start_date, coalesce(sum(fs.sales_amount),0) as total_sales_30_days
from gold.dim_products dp 
left join gold.fact_sales fs on dp.product_key = fs.product_key
and fs.order_date>=dp.start_date and fs.order_date < dp.start_date + '30 days'
where dp.start_date >=
(
select max(dp.start_date) - interval '6 Months' from gold.dim_products dp
) 
group by 1,2
order by 3 desc


-- q4) For each customer who made a purchase, calculate:
-- First purchase date
-- Second purchase date (if any) 
-- Number of days between first and second purchase

with cte as(
select dc.customer_key as customer_key, fs.order_date as order_date,
lead(order_date) over (partition by dc.customer_key order by fs.order_date) as second_order,
row_number() over (partition by dc.customer_key order by fs.order_date) as rn
from gold.dim_customers dc
left join gold.fact_sales fs on dc.customer_key = fs.customer_key
group by 1,2
order by 1,2
)
SELECT 
  customer_key, order_date, second_order,
  second_order - order_date as days_between_next_purchase
  from cte
  where second_order is not null and rn = 1
