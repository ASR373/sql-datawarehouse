/*
=============================================================
Create Database and Schemas
=============================================================
WARNING:
    Drops and recreates 'datawarehouse'. Backup first!
=============================================================
*/

-- Run from another database (e.g., postgres)
DROP DATABASE IF EXISTS datawarehouse;
CREATE DATABASE datawarehouse;

-- After switching to datawarehouse DB:
-- (Connect to 'datawarehouse' and run below)

CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
