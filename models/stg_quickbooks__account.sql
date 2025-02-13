with base as (
    select *
    from {{ ref('stg_quickbooks__account_tmp') }}

),

account as (

    select
        /*
        The below macro is used to generate the correct SQL for package staging models. It takes a list of columns 
        that are expected/needed (staging_columns from dbt_quickbooks_source/models/tmp/) and compares it with columns 
        in the source (source_columns from dbt_quickbooks_source/macros/).
        For more information refer to our dbt_fivetran_utils documentation (https://github.com/fivetran/dbt_fivetran_utils.git).
        */
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_quickbooks__account_tmp')),
                staging_columns=get_account_columns()
            )
        }}
    from base
),

final as (

    select
        cast(id as {{ dbt.type_string() }}) as account_id,
        -- These mapping are needed for the proper order in P/L report (Notion ticket: Quickbooks)
        case 
            when name = 'PayPal Sales' then '4898'
            when name = 'Uncategorized Expense' then '6897'
            when name = 'Exchange Gain or Loss' then '6999'
        else 
            cast(account_number as {{ dbt.type_string() }}) 
        end as account_number,
        sub_account as is_sub_account,
        cast(parent_account_id as {{ dbt.type_string() }}) as parent_account_id,
        name,
        account_type,
        account_sub_type,
        classification,
        balance,
        balance_with_sub_accounts,
        active as is_active,
        created_at,
        currency_id,
        description,
        fully_qualified_name,
        updated_at

    from base
)

select *
from final