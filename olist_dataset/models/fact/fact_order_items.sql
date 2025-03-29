-- models/fact/fact_order_items.sql

{{ config(
    materialized='incremental',
    unique_key='order_id_item',
    incremental_strategy='merge'
) }}

WITH orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        order_approved_at,
        order_delivered_customer_date,
        order_estimated_delivery_date
    FROM {{ source('raw', 'olist_orders_dataset') }}
    WHERE order_status IN ('delivered', 'canceled')  -- Only include order that has finalized, delivered or cancelled
),

order_items AS (
    SELECT
        order_id,
        order_item_id,
        product_id,
        seller_id,
        price,
        freight_value
    FROM {{ source('raw', 'olist_order_items_dataset') }}
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
    INNER JOIN orders o USING (order_id)
)

SELECT
    customer_id,
    order_id,
    order_item_id,
    product_id,
    seller_id,
    price,
    freight_value,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    order_id_item
FROM joined

-- Comment out this part as incremental_strategy='merge' add to config
-- The logic of this part is it filter out those order item id that already in fact_order_item table
-- which assume data already in table never change

-- {% if is_incremental() %}
--   WHERE order_id_item NOT IN (SELECT order_id_item FROM {{ this }})
-- {% endif %}
