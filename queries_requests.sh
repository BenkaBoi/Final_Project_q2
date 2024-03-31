#!/bin/bash
#queries_requests.sh

echo "Executing Query 1: Average Scores by Gender..."
curl 127.0.0.1:5000 -X POST -d "SELECT gender, AVG(math_score) AS avg_math, AVG(reading_score) AS avg_reading, AVG(writing_score) AS avg_writing FROM StudentScores GROUP BY gender;"

# Query 2: Check performance based on test preparation
echo -e "\nExecuting Query 2: Performance Based on Test Preparation..."
curl 127.0.0.1:5000 -X POST -d "SELECT test_preparation_course, AVG(math_score) AS avg_math, AVG(reading_score) AS avg_reading, AVG(writing_score) AS avg_writing FROM StudentScores GROUP BY test_preparation_course;"

# Query 3: Count of students by parental level of education
echo -e "\nExecuting Query 3: Count of Students by Parental Level of Education..."
curl 127.0.0.1:5000 -X POST -d "SELECT parental_level_of_education, COUNT(*) AS num_students FROM StudentScores GROUP BY parental_level_of_education;"

