with orders as (

    select * from {{ source('greenery', 'orders') }}

)

select 
    o.order_id,
    o.user_id,
    o.promo_id,
    o.address_id,
    o.created_at as created_at_utc,
    o.tracking_id,
    o.order_cost,
    o.shipping_cost,
    o.order_total,
    o.shipping_service,
    o.estimated_delivery_at as estimated_delivery_at_utc,
    o.delivered_at as delivered_at_utc,
    o.status
from orders o