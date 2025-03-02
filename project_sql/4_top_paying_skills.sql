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

/* Expected Insights
The highest-paying skills are heavily concentrated in AI, cloud infrastructure, and data management, with some skills related to version control systems and collaboration tools.
Machine learning frameworks like Solidity, Keras, and PyTorch are particularly lucrative, reflecting the growing importance of AI in data analytics.
Tools and skills related to cloud services and database management, like Terraform and Cassandra, are also highly valued.
*/