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
| {% icon check %} ︎︎︎︎︎ | `hostUrls`          | `array`  | The array of URLs valid for embedding of Swedbank Pay Hosted Views.                                                                                                                                                                                                                                      |
| {% icon check %}  | `completeUrl`       | `string` | The URL that Swedbank Pay will redirect back to when the payer has completed their interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment order to inspect it further. See [`completeUrl`][completeurl] for details.  |
| {% icon check %}  | `termsOfServiceUrl` | `string` | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                     |
|                   | `cancelUrl`         | `string` | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
|                   | `paymentUrl`        | `string` | The URL that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. See [`paymentUrl`][payment-url] for details.                                                                                                                                                       |
|                   | `callbackUrl`       | `string` | The URL to the API endpoint receiving `POST` requests on transaction activity related to the payment order.                                                                                                                                                                                              |
|                   | `logoUrl`           | `string` | {% include fields/logo-url.md %}                                                                                                                                                                                                               |
{% include payment-url.md full_reference=true when="selecting the payment
instrument Vipps or in the 3-D Secure verification for Credit Card Payments" %}
{% endcapture %}
{% include accordion-table.html content=table %}

### URLs Resource

It is possible to perform a `GET` request on the `urls` resource to retrieve its
contents.

{:.code-view-header}
Request

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/urls/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
Response

```http
HTTP/1.1 200 OK
Content-Type: application/json
{
    "paymentorder": "/psp/paymentorders/{{ page.payment_order_id }}",
    "urls": {
        "id": "/psp/payments/{{ page.payment_order_id }}/urls",
        "hostUrls": [ "https://example.com", "https://example.net" ],
        "completeUrl": "https://example.com/payment-complete",
        "cancelUrl": "https://example.com/payment-cancelled",
        "paymentUrl": "https://example.com/perform-payment",
        "callbackUrl": "http://api.example.com/payment-callback",
        "logoUrl": "http://merchant.com/path/to/logo.png",
        "termsOfServiceUrl": "http://merchant.com/path/to/tems"
    }
}
```

{:.table .table-striped}
| Field                       | Type     | Description                                                                                                                                                                                                                                                                                              |
| :-------------------------- | :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `paymentorder`              | `string` | {% include fields/id.md sub_resource="urls" %}                                                                                                                                                                                                                                                |
| `urls`                      | `object` | The URLs object.                                                                                                                                                                                                                                                                                         |
| {% f id %}                | `string` | {% include fields/id.md resource="urls" %}                                                                                                                                                                                                                                                    |
| {% f hostsUrl %}          | `string` | An array of the whitelisted URLs that are allowed as parents to a Hosted View, typically the URL of the web shop or similar that will embed a Hosted View within it.                                                                                                                                     |
| {% f completeUrl %}       | `string` | The URL that Swedbank Pay will redirect back to when the payer has completed their interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment order to inspect it further. See [`completeUrl`][completeurl] for details. |
| {% f cancelUrl %}         | `string` | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% f paymentUrl %}        | `string` | The URL that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. See [`paymentUrl`][payment-url] for details.                                                                                                          |
| {% f callbackUrl %}       | `string` | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                |
| {% f logoUrl %}           | `string` | {% include fields/logo-url.md %}                                                                                                                                                                                     |
| {% f termsOfServiceUrl %} | `string` | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                     |

[payment-url]: /checkout-v2/features/technical-reference/payment-url
[completeurl]: /checkout-v2/features/technical-reference/complete-url
[callback]: /checkout-v2/features/core/callback
