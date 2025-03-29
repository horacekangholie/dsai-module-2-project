-- models/star/dim_geolocation.sql

-- This is incremental approach (Type 1 SCD)
{{ config(
    materialized='incremental',
    unique_key='geolocation_zip_code_prefix',
    incremental_strategy='merge'
) }}

WITH source AS (
  SELECT
    geolocation_zip_code_prefix,
    geolocation_city,
    geolocation_state,
    CAST(last_updated AS TIMESTAMP) AS last_updated,
    ROW_NUMBER() OVER (
      PARTITION BY geolocation_zip_code_prefix
      ORDER BY last_updated DESC
    ) as rn
  FROM {{ source('raw', 'olist_geolocation_dataset') }}
)

SELECT * FROM source
WHERE rn = 1

-- Comment out this part as incremental_strategy='merge' add to config
-- The logic of this part is it filter out those geolocation_zip_code_prefix that already in dim_geolocation table
-- which assume data already in table never change

-- {% if is_incremental() %}
--   WHERE geolocation_zip_code_prefix NOT IN (
--       SELECT geolocation_zip_code_prefix FROM {{ this }}
--   )
-- {% endif %}
