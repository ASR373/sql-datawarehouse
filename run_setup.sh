#!/bin/bash

# Prompt for DB credentials
read -p "Enter DB name: " dbname
read -p "Enter DB username: " dbuser
read -sp "Enter DB password: " dbpass
echo ""
read -p "Enter DB host (default: localhost): " dbhost
read -p "Enter DB port (default: 5432): " dbport

dbhost=${dbhost:-localhost}
dbport=${dbport:-5432}

echo "📁 Creating schema and procedure..."
psql -U "$dbuser" -d "$dbname" -h "$dbhost" -p "$dbport" -f scripts/create_tables.sql

echo "📦 Creating all bronze tables via procedure..."
psql -U "$dbuser" -d "$dbname" -h "$dbhost" -p "$dbport" -f scripts/call_procedure.sql

echo "📊 Loading data into tables..."
python3 scripts/load_data.py "$dbname" "$dbuser" "$dbpass" "$dbhost" "$dbport"
