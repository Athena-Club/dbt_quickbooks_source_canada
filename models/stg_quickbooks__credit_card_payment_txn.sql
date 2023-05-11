--To disable this model, set the using_credit_memo variable within your dbt_project.yml file to False.
{{ config(enabled=var('using_credit_card_payment', True)) }}

with base as (

    select * 
    from {{ ref('stg_quickbooks__credit_card_payment_txn_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_quickbooks__credit_card_payment_txn_tmp')),
                staging_columns=get_credit_card_payment_txn_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        cast(id as {{ dbt.type_string() }}) as credit_card_payment_txn_id,
        cast(bank_account_id as {{ dbt.type_string() }}) as bank_account_id,
        cast(credit_card_account_id as {{ dbt.type_string() }}) as credit_card_account_id,
        amount,
        currency_id,
        transaction_date,        
        sync_token,
        created_at,
        updated_at
    from fields
)

select * 
from final