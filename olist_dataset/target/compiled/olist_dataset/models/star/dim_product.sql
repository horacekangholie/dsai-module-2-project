-- models/star/dim_product.sql

-- This is incremental approach (Type 1 SCD)
-- 

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
--     FROM `olist-ecommerce-454812`.`olist_data_staging`.`olist_products_dataset`
-- )

-- SELECT * FROM source

-- 

-- This is snapshot approach, refer to product_snapshot (Type 2 SCD)


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
FROM `olist-ecommerce-454812`.`olist_data_snapshots`.`product_snapshot`
WHERE dbt_valid_to IS NULL