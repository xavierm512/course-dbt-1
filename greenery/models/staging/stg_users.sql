with users as (

    select * from {{ source('greenery', 'users') }}

)

select 
    u.user_id,
    u.address_id,
    u.email,
    u.phone_number,
    u.first_name,
    u.last_name,
    u.first_name || ' ' || last_name as full_name,
    u.created_at,
    u.updated_at
from users u