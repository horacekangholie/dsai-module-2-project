-- models/star/dim_seller.sql

-- This is incremental approach (Type 1 SCD)
-- {{ config( materialized='incremental', unique_key='seller_id' ) }}

-- WITH source AS (
--     SELECT
--         seller_id,
--         seller_zip_code_prefix,
--         seller_city,
--         seller_state,
--         CAST(last_updated AS TIMESTAMP) AS last_updated
--     FROM {{ source('raw', 'olist_sellers_dataset') }}
-- )

-- SELECT * FROM source

-- {% if is_incremental() %}
--   WHERE seller_id NOT IN (SELECT seller_id FROM {{ this }})
-- {% endif %}


-- This is snapshot approach, refer to seller_snapshot (Type 2 SCD)
{{ config(materialized='table') }}

SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state,
    dbt_valid_from,
    dbt_valid_to
FROM {{ ref('seller_snapshot') }}
WHERE dbt_valid_to IS NULL

