CREATE DATABASE sql_project_p2;

Use sql_project_p2;


CREATE TABLE retail_sales
            (
                transactions_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

Select * from retail_sales;

Select count(*) from retail_sales;

--  Data cleaning /checking for null values

SELECT * FROM retail_sales
where 
   transactions_id is NULL
   or
   sale_date is NUll
   or
   sale_time is Null
   or
   customer_id is Null
   or
   gender is Null
   or
   age is Null
   or
   quantiy is Null
   or
   price_per_unit is Null
   or
   cogs is Null
   or
   total_sale is Null;
   
-- if you fine any null values then use the below mention query to delete all

SET SQL_SAFE_UPDATES = 0;


Delete from retail_sales
where 
  transactions_id is NULL
   or
   sale_date is NUll
   or
   sale_time is Null
   or
   customer_id is Null
   or
   gender is Null
   or
   age is Null
   or
   quantiy is Null
   or
   price_per_unit is Null
   or
   cogs is Null
   or
   total_sale is Null;

-- Data Exploration

-- q1 How many sales we have?

Select Count(*) as total_sale from retail_sales;

-- q2 How many unique customers we have?

Select count(distinct customer_id) as differnt_customer from retail_sales;

-- how many category we have?

Select distinct category from retail_sales;

-- data analysis or business key findings

Select * from retail_sales;

-- Write SQL Query to find all columns for sale made on '2022-11-05'

Select * from retail_sales where sale_date= "2022-11-06";

-- Write SQL Query to find all transactions where the category is clothing and the quantity sold is more than 10 in the month of Nov-2022.

Select * from retail_sales 
where category="Clothing" 
	AND date_format(sale_date, 'YYYY-MM')= '2022-11'
    AND
    quantiy>2;
   
-- Write SQL Query to calculate the total sales for each category'

Select category, Sum(total_sale) as totalsales
from retail_sales group by category;

-- Write SQL Query to find the average age of coustomer who purchased items from the Beauty'
Select * from retail_sales;

Select avg(age) from retail_sales 
where category="Beauty";
   
-- Write SQL Query to find all the transaction where the total_sale is greater than 1000.

Select * from retail_sales
where total_sale >= 1000;

-- Write SQL Query to find the total number of transactions (Transactions_id) made by each gender in each category.

Select category, gender,  count(transactions_id) as totalnum
from retail_sales
group by category, gender
order by category;

-- Write SQL Query to calculate average sale for each month, find out best selling month in each year.

Select Years,months, avg_sales
from
(
Select 
year(sale_date) as years,
month(sale_date) as months, 
Round(avg(total_sale),2) as avg_sales,
DENSE_RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY Avg(total_sale) DESC) as sales_raml
from retail_sales
group by years, months
Order by years, avg_sales DESC)

as t1 where sales_raml=1;


-- Write a SQL Query to find the top 5 customers based on the highest total_sales

Select* from retail_sales;

Select customer_id,
Sum(total_sale) as total_sales
 from retail_sales 
 group by customer_id
order by total_sales DESC limit 5;

-- Write a SQL Query to find the number of unique customers who purchased items from each category.


Select category,
Count(distinct customer_id) as unique_cutomer
from retail_sales
group by category;

-- Write a SQL Query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale AS(
Select *,
 CASE
    WHEN hour(sale_time) <12 THEN 'Monrning'
    When hour(sale_time) between 12 AND 17 then 'Afternoon'
    Else 'Evening'
    End as shift
    from retail_sales
)
Select shift, count(*) as total_orders
from hourly_sale
group by shift;

-- END OF PROJECT	