-- ================================================
-- Script: Create and Load RetailSQLAnalytics Database
-- Description: Sets up the database and loads cleaned data
-- ================================================

-- Drop and recreate the 'RetailSQLAnalytics' database
USE master;
GO
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'RetailSQLAnalytics')
BEGIN
    ALTER DATABASE RetailSQLAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RetailSQLAnalytics;
END;
GO

CREATE DATABASE RetailSQLAnalytics;
GO

USE RetailSQLAnalytics;
GO

-- Create schema
CREATE SCHEMA staging;
GO

-- Create Customer table
CREATE TABLE staging.Customer (
    customer_Id INT PRIMARY KEY,
    DOB DATE,
    Gender CHAR(1),
    city_code INT
);
GO

-- Create ProductCategory table
CREATE TABLE staging.ProductCategory (
    prod_cat_code INT,
    prod_cat VARCHAR(100),
    prod_sub_cat_code INT,
    prod_subcat VARCHAR(100),
    PRIMARY KEY (prod_cat_code, prod_sub_cat_code)
);
GO

-- Create Transactions table
CREATE TABLE staging.Transactions (
    transaction_id BIGINT PRIMARY KEY,
    cust_id INT,
    tran_date DATE,
    prod_sub_cat_code INT,
    prod_cat_code INT,
    Qty INT,
    Rate INT,
    Tax FLOAT,
    total_amt FLOAT,
    Store_type VARCHAR(50),
    FOREIGN KEY (cust_id) REFERENCES staging.Customer(customer_Id),
    FOREIGN KEY (prod_cat_code, prod_sub_cat_code) REFERENCES staging.ProductCategory(prod_cat_code, prod_sub_cat_code)
);
GO

-- Load Cleaned Data using BULK INSERT
-- Adjust paths as needed before executing

-- Load Customer
DELETE FROM staging.Customer;
GO
BULK INSERT staging.Customer
FROM 'C:\BulkData\Cleaned_Customer_Data.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- Load ProductCategory
DELETE FROM staging.ProductCategory;
GO
BULK INSERT staging.ProductCategory
FROM 'C:\BulkData\prod_cat_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    TABLOCK
);
GO

-- Load Transactions
DELETE FROM staging.Transactions;
GO
BULK INSERT staging.Transactions
FROM 'C:\BulkData\Clean_Transactions.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO
