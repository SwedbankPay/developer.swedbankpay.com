---
title: Swedbank Pay Credit Payments – Other Features
sidebar:
  navigation:
  - title: Credit Payments
    items:
    - url: /payments/credit/
      title: Introduction
    - url: /payments/credit/after-payment
      title: After Payment
    - url: /payments/credit/other-features
      title: Other Features
---

{% include alert-review-section.md %}

{% include jumbotron.html body="Welcome to Other Features - a subsection of
Credit Account Payments. This section has extented code examples and features
that were not covered by the previous subsections." %}

## Payment resource

The `payment` resource is central to all payment instruments. All operations
that target the payment resource directly produce a response similar to the
example seen below. The response given contains all operations that are
possible to perform in the current state of the payment.

{:.code-header}
**Request**

```http
GET /psp/creditaccount/payments/{{ page.paymentId }}/ HTTP/1.1
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
    "payment": {
        "id": "/psp/creditaccount/payments/{{ page.paymentId }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": "Authorization",
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
            "id": "/psp/creditaccount/payments/{{ page.paymentId }}/prices"
        },
        "payeeInfo": {
            "id": "/psp/creditaccount/payments/{{ page.paymentId }}/payeeInfo"
        },
        "urls": {
            "id": "/psp/creditaccount/payments/{{ page.paymentId }}/urls"
        },
        "transactions": {
            "id": "/psp/creditaccount/payments/{{ page.paymentId }}/transactions"
        },
        "authorizations": {
            "id": "/psp/creditaccount/payments/{{ page.paymentId }}/authorizations"
        },
        "captures": {
            "id": "/psp/creditaccount/payments/{{ page.paymentId }}/captures"
        },
        "reversals": {
            "id": "/psp/creditaccount/payments/{{ page.paymentId }}/reversals"
        },
        "cancellations": {
            "id": "/psp/creditaccount/payments/{{ page.paymentId }}/cancellations"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.apiUrl }}/psp/creditaccount/payments/{{ page.paymentId }}",
            "rel": "update-payment-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.frontEndUrl }}/creditaccount/payments/authorize/{{ page.transactionId }}",
            "rel": "redirect-authorization",
            "contentType": "text/html"
        },
        {
            "method": "POST",
            "href": "{{ page.apiUrl }}/psp/creditaccount/payments/{{ page.paymentId }}/captures",
            "rel": "create-capture",
            "contentType": "application/json"
        }
    ]
}
```

{:.table .table-striped}
| Property                 | Type         | Description                                                                                                                                                                                      |
| :----------------------- | :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                | `object`     | The `payment` object contains information about the specific payment.                                                                                                                            |
| └➔&nbsp;`id`             | `string`     | The relative URI of the payment.                                                                                                                                                                 |
| └➔&nbsp;`number`         | `integer`    | The payment  number , useful when there's need to reference the payment in human communication. Not usable for programmatic identification of the payment, for that  id  should be used instead. |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                               |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                               |
| └➔&nbsp;`state`          | `string`     | Ready ,  Pending ,  Failed  or  Aborted . Indicates the state of the payment. This field is only for status display purposes. To                                                                 |
| └➔&nbsp;`prices`         | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                            |
| └➔&nbsp;`prices.id`      | `string`     | The relative URI of the current prices resource.                                                                                                                                                 |
| └➔&nbsp;`description`    | `string(40)` | A textual description of maximum 40 characters of the purchase.                                                                                                                                  |
| └➔&nbsp;`payerReference` | `string`     | The reference to the payer (consumer/end-user) from the merchant system, like e-mail address, mobile number, customer number etc.                                                                |
| └➔&nbsp;`userAgent`      | `string`     | The [user agent](https://en.wikipedia.org/wiki/User_agent) string of the consumer's browser.                                                                                                     |
| └➔&nbsp;`language`       | `string`     | `nb-NO` , `sv-SE`  or  `en-US`                                                                                                                                                                   |
| └➔&nbsp;`urls`           | `string`     | The URI to the  urls  resource where all URIs related to the payment can be retrieved.                                                                                                           |
| └➔&nbsp;`payeeInfo`      | `string`     | The URI to the  payeeinfo  resource where the information about the payee of the payment can be retrieved.                                                                                       |
| `operations`             | `array`      | The array of possible operations to perform                                                                                                                                                      |
| └─➔&nbsp;`method`        | `string`     | The HTTP method to use when performing the operation.                                                                                                                                            |
| └─➔&nbsp;`href`          | `string`     | The target URI to perform the operation against.                                                                                                                                                 |
| └─➔&nbsp;`rel`           | `string`     | The name of the relation the operation has to the current resource.                                                                                                                              |

### Operations

The operations should be performed as described in each response and not as
described here in the documentation.
Always use the `href` and `method` as specified in the response by finding
the appropriate operation based on its `rel` value.
The only thing that should be hard coded in the client is the value of
the `rel` and the request that will be sent in the HTTP body of the request
for the given operation.

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| `update-payment-abort`   | `abort`s the payment order before any financial transactions are performed.                                               |
| `redirect-authorization` | Contains the URI that is used to redirect the consumer to the Swedbank Pay Payments containing the card authorization UI. |
| `create-capture`         | Creates a `capture` transaction in order to charge the reserved funds from the consumer.                                  |
| `create-cancellation`    | Creates a `cancellation` transaction that cancels a created, but not yet captured payment.                                |

{% include transactions-reference.md payment-instrument="creditaccount" %}

{% include callback-reference.md  payment-instrument="creditaccount" %}

## PayeeReference

{% include payee-info.md %}

{% include settlement-reconciliation.md %}

## Problem messages

When performing unsuccessful operations, the eCommerce API will respond with
a problem message. We generally use the problem message type and status code to
identify the nature of the problem. The problem name and description will often
help narrow down the specifics of the problem.

### Error types

All error types will have the following URI in front of type:
`https://api.payex.com/psp/errordetail/careditaccount/<error-type>`

{:.table .table-striped}
| Type            | Status | Description                   |
| :-------------- | :----- | :---------------------------- |
| `externalerror` | `500`  | No error code                 |
| `inputerror`    | `400`  | 10 - ValidationWarning        |
| `inputerror`    | `400`  | 30 - ValidationError          |
| `inputerror`    | `400`  | 3010 - ClientRequestInvalid   |
| `externalerror` | `502`  | 40 - Error                    |
| `externalerror` | `502`  | 60 - SystemError              |
| `externalerror` | `502`  | 50 - SystemConfigurationError |
| `externalerror` | `502`  | 9999 - ServerOtherServer      |
| `forbidden`     | `403`  | Any other error code          |

{% include iterator.html
        prev_href="after-payment"
        prev_title="Back: After Payment"%}
