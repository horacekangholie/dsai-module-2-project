-- back compat for old kwarg name
  
  
        
            
	    
	    
            
        
    

    

    merge into `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_product` as DBT_INTERNAL_DEST
        using (-- models/star/dim_product.sql



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

        ) as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.product_id = DBT_INTERNAL_DEST.product_id))

    
    when matched then update set
        `product_id` = DBT_INTERNAL_SOURCE.`product_id`,`product_category_name` = DBT_INTERNAL_SOURCE.`product_category_name`,`product_name_lenght` = DBT_INTERNAL_SOURCE.`product_name_lenght`,`product_description_lenght` = DBT_INTERNAL_SOURCE.`product_description_lenght`,`product_photos_qty` = DBT_INTERNAL_SOURCE.`product_photos_qty`,`product_weight_g` = DBT_INTERNAL_SOURCE.`product_weight_g`,`product_length_cm` = DBT_INTERNAL_SOURCE.`product_length_cm`,`product_height_cm` = DBT_INTERNAL_SOURCE.`product_height_cm`,`product_width_cm` = DBT_INTERNAL_SOURCE.`product_width_cm`,`last_updated` = DBT_INTERNAL_SOURCE.`last_updated`
    

    when not matched then insert
        (`product_id`, `product_category_name`, `product_name_lenght`, `product_description_lenght`, `product_photos_qty`, `product_weight_g`, `product_length_cm`, `product_height_cm`, `product_width_cm`, `last_updated`)
    values
        (`product_id`, `product_category_name`, `product_name_lenght`, `product_description_lenght`, `product_photos_qty`, `product_weight_g`, `product_length_cm`, `product_height_cm`, `product_width_cm`, `last_updated`)


    