-- cumulative analysis

-- q1) For each month, show the total number of customers who had created accounts up to and including that month 
with cte as (
	select 
	to_char(acc_created, 'yyyy-mm') as year_month, 
	count(customer_id) as new_customers
	from gold.dim_customers dc
	group by 1
	order by 1
)
select *,
sum(new_customers) over (order by year_month) as total_customers
from cte
where year_month is not null

-- q2) For each year-month, calculate:
-- Total sales in that month and Cumulative sales till that month 
with cte as(
	select 
	to_char(order_date, 'yyyy-mm') as order_date, sum(sales_amount) as new_sales
	from gold.fact_sales fs
	group by 1
	order by 1
)
select *, 
sum(new_sales) over (order by order_date) as total_sales
from cte

-- q3) For each product, compute the running total of quantity sold, ordered by order date.
-- Show product name, order date, quantity sold on that day, and cumulative quantity.

with cte as(
	select 
	dp.product_name as product_name, 
	fs.order_date as order_date, 
	sum(quantity) as new_sold from gold.dim_products dp 
	left join 
		gold.fact_sales fs on dp.product_key = fs.product_key 
	group by 1,2
	order by 1,2
)
select *, sum(new_sold) over (partition by product_name order by order_date) as total_sales
from cte
order by 1,2


-- q4) Calculate total sales per customer and assign them a rank based on cumulative sales in descending order.
-- Return customer name, total sales, and rank.
with cte as
(
	select 
	dc.customer_key, 
	dc.firstname, 
	dc.lastname,
	sum(fs.sales_amount) as total_spent
	from gold.dim_customers dc
	left join 
		gold.fact_sales fs on dc.customer_key = fs.customer_key
	group by 1,2,3
	having sum(fs.sales_amount) is not null
	order by 1
)
select *, rank() over (order by total_spent desc) as rank from cte
order by rank

-- For each product, calculate cumulative sales ordered by date.
-- Identify the first date when the cumulative sales exceeded 1,000 units.
-- Return product name, first date that goal was crossed, and cumulative sales on that date.
with cte3 as
(
with cte2 as
(
with cte as
(
	select 
	dp.product_name as product_name,
	fs.order_date as order_date, 
	sum(quantity) as new_sold from gold.dim_products dp 
	left join 
		gold.fact_sales fs on dp.product_key = fs.product_key 
	group by 1,2
	order by 1,2
)
	select 
	*, 
	sum(new_sold) over (partition by product_name order by order_date) as total_sales
	from cte
	order by 1,2
)
	select 
	distinct product_name, 
	order_date, total_sales,
	rank() over (partition by product_name order by total_sales) as rank
	from cte2
	where total_sales > 1000
	group by 1,2,3
)
select product_name, order_date, total_sales from cte3
where rank=1
