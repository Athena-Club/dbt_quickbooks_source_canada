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
        transaction_id,
        index,
        transaction_date,
        cast(null as {{ dbt_utils.type_string() }}) as customer_id,
        vendor_id,
        amount,
        payment_account_id as account_id,
        'credit' as transaction_type,
        'bill payment' as transaction_source
    from bill_payment_join

    union all

    select
        transaction_id,
        index,
        transaction_date,
        cast(null as {{ dbt_utils.type_string() }}) as customer_id,
        vendor_id,
        amount,
        account_id,
        'debit' as transaction_type,
        'bill payment' as transaction_source
    from bill_payment_join
)

select * 
from final