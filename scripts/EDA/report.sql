-- generate a report that shows all key metrics of the business
select 'total sales' as measure_name, sum(sales_amount) as measure_value 
from gold.fact_sales
union all
select 'total quantity', sum(quantity) 
from gold.fact_saleS
union all
select 'average price', avg(price) 
from gold.fact_sales
union all
select 'total nr. orders', count(distinct order_number) 
from gold.fact_sales
union all
select 'total nr. products', count(distinct product_name) 
from gold.dim_products
union all
select 'total nr. customers', count(distinct customer_key) 
from gold.dim_customers;
