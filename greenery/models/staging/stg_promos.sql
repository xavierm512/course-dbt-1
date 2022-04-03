with promos as (

    select * from {{ source('greenery', 'promos') }}

)

select 
    p.promo_id,
    p.discount,
    p.status
from promos p