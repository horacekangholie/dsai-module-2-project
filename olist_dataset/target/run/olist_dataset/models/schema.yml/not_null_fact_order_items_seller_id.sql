select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select seller_id
from `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_order_items`
where seller_id is null



      
    ) dbt_internal_test