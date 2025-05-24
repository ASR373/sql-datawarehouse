/*
=============================================================
Create Tables Procedure in Bronze Schema (With Timing)
=============================================================
Script Purpose:
    Drops and recreates all bronze tables with timing logs
    for start and end of each table creation.
=============================================================
*/

CREATE OR REPLACE PROCEDURE bronze.create_all_bronze_tables()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
BEGIN
    RAISE NOTICE '🧹 Dropping existing bronze tables...';

    EXECUTE 'DROP TABLE IF EXISTS bronze.crm_cust_info CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.crm_prd_info CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.crm_sales_details CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.erp_cust_az12 CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.erp_loc_a101 CASCADE';
    EXECUTE 'DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2 CASCADE';

    -- crm_cust_info
    RAISE NOTICE '📦 Creating table: bronze.crm_cust_info';
    start_time := clock_timestamp();
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
    end_time := clock_timestamp();
    RAISE NOTICE '⏱️  Time taken: %.3f seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- crm_prd_info
    RAISE NOTICE '📦 Creating table: bronze.crm_prd_info';
    start_time := clock_timestamp();
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
    end_time := clock_timestamp();
    RAISE NOTICE '⏱️  Time taken: %.3f seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- crm_sales_details
    RAISE NOTICE '📦 Creating table: bronze.crm_sales_details';
    start_time := clock_timestamp();
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
    end_time := clock_timestamp();
    RAISE NOTICE '⏱️  Time taken: %.3f seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- erp_cust_az12
    RAISE NOTICE '📦 Creating table: bronze.erp_cust_az12';
    start_time := clock_timestamp();
    EXECUTE '
        CREATE TABLE bronze.erp_cust_az12 (
            CID VARCHAR(50),
            BDATE DATE,
            GEN VARCHAR(20)
        )';
    end_time := clock_timestamp();
    RAISE NOTICE '⏱️  Time taken: %.3f seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- erp_loc_a101
    RAISE NOTICE '📦 Creating table: bronze.erp_loc_a101';
    start_time := clock_timestamp();
    EXECUTE '
        CREATE TABLE bronze.erp_loc_a101 (
            CID VARCHAR(50),
            CNTRY VARCHAR(50)
        )';
    end_time := clock_timestamp();
    RAISE NOTICE '⏱️  Time taken: %.3f seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- erp_px_cat_g1v2
    RAISE NOTICE '📦 Creating table: bronze.erp_px_cat_g1v2';
    start_time := clock_timestamp();
    EXECUTE '
        CREATE TABLE bronze.erp_px_cat_g1v2 (
            ID VARCHAR(50),
            CAT VARCHAR(50),
            SUBCAT VARCHAR(50),
            MAINTENANCE VARCHAR(50)
        )';
    end_time := clock_timestamp();
    RAISE NOTICE '⏱️  Time taken: %.3f seconds', EXTRACT(EPOCH FROM end_time - start_time);

    RAISE NOTICE '✅ All bronze tables created successfully.';
END;
$$;
