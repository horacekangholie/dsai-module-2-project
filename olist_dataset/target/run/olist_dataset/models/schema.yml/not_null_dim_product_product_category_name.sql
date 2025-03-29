select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select product_category_name
from `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_product`
where product_category_name is null



      
    ) dbt_internal_test