{% assign api_resource = include.api_resource | default: 'creditcard' %}
{% assign documentation_section = include.documentation_section %}

A payment contains sub-resources in the form of `transactions`. Most operations
performed on a payment ends up as a transaction. The different types of
operations that alter the state of the payment by creating a transaction is
described below.

The `transactions` resource will list the transactions (one or more) on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md api_resource=api_resource
documentation_section=documentation_section transaction="transaction" %}
