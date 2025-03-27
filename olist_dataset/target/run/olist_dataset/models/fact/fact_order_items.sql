-- back compat for old kwarg name
  
  
        
            
	    
	    
            
        
    

    

    merge into `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_order_items` as DBT_INTERNAL_DEST
        using (-- models/fact/fact_order_items.sql



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

order_items AS (
    SELECT
        order_id,
        order_item_id,
        product_id,
        seller_id,
        price,
        freight_value
    FROM `olist-ecommerce-454812`.`olist_data_staging`.`olist_order_items_dataset`
),

joined AS (
    SELECT
        o.customer_id,
        oi.order_id,
        oi.order_item_id,
        oi.product_id,
        oi.seller_id,
        oi.price,
        oi.freight_value,
        o.order_purchase_timestamp,        
        o.order_approved_at,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date,
        CONCAT(oi.order_id, '_', CAST(oi.order_item_id AS STRING)) AS order_id_item
    FROM order_items oi
    LEFT JOIN orders o USING (order_id)
)

SELECT
    customer_id,
    order_id,
    order_item_id,
    product_id,
    seller_id,
    price,
    freight_value,
    order_approved_at,
    order_purchase_timestamp,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    order_id_item
FROM joined


  WHERE order_id_item NOT IN (SELECT order_id_item FROM `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_order_items`)

        ) as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.order_id_item = DBT_INTERNAL_DEST.order_id_item))

    
    when matched then update set
        `customer_id` = DBT_INTERNAL_SOURCE.`customer_id`,`order_id` = DBT_INTERNAL_SOURCE.`order_id`,`order_item_id` = DBT_INTERNAL_SOURCE.`order_item_id`,`product_id` = DBT_INTERNAL_SOURCE.`product_id`,`seller_id` = DBT_INTERNAL_SOURCE.`seller_id`,`price` = DBT_INTERNAL_SOURCE.`price`,`freight_value` = DBT_INTERNAL_SOURCE.`freight_value`,`order_approved_at` = DBT_INTERNAL_SOURCE.`order_approved_at`,`order_purchase_timestamp` = DBT_INTERNAL_SOURCE.`order_purchase_timestamp`,`order_delivered_customer_date` = DBT_INTERNAL_SOURCE.`order_delivered_customer_date`,`order_estimated_delivery_date` = DBT_INTERNAL_SOURCE.`order_estimated_delivery_date`,`order_id_item` = DBT_INTERNAL_SOURCE.`order_id_item`
    

    when not matched then insert
        (`customer_id`, `order_id`, `order_item_id`, `product_id`, `seller_id`, `price`, `freight_value`, `order_approved_at`, `order_purchase_timestamp`, `order_delivered_customer_date`, `order_estimated_delivery_date`, `order_id_item`)
    values
        (`customer_id`, `order_id`, `order_item_id`, `product_id`, `seller_id`, `price`, `freight_value`, `order_approved_at`, `order_purchase_timestamp`, `order_delivered_customer_date`, `order_estimated_delivery_date`, `order_id_item`)


    