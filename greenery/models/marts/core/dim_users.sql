{{
  config(
    materialized = "table"
  )
}}

with stg_users as (select * from {{ ref('stg_users') }})

select 
    user_id,
    address_id,
    user_email_domain,
    full_name,
    first_name,
    last_name,
    created_at_utc,
    updated_at_utc
from stg_users