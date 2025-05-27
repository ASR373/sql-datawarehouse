select * from information_schema.tables
where table_schema in ('gold', 'silver', 'bronze');


select distinct country from gold.dim_customers;

select distinct category, subcategory, product_name from gold.dim_products 
order by 1, 2,3;

-- first and last order dates, and difference in months
select
    min(order_date) as first_order_date,
    max(order_date) as last_order_date,
    extract(year from age(max(order_date), min(order_date))) * 12 + extract(month from age(max(order_date), min(order_date))) as order_range_months
from gold.fact_sales;

-- oldest and youngest customer birthdates
select
    min(birth_date) as oldest_birthdate,
    max(birth_date) as youngest_birthdate,
    date_part('year', age(current_date, min(birth_date))) as oldest_age,
    date_part('year', age(current_date, max(birth_date))) as youngest_age
from gold.dim_customers;

-- -------------------------------------------------------------------------------------

-- find how many items are sold
select sum(quantity) as total_quantity
from gold.fact_sales;

-- find the average selling price
select avg(price) as avg_price
from gold.fact_sales;

-- find the total number of orders
select count(order_number) as total_orders
from gold.fact_sales;

-- find the total number of distinct orders
select count(distinct order_number) as total_orders
from gold.fact_sales;

-- find the total number of products
select count(product_name) as total_products
from gold.dim_products;

-- find the total number of distinct products
select count(distinct product_name) as total_products
from gold.dim_products;

-- find the total number of customers
select count(customer_key) as total_customers
from gold.dim_customers;

-- find the total number of customers that have placed an order
select count(distinct customer_key) as total_customers
from gold.fact_sales;
