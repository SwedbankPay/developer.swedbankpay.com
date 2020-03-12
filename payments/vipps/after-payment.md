---
title: Swedbank Pay Payments Vipps After Payment
sidebar:
  navigation:
  - title: Vipps Payments
    items:
    - url: /payments/vipps
      title: Introduction
    - url: /payments/vipps/redirect
      title: Redirect
    - url: /payments/vipps/seamless-view
      title: Seamless View
    - url: /payments/vipps/after-payment
      title: After Payment
    - url: /payments/vipps/other-features
      title: Other Features
---


## Payment Resource

This section describes the general sub-resources of the API that are used to
generate payment requests.

### Create Payment

To create a Vipps payment, you perform an HTTP `POST` against the
`/psp/vipps/payments` resource.

An example of a payment creation request is provided below.
Each individual field of the JSON document is described in the following
section.
Use the [expand][expand-parameter] request parameter to get a
response that includes one or more expanded sub-resources inlined.

{:.code-header}
**Request**

```http
POST /psp/vipps/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "NOK",
        "prices": [
            {
                "type": "Vipps",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Vipps Test",
        "payerReference": "ABtimestamp",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "{{ page.api_url }}/psp/payment-callback",
            "logoUrl": "https://example.com/path/to/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "Postmantimestamp",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        },
        "prefillInfo": {
            "msisdn": "+4793000001"
        }
    }
}
```

{:.table .table-striped}
| Required | Field                        | Type         | Description                                                                                                                                                                                                                                               |
| :------: | :--------------------------- | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|    ✔︎    | `payment`                    | `object`     | The `payment` object.                                                                                                                                                                                                                                     |
|    ✔︎    | └➔&nbsp;`operation`          | `string`     | `Purchase`                                                                                                                                                                                                                                                |
|    ✔︎    | └➔&nbsp;`intent`             | `string`     | `Authorization`                                                                                                                                                                                                                                           |
|    ✔︎    | └➔&nbsp;`currency`           | `string`     | NOK                                                                                                                                                                                                                                                       |
|    ✔︎    | └➔&nbsp;`prices`             | `object`     | The [`prices`][prices] object.                                                                                                                                                                                                                            |
|    ✔︎    | └─➔&nbsp;`type`              | `string`     | `vipps`                                                                                                                                                                                                                                                   |
|    ✔︎    | └─➔&nbsp;`amount`            | `integer`    | {% include field-description-amount.md currency="NOK" %}                                                                                                                                                                                                  |
|    ✔︎    | └─➔&nbsp;`vatAmount`         | `integer`    | {% include field-description-vatamount.md currency="NOK" %}                                                                                                                                                                                               |
|    ✔︎    | └➔&nbsp;`description`        | `string(40)` | A textual description max 40 characters of the purchase.                                                                                                                                                                                                  |
|          | └➔&nbsp;`payerReference`     | `string`     | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc.                                                                                                                                         |
|    ✔︎    | └➔&nbsp;`userAgent`          | `string`     | The user agent reference of the consumer's browser - [see user agent][user-agent]                                                                                                                                                                         |
|    ✔︎    | └➔&nbsp;`language`           | `string`     | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                              |
|    ✔︎    | └➔&nbsp;`urls`               | `object`     | The object containing URLs relevant for the `payment`.                                                                                                                                                                                                    |
|    ✔︎    | └─➔&nbsp;`hostUrls`          | `array`      | The array of URIs valid for embedding of Swedbank Pay Hosted Views.                                                                                                                                                                                       |
|    ✔︎    | └─➔&nbsp;`completeUrl`       | `string`     | The URI that Swedbank Pay will redirect back to when the payment page is completed. This does not indicate a successful payment, only that it has reached a completion state. A `GET` request needs to be performed on the payment to inspect it further. |
|          | └─➔&nbsp;`cancelUrl`         | `string`     | The URI to redirect the payer to if the payment is canceled, either by the payer or by the merchant trough an `abort` request of the `payment`.                                                                                                           |
|          | └─➔&nbsp;`paymentUrl`        | `string`     | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the `payment`.                                                                                                      |
|          | └─➔&nbsp;`callbackUrl`       | `string`     | The URI that Swedbank Pay will perform an HTTP `POST` request against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                           |
|          | └─➔&nbsp;`logoUrl`           | `string`     | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width. Require https.                                                                                                                       |
|          | └─➔&nbsp;`termsOfServiceUrl` | `string`     | A URI that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                           |
|    ✔︎    | └➔&nbsp;`payeeInfo`          | `object`     | The object containing information about the payee.                                                                                                                                                                                                        |
|    ✔︎    | └─➔&nbsp;`payeeId`           | `string`     | This is the unique id that identifies this payee (like merchant) set by PayEx.                                                                                                                                                                            |
|    ✔︎    | └─➔&nbsp;`payeeReference`    | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [`payeeReference`][payee-reference] for details.                                                                |
|          | └─➔&nbsp;`payeeName`         | `string`     | The payee name (like merchant name) that will be displayed to consumer when redirected to PayEx.                                                                                                                                                          |
|          | └─➔&nbsp;`productCategory`   | `strin`      | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                   |
|          | └─➔&nbsp;`orderReference`    | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|          | └─➔&nbsp;`prefillInfo`       | `string`     | The mobile number that will be pre-filled in the Swedbank Pay Payments. The consumer may change this number in the UI.                                                                                                                                    |
|          | └─➔&nbsp;`subsite`           | `string(40)` | The `subsite` field can be used to perform split settlement on the payment. The `subsites` must be resolved with Swedbank Pay reconciliation before being used.                                                                                           |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/vipps/payments/{{ page.payment_id }}",
        "number": 72100003079,
        "created": "2018-09-05T14:18:44.4259255Z",
        "instrument": "Vipps",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "NOK",
        "prices": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/prices"
        },
        "amount": 0,
        "description": "Vipps Test",
        "payerReference": "AB1536157124",
        "initiatingSystemUserAgent": "PostmanRuntime/7.2.0",
        "userAgent": "Mozilla/5.0 weeeeee",
        "language": "nb-NO",
        "urls": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/payeeinfo"
        },
        "metadata": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/metadata"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/vipps/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/vipps/payments/authorize/afccf3d0016340620756d5ff3e08f69b555fbe2e45ca71f4bd159ebdb0f00065",
            "rel": "redirect-authorization"
        }
    ]
}
```

### Purchase

Posting a payment (operation `Purchase`) returns the options of aborting the
payment altogether or creating an authorization transaction through the
`redirect-authorization` hyperlink.

{:.code-header}
**Request**

```js
{
    "payment": {
        "operation": "Purchase"
    }
}
```

## Operations

When a payment resource is created and during its lifetime,
it will have a set of operations that can be performed on it.
Which operations are available will vary depending on the state of the
payment resource, what the access token is authorized to do, etc.

{:.table .table-striped}
| Field    | Description                                                         |
| :------- | :------------------------------------------------------------------ |
| `href`   | The target URI to perform the operation against.                    |
| `rel`    | The name of the relation the operation has to the current resource. |
| `method` | The HTTP method to use when performing the operation.               |

The operations should be performed as described in each response and not as
described here in the documentation.
Always use the `href` and `method` as specified in the response by finding
the appropriate operation based on its `rel` value.
The only thing that should be hard coded in the client is the value of the
`rel` and the request that will be sent in the HTTP body of the request for
the given operation.

{:.table .table-striped}
| Operation                | Description                                                                      |
| :----------------------- | :------------------------------------------------------------------------------- |
| `update-payment-abort`   | [Aborts][abort] the payment before any financial transactions are performed.     |
| `redirect-authorization` | Used to redirect the consumer to Swedbank Pay Payments and the authorization UI. |
| `create-capture`         | Creates a [`capture`][capture] transaction.                                      |
| `create-cancellation`    | Creates a [`cancellation`][cancel] transaction.                                  |
| `create-reversal`        | Creates a [`reversal`][reverse] transaction.                                     |

## Vipps transactions

All Vipps after payment transactions are described below.

## Authorizations

The `authorizations` resource contains information about the authorization
transactions made on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-response.md payment_instrument="vipps"
transaction="authorization" %}

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-response.md payment_instrument="vipps" transaction="authorization" %}

## Captures

The `captures` resource lists the capture transactions (one or more) on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/vipps/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md payment_instrument="vipps" transaction="capture" %}

## Create capture transaction

A `capture` transaction can be created after a completed authorization by
finding the `rel` `create-capture`.

{:.code-header}
**Request**

```http
POST /psp/vipps/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 1500,
        "vatAmount": 250,
        "payeeReference": "cpttimestamp",
        "description" : "description for transaction"
    }
}
```

{% include transaction-response.md payment_instrument="vipps"
    transaction="capture" %}

## Cancellations

The `cancellations` resource lists the cancellation transactions on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md payment_instrument="vipps" transaction="cancel" %}

## Create cancellation transaction

A payment may be cancelled if the `rel` `create-cancellation` is available.
You can only cancel a payment, or part of it, if it has yet to be captured.
To revert a capture, or part of a capture, you must perform a `reversal`.
Performing a cancellation will cancel all remaning capture amounts on a payment.

{:.code-header}
**Request**

```http
POST /psp/vipps/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "payeeReference": "testabc",
        "description" : "description for transaction"
    }
}
```

{% include transaction-response.md payment_instrument="vipps"
    transaction="cancel" %}

## Reversals

The `reversals` resource lists the reversal transactions (one or more)
on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md payment_instrument="vipps" transaction="reversal" %}

### Create reversal transaction

A `reversal` transaction can be created if the `rel` `create-reversal` is
available.

{:.code-header}
**Request**

```http
POST /psp/vipps/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 1500,
        "vatAmount": 250,
        "payeeReference": "cpttimestamp",
        "description" : "description for transaction"
    }
}
```

{:.table .table-striped}
| Required | Field                    | Type         | Description                                                                                           |
| :------: | :----------------------- | :----------- | :---------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `transaction`            | `object`     | The trnsaction object.                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md currency="NOK" %}                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md currency="NOK" %}                                           |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`    | `string`     | A textual description of the capture                                                                  |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the reversal transaction. See [`payeeReference`][payee-reference] for details. |

{% include transaction-response.md payment_instrument="vipps"
    transaction="reversal" %}

{% include iterator.html
        prev_href="seamless-view"
        prev_title="Back: Seamless View"
        next_href="other-features"
        next_title="Next: Other Features" %}

[abort]: /payments/vipps/other-features#abort
[expand-parameter]: /#expansion
[callback]: /payments/vipps/other-features#callback
[cancel]: #cancellations
[capture]: #captures
[payee-reference]: /payments/vipps/other-features#payee-reference
[prices]: /payments/vipps/other-features#prices
[reverse]: #reversals
[transaction]: /payments/vipps/other-features#transactions
[user-agent]: https://en.wikipedia.org/wiki/User_agent
