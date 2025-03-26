{% snapshot customer_snapshot %}

{# Put high-level comments here if you want #}

{{ config(
    target_schema='olist_data_snapshots',
    unique_key='customer_id',
    strategy='timestamp',
    updated_at='last_updated',
    valid_from='snapshot_created_at',
    valid_to='snapshot_updated_at'
) }}

SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    CAST(last_updated AS TIMESTAMP) AS last_updated
FROM {{ source('raw', 'olist_customers_dataset') }}

{% endsnapshot %}
