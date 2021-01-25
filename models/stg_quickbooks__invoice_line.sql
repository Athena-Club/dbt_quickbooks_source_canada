--To disable this model, set the using_invoice variable within your dbt_project.yml file to False.
{{ config(enabled=var('using_invoice', True)) }}

with base as (

    select * 
    from {{ ref('stg_quickbooks__invoice_line_tmp') }}

),

fields as (

    select
        /*
        The below macro is used to generate the correct SQL for package staging models. It takes a list of columns 
        that are expected/needed (staging_columns from dbt_salesforce_source/models/tmp/) and compares it with columns 
        in the source (source_columns from dbt_salesforce_source/macros/).
        For more information refer to our dbt_fivetran_utils documentation (https://github.com/fivetran/dbt_fivetran_utils.git).
        */

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_quickbooks__invoice_line_tmp')),
                staging_columns=get_invoice_line_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        invoice_id,
        index,
        amount,
        sales_item_account_id,
        cast(sales_item_item_id as {{ 'int64' if target.name == 'bigquery' else 'bigint' }}) as sales_item_item_id,
        sales_item_class_id,
        sales_item_quantity,
        sales_item_unit_price,
        discount_account_id,
        discount_class_id,
        description,
        quantity,
        bundle_quantity,
        bundle_id,
        cast(account_id as {{ 'int64' if target.name == 'bigquery' else 'bigint' }} ) as account_id,
        item_id
    from fields
)

select * 
from final
