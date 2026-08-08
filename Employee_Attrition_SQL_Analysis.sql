USE hr_analysis;

-- # 1. Total Employees 
SELECT COUNT(*) AS Total_employee
FROM hr_analytics_cleaned_master;

-- # 2. Overall Attrition Rate
SELECT ROUND(SUM(CASE WHEN
Attrition='Yes'
THEN 1 ELSE 0
END)*100.0/COUNT(*),2)
AS Attrition_rate
FROM hr_analytics_cleaned_master;

-- # 3. Department-wise Attrition Rate
SELECT
Department,
COUNT(*) AS Total_Employee,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
2
) AS AttritionRate
FROM hr_analytics_cleaned_master
GROUP BY Department
ORDER BY Total_Employee DESC;

-- # 4. Average Salary by Department
SELECT Department,
ROUND(AVG(MonthlyIncome),2) AS AverageSalary
FROM hr_analytics_cleaned_master
GROUP BY Department
ORDER BY AverageSalary DESC;

SELECT EmployeeID, EducationField, Department, MonthlyIncome
FROM hr_analytics_cleaned_master
ORDER BY MonthlyIncome DESC
LIMIT 10;

-- # 6. Gender Distribution
SELECT Gender,
COUNT(*) AS Employee
FROM hr_analytics_cleaned_master
GROUP BY Gender;

-- # 7. Job Role with Highest Attrition
SELECT JobRole,
COUNT(*) AS HighestAttrition
FROM hr_analytics_cleaned_master
WHERE Attrition='Yes'
GROUP BY JobRole
ORDER BY HighestAttrition DESC;

-- # 8. Average Experience by Department
SELECT Department,
ROUND(AVG(TotalWorkingYears),2) AS AverageExperience
FROM hr_analytics_cleaned_master
GROUP BY Department
ORDER BY AverageExperience DESC;

-- # 9. Employees by Education Level
SELECT 
Education_Label AS EducationLevel,
COUNT(*) AS Employees
FROM hr_analytics_cleaned_master
GROUP BY EducationLevel
ORDER BY Employees DESC;

-- # 10. Salary Hike Analysis
SELECT 
Department,
ROUND(AVG(PercentSalaryHike),2) AS AvgSalaryHike
FROM hr_analytics_cleaned_master
GROUP BY Department
ORDER BY AvgSalaryHike DESC;

-- # 11. Work-Life Balance vs Attrition
SELECT
WorkLifeBalance_Label,
COUNT(*) AS Employee,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition
FROM hr_analytics_cleaned_master
GROUP BY WorkLifeBalance_Label;

-- # 12. Job Satisfaction vs Attrition
SELECT 
JobSatisfaction_Label,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition,
COUNT(*) AS Employee
FROM hr_analytics_cleaned_master
GROUP BY JobSatisfaction_Label;

-- # 13. Performance Rating Distribution
SELECT
PerformanceRating_Label AS PerformanceRating,
COUNT(*) AS Employee
FROM hr_analytics_cleaned_master
GROUP BY PerformanceRating_Label;

-- # 14. Employees with More Than 10 Years Experience
SELECT EmployeeID, TotalWorkingYears
FROM hr_analytics_cleaned_master
WHERE TotalWorkingYears > 10;

-- # 15. Average Income by Job Role
SELECT JobRole,
ROUND(AVG(MonthlyIncome),2) AS AverageIncome
FROM hr_analytics_cleaned_master
GROUP BY JobRole;

-- # 16. Department with Highest Average Job Satisfaction
SELECT Department,
ROUND(AVG(JobSatisfaction),2) AS AverageJobSatisfaction
FROM hr_analytics_cleaned_master
GROUP BY Department
ORDER BY AverageJobSatisfaction DESC
LIMIT 1;

-- # 17. Age Group Analysis
SELECT 
CASE
WHEN Age<25 THEN '18-24'
WHEN Age BETWEEN 25 AND 35 THEN '25-34'
WHEN Age BETWEEN 35 AND 45 THEN '35-44'
WHEN Age BETWEEN 45 AND 55 THEN '45-54'
ELSE '55+' 
END AS AgeGroup,
COUNT(*) AS Employee
FROM hr_analytics_cleaned_master
GROUP BY AgeGroup;

-- # 18. Employees Never Promoted
SELECT
COUNT(*) AS Employee
FROM hr_analytics_cleaned_master
WHERE YearsSinceLastPromotion = 0;

-- # 19. Average Years at Company
SELECT
Department,
ROUND(AVG(YearsAtCompany),2) AS AverageYearsAtCompany
FROM hr_analytics_cleaned_master
GROUP BY Department;

-- # 20. Attrition by Business Travel
SELECT 
BusinessTravel,
COUNT(*) AS Employee,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition
FROM hr_analytics_cleaned_master
GROUP BY BusinessTravel;

-- # 21. Top 5 Departments by Salary
SELECT 
Department,
SUM(MonthlyIncome) AS Salary
FROM hr_analytics_cleaned_master
GROUP BY Department
ORDER BY Salary DESC
LIMIT 5;

-- # 22. Rank Employees by Salary (Window Function)
SELECT
EmployeeID,
Department,
MonthlyIncome,
RANK() OVER(ORDER BY MonthlyIncome DESC) AS SalaryRank
FROM hr_analytics_cleaned_master;

-- # 23. Dense Rank Salary Within Each Department
SELECT
EmployeeID,
Department,
MonthlyIncome,
DENSE_RANK() OVER(
PARTITION BY Department
ORDER BY MonthlyIncome DESC
) AS DenseRank
FROM hr_analytics_cleaned_master;

-- # 24. Running Total of Salary
SELECT
EmployeeID,
MonthlyIncome,
SUM(MonthlyIncome)
OVER(ORDER BY EmployeeID) AS RunningSalary
FROM hr_analytics_cleaned_master;

- # 25. Highest Paid Employee in Each Department
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY Department
               ORDER BY MonthlyIncome DESC
           ) AS RN
    FROM hr_analytics_cleaned_master
)
SELECT *
FROM CTE
WHERE RN = 1;

-- # 26. Average Salary Compared to Company Average
SELECT 
EmployeeID,
MonthlyIncome,
CASE
WHEN MonthlyIncome > (SELECT AVG(MonthlyIncome) FROM hr_analytics_cleaned_master)
THEN 'Above Average'
ELSE 'Below Average'
END AS SalaryStatus
FROM hr_analytics_cleaned_master;

-- # 27. Employees with Highest Experience per Department
SELECT
Department,
MAX(TotalWorkingYears) AS HighestExperience
FROM hr_analytics_cleaned_master
GROUP BY Department;

-- # 28. Average Training by Department
SELECT
Department,
ROUND(AVG(TrainingTimesLastYear),2) AS AvgTraining
FROM hr_analytics_cleaned_master
GROUP BY Department;

-- # 29. Attrition Percentage by Marital Status
SELECT
MaritalStatus,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100.0,2) AS AttritionPercentage
FROM hr_analytics_cleaned_master
GROUP BY MaritalStatus;

-- # 30. HR Risk Score (Advanced CASE Expression)
SELECT
    EmployeeID,
    Department,
    Age,
    MonthlyIncome,
    YearsAtCompany,
    JobSatisfaction,
    WorkLifeBalance,
    CASE
        WHEN JobSatisfaction <= 2
             AND YearsAtCompany < 3
             AND WorkLifeBalance <= 2
        THEN 'High Risk'

        WHEN JobSatisfaction <= 2
             OR WorkLifeBalance <= 2
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS HRRiskScore
FROM hr_analytics_cleaned_master;