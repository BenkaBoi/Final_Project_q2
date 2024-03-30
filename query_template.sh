#!/bin/bash
#query_template.sh

DB_NAME="FinalEx"

QUERY=$1

echo "$QUERY" |  sudo mysql -D $DB_NAME
