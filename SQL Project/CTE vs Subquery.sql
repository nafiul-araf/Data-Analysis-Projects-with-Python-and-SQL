-- 1. Find customers who have placed an order in 2023.
select name from (select name, year(join_date) as year from customers) as ex_year
where year = 2023;

/*
lecture solution */
SELECT name
FROM Customers
WHERE customer_id IN (
SELECT customer_id
FROM Orders
WHERE YEAR(order_date) = 2023
);

-- CTE
with cte1 as
(
  select customer_id, year(order_date) as year from orders
)

select name from customers
where customer_id in (select customer_id from cte1 where year = 2023);

-- 2. Find all products that have never been ordered
select product_name from products
where product_id not in (select product_id from orderdetails);

/*
Lecture Solution */
SELECT product_name
FROM Products
WHERE product_id NOT IN (
SELECT product_id
FROM OrderDetails
);

-- same type of query for CTE
-- 3. Get the name of the customer who spent the most on a single order
select name from customers
where customer_id in (select customer_id from orders
					  where total_amount = (select max(total_amount) from orders));

/*
-- Lecture Solution */
SELECT name
FROM Customers
WHERE customer_id = (
SELECT customer_id
FROM Orders
ORDER BY total_amount DESC
LIMIT 1
);

-- CTE
with cte1 as
(
  select customer_id from orders order by total_amount desc
  limit 1
)

select name from customers
where customer_id in (select customer_id from cte1);

-- 4. List all orders where the total amount is greater than the average total amount of all orders

select * from orders
where total_amount > any((select avg(total_amount) from orders));

/*
Lecture Solution
SELECT order_id, total_amount
FROM Orders
WHERE total_amount > (
SELECT AVG(total_amount)
FROM Orders
); */

-- same type of CTE

-- 5. Find the customer who has ordered the highest quantity of any single product.
select name from customers
where customer_id = (select customer_id from orders
					  where order_id = (select order_id from orderdetails
                                         order by quantity desc
                                         limit 1));
/*
Lecture Solution */
SELECT name
FROM Customers
WHERE customer_id = (
SELECT customer_id
FROM Orders
WHERE order_id = (
SELECT order_id
FROM OrderDetails
ORDER BY quantity DESC
LIMIT 1
)
);

with cte1 as
(
  select customer_id from orders
  where order_id = (select order_id from orderdetails
					  order by quantity desc limit 1)
)

select name from customers
where customer_id in (select customer_id from cte1);


-- 5. Find the name of the customer who has never placed an order
select name from customers
where customer_id not in (select customer_id from orders);


/*
Lecture Solution
SELECT name
FROM Customers
WHERE customer_id NOT IN (
SELECT customer_id
FROM Orders
); */


-- same type of query for CTE

-- 7. Find all customers who have ordered a product from the "Electronics" category
select name from customers 
where customer_id in (select customer_id from orders
                     where order_id in (select order_id from orderdetails
									   where product_id in (select product_id from products
                                                           where category = "Electronics")));
/*
Lecture Solution */
SELECT name
FROM Customers
WHERE customer_id IN (
SELECT customer_id
FROM Orders
WHERE order_id IN (
SELECT order_id
FROM OrderDetails
WHERE product_id IN (
SELECT product_id
FROM Products
WHERE category = 'Electronics'
)
)
);


-- CTE
with cte1 as
(
  select product_id from products where category = 'Electronics'
),

cte2 as
(
  select order_id from orderdetails
  where product_id in (select product_id from cte1)
),

cte3 as
(
  select customer_id from orders
  where order_id in (select order_id from cte2)
)

select name from customers
where customer_id in (select customer_id from cte3);

-- 8. List all customers who have purchased every product in the "Accessories" category

select name from customers
where customer_id not in (
    select customer_id from (
        select customer_id, count(distinct product_id) as product_count
        from orders
        join orderdetails using(order_id)
        where product_id in (
            select product_id from products
            where category = 'Accessories'
        )
        group by customer_id
    ) as customer_products
    where customer_products.product_count < (
        select count(product_id)
        from products
        where category = 'Accessories'
    )
);

/*
Lecture Solution

SELECT name
FROM Customers
WHERE customer_id NOT IN (
SELECT customer_id
FROM (
SELECT customer_id, COUNT(DISTINCT product_id) AS product_count
FROM Orders
JOIN OrderDetails USING(order_id)
WHERE product_id IN (
SELECT product_id
FROM Products
WHERE category = 'Accessories'
)
GROUP BY customer_id
) AS customer_products
WHERE customer_products.product_count < (
SELECT COUNT(product_id)
FROM Products
WHERE category = 'Accessories'
)
); */

-- CTE

with cte1 as (
  select product_id
  from products
  where category = 'Accessories'
),
cte2 as (
  select customer_id, count(distinct product_id) as product_count
  from orders
  join orderdetails using (order_id)
  where product_id in (select product_id from cte1)
  group by customer_id
),
cte3 as (
  select count(product_id) as total_product_count
  from products
  where category = 'Accessories'
)
select c.name
from customers c
where not exists (
  select 1
  from cte2 cp
  join cte3 ct
  on cp.product_count < ct.total_product_count
  where cp.customer_id = c.customer_id
);

-- 9. Find the most expensive product that has been ordered

select product_name from products
where product_id = (select product_id from orderdetails
					 order by price_at_time desc limit 1);

/*
Lecture Solution */
SELECT product_name
FROM Products
WHERE product_id = (
SELECT product_id
FROM OrderDetails
ORDER BY price_at_time DESC
LIMIT 1
);


-- CTE

with cte1 as
(
  select product_id from orderdetails
  order by price_at_time desc 
  limit 1
)

select product_name from products
where product_id in (select product_id from cte1);


-- 10. List all orders that include more than 2 different products
select order_id from orders
where order_id in (select order_id from orderdetails
                  group by order_id
                  having count(distinct product_id) > 2);

/*
Lecture Solution */              
SELECT order_id
FROM Orders
WHERE order_id IN (
SELECT order_id
FROM OrderDetails
GROUP BY order_id
HAVING COUNT(DISTINCT product_id) > 2
);

-- CTE

with cte1 as
(
  select order_id from orderdetails
  group by order_id
  having count(distinct product_id) > 2
)

select order_id from orders
where order_id in (select order_id from cte1);

-- 11. Find the customer who has ordered the most different products
select name from customers
where customer_id = (select customer_id from orders
                      where order_id = (select order_id from orderdetails
                                        group by order_id
                                        order by count(distinct product_id) desc
                                        limit 1));

/* 
Lecture Solution */
SELECT name
FROM Customers
WHERE customer_id = (
SELECT customer_id
FROM Orders
WHERE order_id = (
SELECT order_id
FROM OrderDetails
GROUP BY order_id
ORDER BY COUNT(DISTINCT product_id) DESC
LIMIT 1
));


-- CTE

with cte1 as
(
  select order_id from orderdetails
  group by order_id
  order by count(distinct product_id) desc
  limit 1
),

cte2 as
(
  select order_id, customer_id from orders
  where order_id in (select order_id from cte1)
)

select name from customers
where customer_id in (select customer_id from cte2);

-- 12. Find the total revenue generated from products in the "Electronics" category
select sum(quantity*price_at_time)
from orderdetails
where product_id in (select product_id from products
                     where category = "Electronics");

/*
Lecture Solution */
SELECT SUM(price_at_time * quantity) AS total_revenue
FROM OrderDetails
WHERE product_id IN (
SELECT product_id
FROM Products
WHERE category = 'Electronics'
);

-- CTE
with cte1 as
(
  select product_id from products
  where category = 'Electronics'
)

select sum(quantity * price_at_time) as total_revenue from orderdetails
where product_id in (select product_id from cte1);

-- 13. Find the customers who placed their first order in 2022
select name from customers
where customer_id in (select customer_id from orders
                      group by customer_id
                      having min(order_date) between "2022-01-01" and "2022-12-31");

/* 
Lecture Solution */
SELECT name
FROM Customers
WHERE customer_id IN (
SELECT customer_id
FROM Orders
GROUP BY customer_id
HAVING MIN(order_date) >= '2022-01-01' AND MIN(order_date) <= '2022-12-31'
);

-- CTE

with cte1 as
(
  select customer_id from orders
  group by customer_id
  having min(order_date) between '2022-01-01' and '2022-12-31'
)

select name from customers
where customer_id in (select customer_id from cte1);

-- 14. Find the product that has generated the most revenue.
select product_name from products
where product_id = (select product_id from (select product_id, sum(quantity * price_at_time) as revenue
											from orderdetails
                                            group by product_id) as product_revenue
                                            order by revenue desc
                                            limit 1);

/* 
Lecture Solution */
SELECT product_name
FROM Products
WHERE product_id = (
SELECT product_id
FROM OrderDetails
GROUP BY product_id
ORDER BY SUM(price_at_time * quantity) DESC
LIMIT 1
);

-- CTE

with cte1 as
(
  select product_id from orderdetails
  group by product_id
  order by sum(quantity * price_at_time) desc
  limit 1
)

select product_name from products
where product_id in (select product_id from cte1);

-- 15. List all products that have been ordered by at least 3 different customers.
select product_name from products
where product_id in (select product_id from orderdetails
                     where order_id in (select order_id from orders
									   group by customer_id)
                                       group by product_id
                                       having count(distinct (select customer_id from orders 
															  where orders.order_id = orderdetails.order_id)) >= 3);
/* 
Lecture Solution
SELECT product_name
FROM Products
WHERE product_id IN (
SELECT product_id
FROM OrderDetails
JOIN Orders USING(order_id)
GROUP BY product_id
HAVING COUNT(DISTINCT customer_id) >= 3
);*/

-- CTE
with cte1 as
(
  select order_id from orders
  group by order_id
  having count(distinct customer_id) >= 3
),

cte2 as
(
  select product_id from orderdetails
  where order_id in (select order_id from cte1)
)

select product_name from products
where product_id in (select product_id from cte2);

-- 16. Find all orders with a total amount greater than the largest single product price
select order_id, total_amount from orders
where total_amount > (select max(price) from products);

/*
Lecture Solution
SELECT order_id, total_amount
FROM Orders
WHERE total_amount > (
SELECT MAX(price)
FROM Products
); */

-- Same type as subquery

-- 17. Find the average quantity of products ordered per customer for products in the "Accessories" category
select avg(quantity) as avg_quantity from orderdetails
where product_id in (select product_id from products
					 where category = "Accessories");

/*
Lecture Solution
SELECT AVG(quantity) AS avg_quantity
FROM OrderDetails
WHERE product_id IN (
SELECT product_id
FROM Products
WHERE category = 'Accessories'
); */

-- CTE
with cte1 as
(
  select product_id from products
  where category = 'Accessories'
)

select avg(quantity) as average_quantity from orderdetails
where product_id in (select product_id from cte1);