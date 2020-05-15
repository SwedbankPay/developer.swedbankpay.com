{% assign api_resource = include.api_resource %}
{% if api_resource == "creditcard" %}
    {% assign callback_href = "/payments/card" | append: "/other-features#callback" %}

{% else %}
    {% assign callback_href = "/payments/" | append: api_resource | append: "/other-features#callback" %}
{% endif %}

{% capture body %}
It is mandatory to set a [`callbackUrl`]({{
callback_href }}) in the `POST` request creating the payment. If `callbackUrl`
is set, Swedbank Pay will send a `POST` request to this URL when the consumer
has fulfilled the payment. Upon receiving this `POST` request, a subsequent
`GET` request towards the `id` of the payment generated initially must be made
to receive the state of the transaction.
{% endcapture %}

{% include alert.html type="success" icon="link" header="Callback URL"
body=body %}
