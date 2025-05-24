/*
=============================================================
Create Tables Procedure in Bronze Schema
=============================================================
Script Purpose:
    Creates a procedure that drops and recreates all bronze tables.
    This is useful for refreshing the staging layer.
=============================================================
*/

-- Create the procedure inside the bronze schema
CREATE OR REPLACE PROCEDURE bronze.create_all_bronze_tables()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Drop existing tables if they exist
    EXECUTE 'DROP TABLE IF EXISTS bronze.crm_cust_info CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.crm_prd_info CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.crm_sales_details CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.erp_cust_az12 CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.erp_loc_a101 CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2 CASCADE';

    -- Recreate all tables
    EXECUTE '
        CREATE TABLE bronze.crm_cust_info (
            cst_id INT,
            cst_key VARCHAR(50),
            cst_firstname VARCHAR(50),
            cst_lastname VARCHAR(50),
            cst_marital_status VARCHAR(50),
            cst_gndr VARCHAR(10),
            cst_create_date DATE
        )';

    EXECUTE '
        CREATE TABLE bronze.crm_prd_info (
            prd_id INT,
            prd_key VARCHAR(50),
            prd_nm VARCHAR(75),
            prd_cost INT,
            prd_line VARCHAR(10),
            prd_start_dt DATE,
            prd_end_dt DATE
        )';

    EXECUTE '
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
        )';

    EXECUTE '
        CREATE TABLE bronze.erp_cust_az12 (
            CID VARCHAR(50),
            BDATE DATE,
            GEN VARCHAR(20)
        )';

    EXECUTE '
        CREATE TABLE bronze.erp_loc_a101 (
            CID VARCHAR(50),
            CNTRY VARCHAR(50)
        )';

    EXECUTE '
        CREATE TABLE bronze.erp_px_cat_g1v2 (
            ID VARCHAR(50),
            CAT VARCHAR(50),
            SUBCAT VARCHAR(50),
            MAINTENANCE VARCHAR(50)
        )';
END;
$$;
