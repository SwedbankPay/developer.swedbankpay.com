## URLs

When creating a Payment Order, the `urls` field of the `paymentOrder`
contains the related URLs, including where the payer is redirected when
going forward with or canceling a payment session, as well as the callback URL
that is used to inform the payee (merchant) of changes or updates made to
underlying payments or transaction.

{% capture table %}
{:.table .table-striped .mb-5}
|     Required      | Field               | Type     | Description                                                                                                                                                                                                                                                                                              |
| :---------------: | :------------------ | :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} ︎︎︎︎︎ | `hostUrls`          | `array`  | The array of valid host URLs.                                                                                                                                                                                                                                |
| {% icon check %}  | `completeUrl`       | `string` | {% include fields/complete-url.md resource="payment" %}  |
|                   | `cancelUrl`         | `string` | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
|                   | `paymentUrl`        | `string` | {% include fields/payment-url.md %}                                                                                                                                                       |
|                   | `callbackUrl`       | `string` | {% include fields/callback-url.md %}                                                                                                                                                                                              |
|                   | `logoUrl`           | `string` | {% include fields/logo-url.md %}                                                                                                                                                                                                               |
| {% icon check %}  | `termsOfServiceUrl` | `string` | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                     |
{% include payment-url.md full_reference=true when="selecting the payment
instrument Vipps or in the 3-D Secure verification for Credit Card Payments" %}
{% endcapture %}
{% include accordion-table.html content=table %}

### URLs Resource

It is possible to perform a `GET` request on the `urls` resource to retrieve its
contents.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/urls/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0     // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": "/psp/paymentorders/{{ page.payment_order_id }}",
    "urls": {
        "id": "/psp/payments/{{ page.payment_order_id }}/urls",
        "hostUrls": [ "https://example.com", "https://example.net" ],
        "completeUrl": "https://example.com/payment-complete",
        "cancelUrl": "https://example.com/payment-cancelled",
        "paymentUrl": "https://example.com/perform-payment",
        "callbackUrl": "http://api.example.com/payment-callback",
        "logoUrl": "http://merchant.com/path/to/logo.png",
        "termsOfServiceUrl": "https://example.com/termsandconditions.pdf"
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field                     | Type     | Description                                                                                                                                                                                                                                                                                              |
| :------------------------ | :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f paymentOrder, 0 %}   | `string` | {% include fields/id.md sub_resource="urls" %}                                                                                                                                                                                                                                                |
| {% f urls, 0 %}           | `object` | The URLs object.                                                                                                                                                                                                                                                                                         |
| {% f id %}                | `string` | {% include fields/id.md resource="urls" %}                                                                                                                                                                                                                                                    |
| {% f hostsUrl %}          | `string` | An array of the whitelisted URLs that are allowed as parents to a Hosted View, typically the URL of the web shop or similar that will embed a Hosted View within it.                                                                                                                                     |
| {% f completeUrl %}       | `string` | {% include fields/complete-url.md resource="payment" %} |
| {% f cancelUrl %}         | `string` | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% f paymentUrl %}        | `string` | {% include fields/payment-url.md %}                                                                                                          |
| {% f callbackUrl %}       | `string` | {% include fields/callback-url.md resource="payment" %}                                                                                                                                                |
| {% f logoUrl %}           | `string` | {% include fields/logo-url.md %}                                                                                                                                                                                     |
| {% f termsOfServiceUrl %} | `string` | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                     |
