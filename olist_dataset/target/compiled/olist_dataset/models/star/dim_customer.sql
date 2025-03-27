-- models/star/dim_customer.sql

-- 

-- WITH source AS (
--     SELECT
--         customer_id,
--         customer_unique_id,
--         customer_zip_code_prefix,
--         customer_city,
--         customer_state,
--         CAST(last_updated AS TIMESTAMP) AS last_updated
--     from `olist-ecommerce-454812`.`olist_data_staging`.`olist_customers_dataset`
-- )

-- SELECT * FROM source

-- 

-- models/star/dim_customer.sql



SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    dbt_valid_from,
    dbt_valid_to
FROM `olist-ecommerce-454812`.`olist_data_snapshots`.`customer_snapshot`
WHERE dbt_valid_to IS NULL