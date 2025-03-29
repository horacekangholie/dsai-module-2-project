select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with dbt_test__target as (

  select order_id_item as unique_field
  from `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_order_items`
  where order_id_item is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1



      
    ) dbt_internal_test