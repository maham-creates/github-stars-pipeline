Select distinct 
  repo_id, 
  repo_name, 
  date_trunc('day', event_date) as date_day, 
  count(*) as star_count,
  SUM(COUNT(*)) OVER (PARTITION BY repo_id ORDER BY date_trunc('day', event_date)) AS cumul_push_count
from {{ ref("stg_gharchive") }} 
where event_type = 'Push'
GROUP BY 
  repo_id, 
  repo_name, 
  date_day