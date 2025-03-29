
    
    

with all_values as (

    select
        order_status as value_field,
        count(*) as n_records

    from `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_orders`
    group by order_status

)

select *
from all_values
where value_field not in (
    'delivered','canceled'
)


