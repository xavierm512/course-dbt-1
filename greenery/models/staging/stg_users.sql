with users as (

    select * from {{ source('greenery', 'users') }}

)

select 
    u.user_id,
    u.address_id,
    u.email,
    split_part(u.email, '@', 2) as user_email_domain,
    u.phone_number,
    u.first_name,
    u.last_name,
    u.first_name || ' ' || last_name as full_name,
    u.created_at as created_at_utc,
    u.updated_at as updated_at_utc
from users u