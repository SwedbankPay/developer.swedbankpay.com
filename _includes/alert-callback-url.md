{% assign payment_instrument = include.payment_instrument | default: "creditcard" %}
{% assign callback_href = "/payments/" | append: payment_instrument | append: "/other-features#callback" %}

{% capture body %}
While optional, it is strongly recommended to set a [`callbackUrl`]({{
callback_href }}) in the `POST` request creating the payment. If `callbackUrl`
is set, Swedbank Pay will send a `POST` request to this URL when the consumer
has fulfilled the payment. Upon receiving this `POST` request, a subsequent
`GET` request towards the `id` of the payment generated initially must be made
to receive the state of the transaction.
{% endcapture %}

{% include alert.html type="success" icon="link" header="Callback URL"
body=body %}
