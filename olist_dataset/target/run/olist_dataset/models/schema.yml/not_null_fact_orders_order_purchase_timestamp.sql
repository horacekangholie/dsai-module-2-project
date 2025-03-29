select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select order_purchase_timestamp
from `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_orders`
where order_purchase_timestamp is null



      
    ) dbt_internal_test