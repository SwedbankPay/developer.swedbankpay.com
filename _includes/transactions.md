{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% assign header_level = include.header_level | default: 2 %}
{% assign next_header_level = header_level | plus: 1 %}
{% capture h %}{% for i in (1..header_level) %}#{% endfor %}{% endcapture %}

{{ h }} Transactions

{% if api_resource == "paymentorders" -%}
A payment order contains one or more `payment` sub-resources, which in turn
contains sub-resources in the form of `transactions`.
{% else -%}
A payment contains sub-resources in the form of `transactions`.
{% endif -%}

Most operations performed on a payment ends up as a `transaction` resource. The
different types of operations that alter the state of the payment by creating a
transaction is described below.

The `transactions` resource will list the transactions (one or more) on a
specific payment.

{:.code-view-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md transaction="transaction" %}
{% include transaction.md header_level=next_header_level %}
