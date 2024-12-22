create database product_database;


-- ------------------------------------------- DATA CLEANING PHASE ---------------------------------------------------
select * from product_data;

update product_data
set `Cost Price` = replace(`Cost Price`, '$', ''),
	`Sale Price` = replace(`Sale Price`, '$', '');
    
select * from product_data;

alter table product_data
modify column `Cost Price` float,
modify column `Sale Price` float;

select * from product_data;
describe product_data;


select * from discount_data;
describe discount_data;

select * from product_sales;
describe product_sales;

select date, str_to_date(date, '%d/%m/%Y') as ConvertedDate
from product_sales;

update product_sales
set date = str_to_date(date, '%d/%m/%Y');

select * from product_sales;

alter table product_sales
change Product `Product ID` text;

select * from product_sales;


update product_sales set `Discount Band` = trim(lower(`Discount Band`));
update discount_data set `Discount Band` = trim(lower(`Discount Band`));


-- --------------------------------------BEGIN ANALYSIS----------------------------------------------------------
-- Data Preparation for Power BI 
with cte as (
select p.`Product ID`, p.Product, p.Category, p.`Cost Price`, p.`Sale Price`, p.Brand, p.`Image url`, 
       s.Date, s.`Customer Type`, s.Country, s.`Discount Band`, s.`Units Sold`, 
       monthname(s.Date) as Month,
       Year(s.Date) as Year,
       (p.`Cost Price` * s.`Units Sold`) as COGS, 
       (p.`Sale Price` * s.`Units Sold`) as `Gross Sales`
from product_data p
join product_sales s on p.`Product ID` = s.`Product ID`
)

select c.*,
	   d.Discount,
       round((1 - (d.Discount/100)) * c.`Gross Sales`, 2) as `Net Revenue`,
       round(((1 - (d.Discount / 100)) * c.`Gross Sales`) - c.COGS, 2) AS Profit
from cte c 
left join discount_data d 
on c.`Discount Band` = d.`Discount Band` and c.Month = d.Month;

/*
The output was giving an empty table

so I used 
update product_sales set `Discount Band` = trim(lower(`Discount Band`));
update discount_data set `Discount Band` = trim(lower(`Discount Band`));
earlier
*/





























































