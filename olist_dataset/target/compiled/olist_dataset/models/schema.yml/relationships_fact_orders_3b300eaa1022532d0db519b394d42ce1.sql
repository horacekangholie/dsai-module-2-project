
    
    

with child as (
    select customer_id as from_field
    from `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_orders`
    where customer_id is not null
),

parent as (
    select customer_id as to_field
    from `olist-ecommerce-454812`.`olist_data_ingestion_dim_tables`.`dim_customer`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


