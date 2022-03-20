with order_items as (

    select * from {{ source('greenery', 'order_items') }}

)

select

    {{ dbt_utils.surrogate_key(['order_id', 'product_id']) }} as order_item_id,
    order_id,
    product_id,
    quantity

from order_items items