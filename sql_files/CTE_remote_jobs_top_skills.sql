WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN
        job_postings_fact ON skills_to_job.job_id = job_postings_fact.job_id
    WHERE job_postings_fact.job_work_from_home = TRUE AND
        job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    skills_dim.skill_id,
    skills AS skill_name,
    skill_count
FROM
    skills_dim
INNER JOIN
    remote_job_skills ON skills_dim.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;

