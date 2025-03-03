# Introductoon
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql](https://github.com/MissSamyuktha/SQL-Data-Job-Analysis/tree/main/project_sql)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data is sourced from [Data Jobs Dataset](https://www.lukebarousse.com/sql) collected by [Luke Barosse](https://github.com/lukebarousse). It's packed with insights on job titles, salaries, locations, and essential skills.

The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

1. **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
2. **PostgreSQL**: The chosen database management system, ideal for handling large data.
3. **Visual Studio Code**: For database management and executing SQL queries.
4. **GitHub**: For sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```
SELECT
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg

FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range**: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.

- **Leadership and Specialization**: Roles with titles like Director, Associate Director, and Principal often command higher salaries, indicating the value placed on leadership and specialized skills.

- **Industry Diversity**: Companies from diverse industries such as tech (Meta), telecom (AT&T), and healthcare (Uclahealthcareers) highlight the universal demand for data analysis skills.

In short, seniority and industry (especially tech) are key drivers of higher salaries.  

![Top Paying Jobs]()   
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query result.*

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg

    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:  
- **SQL** & **Python** Lead – Essential for querying, automation, and data analysis.
- **Tableau** & **Power BI** – Key for data visualization and reporting.
- **Cloud & Big Data** – *AWS*, *Azure*, and *Snowflake* are in demand.
- **Excel** is Still Relevant – Used for quick analysis and reporting.
- **Collaboration** Tools Matter – *Git*, *Jira*, and *Confluence* show teamwork is valued.   

Focusing on SQL, Python, and visualization tools is crucial for high-paying Data Analyst roles.  
 ![Skills For Top Paying Jobs]()

*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results*

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
SELECT
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skill_name
ORDER BY
    demand_count DESC
LIMIT 5;
```
Quick Insights:
- **SQL** is King 🏆 – The most in-demand skill, crucial for querying and managing data.
- **Excel** is Still Strong 📊 – Despite modern tools, Excel remains a staple for analysis.
- **Python**’s Growing Importance 🐍 – Essential for automation, data manipulation, and analytics.
- **Tableau & Power BI** Dominate Visualization 🎨 – Business intelligence tools are key for reporting.  

Takeaway:  
Mastering SQL, Excel, Python, and visualization tools (Tableau, Power BI) is essential for landing a high-demand Data Analyst role.  

| Skill      | Demand Count |
|------------|--------------|
| SQL        | 92,628       |
| Excel      | 67,031       |
| Python     | 57,326       |
| Tableau    | 46,554       |
| Power BI   | 39,468       |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT
    skills_dim.skills AS skill_name,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skill_name
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Quick Insights on Top-Paying Skills for Data Analysts:

- **Niche & Specialized Skills** Pay More 💰 – Rare skills like SVN ($400K), Solidity ($179K), and Couchbase ($160K) offer high salaries.
- **AI & ML** Tools are Lucrative 🤖 – DataRobot, MXNet, TensorFlow, Keras, PyTorch, and Hugging Face show strong demand for AI expertise.
- **Cloud & DevOps** Skills Matter ☁️ – Terraform, VMware, Ansible, and Puppet highlight the importance of cloud infrastructure.
- **Big Data** & Streaming Skills Are Valuable 📊 – Kafka, Cassandra, and Airflow are crucial for handling large-scale data processing.
- **Version Control & Collaboration** Tools Pay Well 🔧 – GitLab, Bitbucket, and Atlassian show that companies value structured development workflows.   

| Skill         | Average Salary ($) |
|--------------|------------------|
| SVN          | 400,000          |
| Solidity     | 179,000          |
| Couchbase    | 160,515          |
| DataRobot    | 155,486          |
| Golang       | 155,000          |
| MXNet        | 149,000          |
| Dplyr        | 147,633          |
| VMware       | 147,500          |
| Terraform    | 146,734          |
| Twilio       | 138,500          |

*Table of the average salary for the top 10 paying skills for data analysts.*

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.  
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS demand_count,
    AVG(salary_year_avg) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
Having
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
 Quick Insights on High-Demand & High-Paying Skills for Data Analysts:

- **Big Data & Cloud Dominate** ☁️ – Kafka, Spark, Hadoop, Snowflake, Databricks, and GCP are crucial for handling large-scale data processing.
- **AI & ML Skills Are Lucrative** 🤖 – TensorFlow, PyTorch, and Pandas indicate strong demand for machine learning and deep learning expertise.
- **DevOps & Scripting Skills Pay Well** 💻 – Linux, Unix, Shell, and Git show the importance of automation and version control in data roles.  

🔥 Takeaway:  
To maximize salary & job opportunities, focus on Big Data, AI/ML, DevOPs, and Cloud Technologies! 🚀 

| Skill ID | Skill       | Category         | Demand Count | Average Salary ($) |
|----------|------------|------------------|--------------|------------------|
| 98       | Kafka      | Cloud & Big Data | 40           | 129,999         |
| 101      | PyTorch    | AI/ML            | 20           | 125,226         |
| 31       | Perl       | Programming      | 20           | 124,685         |
| 99       | TensorFlow | AI/ML            | 24           | 120,646         |
| 63       | Cassandra  | Database         | 11           | 118,406         |
| 219      | Atlassian  | DevOps & Infra   | 15           | 117,965         |
| 96       | Airflow    | DevOps & Infra   | 71           | 116,387         |
| 3        | Scala      | Programming      | 59           | 115,479         |
| 169      | Linux      | DevOps & Infra   | 58           | 114,883         |
| 234      | Confluence | DevOps & Infra   | 62           | 114,153         |

*Table of the most optimal skills for data analyst sorted by salary.*


# What I Learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- 🧩 **Advanced SQL Mastery**: Skilled in crafting complex queries using JOINs, subqueries, and WITH clauses, optimizing data retrieval for deep analysis.
- 📊 **Powerful Data Aggregation**: Using GROUP BY, ORDER BY, and aggregate functions like COUNT() and AVG(), transforming raw data into meaningful insights.
- 💡 **Data-Driven Problem Solving**: Proven ability to translate business questions into actionable SQL queries, extracting insights that drive informed decision-making.

# Conclusions
### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Niche & Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: Big Data, AI/ML, Cloud, Database leads in demand and offers for a high average salary, positioning  as few of the most optimal skills for data analysts to learn to maximize their market value.  

### Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
