-- models/star/dim_product.sql

-- This is incremental approach (Type 1 SCD)
-- {{ config( materialized='incremental', unique_key='product_id' ) }}

-- WITH source AS (
--     SELECT
--         product_id,
--         product_category_name,
--         product_name_lenght,
--         product_description_lenght,
--         product_photos_qty,
--         product_weight_g,
--         product_length_cm,
--         product_height_cm,
--         product_width_cm,
--         CAST(last_updated AS TIMESTAMP) AS last_updated
--     FROM {{ source('raw', 'olist_products_dataset') }}
-- )

-- SELECT * FROM source

-- {% if is_incremental() %}
--   WHERE product_id NOT IN (SELECT product_id FROM {{ this }})
-- {% endif %}

-- This is snapshot approach, refer to product_snapshot (Type 2 SCD)
{{ config(materialized='table') }}

SELECT
    product_id,
    COALESCE(product_category_name, 'UNKNOWN') AS product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    dbt_valid_from,
    dbt_valid_to
FROM {{ ref('product_snapshot') }}
WHERE dbt_valid_to IS NULL

