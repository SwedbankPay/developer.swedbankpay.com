{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% assign transaction = include.transaction | default: "authorization" %}
{% if api_resource == "paymentorders" %}
  {% assign resource_title = "Payment Order" %}
{% else %}
  {% assign resource_title = "Payment" %}
{% endif %}
{% if api_resource == "swish" or api_resource == "trustly" %}
  {% assign transaction="sale" %}
{% else %}
  {% assign transaction="authorization" %}
{% endif %}

## {{ resource_title }} State

The `state` field on the `{{ transaction }}` does not indicate whether a given
`transaction` was successful or not, it only tells whether the {{ transaction }}
resource itself is operational or not. To figure out the `state` of i.e. {{
transaction }} `transactions`, you have two options:

### Paid or Failed Operations

You can perform a `GET` request on the {{ transaction }}. As long as the
{{ transaction }} has been completed, successful or not, you will find the
`Paid` or `Failed` operation among the operations in the response.

Please note that a {{ transaction }} where a `Failed` attempt has been made,
but the payer still has attempts left to complete the {{ transaction }}, you
won't see the `Failed` operation. It will only appear when all attempts have
been made.

### Authorization or Sale Transactions

Find the {{ transaction }}’s list of `transactions` either by expanding it when
retrieving the {{ transaction }}, or by performing a `GET` request towards the
`transactions.id` URI.

If you find a `transaction` with `type` equal to {{ transaction }}, with its
`state` equal to `Completed`, you can be sure that the amount of the
{{transaction }} has been reserved or withdrawn and that the {{ transaction }}
can be considered successful.
