{{
  config(
    materialized = "table"
  )
}}

with stg_products as (
    select * from {{ ref('stg_products') }}
)

select 
    product_id,
    product_name,
    price,
    inventory
from stg_products 