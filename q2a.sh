#!/bin/bash
#q2a.sh

is_mysql_installed() {
    #check if MySQL is installed by trying to get its version. Output and errors are redirected to /dev/null.
    #a successful command execution (status 0) indicates MySQL is installed.
    if mysql --version >/dev/null 2>&1; then 
        echo "MySQL is already installed."
        return 1
    else
        echo "MySQL is not installed."
        return 0
    fi
}

#Function to install MySQL
install_mysql() {
    echo "Installing MySQL..."
    sudo apt-get update
    sudo apt-get install -y mysql-server

    if [ $? -eq 0 ]; then # $? check exit status
        echo "MySQL installed successfully."
    else
        echo "Failed to install MySQL."
        exit 1
    fi
}

#start MySQL service
start_mysql_service() {
    echo "Starting MySQL service..."
    sudo service mysql start

    if [ $? -eq 0 ]; then
        echo "MySQL service started successfully."
    else
        echo "Failed to start MySQL service."
        exit 1
    fi
}

if is_mysql_installed; then
    install_mysql
    start_mysql_service
fi

#initialize global variables 
DB_NAME="FinalEx"
TABLE_NAME="StudentScores"
DATA_FILE="study_performance.csv"

#create database
create_database() {
    echo "Checking if database $DB_NAME exists..."
    if echo "USE $DB_NAME;" | sudo mysql; then
        echo "Database $DB_NAME already exists. Continuing with existing database."
    else
        echo "Database $DB_NAME does not exist. Creating database..."
        echo "CREATE DATABASE $DB_NAME;" | sudo mysql

        if [ $? -eq 0 ]; then
            echo "Database created successfully."
        else
            echo "Failed to create database."
            exit 1
        fi
    fi
}

#create table from CSV headers
create_table_from_csv() {
    echo "Creating table ($TABLE_NAME)..."
    
    #extract the headers with head -1
    local headers=$(head -1 "$DATA_FILE") 
    #initialize column_definitions with a new column 'id' (at the original csv there is no primary key column and any identifier for each instance).
    local column_definitions="id INT AUTO_INCREMENT PRIMARY KEY, " #FIXED BUG: we changed the type from VARCHAR(255) to INT
    #define manually the column types according to the csv column
    local column_types=("VARCHAR(255)" "VARCHAR(255)" "VARCHAR(255)" "VARCHAR(255)" "VARCHAR(255)" "INT" "INT" "INT") 
    local i=0 #initialize a counter for column_types index

    IFS=',' read -ra ADDR <<< "$headers" #split by ',' headers' string into array - ADDR
    for col in "${ADDR[@]}"; do #run on ADDR elements (the column names)
    
        #replace by using sed -r (regex) all the spaces with underscores for SQL compatibility
        col=$(echo $col | sed -r 's/\s/_/g') 
        #wrap the column name with single quote for SQL compatibility
        col=$(echo $col | sed -r 's/(.*)/`\1`/g') 
        #concatenate all the formatted column names and their's type into column_definitions
        column_definitions+="$col ${column_types[i]}, " 
        ((i++))
    done

    column_definitions=${column_definitions%, } #remove the last ','

    echo "CREATE TABLE $TABLE_NAME ($column_definitions);" | sudo mysql -D $DB_NAME #create the table

    if [ $? -eq 0 ]; then
        echo "Table created successfully."
    else
        echo "Failed to create table."
        exit 1
    fi
}

#import CSV data into the table
import_csv_to_table() {
    #Format the headers for SQL - group with regex all the column names and wrap it with single quotes
    local headers=$(head -1 "$DATA_FILE" | sed -r 's/([^,]+)/`\1`/g') 
    echo "Importing data from '$DATA_FILE' to table '$TABLE_NAME'..."
    
    #while loop that runs on each line in the csv file except the first (headers)
    tail -n +2 "$DATA_FILE" | while IFS= read -r line; do 
    
        #Handle integer fields for SQL compatibility and remove quotes
        line=$(echo "$line" | sed -r "s/'//g" | sed -r "s/\"//g" | sed "s/,/','/g") 
        
        echo "USE \`$DB_NAME\`; INSERT INTO \`$TABLE_NAME\` ($headers) VALUES ('$line');" | sudo mysql #insert all the format data
    done
    echo "Data import completed."
}

create_database
create_table_from_csv
import_csv_to_table
