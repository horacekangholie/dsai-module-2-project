-- back compat for old kwarg name
  
  
        
            
	    
	    
            
        
    

    

    merge into `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_orders` as DBT_INTERNAL_DEST
        using (-- models/fact/fact_orders.sql



WITH orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        order_approved_at,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        order_estimated_delivery_date
    FROM `olist-ecommerce-454812`.`olist_data_staging`.`olist_orders_dataset`
),

payments AS (
    SELECT
        order_id,
        ROUND(SUM(ifnull(payment_value, 0.0)), 2) AS payment_value
    FROM `olist-ecommerce-454812`.`olist_data_staging`.`olist_order_payments_dataset`
    GROUP BY order_id
)

SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    p.payment_value
FROM orders o
LEFT JOIN payments p USING (order_id)


  WHERE order_id NOT IN (SELECT order_id FROM `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_orders`)

        ) as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.order_id = DBT_INTERNAL_DEST.order_id))

    
    when matched then update set
        `order_id` = DBT_INTERNAL_SOURCE.`order_id`,`customer_id` = DBT_INTERNAL_SOURCE.`customer_id`,`order_status` = DBT_INTERNAL_SOURCE.`order_status`,`order_purchase_timestamp` = DBT_INTERNAL_SOURCE.`order_purchase_timestamp`,`order_approved_at` = DBT_INTERNAL_SOURCE.`order_approved_at`,`order_delivered_carrier_date` = DBT_INTERNAL_SOURCE.`order_delivered_carrier_date`,`order_delivered_customer_date` = DBT_INTERNAL_SOURCE.`order_delivered_customer_date`,`order_estimated_delivery_date` = DBT_INTERNAL_SOURCE.`order_estimated_delivery_date`,`payment_value` = DBT_INTERNAL_SOURCE.`payment_value`
    

    when not matched then insert
        (`order_id`, `customer_id`, `order_status`, `order_purchase_timestamp`, `order_approved_at`, `order_delivered_carrier_date`, `order_delivered_customer_date`, `order_estimated_delivery_date`, `payment_value`)
    values
        (`order_id`, `customer_id`, `order_status`, `order_purchase_timestamp`, `order_approved_at`, `order_delivered_carrier_date`, `order_delivered_customer_date`, `order_estimated_delivery_date`, `payment_value`)


    