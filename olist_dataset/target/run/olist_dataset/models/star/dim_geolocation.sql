-- back compat for old kwarg name
  
  
        
            
	    
	    
            
        
    

    

    merge into `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_geolocation` as DBT_INTERNAL_DEST
        using (-- models/star/dim_geolocation.sql

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
--   WHERE geolocation_zip_code_prefix NOT IN (
--       SELECT geolocation_zip_code_prefix FROM `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_geolocation`
--   )
-- 
        ) as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.geolocation_zip_code_prefix = DBT_INTERNAL_DEST.geolocation_zip_code_prefix))

    
    when matched then update set
        `geolocation_zip_code_prefix` = DBT_INTERNAL_SOURCE.`geolocation_zip_code_prefix`,`geolocation_city` = DBT_INTERNAL_SOURCE.`geolocation_city`,`geolocation_state` = DBT_INTERNAL_SOURCE.`geolocation_state`,`last_updated` = DBT_INTERNAL_SOURCE.`last_updated`,`rn` = DBT_INTERNAL_SOURCE.`rn`
    

    when not matched then insert
        (`geolocation_zip_code_prefix`, `geolocation_city`, `geolocation_state`, `last_updated`, `rn`)
    values
        (`geolocation_zip_code_prefix`, `geolocation_city`, `geolocation_state`, `last_updated`, `rn`)


    