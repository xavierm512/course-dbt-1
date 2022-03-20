{{
  config(
    materialized = "table"
  )
}}

with stg_orders as (
    select * from {{ ref('stg_orders') }}
)

select
    order_id,
    user_id,
    promo_id,
    address_id,
    created_at_utc,
    tracking_id,
    order_cost,
    shipping_cost,
    order_total,
    shipping_service,
    estimated_delivery_at_utc,
    delivered_at_utc
    status
from stg_orders
