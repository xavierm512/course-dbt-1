{% snapshot source_orders_snapshot %}

  {{
    config(
      target_schema='dbt_xavier_m',
      unique_key='order_id',
      strategy='check',
      check_cols = ['status','estimated_delivery_at','address_id','shipping_service']
    )
  }}

  SELECT * FROM {{ source('greenery', 'orders') }}

{% endsnapshot %}
