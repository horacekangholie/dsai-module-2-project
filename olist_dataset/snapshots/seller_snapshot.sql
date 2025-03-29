{% snapshot seller_snapshot %}

{{ config(
    target_schema='olist_data_snapshots',
    unique_key='seller_id',
    strategy='timestamp',
    updated_at='last_updated',
    valid_from='snapshot_created_at',
    valid_to='snapshot_updated_at'
) }}

SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state,
    CAST(last_updated AS TIMESTAMP) AS last_updated
FROM {{ source('raw', 'olist_sellers_dataset') }}

{% endsnapshot %}
