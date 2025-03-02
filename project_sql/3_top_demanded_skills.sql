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

/* Expected results
[
  {
    "skill_name": "sql",
    "demand_count": "92628"
  },
  {
    "skill_name": "excel",
    "demand_count": "67031"
  },
  {
    "skill_name": "python",
    "demand_count": "57326"
  },
  {
    "skill_name": "tableau",
    "demand_count": "46554"
  },
  {
    "skill_name": "power bi",
    "demand_count": "39468"
  }
]
*/