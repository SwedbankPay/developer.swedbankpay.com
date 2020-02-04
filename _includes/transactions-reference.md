{% assign payment_instrument = include.payment_instrument | default: 'creditcard' %}

## Transactions

{% include transactions.md payment_instrument=payment_instrument %}

### Transaction

{% include transaction.md payment_instrument=payment_instrument %}
