{% assign payment-instrument = include.payment-instrument | default: 'creditcard' %}

## Transactions

{% include transactions.md payment-instrument=payment-instrument %}

### Transaction

{% include transaction.md payment-instrument=payment-instrument %}
