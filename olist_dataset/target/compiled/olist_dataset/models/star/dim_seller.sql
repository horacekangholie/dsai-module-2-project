-- models/star/dim_seller.sql



WITH source AS (
    SELECT
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state,
        CAST(last_updated AS TIMESTAMP) AS last_updated
    FROM `olist-ecommerce-454812`.`olist_data_staging`.`olist_sellers_dataset`
)

SELECT * FROM source


  WHERE seller_id NOT IN (SELECT seller_id FROM `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_seller`)
