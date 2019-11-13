The `urls` resource contains the URIs related to a payment order, including
where the consumer gets redirected when going forward with or cancelling a
payment session, as well as the callback URI that is used to inform the payee
(merchant) of changes or updates made to underlying payments or transaction.

{:.code-header}
Request

```http
GET /psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls/ HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json
```

{:.code-header}
Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": "/psp/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "urls": {
        "id": "/psp/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls",
        "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
        "completeUrl": "http://example.com/payment-complete",
        "cancelUrl": "http://example.com/payment-canceled",
        "paymentUrl": "http://example.com/perform-payment",
        "callbackUrl": "http://api.example.com/payment-callback",
        "logoUrl": "http://merchant.com/path/to/logo.png",
        "termsOfServiceUrl": "http://merchant.com/path/to/tems"
    }
}
```

{:.table .table-striped}
| Property                    | Type     | Description                                                                                                                                                                                                                                |
| :-------------------------- | :------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `paymentorder`              | `string` | The URI to the payment order the resource belong to.                                                                                                                                                                                       |
| `urls`                      | `object` | The URLs object.                                                                                                                                                                                                                           |
| └➔&nbsp;`id`                | `string` | The relative URI to the `urls` resource.                                                                                                                                                                                                   |
| └➔&nbsp;`hostsUrl`          | `string` | An array of the whitelisted URIs that are allowed as parents to a Hosted View, typically the URI of the web shop or similar that will embed a Hosted View within it.                                                                       |
| └➔&nbsp;`completeUrl`       | `string` | The URI that Swedbank Pay will redirect back to when the payment page is completed.                                                                                                                                                               |
| └➔&nbsp;`cancelUrl`         | `string` | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. If both cancelUrl and paymentUrl is sent, the paymentUrl will used.                                                                          |
| └➔&nbsp;`paymentUrl`        | `string` | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in Seamless Views. If both cancelUrl and paymentUrl is sent, the paymentUrl will used. |
| └➔&nbsp;`callbackUrl`       | `string` | The URI that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback-reference] for details.                                                                                 |
| └➔&nbsp;`logoUrl`           | `string` | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width.                                                                                                                       |
| └➔&nbsp;`termsOfServiceUrl` | `string` | A URI that contains your terms and conditions for the payment, to be linked on the payment page.                                                                                                                                           |
