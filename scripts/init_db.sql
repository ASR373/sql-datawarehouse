/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'datawarehouse'.
    Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.

WARNING:
    Running this script will drop the entire 'datawarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- NOTE: The following command must be run from another database (like 'postgres')
-- If you're already connected to 'datawarehouse', this will fail.

DROP DATABASE IF EXISTS datawarehouse;
CREATE DATABASE datawarehouse;

-- The schema creation must be run **after connecting to the new database**
-- So save the below into a separate file or run it after connecting:

-- Once inside the 'datawarehouse' DB:
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
