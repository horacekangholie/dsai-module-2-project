-- models/star/dim_customer.sql

-- {{ config( materialized='incremental', unique_key='customer_id' ) }}

-- WITH source AS (
--     SELECT
--         customer_id,
--         customer_unique_id,
--         customer_zip_code_prefix,
--         customer_city,
--         customer_state,
--         CAST(last_updated AS TIMESTAMP) AS last_updated
--     from {{ source('raw', 'olist_customers_dataset') }}
-- )

-- SELECT * FROM source

-- {% if is_incremental() %}
--   WHERE customer_id NOT IN (SELECT customer_id FROM {{ this }})
-- {% endif %}

-- models/star/dim_customer.sql

{{ config(materialized='table') }}

SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    dbt_valid_from,
    dbt_valid_to
FROM {{ ref('customer_snapshot') }}
WHERE dbt_valid_to IS NULL



