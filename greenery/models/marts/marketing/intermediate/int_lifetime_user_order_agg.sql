{{
  config(
    materialized = "table",
    sort = 'event_time',
    dist = 'event_id'
  )
}}


with orders as (
    select 
    *
    from {{ ref('stg_orders') }}
),

lifetime_user_order_agg as (

  select
    user_id,
    min(created_at_utc) as first_order_at_utc,
    max(created_at_utc) as most_recent_order_at_utc,
    count(distinct order_id) as lifetime_orders,
    sum(order_total) as lifetime_total_order_spend,
    sum(order_cost) as lifetime_order_cost,
    sum(shipping_cost) as lifetime_shipping_cost
  from orders
  group by 1
     
)

select * from lifetime_user_order_agg