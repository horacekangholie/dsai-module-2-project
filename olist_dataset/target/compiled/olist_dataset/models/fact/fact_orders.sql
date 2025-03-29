-- models/fact/fact_orders.sql



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
    WHERE order_status IN ('delivered', 'canceled')   -- Only include delivered or canceled
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

-- Comment out this part as incremental_strategy='merge' add to config
-- The logic of this part is it filter out those order id that already in fact_orders table
-- which assume data already in table never change

-- 
--   WHERE order_id NOT IN (SELECT order_id FROM `olist-ecommerce-454812`.`olist_data_ingestion_fact_tables`.`fact_orders`)
-- 