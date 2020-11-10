---
title: Technical Reference
redirect_from:
estimated_read: 30
description: |
  Welcome to Technical Features.
  This section has extented code examples and features that were not
  covered by the other subsections.
menu_order: 1200
---

{% include alert-risk-indicator.md %}

{% include callback-reference.md api_resource="creditcard" %}

{% include card-authorization-transaction.md %}

{% include card-purchase.md full_reference=true %}

{% include checkin-events.md %}

{% include complete-url.md %}

{% include create-payment.md %}

{% include description.md api_resource="creditcard" %}

{% include metadata.md api_resource="creditcard" %}

{% include payee-info.md api_resource="creditcard" documentation_section="card" %}

{% include payments-operations.md api_resource="creditcard"
documentation_section="card" %}

{% include payment-order-operations.md %}

{% include payment-transaction-states.md %}

{% include payment-url.md api_resource="card" documentation_section="card"
when="at the 3-D Secure verification for credit card payments" full_reference=true %}

{% include prices.md %}

{% include problems/problems.md documentation_section="card" %}

{% include seamless-view-events.md api_resource="creditcard" %}

{% include seamless-view-events.md api_resource="paymentorders" %}

{% include transactions.md api_resource="creditcard" documentation_section="card" %}

{% include iterator.html prev_href="optional-features" prev_title="Optional Features" %}
