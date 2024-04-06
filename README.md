**Developed by Ben Kairi - 206481160 , Maor Ben Eliyahu - 305523169**

# Q2: MySQL Data Integration and Analysis with HTTP Server

## Overview
This project involves setting up a MySQL database to store and analyze data from a CSV file, with the added functionality of an HTTP server for handling SQL queries.

## Key Components
- **MySQL Database**: Creation and management of a MySQL database and table, along with data importation from a CSV file.
- **HTTP Server**: A Flask-based HTTP server in Python that processes SQL queries sent via HTTP POST requests.
- **Data Analysis**: Execution of SQL queries.

## Installation and Setup
1. **Extract the Data File**: Before running the scripts, extract the data file from the study_performance.tar.gz archive.
2. **MySQL Installation and DB setup**: run q2a.sh
3. **Start Server**: Execute `python3 q2.py` to run the Flask HTTP server (makesure you're giving permissions for 'query_template.sh', can done with "chmod +x query_template.sh").
4. **POST & GET Requests**: call for a GET request for more instructions

## Example Queries - queries_requests.sh
- Average scores by gender.
- Performance based on test preparation.
- Parental education level and student count.

## Data Source
The dataset for this project is sourced from Kaggle




