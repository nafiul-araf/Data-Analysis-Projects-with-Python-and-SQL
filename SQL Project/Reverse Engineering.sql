-- Prerequisites for Data Load Using Reverse Engineering in MySQL

-- 1. MySQL Database and Workbench:
--    Ensure MySQL server is installed and running, and MySQL Workbench is available for reverse engineering.

-- 2. Proper Access and Privileges:
--    Verify that you have appropriate permissions (CREATE, SELECT, INSERT) on the MySQL database.

-- 3. Database or Data File:
--    Have a database schema, SQL dump, or data files (e.g., CSV, JSON, XML) to reverse engineer from.

-- 4. Schema Structure Knowledge:
--    Understand the data model or schema of the source data (tables, columns, relationships).
--    Alternatively, have access to a data dictionary for reference.

-- 5. Data Loading Tool or Method:
--    Choose a tool or method for loading data into MySQL:
--    - MySQL Workbench
--    - MySQL 'LOAD DATA' command
--    - MySQL Import Wizard in Workbench
--    - Third-party tools (e.g., DBeaver, HeidiSQL).

-- 6. Data Cleaning and Transformation:
--    Ensure data is cleaned or ready for transformation to match MySQL schema.
--    Handle data type conversions, null values, date formats, etc.

-- 7. Primary Keys, Indexes, and Constraints:
--    Ensure primary keys, foreign keys, indexes, and constraints are well-defined for maintaining data integrity.

-- 8. Character Encoding and Collation:
--    Be aware of the character encoding of your data (e.g., UTF-8) to avoid data corruption during the load process.

-- 9. Error Handling Strategy:
--    Prepare for potential data loading errors such as type mismatches or foreign key violations.
--    Use logging or error capture mechanisms to manage issues during the process.

-- 10. Storage and Performance Considerations:
--    Verify that the MySQL server has sufficient storage and optimize performance by using batch processing or bulk inserts.

-- 11. Data Mapping Logic:
--    For migrations from other database systems (e.g., SQL Server, Oracle), develop a data mapping strategy.
--    This includes converting data types, constraints, and handling incompatibilities.

-- 12. Backup of Data and Schema:
--    Always create a backup of your data and schema before reverse engineering or data load to avoid data loss.

-- 13. ETL Tool or Scripting for Transformation (Optional):
--    If complex transformations are needed, consider using an ETL tool (e.g., Talend, Pentaho) or custom scripts (Python, etc.).


-- Start

create schema healthcare_database;

use healthcare_database;

CREATE TABLE visits (
    Date_of_Visit DATE,
    Patient_ID INT,
    Provider_ID INT,
    Department_ID INT,
    Diagnosis_ID INT,
    Procedure_ID INT,
    Insurance_ID INT,
    Service_Type VARCHAR(50),
    Treatment_Cost DECIMAL(10, 2),
    Medication_Cost DECIMAL(10, 2),
    Follow_Up_Visit_Date DATE,
    Patient_Satisfaction_Score INT,
    Referral_Source VARCHAR(50),
    Emergency_Visit VARCHAR(3),
    Payment_Status VARCHAR(10),
    Discharge_Date DATE,
    Admitted_Date DATE,
    Room_Type VARCHAR(50),
    Insurance_Coverage DECIMAL(10, 2),
    Room_Charges_Daily_Rate DECIMAL(10, 2)
);



show variables like 'local_infile';

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/visits.csv'
into table visits
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
(@date_str, Patient_ID, Provider_ID, Department_ID, Diagnosis_ID, Procedure_ID, Insurance_ID, Service_Type, 
Treatment_Cost, Medication_Cost, @date_str, Patient_Satisfaction_Score, Referral_Source, 
Emergency_Visit, Payment_Status, @date_str, @date_str, Room_Type, Insurance_Coverage, 
Room_Charges_Daily_Rate)
set Date_of_Visit = STR_TO_DATE(@date_str, '%m/%d/%Y'),
    Follow_Up_Visit_Date = STR_TO_DATE(@followup_date_str, '%m/%d/%Y'),
    Discharge_Date = STR_TO_DATE(@discharge_date_str, '%m/%d/%Y'),
    Admitted_Date = STR_TO_DATE(@admitted_date_str, '%m/%d/%Y');



select count(*) as total_rows_in_visits from visits;
