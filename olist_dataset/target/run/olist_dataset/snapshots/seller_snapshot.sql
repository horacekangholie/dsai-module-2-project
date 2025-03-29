
      merge into `olist-ecommerce-454812`.`olist_data_snapshots`.`seller_snapshot` as DBT_INTERNAL_DEST
    using `olist-ecommerce-454812`.`olist_data_snapshots`.`seller_snapshot__dbt_tmp` as DBT_INTERNAL_SOURCE
    on DBT_INTERNAL_SOURCE.dbt_scd_id = DBT_INTERNAL_DEST.dbt_scd_id

    when matched
     
       and DBT_INTERNAL_DEST.dbt_valid_to is null
     
     and DBT_INTERNAL_SOURCE.dbt_change_type in ('update', 'delete')
        then update
        set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to

    when not matched
     and DBT_INTERNAL_SOURCE.dbt_change_type = 'insert'
        then insert (`seller_id`, `seller_zip_code_prefix`, `seller_city`, `seller_state`, `last_updated`, `dbt_updated_at`, `dbt_valid_from`, `dbt_valid_to`, `dbt_scd_id`)
        values (`seller_id`, `seller_zip_code_prefix`, `seller_city`, `seller_state`, `last_updated`, `dbt_updated_at`, `dbt_valid_from`, `dbt_valid_to`, `dbt_scd_id`)


  