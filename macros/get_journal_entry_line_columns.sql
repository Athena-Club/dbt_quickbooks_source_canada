{% macro get_journal_entry_line_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_int()},
    {"name": "amount", "datatype": dbt_utils.type_float()},
    {"name": "billable_status", "datatype": dbt_utils.type_string()},
    {"name": "class_id", "datatype": dbt_utils.type_int()},
    {"name": "customer_id", "datatype": dbt_utils.type_int()},
    {"name": "department_id", "datatype": dbt_utils.type_int()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "description_service_date", "datatype": "date"},
    {"name": "description_tax_code_id", "datatype": dbt_utils.type_int()},
    {"name": "employee_id", "datatype": dbt_utils.type_int()},
    {"name": "index", "datatype": dbt_utils.type_int()},
    {"name": "journal_entry_id", "datatype": dbt_utils.type_int()},
    {"name": "posting_type", "datatype": dbt_utils.type_string()},
    {"name": "tax_amount", "datatype": dbt_utils.type_float()},
    {"name": "tax_applicable_on", "datatype": dbt_utils.type_string()},
    {"name": "tax_code_id", "datatype": dbt_utils.type_int()},
    {"name": "vendor_id", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
