-- models/star/dim_geolocation.sql



WITH source AS (
    SELECT
        geolocation_zip_code_prefix,
        geolocation_city,
        geolocation_state,
        CAST(last_updated AS TIMESTAMP) AS last_updated
    FROM `olist-ecommerce-454812`.`olist_data_staging`.`olist_geolocation_dataset`
)

SELECT * FROM source


  WHERE geolocation_zip_code_prefix NOT IN (
      SELECT geolocation_zip_code_prefix FROM `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_geolocation`
  )
