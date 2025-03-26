-- models/star/dim_geolocation.sql

{{ config(
    materialized='incremental',
    unique_key='geolocation_zip_code_prefix'
) }}

WITH source AS (
    SELECT
        geolocation_zip_code_prefix,
        geolocation_city,
        geolocation_state,
        CAST(last_updated AS TIMESTAMP) AS last_updated
    FROM {{ source('raw', 'olist_geolocation_dataset') }}
)

SELECT * FROM source

{% if is_incremental() %}
  WHERE geolocation_zip_code_prefix NOT IN (
      SELECT geolocation_zip_code_prefix FROM {{ this }}
  )
{% endif %}
