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

DB_NAME="FinalEx"

#create database
create_database() {
    echo "Creating database ($DB_NAME)..."
    echo "CREATE DATABASE $DB_NAME;" | sudo mysql

    if [ $? -eq 0 ]; then
        echo "Database created successfully."
    else
        echo "Failed to create database."
        exit 1
    fi
}


