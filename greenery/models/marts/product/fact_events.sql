{{
  config(
    materialized = "table"
  )
}}

with stg_events as (
    select * from {{ ref('stg_events') }}
)

select
    e.event_id,
    e.session_id,
    e.user_id,
    e.order_id,
    e.product_id,
    e.page_url,
    e.event_type,
    e.event_at_utc,
    case 
        when order_id is not null 
        then 1 
        else 0 end as placed_order_flag
from stg_events as e