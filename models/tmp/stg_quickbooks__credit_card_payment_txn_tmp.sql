--To enable this model, set the using_credit_memo variable within your dbt_project.yml file to True.
{{ config(enabled=var('using_credit_card_payment', True)) }}

select * 
from {{ var('credit_card_payment_txn') }}
