SELECT
    company_dim.company_id,
    company_dim.name AS company_name,
    CASE
        WHEN job_count < 10 THEN 'small'
        WHEN job_count < 50 THEN 'medium'
        ELSE 'large'
    END AS company_size,
    job_count
FROM
    (SELECT
        COUNT(job_id) AS job_count,
        company_id
    FROM
        job_postings_fact
    GROUP BY
        company_id
    ORDER BY
        job_count DESC) AS job_counts
RIGHT JOIN
    company_dim ON job_counts.company_id = company_dim.company_id