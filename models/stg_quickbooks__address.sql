--To disable this model, set the using_address variable within your dbt_project.yml file to False.
{{ config(enabled=var('using_address', True)) }}

with base as (

    select * 
    from {{ ref('stg_quickbooks__address_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_quickbooks__address_tmp')),
                staging_columns=get_address_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        cast(id as {{ dbt.type_string() }}) as address_id,
        city,
        country,
        line_1 as address_1,
        line_2 as address_2,
        postal_code
    from fields
)

select * 
from final
