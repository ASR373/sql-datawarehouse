#!/bin/bash

# Prompt for DB credentials
read -p "Enter DB name: " dbname
read -p "Enter DB username: " dbuser
read -sp "Enter DB password: " dbpass
echo ""
read -p "Enter DB host (default: localhost): " dbhost
read -p "Enter DB port (default: 5432): " dbport

# Use defaults if not provided
dbhost=${dbhost:-localhost}
dbport=${dbport:-5432}

echo "📁 Creating schema..."
psql -U "$dbuser" -d "$dbname" -h "$dbhost" -p "$dbport" -f setup/01_create_schemas.sql

echo "📦 Creating tables..."
psql -U "$dbuser" -d "$dbname" -h "$dbhost" -p "$dbport" -f setup/02_create_tables.sql

echo "📊 Loading data into tables..."
python3 setup/03_load_data.py "$dbname" "$dbuser" "$dbpass" "$dbhost" "$dbport"
