select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select order_status
from `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_orders`
where order_status is null



      
    ) dbt_internal_test