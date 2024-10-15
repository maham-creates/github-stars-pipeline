Select distinct 
  repo_id, 
  repo_name, 
  date_trunc('month', event_date) as date_month, 
  count(*) as star_count,
  SUM(COUNT(*)) OVER (PARTITION BY repo_id ORDER BY date_trunc('month', event_date)) AS cumul_star_count
from {{ ref("stg_gharchive") }} 
where event_type = 'Watch'
GROUP BY 
  repo_id, 
  repo_name, 
  date_month
