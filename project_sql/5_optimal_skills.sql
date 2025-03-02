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

/* Quick Insights:
Top Skills for High Salary: Kafka, PyTorch, Perl, and TensorFlow offer high salaries but have relatively low demand.
Top Skills for High Demand: Snowflake, Spark, Databricks, and Databases (MongoDB, Cassandra) are in high demand, making them valuable for job seekers.
Cloud and Big Data: Cloud platforms like GCP, Databricks, and Snowflake, along with big data tools like Spark, are driving high demand in the industry.
AI/ML Growth: Frameworks like TensorFlow and PyTorch continue to be lucrative but are more niche in demand.
Foundational Skills: Core programming languages like Python (via Pandas) and system management skills like Linux and Shell are foundational and widely required.
In conclusion, mastering cloud technologies, big data tools, AI/ML frameworks, and database management will provide a well-rounded and high-demand skill set for data analysts.
*/