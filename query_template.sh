#!/bin/bash
#query_template.sh

DB_USER="myuser"
DB_NAME="FinalEx"
DB_HOST="localhost"
DB_PASSWORD="mypassword"

QUERY=$1

echo "$QUERY" | mysql -u "$DB_USER" -p"$DB_PASSWORD" -h "$DB_HOST" "$DB_NAME"

