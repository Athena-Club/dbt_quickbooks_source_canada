--To disable this model, set the using_invoice_bundle variable within your dbt_project.yml file to False.
{{ config(enabled=var('using_invoice_bundle', True)) }}

with base as (

    select * 
    from {{ ref('stg_quickbooks__bundle_tmp') }}

),

fields as (

    select
        /*
        The below macro is used to generate the correct SQL for package staging models. It takes a list of columns 
        that are expected/needed (staging_columns from dbt_quickbooks_source/models/tmp/) and compares it with columns 
        in the source (source_columns from dbt_quickbooks_source/macros/).
        For more information refer to our dbt_fivetran_utils documentation (https://github.com/fivetran/dbt_fivetran_utils.git).
        */
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_quickbooks__bundle_tmp')),
                staging_columns=get_bundle_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        cast(id as {{ dbt.type_string() }}) as bundle_id,
        created_at,
        active as is_active,
        fully_qualified_name,
        updated_at

    from fields
)

select * from final
