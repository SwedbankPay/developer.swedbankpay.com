{% assign api_resource  = include.api_resource  | default: 'creditcard' %}
{% assign documentation_section = include.documentation_section %}

## Transactions

{% include transactions.md api_resource=api_resource
documentation_section=documentation_section %}

### Transaction

{% include transaction.md
           api_resource=api_resource
           documentation_section=documentation_section %}
