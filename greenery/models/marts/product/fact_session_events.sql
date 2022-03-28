with events as (
    select * from {{ ref('stg_events') }}
),

session_event_counts as (
    select * from {{ ref('int_session_events_agg') }}
),

user_sessions as (

    select
        e.session_id,
        e.user_id

    from
        events e
    group by 1,2)

select
    s.*,
    {{ dbt_utils.star(from=ref('int_session_events_agg'), except=["session_id"]) }}
from user_sessions as s 
left join session_event_counts se 
    on se.session_id = s.session_id
