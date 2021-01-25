{% macro get_refund_receipt_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "apply_tax_after_discount", "datatype": "boolean"},
    {"name": "balance", "datatype": dbt_utils.type_float()},
    {"name": "bill_email", "datatype": dbt_utils.type_string()},
    {"name": "billing_address_id", "datatype": dbt_utils.type_int()},
    {"name": "check_payment_account_number", "datatype": dbt_utils.type_string()},
    {"name": "check_payment_bank_name", "datatype": dbt_utils.type_string()},
    {"name": "check_payment_check_number", "datatype": dbt_utils.type_string()},
    {"name": "check_payment_name_on_account", "datatype": dbt_utils.type_string()},
    {"name": "check_payment_status", "datatype": dbt_utils.type_string()},
    {"name": "class_id", "datatype": dbt_utils.type_int()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "credit_card_amount", "datatype": dbt_utils.type_float()},
    {"name": "credit_card_auth_code", "datatype": dbt_utils.type_string()},
    {"name": "credit_card_billing_address_street", "datatype": dbt_utils.type_string()},
    {"name": "credit_card_cc_expiry_month", "datatype": dbt_utils.type_int()},
    {"name": "credit_card_cc_expiry_year", "datatype": dbt_utils.type_int()},
    {"name": "credit_card_cctrans_id", "datatype": dbt_utils.type_int()},
    {"name": "credit_card_name_on_account", "datatype": dbt_utils.type_string()},
    {"name": "credit_card_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "credit_card_process_payment", "datatype": "boolean"},
    {"name": "credit_card_status", "datatype": dbt_utils.type_string()},
    {"name": "credit_card_transaction_authorization_time", "datatype": "date"},
    {"name": "credit_card_type", "datatype": dbt_utils.type_string()},
    {"name": "currency_id", "datatype": dbt_utils.type_int()},
    {"name": "customer_id", "datatype": dbt_utils.type_int()},
    {"name": "customer_memo", "datatype": dbt_utils.type_string()},
    {"name": "department_id", "datatype": dbt_utils.type_int()},
    {"name": "deposit_to_account_id", "datatype": dbt_utils.type_int()},
    {"name": "doc_number", "datatype": dbt_utils.type_string()},
    {"name": "exchange_rate", "datatype": dbt_utils.type_float()},
    {"name": "global_tax_calculation", "datatype": dbt_utils.type_string()},
    {"name": "home_balance", "datatype": dbt_utils.type_float()},
    {"name": "home_total_amount", "datatype": dbt_utils.type_float()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "payment_method_id", "datatype": dbt_utils.type_int()},
    {"name": "payment_reference_number", "datatype": dbt_utils.type_string()},
    {"name": "payment_type", "datatype": dbt_utils.type_string()},
    {"name": "print_status", "datatype": dbt_utils.type_string()},
    {"name": "private_note", "datatype": dbt_utils.type_string()},
    {"name": "shipping_address_id", "datatype": dbt_utils.type_int()},
    {"name": "sync_token", "datatype": dbt_utils.type_string()},
    {"name": "tax_code_id", "datatype": dbt_utils.type_int()},
    {"name": "total_amount", "datatype": dbt_utils.type_float()},
    {"name": "total_tax", "datatype": dbt_utils.type_float()},
    {"name": "transaction_date", "datatype": "date"},
    {"name": "transaction_source", "datatype": dbt_utils.type_string()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}
