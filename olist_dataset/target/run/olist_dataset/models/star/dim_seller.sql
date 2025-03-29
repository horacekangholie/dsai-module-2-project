
  
    

    create or replace table `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_seller`
      
    
    

    OPTIONS()
    as (
      -- models/star/dim_seller.sql

-- This is incremental approach (Type 1 SCD)
-- 

-- WITH source AS (
--     SELECT
--         seller_id,
--         seller_zip_code_prefix,
--         seller_city,
--         seller_state,
--         CAST(last_updated AS TIMESTAMP) AS last_updated
--     FROM `olist-ecommerce-454812`.`olist_data_staging`.`olist_sellers_dataset`
-- )

-- SELECT * FROM source

-- 


-- This is snapshot approach, refer to seller_snapshot (Type 2 SCD)


SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state,
    dbt_valid_from,
    dbt_valid_to
FROM `olist-ecommerce-454812`.`olist_data_snapshots`.`seller_snapshot`
WHERE dbt_valid_to IS NULL
    );
  