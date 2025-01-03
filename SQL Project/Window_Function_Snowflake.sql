SELECT * FROM FACT_DATA;


----------------------------------------- Basic Cleaning -----------------------------------------

SELECT DISTINCT PIZZA_SIZE
FROM FACT_DATA;

UPDATE FACT_DATA
SET PIZZA_SIZE = CASE
    WHEN PIZZA_SIZE = 'S' THEN 'Regular'
    WHEN PIZZA_SIZE = 'L' THEN 'Large'
    WHEN PIZZA_SIZE = 'M' THEN 'Medium'
    WHEN PIZZA_SIZE IN ('XL', 'XXL') THEN 'XL'
    ELSE PIZZA_SIZE -- Keep the original value if no match
END;

SELECT DISTINCT PIZZA_SIZE
FROM FACT_DATA;



-- -------------------------------------- Window Functions ---------------------------------------


SELECT PIZZA_SIZE, ROUND(SUM(TOTAL_PRICE), 2) AS TOTAL_SALES
FROM FACT_DATA
GROUP BY 1
ORDER BY 2 DESC;



SELECT PIZZA_SIZE, 
       AVG(ROUND(TOTAL_PRICE, 2)) OVER() AS AVG_SALES -- AVG() WINDOW
FROM FACT_DATA;



WITH CTE1 AS (
SELECT DISTINCT PIZZA_SIZE, 
       AVG(ROUND(TOTAL_PRICE, 2)) OVER(PARTITION BY PIZZA_SIZE) AS AVG_SALES -- PARTITION BY FOR GROUPING
FROM FACT_DATA
)

SELECT *,
       ROW_NUMBER() OVER(ORDER BY AVG_SALES DESC) AS RN -- ROW_NUMBER() FOR RANKING
FROM CTE1;







SELECT DISTINCT PIZZA_CATEGORY
FROM FACT_DATA;


SELECT DISTINCT PIZZA_CATEGORY,
       MAX(TOTAL_PRICE) OVER(PARTITION BY PIZZA_CATEGORY) AS MAX_SALES, -- MAX() WINDOW
       (MAX(TOTAL_PRICE) OVER(PARTITION BY PIZZA_CATEGORY) - TOTAL_PRICE) AS DIFFERENCE
FROM FACT_DATA;




WITH CTE1 AS (
SELECT DISTINCT PIZZA_CATEGORY,
       COUNT(DISTINCT ORDER_ID) OVER(PARTITION BY PIZZA_CATEGORY) AS TOTAL_ORDERS  -- COUNT() WINDOW
FROM FACT_DATA
)

SELECT *,
       RANK() OVER(ORDER BY TOTAL_ORDERS DESC) AS RN -- RANK() FOR RANKING
FROM CTE1;



WITH CTE1 AS (
SELECT DISTINCT PIZZA_CATEGORY,
       COUNT(DISTINCT ORDER_ID) OVER(PARTITION BY PIZZA_CATEGORY) AS TOTAL_ORDERS  -- COUNT() WINDOW
FROM FACT_DATA
)

SELECT *,
       PERCENT_RANK() OVER(ORDER BY TOTAL_ORDERS DESC) AS RN -- PERCENT_RANK() FOR PERCENTILE RANKING
FROM CTE1;






-- OUTLIERS DETECTION USING NTILES() WINDOW FUNCTION

WITH CTE1 AS (
SELECT TOTAL_PRICE,
       NTILE(4) OVER(ORDER BY TOTAL_PRICE) AS PERCENTILES
FROM FACT_DATA
),

CTE2 AS (
SELECT 
       MAX(CASE WHEN PERCENTILES = 1 THEN TOTAL_PRICE END) AS Q1,
       MAX(CASE WHEN PERCENTILES = 3 THEN TOTAL_PRICE END) AS Q3
FROM CTE1
),

CTE3 AS (
SELECT
       Q1,
       Q3,
       (Q3 - Q1) AS IQR,
       (Q1 - 1.5*(Q3 - Q1)) AS LOWER_BOUND,
       (Q1 + 1.5*(Q3 - Q1)) AS UPPER_BOUND
FROM CTE2
)

SELECT COUNT(*) AS OUTLIER_COUNT
FROM FACT_DATA AS F
CROSS JOIN CTE3 AS C
WHERE F.TOTAL_PRICE < C.LOWER_BOUND OR F.TOTAL_PRICE > C.UPPER_BOUND;




-- LEAD(), LAG()

WITH CTE1 AS (
    SELECT 
        ORDER_DATE,
        PIZZA_CATEGORY,
        COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
    FROM FACT_DATA
    GROUP BY ORDER_DATE, PIZZA_CATEGORY
)
SELECT 
    ORDER_DATE,
    PIZZA_CATEGORY,
    TOTAL_ORDERS,
    LAG(TOTAL_ORDERS) OVER (PARTITION BY PIZZA_CATEGORY ORDER BY ORDER_DATE) AS PREVIOUS_DAY_ORDERS -- LAG() WINDOW
FROM CTE1;




WITH CTE1 AS (
     SELECT 
          ORDER_DATE,
          COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS,
          LAG(COUNT(DISTINCT ORDER_ID)) OVER(ORDER BY ORDER_DATE) AS PREVIOUS_DAY_ORDERS
     FROM FACT_DATA
     GROUP BY 1
),

CTE2 AS (
   SELECT 
         *,
         (TOTAL_ORDERS - PREVIOUS_DAY_ORDERS) AS DIFFERENCE 
   FROM CTE1
)

SELECT *,
       SUM(DIFFERENCE) OVER() AS TOTAL_DIFFERENCE
FROM CTE2;






WITH CTE1 AS (
     SELECT 
          ORDER_DATE,
          COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS,
          LEAD(COUNT(DISTINCT ORDER_ID)) OVER(ORDER BY ORDER_DATE) AS LATER_DAY_ORDERS -- LEAD() WINDOW
     FROM FACT_DATA
     GROUP BY 1
),

CTE2 AS (
   SELECT 
         *,
         (TOTAL_ORDERS - LATER_DAY_ORDERS) AS DIFFERENCE 
   FROM CTE1
)

SELECT *,
       SUM(DIFFERENCE) OVER() AS TOTAL_DIFFERENCE
FROM CTE2;












SELECT * FROM FACT_DATA;

SELECT DISTINCT PIZZA_NAME
FROM FACT_DATA;

SELECT PIZZA_CATEGORY,
       COUNT(DISTINCT PIZZA_NAME) AS TOTAL_PIZZAS
FROM FACT_DATA
GROUP BY 1
ORDER BY 2 DESC;


SELECT PIZZA_CATEGORY,
       LISTAGG(PIZZA_NAME, ', ') AS PIZZAS
FROM FACT_DATA
GROUP BY 1;

-- FIRST, FETCH ME THE TOP TWO PIZZAS FROM EACH CATEGORY AFTER THAT COMPARE THERE SALES

WITH CTE1 AS (
SELECT PIZZA_CATEGORY, PIZZA_NAME,
       ROUND(SUM(TOTAL_PRICE), 2) AS SALES
FROM FACT_DATA
GROUP BY 1, 2
),

CTE2 AS (
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY PIZZA_CATEGORY ORDER BY SALES DESC) AS RN
FROM CTE1
),

CTE3 AS (
SELECT *, 
       LAG(SALES) OVER(PARTITION BY PIZZA_CATEGORY ORDER BY RN) AS PREV_SALES
FROM CTE2
WHERE RN <= 2
)

SELECT *, 
       SALES - PREV_SALES AS DIFFERENCE 
FROM CTE3;








-- GET ROLLING AVERAGE

SELECT * FROM FACT_DATA;

WITH CTE1 AS (
SELECT TO_CHAR(ORDER_DATE::DATE, 'YYYY-MM') AS MONTH,
       SUM(TOTAL_PRICE) AS MONTHLY_REVENUE
FROM FACT_DATA
GROUP BY 1
ORDER BY 1
)


SELECT MONTH,
       MONTHLY_REVENUE,
       AVG(MONTHLY_REVENUE) OVER(ORDER BY MONTH ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS AVG_SALES_3_MONTH_REVENUE
FROM CTE1;





WITH CTE1 AS (
    SELECT 
           TO_CHAR(ORDER_DATE::DATE, 'YYYY-MM') AS MONTH,
           SUM(TOTAL_PRICE) AS MONTHLY_REVENUE
    FROM FACT_DATA
    GROUP BY 1
    ORDER BY 1
),
CTE2 AS (
    SELECT 
           MONTH,
           MONTHLY_REVENUE,
           LAG(MONTHLY_REVENUE) OVER (ORDER BY MONTH) AS PREVIOUS_MONTH_REVENUE,
           LEAD(MONTHLY_REVENUE) OVER (ORDER BY MONTH) AS NEXT_MONTH_REVENUE
    FROM CTE1
)
SELECT 
       MONTH,
       MONTHLY_REVENUE,
       ROUND((COALESCE(PREVIOUS_MONTH_REVENUE, 0) + COALESCE(NEXT_MONTH_REVENUE, 0)) / 
             (CASE WHEN PREVIOUS_MONTH_REVENUE IS NOT NULL AND NEXT_MONTH_REVENUE IS NOT NULL THEN 2
                   WHEN PREVIOUS_MONTH_REVENUE IS NULL OR NEXT_MONTH_REVENUE IS NULL THEN 1
                   ELSE 0 END), 2) AS AVG_SALES_2_MONTH_REVENUE_EXCLUDE_CURRENT
FROM CTE2;










WITH CTE1 AS (
    SELECT 
           TO_CHAR(ORDER_DATE::DATE, 'YYYY-MM') AS MONTH,
           SUM(TOTAL_PRICE) AS MONTHLY_REVENUE
    FROM FACT_DATA
    GROUP BY 1
    ORDER BY 1
),
CTE2 AS (
    SELECT 
           MONTH,
           MONTHLY_REVENUE,
           LAG(MONTHLY_REVENUE) OVER (ORDER BY MONTH) AS PREVIOUS_MONTH_REVENUE,
           LEAD(MONTHLY_REVENUE) OVER (ORDER BY MONTH) AS NEXT_MONTH_REVENUE
    FROM CTE1
    WHERE MONTHLY_REVENUE > 70000
)
SELECT 
       MONTH,
       MONTHLY_REVENUE,
       ROUND((COALESCE(PREVIOUS_MONTH_REVENUE, 0) + COALESCE(NEXT_MONTH_REVENUE, 0)) / 
             (CASE WHEN PREVIOUS_MONTH_REVENUE IS NOT NULL AND NEXT_MONTH_REVENUE IS NOT NULL THEN 2
                   WHEN PREVIOUS_MONTH_REVENUE IS NULL OR NEXT_MONTH_REVENUE IS NULL THEN 1
                   ELSE 0 END), 2) AS AVG_SALES_2_MONTH_REVENUE_EXCLUDE_CURRENT
FROM CTE2;