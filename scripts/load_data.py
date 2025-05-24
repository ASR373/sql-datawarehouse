import psycopg2
import os
import sys

# Get credentials from command-line arguments
if len(sys.argv) != 6:
    print("Usage: python3 03_load_data.py <db_name> <user> <password> <host> <port>")
    sys.exit(1)

PG_DB, PG_USER, PG_PASSWORD, PG_HOST, PG_PORT = sys.argv[1:]

# Establish connection
conn = psycopg2.connect(
    dbname=PG_DB,
    user=PG_USER,
    password=PG_PASSWORD,
    host=PG_HOST,
    port=PG_PORT
)

cur = conn.cursor()

files_to_load = [
    {
        "file": "Datasets/source_erp/PX_CAT_G1V2.csv",
        "table": "bronze.erp_px_cat_g1v2",
        "columns": ("ID", "CAT", "SUBCAT", "MAINTENANCE")
    },
    {
        "file": "Datasets/source_erp/LOC_A101.csv",
        "table": "bronze.erp_loc_a101",
        "columns": ("CID", "CNTRY")
    },
    {
        "file": "Datasets/source_erp/CUST_AZ12.csv",
        "table": "bronze.erp_cust_az12",
        "columns": ("CID", "BDATE", "GEN")
    },
    {
        "file": "Datasets/source_crm/CRM_CUST_INFO.csv",
        "table": "bronze.crm_cust_info",
        "columns": ("cst_id", "cst_key", "cst_firstname", "cst_lastname", "cst_marital_status", "cst_gndr", "cst_create_date")
    },
    {
        "file": "Datasets/source_crm/CRM_PRD_INFO.csv",
        "table": "bronze.crm_prd_info",
        "columns": ("prd_id", "prd_key", "prd_nm", "prd_cost", "prd_line", "prd_start_dt", "prd_end_dt")
    },
    {
        "file": "Datasets/source_crm/CRM_SALES_DETAILS.csv",
        "table": "bronze.crm_sales_details",
        "columns": ("sls_ord_num", "sls_prd_key", "sls_cust_id", "sls_order_dt", "sls_ship_dt", "sls_due_dt", "sls_sales", "sls_quantity", "sls_price")
    }
]

for item in files_to_load:
    print(f"📥 Loading {item['file']} into {item['table']}...")
    try:
        with open(item["file"], "r") as f:
            next(f)  # Skip header
            cur.copy_from(f, item["table"], sep=",", columns=item["columns"])
        print("✅ Success")
    except Exception as e:
        print(f"❌ Failed to load {item['file']}: {e}")

conn.commit()
cur.close()
conn.close()
print("🎉 All loads complete.")
