#!/bin/bash
#q2c.sh

curl 127.0.0.1:5000 -X POST -d "SELECT 
    CONCAT('In ', YEAR, ', the most common parental education level among students with top math scores (>90) was ', ParentalEducation) AS Insight
FROM (
    SELECT 
        YEAR(Now()) AS YEAR, 
        parental_level_of_education AS ParentalEducation, 
        COUNT(*) AS Count
    FROM 
        StudentScores
    WHERE 
        math_score > 90
    GROUP BY 
        parental_level_of_education
    ORDER BY 
        Count DESC
    LIMIT 1
) AS DerivedTable;"


echo -e "\nOur logic, Expected higher math scores from students with parents holding master's or bachelor's degrees. Surprisingly, results showed students with parents having an associate's degree leading in math"
