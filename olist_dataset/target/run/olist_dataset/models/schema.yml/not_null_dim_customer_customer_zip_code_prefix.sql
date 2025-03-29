select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select customer_zip_code_prefix
from `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_customer`
where customer_zip_code_prefix is null



      
    ) dbt_internal_test