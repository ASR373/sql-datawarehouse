# 🗃️ PostgreSQL Bronze Layer Setup with Bulk Data Load

This project sets up a PostgreSQL schema and tables (bronze layer) and bulk loads data from CSV files. It includes fully automated scripts for repeatable, version-controlled data pipelines.

---

## 📁 Project Structure

sql_proj/
├── setup/
│ ├── 01_create_schemas.sql # Creates 'bronze' schema
│ ├── 02_create_tables.sql # Creates 6 bronze tables
│ └── 03_load_data.py # Loads all CSVs into PostgreSQL tables
├── Datasets/
│ ├── source_erp/
│ │ ├── PX_CAT_G1V2.csv
│ │ ├── LOC_A101.csv
│ │ └── CUST_AZ12.csv
│ └── source_crm/
│ ├── CRM_CUST_INFO.csv
│ ├── CRM_PRD_INFO.csv
│ └── CRM_SALES_DETAILS.csv
├── run_setup.sh # One-command automation script
├── .gitignore
└── README.md

yaml
Copy
Edit

---

## 🛠️ Requirements

- Python 3.x
- PostgreSQL (local or remote)
- Python `psycopg2` library:
  ```bash
  pip install psycopg2-binary
🚀 How to Run
Clone this repository:

bash
Copy
Edit
git clone https://github.com/<your-username>/sql_proj.git
cd sql_proj
Make sure your PostgreSQL server is running and the datawarehouse database exists.

Run the setup script:

bash
Copy
Edit
./run_setup.sh
You'll be prompted for:

Database name

Username

Password (input hidden)

Host (press Enter for default localhost)

Port (press Enter for default 5432)

🧩 What This Script Does
✅ Creates bronze schema (if not already present)

✅ Creates the following tables:

crm_cust_info

crm_prd_info

crm_sales_details

erp_cust_az12

erp_loc_a101

erp_px_cat_g1v2

✅ Bulk inserts data into all 6 tables from Datasets/ CSVs

💡 Notes
Table definitions are in setup/02_create_tables.sql

Data files are assumed to be clean and comma-delimited (.csv)

For production pipelines, consider migrating this to Docker + CI/CD

📜 License
This project is open source and free to use under the MIT License.

🙋‍♂️ Author
Leo Das
GitHub: @<your-username>
Email: you@example.com

yaml
Copy
Edit

---

### ✅ To Use This:
- Replace `<your-username>` with your GitHub username
- Update your contact/email if you like

Let me know if you'd like a sample `LICENSE` file or GitHub Actions CI/CD template next!
