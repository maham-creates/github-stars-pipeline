{% macro repo_event_by_period(event_type, period) -%}
   SELECT 
     repo_id,
     repo_name,
     DATE_TRUNC({{period}}, event_date) AS date_{{period}},
     COUNT(*) AS {{event_type}}_count,
     SUM({{event_type}}_count) OVER (PARTITION BY repo_id ORDER BY date_{{period}}) AS comul_{{event_type}}_count
     FROM {{ref("stg_gharchive")}}
     WHERE event_type = {{event_type}}
     GROUP BY 1,2,3
     
{% endmacro %}
