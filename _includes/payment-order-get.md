The `paymentorders` resource is used when initiating a payment process through
[Payment Menu][payment-menu] and [Swedbank Pay Checkout](/checkout/index). The payment
order is a container for the payment instrument object selected by the payer. This
will generate a payment that is accessed through the sub-resources `payments`
and `currentPayment`.

{:.code-header}
**Request**

```http
GET /psp/paymentorders/{{ page.paymentOrderId }}/ HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.paymentOrderId }}",
        "created": "2018-09-14T13:21:29.3182115Z",
        "updated": "2018-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls" : { "id": "/psp/paymentorders/{{ page.paymentOrderId }}/urls" },
        "payeeInfo" : { "id": "/psp/paymentorders/{{ page.paymentOrderId }}/payeeinfo" },
        "settings": { "id": "/psp/paymentorders/{{ page.paymentOrderId }}/settings" },
        "payers": { "id": "/psp/paymentorders/{{ page.paymentOrderId }}/payers" },
        "orderItems" : { "id": "/psp/paymentorders/{{ page.paymentOrderId }}/orderItems" },
        "metadata": { "id": "/psp/paymentorders/{{ page.paymentOrderId }}/metadata" },
        "payments": { "id": "/psp/paymentorders/{{ page.paymentOrderId }}/payments" },
        "currentPayment": { "id": "/psp/paymentorders/{{ page.paymentOrderId }}/currentpayment" }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.apiUrl }}/psp/paymentorders/{{ page.paymentOrderId }}",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.frontEndUrl }}/paymentmenu/{{ page.paymentToken }}",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "{{ page.frontEndUrl }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.paymentToken }}&culture=nb-NO",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        }
    ]
}
```

{:.table .table-striped}
| Property                 | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `paymentorder`           | `object`     | The payment order object.                                                                                                                                                                                                 |
| └➔&nbsp;`id`             | `string`     | The relative URI to the payment order.                                                                                                                                                                                    |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| └➔&nbsp;`operation`      | `string`     | Purchase                                                                                                                                                                                                                  |
| └➔&nbsp;`state`          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes. |
| └➔&nbsp;`currency`       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| └➔&nbsp;`amount`         | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK`, a `5000` quals `50.00 NOK`.                                                                                       |
| └➔&nbsp;`vatAmount`      | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals `50.00 NOK`.                                                                                              |
| └➔&nbsp;`description`    | `string(40)` | A textual description of maximum 40 characters of the purchase.                                                                                                                                                           |
| └➔&nbsp;`userAgent`      | `string`     | The [user agent][user-agent] string of the consumer's browser.                                                                                                                                                            |
| └➔&nbsp;`language`       | `string`     | `nb-NO`, `sv-SE` or `en-US`                                                                                                                                                                                               |
| └➔&nbsp;`urls`           | `string`     | The URI to the `urls` resource where all URIs related to the payment order can be retrieved.                                                                                                                              |
| └➔&nbsp;`payeeInfo`      | `string`     | The URI to the `payeeinfo` resource where the information about the payee of the payment order can be retrieved.                                                                                                          |
| └➔&nbsp;`payers`         | `string`     | The URI to the `payers` resource where information about the payee of the payment order can be retrieved.                                                                                                                 |
| └➔&nbsp;`orderItems`     | `string`     | The URI to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| └➔&nbsp;`metadata`       | `string`     | The URI to the `payments` resource where information about all underlying payments can be retrieved.                                                                                                                      |
| └➔&nbsp;`payments`       | `string`     | The URI to the `payments` resource where information about all underlying payments can be retrieved.                                                                                                                      |
| └➔&nbsp;`currentPayment` | `string`     | The URI to the `currentPayment` resource where information about the current – and sole active – payment can be retrieved.                                                                                                |
| └➔&nbsp;`operations`     | `array`      | The array of possible operations to perform, given the state of the payment order. [See Operations for details][operations].                                                                                              |

-----------------------------------------
[payment-menu]: /checkout/payment-menu
