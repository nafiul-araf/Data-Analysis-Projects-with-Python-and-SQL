SELECT * FROM FACT_DATA;


-------------------------------------------------------------------------- STORED PROCEDURE -----------------------------------------------------------------

/*
--Stored Procedure Purpose:
Generally, to perform administrative operations by executing SQL statements. 
The body of a stored procedure is allowed, but not required, to explicitly return a value (such as an error indicator).

Create a Stored Procedure When:
-Typical queries and DML, such as SELECT, UPDATE, etc.
-Administrative tasks, including DDL such as deleting temporary tables, deleting data older than N days, or adding users.

Supported Handler Languages: Java, JavaScript, Python, Scala, Snowflake Scripting.
*/

-- REVENUE PER SIZE

SELECT PIZZA_SIZE, ROUND(SUM(TOTAL_PRICE)) AS REVENUE
FROM FACT_DATA
GROUP BY 1;


CREATE OR REPLACE PROCEDURE REV_PER_SIZE()
RETURNS TABLE()
LANGUAGE SQL
AS
DECLARE
       RES RESULTSET DEFAULT(
       SELECT PIZZA_SIZE, ROUND(SUM(TOTAL_PRICE)) AS REVENUE
       FROM FACT_DATA
       GROUP BY 1
       );
BEGIN 
      RETURN TABLE(RES);
END;

CALL REV_PER_SIZE();





SELECT PIZZA_SIZE, ROUND(SUM(TOTAL_PRICE)) AS REVENUE
      FROM FACT_DATA
      WHERE PIZZA_CATEGORY = 'Classic'
      GROUP BY 1;




CREATE OR REPLACE PROCEDURE REV_PER_SIZE_CAT(CATEGORY VARCHAR)
RETURNS TABLE()
LANGUAGE SQL
AS
DECLARE 
      RES RESULTSET DEFAULT(
      SELECT PIZZA_SIZE, ROUND(SUM(TOTAL_PRICE)) AS REVENUE
      FROM FACT_DATA
      WHERE PIZZA_CATEGORY = :CATEGORY
      GROUP BY 1 
      );
BEGIN
     RETURN TABLE(RES);
END;


CALL REV_PER_SIZE_CAT('Classic');





/*
SELECT * FROM SALES_SAMPLE_DATA WHERE POSTALCODE IS NULL;

CREATE OR REPLACE PROCEDURE PURGE_NULL_POSTALCODE()
RETURNS TABLE ()
LANGUAGE SQL
AS
DECLARE
  res RESULTSET DEFAULT (
  DELETE FROM SALES_SAMPLE_DATA WHERE POSTALCODE IS NULL
  );
BEGIN
  RETURN TABLE(res);
END;


CALL PURGE_NULL_POSTALCODE();--76
SELECT * FROM SALES_SAMPLE_DATA WHERE POSTALCODE IS NULL;--0
*/




---------------------------------------------------------------------- USER DEFINED FUNCTIONS ---------------------------------------------------------------


/*
--User-Defined Function Purpose:
Calculate and return a value. A function always returns a value explicitly by specifying an expression. 
For example, the body of a JavaScript UDF must have a return statement that returns a value.

Create a UDF When:
-You need a function that can be called as part of a SQL statement and that must return a value that will be used in the statement.
-Your output needs to include a value for every input row or every group.

Supported Handler Languages: Java, JavaScript, Python, Scala, SQL


-- Difference Between Stored Procedure and User Defined Function

*** UDFs Return a Value; Stored Procedures Need Not.
*** UDF Return Values Are Directly Usable in SQL; Stored Procedure Return Values May Not Be, like an error message.
*** UDFs Can Be Called In the Context of Another Statement; Stored Procedures Are Called Independently.
A stored procedure does not evaluate to a value, and cannot be used in all contexts in which a general expression can be used. For example, you cannot execute SELECT my_stored_procedure()....

A UDF evaluates to a value, and can be used in contexts in which a general expression can be used (such as SELECT my_function() ...)

CALL MyStoredProcedure_1(argument_1);

SELECT MyFunction_1(column_1) FROM table1;

*** Multiple UDFs May Be Called With One Statement; a Single Stored Procedure Is Called With One Statement.
*** UDFs May Not Access the Database; Stored Procedures Can
*/

-- creating a simple orders table
create or replace table orders(
    order_id number,
    customer_id_fk number,
    item_id_fk number,
    retail_price number(10,2),
    purchase_price number(10,2),
    sold_quantity number(3),
    country_code varchar(2)
);

-- inserting handful records
insert into orders 
(order_id, customer_id_fk, item_id_fk,retail_price,purchase_price, sold_quantity,country_code)
values
(1,1,1,99.2,89.6,2,'US'),
(2,8,2,17.1,11,10,'IN'),
(3,5,1,827,900.99,5,'JP'),
(4,10,4,200,172,7,'DE');

-- lets check the records
select * from orders;

CREATE OR REPLACE FUNCTION 
    calculate_profit(retail_price number, purchase_price number, sold_quantity number)
RETURNS NUMBER (10,2)
COMMENT = 'this is a simple profit calculator'
as 
$$
  SELECT ((retail_price - purchase_price) * sold_quantity)
$$;


select 
    item_id_fk,
    retail_price,
    purchase_price, 
    sold_quantity, 
    calculate_profit(retail_price,purchase_price, sold_quantity) as profit_udf 
from orders ;

select 
    item_id_fk,
    retail_price,
    purchase_price, 
    sold_quantity,
    ((retail_price - purchase_price) * sold_quantity) as profit
from orders ;


-- create bit more complex udf
create or replace function country_name(country_code string)
returns string
as 
$$
 select country_code || '-' ||case
        when country_code='US' then 'USA'
        when country_code='IN' then 'India'
        when country_code='JP' then 'Japan'
        when country_code='DE' then 'Germany'
        else 'Unknown'
    end
$$;

select 
    item_id_fk,
    retail_price,
    purchase_price, 
    sold_quantity,
    calculate_profit(retail_price,purchase_price, sold_quantity) as profit_udf ,
    country_name(country_code) as country_udf
 from orders ;
 
select 
    item_id_fk,
    retail_price,
    purchase_price, 
    sold_quantity,
    ((retail_price - purchase_price) * sold_quantity) as profit ,
    country_code || '-' ||case
        when country_code='US' then 'USA'
        when country_code='IN' then 'India'
        when country_code='JP' then 'Japan'
        when country_code='DE' then 'Germany'
        else 'Unknown'
        end as country
 from orders ;


-- now lets understand show and desc function features.
show functions;

-- filter by using object name
show functions like 'COUNTRY%';
show functions like'%PROFIT';

-- how to describe a function using desc function sql keywords
desc function country_name(string);