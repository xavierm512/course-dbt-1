{{
  config(
    materialized = "table"
  )
}}

with session_events as (
    select* from {{ ref('fact_session_events') }}
)

select 
'all_sessions' as funnel_stage,
date_trunc('day',session_start_timestamp_utc) as session_date,
count(distinct case 
                when page_view_count > 0
                or add_to_cart_count > 0
                or checkout_count >0
                then session_id end) as session_count
from 
session_events
group by 1,2

union all 

select 
'add_to_cart' as funnel_stage,
date_trunc('day',session_start_timestamp_utc) as session_date,
count(distinct case 
                when add_to_cart_count > 0
                or checkout_count > 0
                then session_id end) as session_count
from 
session_events
group by 1,2

union all

select 
'checkout' as funnel_stage,
date_trunc('day',session_start_timestamp_utc) as session_date,
count(distinct case 
                when checkout_count > 0
                then session_id end) as session_count
from 
session_events
group by 1,2
