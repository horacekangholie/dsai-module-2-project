-- models/star/dim_seller.sql

{{ config(
    materialized='incremental',
    unique_key='seller_id'
) }}

WITH source AS (
    SELECT
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state,
        CAST(last_updated AS TIMESTAMP) AS last_updated
    FROM {{ source('raw', 'olist_sellers_dataset') }}
)

SELECT * FROM source

{% if is_incremental() %}
  WHERE seller_id NOT IN (SELECT seller_id FROM {{ this }})
{% endif %}
