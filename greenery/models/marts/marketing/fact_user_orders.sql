{{
  config(
    materialized = "table",
    sort = 'event_time',
    dist = 'event_id'
  )
}}

with lifetime_user_order_agg as (
    select * from {{ ref('int_lifetime_user_order_agg') }}
),

first_user_order_details as (
    select * from {{ ref('int_first_user_order_details') }}
),

users as (
    select * from {{ ref('stg_users') }}
)

select
users.user_id,
users.address_id,
{{ dbt_utils.star(from=ref('int_first_user_order_details'), except=["user_id"]) }},
{{ dbt_utils.star(from=ref('int_lifetime_user_order_agg'), except=["user_id"]) }},
DATE_PART('day', current_date - first_order_at_utc) as days_since_first_order,
DATE_PART('day', current_date - most_recent_order_at_utc) as days_since_last_order,

--helpful boolean flags
case
    when lifetime_orders > 0 
    then 1 else 0 end as is_purchaser_flag,

case 
    when lifetime_orders > 1
    then 1 else 0 end as is_repeat_purchaser_flag,

case when first_order_days_from_expected_delivery_to_delivered <= 0
     then 1 else 0 end as first_order_arrived_on_schedule_flag,

case when first_order_days_from_expected_delivery_to_delivered < 0
    then 1 else 0 end as first_order_arrived_ahead_of_schedule_flag,

case when first_order_promo_id is not null
    then 1 else 0 end as first_order_had_promo_flag

from users
left join first_user_order_details as first_orders
on users.user_id = first_orders.user_id

left join lifetime_user_order_agg as lifetime_orders
    on lifetime_orders.user_id = users.user_id