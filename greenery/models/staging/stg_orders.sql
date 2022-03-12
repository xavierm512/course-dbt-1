with orders as (

    select * from {{ source('greenery', 'orders') }}

)

select 
    o.order_id,
    o.user_id,
    o.promo_id,
    o.address_id,
    o.created_at,
    o.tracking_id,
    o.order_cost,
    o.shipping_cost,
    o.order_total,
    o.shipping_service,
    o.estimated_delivery_at,
    o.delivered_at,
    o.status
from orders o