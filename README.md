# Employee Attrition & HR Analytics Dashboard
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi)
![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Python](https://img.shields.io/badge/Python-EDA-green)

> An end-to-end HR Analytics project leveraging Microsoft Excel, SQL, Python, and Power BI to analyze employee attrition, workforce performance, employee demographics, and HR KPIs through interactive dashboards and actionable business insights.

## 📊 Dashboard Preview

![Dashboard Preview](https://github.com/Hariomdubey01/End-to-End-HR-Analytics-Employee-Attrition-Dashboard/blob/main/HR%20Analytics%20Dashboard.png)

## 📑 Table of Contents

- [Overview](#-overview)
- [Project Objectives](#-project-objectives)
- [Project Workflow](#-project-workflow)
- [Dashboard Highlights](#-dashboard-highlights)
- [Key Business Insights](#-key-business-insights)
- [Business Recommendations](#-business-recommendations)
- [Data Integrity & Corrections](#-data-integrity--corrections)
- [SQL Analytics](#-sql-analytics)
- [Python Analysis](#-python-analysis)
- [Tech Stack](#-tech-stack)
- [Data Preparation](#-data-preparation)
- [Dataset](#-dataset)
- [Business Value](#-business-value)
- [Skills Demonstrated](#-skills-demonstrated)
- [Repository Structure](#-repository-structure)
- [Getting Started](#-getting-started)
- [Future Enhancements](#-future-enhancements)
- [About Me](#-about-me)
- [Contact](#-contact)

---

## 📖 Overview

Employee attrition is one of the most significant challenges faced by organizations, impacting productivity, employee retention, and recruitment costs.

This project presents a complete **HR Analytics solution** developed using **Microsoft Excel, SQL, Python, and Power BI**. The workflow covers data preparation, SQL-based business analysis, exploratory data analysis (EDA), and dashboard development to uncover workforce trends, identify high-risk employee groups, and support data-driven HR decision-making.

---
## ⭐ Key Features

- End-to-End HR Analytics Project
- SQL Business Analysis (30+ Queries)
- Python EDA & Statistical Analysis
- Interactive Power BI Dashboard
- Executive KPI Reporting
- HR Business Recommendations

## 🎯 Project Objectives

The project was designed to answer key HR business questions, including:

- What is the overall employee attrition rate?
- Which departments experience the highest attrition?
- Which age groups and tenure groups are most likely to leave?
- How do job satisfaction and work-life balance influence attrition?
- Which employee segments require immediate retention strategies?
- How can HR use data to improve workforce planning?

---

## 🔄 Project Workflow

```text
📂 Excel Data Preparation
│
├── Data Import
├── Data Cleaning
├── Missing Value Handling
└── Data Validation
        │
        ▼
🗄️ SQL Analysis (30 Business Queries)
│
├── Employee Workforce Analysis
├── Attrition Analysis
├── Salary & Performance Analysis
├── Department Insights
└── Advanced SQL Analytics
        │
        ▼
🐍 Python
│
├── Data Preprocessing
├── Exploratory Data Analysis (EDA)
├── Statistical Analysis
└── Data Visualization
        │
        ▼
📊 Power BI
│
├── Data Modeling
├── DAX Measures
├── Interactive Dashboard
└── KPI Development
        │
        ▼
📈 Business Insights
│
├── Workforce Analysis
├── Attrition Trends
├── High-Risk Employee Identification
└── HR Recommendations
```

## ✨ Dashboard Highlights

### 📌 Executive KPIs

- Total Employees
- Attrition Rate
- Average Salary
- Average Age
- Average Tenure
- Average Job Satisfaction

### 👨‍💼 HR Analytics

- Department-wise Attrition
- Gender-wise Attrition
- Age Group Analysis
- Tenure Group Analysis
- Job Satisfaction Analysis
- Work-Life Balance Analysis
- Performance Rating Analysis
- Salary by Job Role

### 📈 Executive Summary

- High-risk employee identification
- Business recommendations
- Workforce risk profiling
- Executive KPI reporting

### 🎛 Interactive Features

- Dynamic slicers
- Cross-filtering
- KPI cards
- Interactive navigation
- Executive summary page

---

## 📊 Key Business Insights

The dashboard reveals several important workforce trends:

- 📉 Overall employee attrition stands at **16.2%** across **4,327 employees**, indicating opportunities to improve retention.
- 👶 Employees with **0–2 years of tenure** experience the highest attrition (**30.2%**), making early retention initiatives a priority.
- 🎯 Employees aged **18–25 years** show the highest attrition (**35.9%**), significantly higher than other age groups.
- 🏢 The **Human Resources department** records the highest attrition rate (**29.8%**), followed by Research & Development and Sales.
- 😊 Lower **job satisfaction** and poor **work-life balance** are strongly associated with increased employee attrition.
- 🚻 Gender has minimal influence on attrition, suggesting other workforce factors have a greater impact.
- ⚠️ High-risk employees typically belong to the **18–25 age group**, have **0–2 years of tenure**, work in **HR**, and report poor work-life balance.

---

## 💡 Business Recommendations

Based on the analysis, the following recommendations can improve employee retention:

- Strengthen onboarding and mentoring programs during employees' first two years.
- Improve work-life balance through flexible work policies and wellness initiatives.
- Conduct focused retention reviews within the Human Resources department.
- Increase employee engagement through regular feedback, career development, and recognition programs.
- Monitor high-risk employee segments using HR dashboards for proactive decision-making.

---

## 🔍 Data Integrity & Corrections

Every deliverable in this repo was cross-checked against the underlying data before being finalized — not just built once and left alone. Fixes applied during that process:

| Area | Issue Found | Fix |
|------|-------------|-----|
| Power BI DAX | `Attrition Rate` measure used `COUNTROWS()`, which produced rates **over 100%** when sliced by department (duplicate rows in the source table inflated the count) | Rebuilt using `DISTINCTCOUNT(EmployeeID)` so the rate is mathematically bounded at 100% regardless of row duplication |
| SQL Query #16 | Missing `ORDER BY ... LIMIT 1` — returned every department's satisfaction score instead of the single highest one the query's name promised | Added `ORDER BY AverageJobSatisfaction DESC LIMIT 1` |
| SQL Query #23 | Named "Dense Rank" but used `RANK()`, which skips numbers on ties | Switched to `DENSE_RANK()` to match the query's own name and intended behavior |
| SQL Queries #18, #25 | Compared numeric columns to string literals (`= '0'`, `= '1'`) | Changed to numeric literals (`= 0`, `= 1`) |
| SQL Query #30 (HR Risk Score) | Inconsistent threshold — `WorkLifeBalance < 2` in one branch vs. `<= 2` in another | Harmonized to `<= 2` in both branches |
| Notebook | Hardcoded MySQL password in a cell that would be committed to this public repo | Replaced with environment-variable lookup (`os.getenv`) and a fail-fast check if the variable isn't set |
| Notebook | Claimed "Statistical Analysis" as a skill with no actual hypothesis testing performed | Added chi-square tests (Department, WorkLifeBalance, JobSatisfaction, MaritalStatus, BusinessTravel — all p < 0.05) and a Welch's t-test on Age (p < 0.000001) |
| Notebook | HR Risk Score was a hand-picked rule with no validation against real outcomes | Validated it: **41.4% attrition in the "High Risk" tier vs. 12.1% in "Low Risk"** — confirms the rule carries real signal, not just plausible-sounding thresholds |
| Dataset Overview slide | Stated "35 Features/Attributes" | Corrected to **31** (verified directly against the CSV column count) |

The `Attrition Rate` DAX bug in particular is worth knowing well — it's the best walkthrough example in this project of catching an analytical error (a rate impossible above 100%), diagnosing the root cause (row duplication via `COUNTROWS`), and fixing it in a way that's robust regardless of future data changes (`DISTINCTCOUNT`).

---

## 🗄 SQL Analytics

The SQL phase includes **30 business-focused queries** covering:

- Aggregate Functions
- GROUP BY Analysis
- CASE Statements
- Window Functions
- Common Table Expressions (CTEs)
- Subqueries
- Running Totals
- HR Risk Score
- KPI Reporting

---

## 🐍 Python Analysis

Performed using:

- Pandas
- NumPy
- Matplotlib
- Seaborn

Key tasks include:

- Data Cleaning
- Data Preprocessing
- Missing Value Analysis
- Exploratory Data Analysis (EDA)
- Statistical Significance Testing (chi-square, t-test)
- Data Visualization

---

## 🛠 Tech Stack

| Technology | Purpose |
|------------|---------|
| Microsoft Excel | Data Preparation |
| SQL (MySQL) | Data Analysis |
| Python | Data Cleaning & EDA |
| Pandas | Data Manipulation |
| NumPy | Numerical Analysis |
| Matplotlib | Data Visualization |
| Seaborn | Statistical Visualization |
| Power BI | Dashboard Development |
| DAX | KPI Calculations |
| Power Query | Data Transformation |

---

## 🧹 Data Preparation

Before analysis, the dataset was validated and prepared:

- Checked for missing values and duplicate rows (none were found — the dataset was clean on arrival, so no imputation or row removal was needed)
- Data type validation and correction
- Feature standardization (numeric scales mapped to readable labels, e.g. 1–4 → Low/Medium/High/Very High)
- Continuous fields bucketed into groups (age, tenure) for cleaner reporting
- SQL import preparation
- Power BI data modeling

---

## 📂 Dataset

**Dataset:** IBM HR Analytics Employee Attrition Dataset

| Attribute | Details |
|-----------|----------|
| Domain | Human Resources |
| Records | 4,327 Employees |
| Features | Employee demographics, salary, department, education, job role, performance, job satisfaction, work-life balance, business travel, promotions, and attrition |

---

## 💼 Business Value

This dashboard helps organizations:

- Monitor employee attrition trends.
- Identify high-risk employee groups.
- Improve employee retention strategies.
- Evaluate workforce performance.
- Monitor HR KPIs.
- Support strategic HR decision-making.
- Reduce recruitment and turnover costs.

---

## 💡 Skills Demonstrated

### Data Analytics

- Data Cleaning
- Data Preprocessing
- Exploratory Data Analysis (EDA)
- Statistical Analysis
- Data Visualization

### SQL

- Aggregate Functions
- CASE Statements
- Window Functions
- CTEs
- Subqueries
- Business Query Writing

### Power BI

- Dashboard Development
- DAX
- Power Query
- Data Modeling
- KPI Development
- Interactive Visualizations

### Business Intelligence

- HR Analytics
- Workforce Analytics
- KPI Reporting
- Executive Dashboard Design
- Data Storytelling

---

## 📁 Repository Structure

```text
End-to-End-HR-Analytics-Employee-Attrition-Dashboard/

dashboard/
│
├── HR_Analytics_Dashboard.pbix
├── HR_Analytics_Dashboard.pdf
└── HR_Analytics_Dashboard.png

sql/
│
├── Employees_Analysis_SQL_Queries.sql
└── Employees_Analysis_SQL_Queries.pdf

notebooks/
│
└── HR_Analytics_EDA_Notebook_Executed.ipynb

dataset/
│
└── HR_Analytics_Cleaned_Master.csv

presentation/
│
└── HR_Analytics_Full_Presentation.pdf
└── HR_Analytics_Full_Presentation.pptx

README.md
```

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Hariomdubey01/End-to-End-HR-Analytics-Employee-Attrition-Dashboard.git
```

### 2. Open the Power BI Dashboard

Open the `.pbix` file using **Microsoft Power BI Desktop**.

### 3. Run SQL Queries

Import the dataset into **MySQL** and execute the SQL script:

```sql
source Employees_Analysis_SQL_Queries.sql;
```

Alternatively, you can open and run the `Employees_Analysis_SQL_Queries.sql` file using MySQL Workbench or any compatible SQL client.

### 4. Run Python Analysis

Install dependencies:

```bash
pip install pandas numpy matplotlib seaborn
```

Launch Jupyter Notebook:

```bash
jupyter notebook
```

Open the notebook:

```text
HR_Analytics_EDA_Notebook_Executed.ipynb
```

---

## 🔮 Future Enhancements

- Predictive Employee Attrition Modeling
- Machine Learning Integration
- Employee Segmentation
- HR Forecasting Dashboard
- Drill-through Analysis
- Automated Data Refresh
- Natural Language Query Support

---

## 👨‍💻 About Me

**Hariom Dubey**

Aspiring **Data Analyst** passionate about transforming data into meaningful business insights.

### Areas of Interest

- Data Analytics
- Business Intelligence
- Data Visualization
- SQL
- Python
- Power BI
- Machine Learning

---

## 📬 Contact

| Platform | Link |
|----------|------|
| 📧 Email | <mailto:hariomkumard8@gmail.com> |
| 💼 LinkedIn | [linkedin.com/in/hariom-dubey-81b752285](https://linkedin.com/in/hariom-dubey-81b752285) |
| 💻 GitHub | [github.com/Hariomdubey01](https://github.com/Hariomdubey01) |
---
