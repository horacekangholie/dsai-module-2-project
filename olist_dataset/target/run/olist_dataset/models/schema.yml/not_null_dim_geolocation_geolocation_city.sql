select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select geolocation_city
from `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_geolocation`
where geolocation_city is null



      
    ) dbt_internal_test