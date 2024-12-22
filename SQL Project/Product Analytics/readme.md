
# Product Analytics Dashboard

Web Link :-> [Here](https://app.powerbi.com/view?r=eyJrIjoiNGYxMTMyY2MtZjZhNy00YWM2LWFlYjItNDFlZTUwNzNjYjRjIiwidCI6IjhjMTI4NjJkLWZjYWYtNGEwNi05M2FjLTk0Yjk3YjVjZWQ1NSIsImMiOjEwfQ%3D%3D)

![image](https://github.com/user-attachments/assets/010c8b87-5716-46ee-9fd3-d1fa8753c214)


This repository contains the SQL scripts used to prepare, clean, and transform data for building a **Product Analytics Dashboard** in Power BI. The dashboard provides insights into key performance metrics like revenue, profit, and YoY changes.

---

## Database and Tables Overview

### **Database: `product_database`**
This database contains three key tables:

1. **`product_data`**: Product details including cost price, sale price, and brand information.
2. **`product_sales`**: Sales transaction data, including country, date, and discount band.
3. **`discount_data`**: Discount percentage for each discount band by month.

---

## Data Cleaning and Transformation Steps

### 1. **Cleaning Currency Fields**
- Removed `$` symbols from `Cost Price` and `Sale Price` fields in the `product_data` table for numeric conversions.

```sql
update product_data
set `Cost Price` = replace(`Cost Price`, '$', ''),
    `Sale Price` = replace(`Sale Price`, '$', '');
```

- Converted `Cost Price` and `Sale Price` columns to `FLOAT` data type:

```sql
alter table product_data
modify column `Cost Price` float,
modify column `Sale Price` float;
```

---

### 2. **Standardizing Date Formats**
- Transformed `Date` column in the `product_sales` table to a consistent format:

```sql
update product_sales
set date = str_to_date(date, '%d/%m/%Y');
```

---

### 3. **Ensuring Consistency in `Discount Band`**
- Trimmed and standardized `Discount Band` column values to lowercase in both `product_sales` and `discount_data` tables:

```sql
update product_sales set `Discount Band` = trim(lower(`Discount Band`));
update discount_data set `Discount Band` = trim(lower(`Discount Band`));
```

---

## Data Transformation for Analysis

### Common Table Expression (CTE): `cte`
- Combined product details with sales data to calculate **COGS (Cost of Goods Sold)** and **Gross Sales**:

```sql
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
```

---

### Final Output: Cleaned and Transformed Data
- Integrated `discount_data` to calculate **Net Revenue** and **Profit**:

```sql
select c.*,
       d.Discount,
       round((1 - (d.Discount / 100)) * c.`Gross Sales`, 2) as `Net Revenue`,
       round(((1 - (d.Discount / 100)) * c.`Gross Sales`) - c.COGS, 2) as Profit
from cte c 
left join discount_data d 
on c.`Discount Band` = d.`Discount Band` and c.Month = d.Month;
```

---

## Issues Resolved
- Mismatched values in the `Discount Band` column caused joins to fail. This was fixed by trimming and converting the values to lowercase.

```sql
update product_sales set `Discount Band` = trim(lower(`Discount Band`));
update discount_data set `Discount Band` = trim(lower(`Discount Band`));
```

---

## Outcome
The SQL script outputs a cleaned and transformed dataset with the following key metrics:
- **Net Revenue**
- **Profit**
- **COGS**
- **Gross Sales**

This data was exported to Power BI for creating the **Product Analytics Dashboard**.

---

### Dashboard Features
The final Power BI dashboard includes:
1. **Revenue by Country**: Displays top-performing regions.
2. **Revenue by Date**: Visualizes revenue trends.
3. **YoY Changes**: Highlights profit and unit sales growth.
4. **Revenue by Discount Band**: Breaks down revenue distribution.
5. **Detailed Table**: Provides revenue and profit details by year and country.


