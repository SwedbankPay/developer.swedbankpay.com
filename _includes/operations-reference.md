### Operations

When a payment order resource is created and during its lifetime, 
it will have a set of operations that can be performed on it. 
The state of the payment order resource, what the access token is authorized 
to do, the chosen payment instrument and its transactional states, 
etc. determine the available operations before the initial purchase. 
A list of possible operations and their explanation is given below.

{:.code-header}
**Operations**

```js
{
    "paymentOrder": {
        "id": "/psp/paymentorders/8bf85423-841d-4fb8-d754-08d6d398f0c5",
    }
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/8bf85423-841d-4fb8-d754-08d6d398f0c5",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/8bf85423-841d-4fb8-d754-08d6d398f0c5",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/eb6932c2e24113377ecd88da343a10566b31f59265c665203b1287277224ef60",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=eb6932c2e24113377ecd88da343a10566b31f59265c665203b1287277224ef60&culture=nb-NO",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/captures",
            "rel": "create-paymentorder-capture",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/cancellations",
            "rel": "create-paymentorder-cancel",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/reversals",
            "rel": "create-paymentorder-reversal",
            "contentType": "application/json"
        }
    ]
}
```

{:.table .table-striped}
| Property      | Description                                                              |
| :------------ | :----------------------------------------------------------------------- |
| `href`        | The target URI to perform the operation against.                         |
| `rel`         | The name of the relation the operation has to the current resource.      |
| `method`      | The HTTP method to use when performing the operation.                    |
| `contentType` | The HTTP content type of the resource referenced in the `href` property. |

The operations should be performed as described in each response and not as 
described here in the documentation. 
Always use the `href` and `method` as specified in the response by finding 
the appropriate operation based on its `rel` value. 
The only thing that should be hard coded in the client is the value of 
the `rel` and the request that will be sent in the HTTP body of the request 
for the given operation.


{:.table .table-striped}
| Operation                          | Description                                                                                                                                                                                                                                                                    |
| :--------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `update-paymentorder-abort`        | [Aborts][payment-order-abort] the payment order before any financial transactions are performed.                                                                                                                                                                               |
| `update-paymentorder-updateorder`  | [Updates the order][payment-order-update] with a change in the `amount` and/or `vatAmount`.                                                                                                                                                                                    |
| `redirect-paymentorder`            | Contains the URI that is used to redirect the consumer to the PayEx Payment Pages containing the Payment Menu.                                                                                                                                                                 |
| `view-paymentorder`                | Contains the JavaScript `href` that is used to embed the Payment Menu UI directly on the webshop/merchant site.                                                                                                                                                                |
| `create-paymentorder-capture`      | The second part of a two-phase transaction where the authorized amount is sent from the payer to the payee. It is possible to do a part-capture on a subset of the authorized amount. Several captures on the same payment are possible, up to the total authorization amount. |
| `create-paymentorder-cancellation` | Used to cancel authorized and not yet captured transactions. If a cancellation is performed after doing a part-capture, it will only affect the not yet captured authorization amount.                                                                                         |
| `create-paymentorder-reversal`     | Used to reverse a payment. It is only possible to reverse a payment that has been captured and not yet reversed.                                                                                                                                                               |

#### View Payment Order

The `view-paymentorder` operation contains the URI of the JavaScript that 
needs to be set as a `script` element's `src` attribute, 
either client-side through JavaScript or server-side in HTML as shown below.

```html
<!DOCTYPE html>
<html>
    <head>
        <title>Swedbank Pay Checkout is Awesome!</title>
    </head>
    <body>
        <div id="checkout"></div>
        <script src="https://ecom.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=38540e86bd78e885fba2ef054ef9792512b1c9c5975cbd6fd450ef9aa15b1844&culture=nb-NO"></script>
        <script language="javascript">
            payex.hostedView.paymentMenu({
                container: 'checkout',
                culture: 'nb-NO',
                onPaymentCompleted: function(paymentCompletedEvent) {
                    console.log(paymentCompletedEvent);
                },
                onPaymentFailed: function(paymentFailedEvent) {
                    console.log(paymentFailedEvent);
                },
                onPaymentCreated: function(paymentCreatedEvent) {
                    console.log(paymentCreatedEvent);
                },
                onPaymentToS: function(paymentToSEvent) {
                    console.log(paymentToSEvent);
                },
                onPaymentMenuInstrumentSelected: function(paymentMenuInstrumentSelectedEvent) {
                    console.log(paymentMenuInstrumentSelectedEvent);
                },
                onError: function(error) {
                    console.error(error);
                },
            }).open();
        </script>
    </body>
</html>
```

#### Update Order

Change amount and vat amount on a payment order. 
If you implement `updateorder` **you need to `refresh()`** 
the [Payment Menu front end][payment-menu-front-end]
so the new amount is shown to the end customer.

{:.code-header}
**Request**

```http
PATCH /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4 HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "UpdateOrder",
        "amount": 2500,
        "vatAmount": 120
    }
}
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
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
        "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
        "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeinfo" },
        "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
        "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
        "orderItems" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/orderItems" },
        "metadata": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/metadata" },
        "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
        "currentPayment": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/currentpayment" }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/479a7a2b-3b20-4302-fa84-08d676d15bc0",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/4b0baaf8fdb5a56b5bdd78a8dd9e63e42e93ec79e5d0c0b5cc40f79cf43c9428",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=4b0baaf8fdb5a56b5bdd78a8dd9e63e42e93ec79e5d0c0b5cc40f79cf43c9428&culture=nb-NO",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        } 
    ]   
}
```
**Remember to call .refresh() on the Payment Menu in JavaScript**

{:.table .table-striped}
| Property                 | Type         | Description                                                                                                                          |
| :----------------------- | :----------- | :----------------------------------------------------------------------------------------------------------------------------------- |
| `paymentorder`           | `object`     | The payment order object.                                                                                                            |
| └➔&nbsp;`id`             | `string`     | The relative URI to the payment order.                                                                                               |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment order was created.                                                                             |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                             |
| └➔&nbsp;`operation`      | `string`     | Purchase                                                                                                                             |
| └➔&nbsp;`state`          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment order. This field is only for status display purposes. |
| └➔&nbsp;`currency`       | `string`     | The currency of the payment order.                                                                                                   |
| └➔&nbsp;`amount`         | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.    |
| └➔&nbsp;`vatAmount`      | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.           |
| └➔&nbsp;`description`    | `string(40)` | A textual description of maximum 40 characters of the purchase.                                                                      |
| └➔&nbsp;`userAgent`      | `string`     | The [user agent][user-agent] string of the consumer's browser.                                                                       |
| └➔&nbsp;`language`       | `string`     | `nb-NO`, `sv-SE` or `en-US`                                                                                                          |
| └➔&nbsp;`urls`           | `string`     | The URI to the `urls` resource where all URIs related to the payment order can be retrieved.                                         |
| └➔&nbsp;`payeeInfo`      | `string`     | The URI to the `payeeinfo` resource where the information about the payee of the payment order can be retrieved.                     |
| └➔&nbsp;`payers`         | `string`     | The URI to the `payers` resource where information about the payee of the payment order can be retrieved.                            |
| └➔&nbsp;`orderItems`     | `string`     | The URI to the `orderItems` resource where information about the order items can be retrieved.                                       |
| └➔&nbsp;`metadata`       | `string`     | The URI to the `payments` resource where information about all underlying payments can be retrieved.                                 |
| └➔&nbsp;`payments`       | `string`     | The URI to the `payments` resource where information about all underlying payments can be retrieved.                                 |
| └➔&nbsp;`currentPayment` | `string`     | The URI to the `currentPayment` resource where information about the current – and sole active – payment can be retrieved.           |
| └➔&nbsp;`operations`     | `array`      | The array of possible operations to perform, given the state of the payment order. [See Operations for details][operations].         |

#### Capture

Capture can only be done on a payment with a successful authorized transaction. 
It is possible to do a part-capture where you only capture a smaller amount 
than the authorized amount. 
You can later do more captures on the same payment up to the total 
authorization amount.

To capture the authorized payment, we need to perform 
`create-paymentorder-capture` against the accompanying href returned in the
`operations` list. 
See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/captures HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "transaction": {
        "description": "Capturing the authorized payment",
        "amount": 15610,
        "vatAmount": 3122,
        "payeeReference": "AB832",
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 4,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 200,
                "vatPercent": 2500,
                "amount": 1000,
                "vatAmount": 250
            },
            {
                "reference": "P2",
                "name": "Product2",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "description": "Product 2 description",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 500,
                "vatPercent": 2500,
                "amount": 500,
                "vatAmount": 125
            }
        ]
    }
}
```

{:.table .table-striped}
| Required | Property                     | Type         | Description                                                                                                                                                                                    |
| :------- | :--------------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✔︎︎︎︎︎   | `transaction.description`    | `string`     | The description of the capture transaction.                                                                                                                                                    |
| ✔︎︎︎︎︎   | `transaction.amount`         | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                              |
| ✔︎︎︎︎︎   | `transaction.vatAmount`      | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                                     |
| ✔︎︎︎︎︎   | `transaction.payeeReference` | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.       |
|          | `transaction.orderItems`     | `array`      | The array of items being purchased with the order. Used to print on invoices if the payer chooses to pay with invoice, among other things. [See Order Items for details][payment-order-items]. |

If the capture succeeds, it should respond with something like the following:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "capture": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/captures/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Capture",
            "state": "Completed",
            "amount": 15610,
            "vatAmount": 3122,
            "description": "Capturing the authorized payment",
            "payeeReference": "AB832",
        }
    }
}
```

{:.table .table-striped}
| Property              | Data type | Description                                                                              |
| :-------------------- | :-------- | :--------------------------------------------------------------------------------------- |
| `payment`             | `string`  | The relative URI of the payment this capture transaction belongs to.                     |
| `capture.id`          | `string`  | The relative URI of the created capture transaction.                                     |
| `capture.transaction` | `object`  | The object representation of the generic [`transaction` resource][transaction-resource]. |

Checkout should now be complete, the payment should be secure and everyone 
should be happy. 
But, sometimes you also need to implement the cancellation and reversal 
operations described below.

#### Abort

* It is possible for the merchant to abort a payment before the end user has fulfilled the payment process. If the merchant calls the `PATCH` function (see example below), the payment will be aborted.
* This can only happen if there exist no final transactions (like captures) on the payment with a successful status. Once the payment is aborted, no more transactions/operations can be done. If the consumer has been redirected to a hosted payment page when this happens, the end user will be redirected back to your merchant page.

To abort a payment order, perform the `update-paymentorder-abort` operation 
that is returned in the payment order response. 
You need to include the following `HTTP` body:

{:.code-header}
**Request**

```http
PATCH /psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Abort",
    "abortReason": "CancelledByConsumer"
  }
}
```


The response given when aborting a payment order is equivalent to a `GET` 
request towards the `paymentorders` resource, with its `state` set to `Aborted`.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b",
        "number": 70100130293,
        "created": "2019-01-09T13:11:28.371179Z",
        "updated": "2019-01-09T13:11:46.5949967Z",
        "instrument": "CreditCard",
        "operation": "Purchase",
        "intent": "AutoCapture",
        "state": "Aborted",
        "currency": "DKK",
        "prices": {
            "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b/prices"
        },
        "amount": 0,
        "description": "creditcard Test",
        "payerReference": "100500",
        "initiatingSystemUserAgent": "PostmanRuntime/7.1.1",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b/urls"
        },
        "payeeInfo": {
            "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b/payeeinfo"
        },
        "metadata": {
            "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b/metadata"
        }
    },
    "operations": []
}
```

#### Cancel

If we want to cancel up to the total authorized (not captured) amount, 
we need to perform `create-paymentorder-cancel` against the accompanying `href` 
returned in the` operations `list. 
See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/cancellations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "transaction": {
        "payeeReference": "ABC123",
        "description": "Cancelling parts of the total amount"
    }
}
```

{:.table .table-striped}
| Property | Type                         | Required     | Description                                                                                                                                                                              |
| :------- | :--------------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✔︎︎︎︎︎   | `transaction.payeeReference` | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details. |
| ✔︎︎︎︎︎   | `transaction.description`    | `string`     | A textual description of why the transaction is cancelled.                                                                                                                               |

If the cancellation request succeeds, the response should be 
similar to the example below:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "cancellation": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/cancellations/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Cancel",
            "state": "Completed",
            "amount": 5610,
            "vatAmount": 1122,
            "description": "Cancelling parts of the authorized payment",
            "payeeReference": "AB832",
        }
    }
}
```

{:.table .table-striped}
| Property                   | Data type | Description                                                                              |
| :------------------------- | :-------- | :--------------------------------------------------------------------------------------- |
| `payment`                  | `string`  | The relative URI of the payment this capture transaction belongs to.                     |
| `cancellation.id`          | `string`  | The relative URI of the created capture transaction.                                     |
| `cancellation.transaction` | `object`  | The object representation of the generic [`transaction` resource][transaction-resource]. |

#### Reversal

If we want to reverse a previously captured amount, we need to perform 
`create-paymentorder-reversal` against the accompanying `href` returned 
in the `operations` list. 
See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/reversals HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 15610,
        "vatAmount": 3122,
        "payeeReference": "ABC123",
        "description": "description for transaction"
    }
}
```

{:.table .table-striped}
| Required | Property                     | Type         | Description                                                                                                                                                                              |
| :------- | :--------------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✔︎︎︎︎︎   | `transaction.amount`         | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                        |
| ✔︎︎︎︎︎   | `transaction.vatAmount`      | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                               |
| ✔︎︎︎︎︎   | `transaction.payeeReference` | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details. |
| ✔︎︎︎︎︎   | `transaction.description`    | `string`     | Textual description of why the transaction is reversed.                                                                                                                                  |

If the reversal request succeeds, 
the response should be similar to the example below:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "reversals": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/cancellations/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Reversal",
            "state": "Completed",
            "amount": 5610,
            "vatAmount": 1122,
            "description": "Reversing the capture amount",
            "payeeReference": "ABC987",
        }
    }
}
```

{:.table .table-striped}
| Property               | Data type | Description                                                                              |
| :--------------------- | :-------- | :--------------------------------------------------------------------------------------- |
| `payment`              | `string`  | The relative URI of the payment this reversal transaction belongs to.                    |
| `reversal.id`          | `string`  | The relative URI of the created reversal transaction.                                    |
| `reversal.transaction` | `object`  | The object representation of the generic [`transaction` resource][transaction-resource]. |

[payment-order-abort]: #abort
[payment-order-update]: #update-order
[payment-menu-front-end]: /checkout/payment-menu#payment-menu-front-end
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[operations]: #operations
[payment-order-items]: #payment-orders
[transaction-resource]: #transactions
[payee-reference]: #payee-info
