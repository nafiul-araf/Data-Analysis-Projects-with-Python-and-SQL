-- Create schema and use it
CREATE SCHEMA IF NOT EXISTS grocery_SP;
USE grocery_SP;

-- Create the grocery_sales fact table to load raw data
CREATE TABLE IF NOT EXISTS grocery_sales (
    `Item Fat Content` VARCHAR(50),
    `Item Identifier` VARCHAR(50),
    `Item Type` VARCHAR(50),
    `Outlet Establishment Year` INT,
    `Outlet Identifier` VARCHAR(50),
    `Outlet Location Type` VARCHAR(50),
    `Outlet Size` VARCHAR(50),
    `Outlet Type` VARCHAR(50),
    `Item Visibility` DECIMAL(12,10),
    `Item Weight` DECIMAL(10,5),
    `Sales` DECIMAL(10,5),
    `Rating` INT
);

-- Load data into grocery_sales table (ensure local_infile is enabled)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BlinkIT_Grocery_Data.csv'
INTO TABLE grocery_sales
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`Item Fat Content`, `Item Identifier`, `Item Type`, `Outlet Establishment Year`, `Outlet Identifier`, `Outlet Location Type`, `Outlet Size`, 
`Outlet Type`, `Item Visibility`, `Item Weight`, `Sales`, `Rating`);

-- Procedure to create Star Schema
DELIMITER $$

CREATE PROCEDURE grocery_schema()
BEGIN
    -- Create dim_item table
    CREATE TABLE IF NOT EXISTS dim_item (
        `Item ID` INT AUTO_INCREMENT PRIMARY KEY,
        `Item Identifier` VARCHAR(255) NOT NULL,
        `Item Fat Content` VARCHAR(255) NOT NULL,
        `Item Type` VARCHAR(255) NOT NULL,
        UNIQUE(`Item Identifier`)
    );

    -- Create dim_outlet table
    CREATE TABLE IF NOT EXISTS dim_outlet (
        `Outlet ID` INT AUTO_INCREMENT PRIMARY KEY,
        `Outlet Identifier` VARCHAR(255) NOT NULL,
        `Outlet Establishment Year` INT NOT NULL,
        UNIQUE(`Outlet Identifier`)
    );

    -- Create dim_location_type table
    CREATE TABLE IF NOT EXISTS dim_location_type (
        `Location Type ID` INT AUTO_INCREMENT PRIMARY KEY,
        `Outlet Location Type` VARCHAR(255) NOT NULL,
        UNIQUE(`Outlet Location Type`)
    );

    -- Create dim_outlet_type table
    CREATE TABLE IF NOT EXISTS dim_outlet_type (
        `Outlet Type ID` INT AUTO_INCREMENT PRIMARY KEY,
        `Outlet Type` VARCHAR(255) NOT NULL,
        UNIQUE(`Outlet Type`)
    );

    -- Create fact_grocery table
    CREATE TABLE IF NOT EXISTS fact_grocery (
        `Fact ID` INT AUTO_INCREMENT PRIMARY KEY, -- Adding primary key for fact table
        `Item ID` INT,
        `Outlet ID` INT,
        `Location Type ID` INT,
        `Outlet Size` VARCHAR(255),
        `Outlet Type ID` INT,
        `Item Visibility` DECIMAL(12,10),
        `Item Weight` DECIMAL(10,5),
        `Sales` DECIMAL(10,5),
        `Rating` INT,
        FOREIGN KEY (`Item ID`) REFERENCES dim_item(`Item ID`) ON DELETE CASCADE,
        FOREIGN KEY (`Outlet ID`) REFERENCES dim_outlet(`Outlet ID`) ON DELETE CASCADE,
        FOREIGN KEY (`Location Type ID`) REFERENCES dim_location_type(`Location Type ID`) ON DELETE CASCADE,
        FOREIGN KEY (`Outlet Type ID`) REFERENCES dim_outlet_type(`Outlet Type ID`) ON DELETE CASCADE
    );

    -- Populate dimension tables
    INSERT IGNORE INTO dim_item (`Item Identifier`, `Item Fat Content`, `Item Type`)
    SELECT DISTINCT `Item Identifier`, `Item Fat Content`, `Item Type` 
    FROM grocery_sales
    WHERE `Item Identifier` IS NOT NULL AND `Item Identifier` <> '';

    INSERT IGNORE INTO dim_outlet (`Outlet Identifier`, `Outlet Establishment Year`)
    SELECT DISTINCT `Outlet Identifier`, `Outlet Establishment Year` 
    FROM grocery_sales
    WHERE `Outlet Identifier` IS NOT NULL AND `Outlet Identifier` <> '';

    INSERT IGNORE INTO dim_location_type (`Outlet Location Type`)
    SELECT DISTINCT `Outlet Location Type` 
    FROM grocery_sales
    WHERE `Outlet Location Type` IS NOT NULL AND `Outlet Location Type` <> '';

    INSERT IGNORE INTO dim_outlet_type (`Outlet Type`)
    SELECT DISTINCT `Outlet Type`
    FROM grocery_sales
    WHERE `Outlet Type` IS NOT NULL AND `Outlet Type` <> '';

    -- Populate fact_grocery table
    INSERT INTO fact_grocery 
        (`Item ID`, `Outlet ID`, `Location Type ID`, `Outlet Size`, `Outlet Type ID`, `Item Visibility`, `Item Weight`, `Sales`, `Rating`)
    SELECT 
        i.`Item ID`, o.`Outlet ID`, l.`Location Type ID`, g.`Outlet Size`,
        ot.`Outlet Type ID`, g.`Item Visibility`, g.`Item Weight`, g.`Sales`, g.`Rating`
    FROM grocery_sales AS g
    LEFT JOIN dim_item AS i ON g.`Item Identifier` = i.`Item Identifier`
    LEFT JOIN dim_outlet AS o ON g.`Outlet Identifier` = o.`Outlet Identifier`
    LEFT JOIN dim_location_type AS l ON g.`Outlet Location Type` = l.`Outlet Location Type`
    LEFT JOIN dim_outlet_type AS ot ON g.`Outlet Type` = ot.`Outlet Type`;

END $$

DELIMITER ;

-- Execute the procedure
CALL grocery_schema();


-- Select data to confirm tables are populated correctly
SELECT * FROM dim_item;
SELECT * FROM dim_outlet;
SELECT * FROM dim_location_type;
SELECT * FROM dim_outlet_type;
SELECT * FROM fact_grocery;