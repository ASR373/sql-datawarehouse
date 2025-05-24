/*
=============================================================
Create Tables in Bronze Schema
=============================================================
Script Purpose:
    This script drops and recreates all staging-level (bronze) tables
    used for CRM and ERP data ingestion into the 'datawarehouse' database.

WARNING:
    Running this script will drop all existing data in the following tables.
    Ensure backups or exports are taken before execution in production.
=============================================================
*/

-- Drop existing tables if they exist (safe to rerun)
DROP TABLE IF EXISTS bronze.crm_cust_info;
DROP TABLE IF EXISTS bronze.crm_prd_info;
DROP TABLE IF EXISTS bronze.crm_sales_details;
DROP TABLE IF EXISTS bronze.erp_cust_az12;
DROP TABLE IF EXISTS bronze.erp_loc_a101;
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;

-- CRM Customer Info Table
CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(10),
    cst_create_date DATE
);

-- CRM Product Info Table
CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(75),
    prd_cost INT,
    prd_line VARCHAR(10),
    prd_start_dt DATE,
    prd_end_dt DATE
);

-- CRM Sales Details Table
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

-- ERP Customer Table
CREATE TABLE bronze.erp_cust_az12 (
    CID VARCHAR(50),
    BDATE DATE,
    GEN VARCHAR(20)
);

-- ERP Location Table
CREATE TABLE bronze.erp_loc_a101 (
    CID VARCHAR(50),
    CNTRY VARCHAR(50)
);

-- ERP Product Category Table
CREATE TABLE bronze.erp_px_cat_g1v2 (
    ID VARCHAR(50),
    CAT VARCHAR(50),
    SUBCAT VARCHAR(50),
    MAINTENANCE VARCHAR(50)
);
