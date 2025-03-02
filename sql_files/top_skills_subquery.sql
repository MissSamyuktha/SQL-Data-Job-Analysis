SELECT
    skills_dim.skill_id,
    skills_dim.skills AS skill_name
FROM skills_dim
LEFT JOIN skills_job_dim
ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE skills_dim.skill_id IN 

    (SELECT 
        skill_id
    FROM skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        COUNT(skill_id) DESC
    LIMIT 5)
GROUP BY
    skills_dim.skill_id