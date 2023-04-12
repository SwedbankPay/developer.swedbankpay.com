---
title: Delete Token
description: How to delete tokens.
menu_order: 1800
icon:
  content: delete_sweep
  outlined: true
---

## Delete Unscheduled, Recurrence Or Payment Tokens

Payers should be able to delete tokens connected to them. How to do this is
described in the example below. Note that the different token types have
different responses. The `state` field must have the state `Deleted` when
deleting the token. No other states are supported.

{% include delete-payment-order-token.md token_field_name="recurrenceToken" %}

{% include delete-payment-order-token.md token_field_name="unscheduledToken" %}

{% include delete-payment-order-token.md token_field_name="paymentToken" %}
