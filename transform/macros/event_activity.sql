{% macro event_activity (event_type, date_type, comul_count) %}
   SELECT 
     repo_id,
     repo_name,
     DATE_TRUNC('{{date_type}}', event_date) AS date_{{date_type}},
     COUNT(*) AS star_count,
     SUM(COUNT(*)) OVER (PARTITION BY repo_id ORDER BY DATE_TRUNC('{{date_type}}', event_date)) AS comul_count
     FROM {{ref("stg_gharchive")}}
     WHERE event_type = '{{event_type}}'
     GROUP BY 1,2,3
     
{% endmacro %}