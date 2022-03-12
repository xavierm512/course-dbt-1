with addresses as (

    select * from {{ source('greenery', 'addresses') }}

)

select 
    a.address_id,
    a.address as street_address,
    a.state,
    a.zipcode,
    a.country
from addresses a