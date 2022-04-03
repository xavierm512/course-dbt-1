{{
  config(
    materialized = "table",
    sort = 'event_time',
    dist = 'event_id'
  )
}}


with orders as (
    select 
    *,
    row_number()
    over(
        partition by user_id
        order by created_at_utc asc
    ) as user_order_index
    from {{ ref('stg_orders') }}
),

first_order_details as (

  select 
    user_id,

    first_value(status)
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_status,

    first_value(shipping_service)
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_shipping_service,

    first_value(order_total)
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_total_cost,

    first_value(shipping_cost)
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_shipping_cost,

    first_value(order_cost)
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_order_cost,
  
    first_value(promo_id)
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_promo_id,

    first_value(estimated_delivery_at_utc)
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_estimated_delivery_utc,

    first_value(delivered_at_utc)
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_delivered_at_utc,

    first_value(date_part('day', delivered_at_utc - created_at_utc))
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_days_from_placed_to_delivered,
  
    first_value(date_part('day', delivered_at_utc - estimated_delivery_at_utc))
    over(
      partition by user_id
      order by created_at_utc asc
    ) as first_order_days_from_expected_delivery_to_delivered

  from orders
  where user_order_index = 1
)

select * from first_order_details