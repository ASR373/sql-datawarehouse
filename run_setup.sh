#!/bin/bash

echo "🛠️  PostgreSQL Bronze Setup Script"

# Prompt for DB credentials
read -p "Enter DB name: " dbname
read -p "Enter DB username: " dbuser
read -sp "Enter DB password: " dbpass
echo ""
read -p "Enter DB host (default: localhost): " dbhost
read -p "Enter DB port (default: 5432): " dbport

# Apply defaults
dbhost=${dbhost:-localhost}
dbport=${dbport:-5432}

echo ""
echo "🔗 Connecting to database '$dbname' on $dbhost:$dbport as user '$dbuser'..."

# Step 1: Create schema and stored procedure
echo "📁 Step 1: Creating bronze schema and DDL procedure..."
psql -U "$dbuser" -d "$dbname" -h "$dbhost" -p "$dbport" -f scripts/bronze/ddl_bronze.sql
if [ $? -ne 0 ]; then
  echo "❌ Error: Failed to create schema/procedure. Exiting."
  exit 1
fi

# Step 2: Call procedure to create all bronze tables
echo "📦 Step 2: Executing procedure to create bronze tables..."
psql -U "$dbuser" -d "$dbname" -h "$dbhost" -p "$dbport" -f scripts/bronze/call_procedure.sql
if [ $? -ne 0 ]; then
  echo "❌ Error: Procedure execution failed. Exiting."
  exit 1
fi

# Step 3: Load data using Python script
echo "📊 Step 3: Loading CSV data into bronze tables..."
python3 scripts/load_data.py "$dbname" "$dbuser" "$dbpass" "$dbhost" "$dbport"
if [ $? -ne 0 ]; then
  echo "❌ Error: Python data load failed. Exiting."
  exit 1
fi

echo "✅ Setup complete! All bronze tables are created and populated."
