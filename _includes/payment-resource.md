The `payment` resource is central to all payment instruments. All operations 
that target the payment resource directly produce a response similar to the 
example seen below. The response given contains all operations that are 
possible to perform in the current state of the payment. You can use the 
`expand` parameter to expand one or more properties relating to the purchase 
resource (see [Expansion][expansion]).

{:.code-header}
**Request**

```http
GET /psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/ HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": "PreAuthorization",
        "currency": "NOK",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "prices": {
            "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices"
        },
        "payeeInfo": {
            "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo"
        },
        "urls": {
            "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls"
        },
        "transactions": {
            "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions"
        },
        "authorizations": {
            "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations"
        },
        "captures": {
            "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures"
        },
        "reversals": {
            "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals"
        },
        "cancellations": {
            "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
            "rel": "update-payment-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/creditcardv2/core/scripts/client/px.creditcard.client.js?token=c5c29b7c0d45913a9fbca195056b47fdde0201cc6ad93c3634d7cd8dea361e1f&operation=authorize",
            "rel": "view-authorization",
            "contentType": "application/javascript"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/creditcardv2/payments/authorize/c5c29b7c0d45913a9fbca195056b47fdde0201cc6ad93c3634d7cd8dea361e1f",
            "rel": "redirect-authorization",
            "contentType": "text/html"
        }
    ]
}
```

{:.table .table-striped}
| Property                 | Type       | Description                                                                                                                                                                                      |
| :----------------------- | :--------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                | object     | The `payment` object contains information about the specific payment.                                                                                                                            |
| └➔&nbsp;`id`             | string     | The relative URI of the payment.                                                                                                                                                                 |
| └➔&nbsp;`number`         | integer    | The payment  number , useful when there's need to reference the payment in human communication. Not usable for programmatic identification of the payment, for that  id  should be used instead. |
| └➔&nbsp;`created`        | string     | The ISO-8601 date of when the payment was created.                                                                                                                                               |
| └➔&nbsp;`updated`        | string     | The ISO-8601 date of when the payment was updated.                                                                                                                                               |
| └➔&nbsp;`state`          | string     | Ready ,  Pending ,  Failed  or  Aborted . Indicates the state of the payment. This field is only for status display purposes. To                                                                 |
| └➔&nbsp;`prices`         | object     | The `prices` resource lists the prices related to a specific payment.                                                                                                                            |
| └➔&nbsp;`prices.id`      | string     | The relative URI of the current prices resource.                                                                                                                                                 |
| └➔&nbsp;`description`    | string(40) | A textual description of maximum 40 characters of the purchase.                                                                                                                                  |
| └➔&nbsp;`payerReference` | string     | The reference to the payer (consumer/end-user) from the merchant system, like e-mail address, mobile number, customer number etc.                                                                |
| └➔&nbsp;`userAgent`      | string     | The [user agent](https://en.wikipedia.org/wiki/User_agent) string of the consumer's browser.                                                                                                     |
| └➔&nbsp;`language`       | string     | `nb-NO` , `sv-SE`  or  `en-US`                                                                                                                                                                   |
| └➔&nbsp;`urls`           | string     | The URI to the  urls  resource where all URIs related to the payment can be retrieved.                                                                                                           |
| └➔&nbsp;`payeeInfo`      | string     | The URI to the  payeeinfo  resource where the information about the payee of the payment can be retrieved.                                                                                       |
| `operations`             | array      | The array of possible operations to perform                                                                                                                                                      |
| └─➔&nbsp;`method`        | string     | The HTTP method to use when performing the operation.                                                                                                                                            |
| └─➔&nbsp;`href`          | string     | The target URI to perform the operation against.                                                                                                                                                 |
| └─➔&nbsp;`rel`           | string     | The name of the relation the operation has to the current resource.                                                                                                                              |

### Operations

The operations should be performed as described in each response and not as
described here in the documentation.
Always use the `href` and `method` as specified in the response by finding
the appropriate operation based on its `rel` value.
The only thing that should be hard coded in the client is the value of
the `rel` and the request that will be sent in the HTTP body of the request
for the given operation.

{:.table .table-striped}
| Operation                | Description                                                                                                             |
| :----------------------- | :---------------------------------------------------------------------------------------------------------------------- |
| `update-payment-abort`   | [Aborts][abort] the payment order before any financial transactions are performed.                                      |
| `redirect-authorization` | Contains the URI that is used to redirect the consumer to the PayEx Payment Pages containing the card authorization UI. |
| `view-authorization`     | Contains the JavaScript href that is used to embed  the card authorization UI directly on the webshop/merchant site     |
