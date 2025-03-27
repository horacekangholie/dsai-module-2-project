-- back compat for old kwarg name
  
  
        
            
	    
	    
            
        
    

    

    merge into `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_seller` as DBT_INTERNAL_DEST
        using (-- models/star/dim_seller.sql



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

        ) as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.seller_id = DBT_INTERNAL_DEST.seller_id))

    
    when matched then update set
        `seller_id` = DBT_INTERNAL_SOURCE.`seller_id`,`seller_zip_code_prefix` = DBT_INTERNAL_SOURCE.`seller_zip_code_prefix`,`seller_city` = DBT_INTERNAL_SOURCE.`seller_city`,`seller_state` = DBT_INTERNAL_SOURCE.`seller_state`,`last_updated` = DBT_INTERNAL_SOURCE.`last_updated`
    

    when not matched then insert
        (`seller_id`, `seller_zip_code_prefix`, `seller_city`, `seller_state`, `last_updated`)
    values
        (`seller_id`, `seller_zip_code_prefix`, `seller_city`, `seller_state`, `last_updated`)


    