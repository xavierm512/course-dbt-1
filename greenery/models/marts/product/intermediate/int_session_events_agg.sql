{{
  config(
    materialized = "table"
  )
}}

{% set event_types = get_event_types() %}
--{% set event_types = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type') %}
with events as (
    select * from {{ ref('stg_events') }}
)

select
    session_id,
    min(event_at_utc) as session_start_timestamp_utc,
    max(event_at_utc) as session_end_timestamp_utc,
{% for event_type in event_types %}
    sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}_count,
{% endfor %}
    count(event_id) as all_events_count
from events
{{ dbt_utils.group_by(1) }}
