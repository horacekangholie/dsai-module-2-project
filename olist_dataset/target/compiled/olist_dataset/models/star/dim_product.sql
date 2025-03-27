-- models/star/dim_product.sql



WITH source AS (
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
    FROM `olist-ecommerce-454812`.`olist_data_staging`.`olist_products_dataset`
)

SELECT *
FROM source


  WHERE product_id NOT IN (SELECT product_id FROM `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_product`)
