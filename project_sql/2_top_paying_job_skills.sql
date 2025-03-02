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

/* Expected Insights:
SQL is the most frequently mentioned skill, appearing in all 10 job postings. This highlights its importance in data analysis roles.

Python is also highly sought after, with 8 mentions. It's a versatile language used for data manipulation, analysis, and visualization.

Tableau is a popular tool for data visualization, mentioned in 7 job postings. This indicates a strong demand for skills in creating interactive dashboards and visualizations.

Excel and R are mentioned 3 times each, showing their continued relevance in data analysis tasks.

Azure and AWS are both mentioned twice, reflecting the growing importance of cloud computing skills in data analysis.

Other skills like Pandas, Snowflake, and Power BI are also mentioned multiple times, indicating their value in the industry.

Overall, it's clear that a strong foundation in SQL, Python, and data visualization tools like Tableau is essential for data analyst roles. Additionally, familiarity with cloud platforms and other data manipulation tools can give you a competitive edge.
*/