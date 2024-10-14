-- select
--   type as event_type,
--   actor.login as user,
--   repo.id as repo_id,
--   repo.name as repo_name,
--   created_at as event_date
-- from {{ source("gharchive", "src_gharchive") }}

select
   replace(type,'Event','') as event_type, --remove 'Event' suffix
   actor.login as user,
   repo.id as repo_id,
   repo.name as repo_name,
   created_at as event_date
from {{source("gharchive", "src_gharchive")}}