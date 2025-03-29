{% snapshot product_snapshot %}

{{ config(
    target_schema='olist_data_snapshots',
    unique_key='product_id',
    strategy='timestamp',
    updated_at='last_updated',
    valid_from='snapshot_created_at',
    valid_to='snapshot_updated_at'
) }}

SELECT
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    CAST(last_updated AS TIMESTAMP) AS last_updated
FROM {{ source('raw', 'olist_products_dataset') }}

{% endsnapshot %}
