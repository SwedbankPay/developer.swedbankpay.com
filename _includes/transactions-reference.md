{% assign api_resource  = include.api_resource  | default: 'creditcard' %}

## Transactions

{% include transactions.md api_resource=api_resource  %}

### Transaction

{% include transaction.md api_resource=api_resource  %}
