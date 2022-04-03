with products as (

    select * from {{ source('greenery', 'products') }}

)

select 
    p.product_id,
    p.name as product_name,
    p.price,
    p.inventory
from products p