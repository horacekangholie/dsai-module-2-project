-- models/star/dim_geolocation.sql

-- This is incremental approach (Type 1 SCD)


WITH source AS (
  SELECT
    geolocation_zip_code_prefix,
    geolocation_city,
    geolocation_state,
    CAST(last_updated AS TIMESTAMP) AS last_updated,
    ROW_NUMBER() OVER (
      PARTITION BY geolocation_zip_code_prefix
      ORDER BY last_updated DESC
    ) as rn
  FROM `olist-ecommerce-454812`.`olist_data_staging`.`olist_geolocation_dataset`
)

SELECT * FROM source
WHERE rn = 1

-- Comment out this part as incremental_strategy='merge' add to config
-- The logic of this part is it filter out those geolocation_zip_code_prefix that already in dim_geolocation table
-- which assume data already in table never change

-- 