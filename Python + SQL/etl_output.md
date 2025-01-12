# Retail Orders ETL Process

This repository documents the **ETL process** performed on retail orders data. Below is a detailed summary of the data and transformations carried out during the ETL pipeline.

---

## **Data Overview**

### Sample Data
| Order Id | Order Date  | Ship Mode      | Segment   | Country       | City            | State      | Category        | Sub Category | Product Id         | Cost Price | List Price | Quantity | Discount Percent |
|----------|-------------|----------------|-----------|---------------|-----------------|------------|-----------------|--------------|--------------------|------------|------------|----------|------------------|
| 1        | 2023-03-01  | Second Class   | Consumer  | United States | Henderson       | Kentucky   | Furniture       | Bookcases    | FUR-BO-10001798    | 240        | 260        | 2        | 2                |
| 2        | 2023-08-15  | Second Class   | Consumer  | United States | Henderson       | Kentucky   | Furniture       | Chairs       | FUR-CH-10000454    | 600        | 730        | 3        | 3                |
| 3        | 2023-01-10  | Second Class   | Corporate | United States | Los Angeles     | California | Office Supplies | Labels       | OFF-LA-10000240    | 10         | 10         | 2        | 5                |
| 4        | 2022-06-18  | Standard Class | Consumer  | United States | Fort Lauderdale | Florida    | Furniture       | Tables       | FUR-TA-10000577    | 780        | 960        | 5        | 2                |
| 5        | 2022-07-13  | Standard Class | Consumer  | United States | Fort Lauderdale | Florida    | Office Supplies | Storage      | OFF-ST-10000760    | 20         | 20         | 2        | 5                |

### Data Shape
- **Rows**: 9994
- **Columns**: 16

---

## **Data Types**

### Initial Data Types
| Column             | Data Type     |
|--------------------|---------------|
| Order Id           | `int64`       |
| Order Date         | `object`      |
| Ship Mode          | `object`      |
| Segment            | `object`      |
| Country            | `object`      |
| City               | `object`      |
| State              | `object`      |
| Postal Code        | `int64`       |
| Region             | `object`      |
| Category           | `object`      |
| Sub Category       | `object`      |
| Product Id         | `object`      |
| Cost Price         | `int64`       |
| List Price         | `int64`       |
| Quantity           | `int64`       |
| Discount Percent   | `int64`       |

### Data Types After Conversion
- `Order Date`: Converted to `datetime64[ns]`.

---

## **Data Cleaning**

1. **Null Values**
   - Columns with Nulls:
     - `Ship Mode`: 1 Null value.
   - Null value rows were dropped.
   - **Shape After Cleaning**: 9993 rows × 16 columns.

2. **Duplicate Rows**
   - No duplicates were found.

3. **Unique Value Analysis**
   - **Ship Mode**: Converted `unknown` and `Same Day` to `Unknown`.
   - Categories and subcategories were validated, with no unwanted levels.

---

## **Feature Engineering**

### New Columns Derived:
1. **Discount**: `list_price * (discount_percent * 0.01)`
2. **Revenue**: `list_price - discount`
3. **Profit**: `revenue - cost_price`

### Dropped Columns:
- `list_price`, `cost_price`, `discount_percent`

### Final Dataset
| Order Id | Order Date  | Ship Mode      | Segment   | Category        | Sub Category | Revenue | Profit |
|----------|-------------|----------------|-----------|-----------------|--------------|---------|--------|
| 1        | 2023-03-01  | Second Class   | Consumer  | Furniture       | Bookcases    | 254.8   | 14.8   |
| 2        | 2023-08-15  | Second Class   | Consumer  | Furniture       | Chairs       | 708.1   | 108.1  |
| 3        | 2023-01-10  | Second Class   | Corporate | Office Supplies | Labels       | 9.5     | -0.5   |
| 4        | 2022-06-18  | Standard Class | Consumer  | Furniture       | Tables       | 940.8   | 160.8  |
| 5        | 2022-07-13  | Standard Class | Consumer  | Office Supplies | Storage      | 19.0    | -1.0   |

---

## **Summary Statistics**

| Metric               | Value (Sample)            |
|----------------------|---------------------------|
| **Cost Price**       | Min: 0, Max: 18,110       |
| **Quantity**         | Min: 1, Max: 14           |
| **Discount Percent** | Min: 2, Max: 5, Mean: 3.48|

---

## **Data Loading**

- **Target**: MySQL Database
- **Table Name**: `orders_data`
- **Outcome**: Data successfully loaded.

---
