with events as (

    select * from {{ source('greenery', 'events') }}

)

select 
    e.event_id,
    e.session_id,
    e.user_id,
    e.order_id,
    e.product_id,
    e.page_url,
    e.event_type,
    e.created_at as event_at
from events e