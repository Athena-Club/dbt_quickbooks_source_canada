{% macro get_bill_line_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_expense_account_id", "datatype": dbt_utils.type_int()},
    {"name": "account_expense_billable_status", "datatype": dbt_utils.type_string()},
    {"name": "account_expense_class_id", "datatype": dbt_utils.type_int()},
    {"name": "account_expense_customer_id", "datatype": dbt_utils.type_int()},
    {"name": "account_expense_tax_amount", "datatype": dbt_utils.type_float()},
    {"name": "account_expense_tax_code_id", "datatype": dbt_utils.type_int()},
    {"name": "amount", "datatype": dbt_utils.type_float()},
    {"name": "bill_id", "datatype": dbt_utils.type_int()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "index", "datatype": dbt_utils.type_int()},
    {"name": "item_expense_billable_status", "datatype": dbt_utils.type_string()},
    {"name": "item_expense_class_id", "datatype": dbt_utils.type_int()},
    {"name": "item_expense_customer_id", "datatype": dbt_utils.type_int()},
    {"name": "item_expense_item_id", "datatype": dbt_utils.type_int()},
    {"name": "item_expense_quantity", "datatype": dbt_utils.type_float()},
    {"name": "item_expense_tax_code_id", "datatype": dbt_utils.type_int()},
    {"name": "item_expense_unit_price", "datatype": dbt_utils.type_float()}
] %}

{{ return(columns) }}

{% endmacro %}
