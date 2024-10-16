SELECT 
  repo_id, 
  repo_name, 
  DATE_TRUNC('month', event_date) AS date_month, 
  COUNT(*) AS star_count,
  SUM(COUNT(*)) OVER (PARTITION BY repo_id ORDER BY DATE_TRUNC('month', event_date)) AS cumul_push_count
FROM {{ ref("stg_gharchive") }} 
WHERE event_type = 'Push'
GROUP BY 1, 2, 3
  