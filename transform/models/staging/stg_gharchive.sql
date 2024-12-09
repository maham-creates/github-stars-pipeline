SELECT
   CASE 
       WHEN REPLACE(type, 'Event', '') = 'Push' THEN 'commit'
       WHEN REPLACE(type, 'Event', '') = 'Watch' THEN 'star'
       ELSE LOWER(REPLACE(type, 'Event', ''))
   END AS event_type,
   actor.login AS user,
   repo.id AS repo_id,
   repo.name AS repo_name,
   created_at AS event_date
FROM {{source("gharchive", "src_gharchive")}}