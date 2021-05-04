---
title: After Payment
redirect_from: /payments/vipps/after-payment
estimated_read: 30
menu_order: 1200
---

### Create Payment

To create a Vipps payment, you perform an HTTP `POST` against the
`/psp/vipps/payments` resource.

An example of a payment creation request is provided below.
Each individual field of the JSON document is described in the following
section.
Use the [expand][expand-parameter] request parameter to get a
response that includes one or more expanded sub-resources inlined.

{:.code-view-header}
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
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
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
        "payer": {
            "payerReference": "AB1234",
        },
        "prefillInfo": {
            "msisdn": "+4793000001"
        }
    }
}
```

{:.table .table-striped}
|     Required     | Field                        | Type         | Description                                                                                                                                                                                                                                               |
| :--------------: | :--------------------------- | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %}︎ | `payment`                    | `object`     | The `payment` object.                                                                                                                                                                                                                                     |
| {% icon check %}︎ | └➔&nbsp;`operation`          | `string`     | `Purchase`                                                                                                                                                                                                                                                |
| {% icon check %}︎ | └➔&nbsp;`intent`             | `string`     | `Authorization`                                                                                                                                                                                                                                           |
| {% icon check %}︎ | └➔&nbsp;`currency`           | `string`     | NOK                                                                                                                                                                                                                                                       |
| {% icon check %}︎ | └➔&nbsp;`prices`             | `object`     | The [`prices`][prices] object.                                                                                                                                                                                                                            |
| {% icon check %}︎ | └─➔&nbsp;`type`              | `string`     | `vipps`                                                                                                                                                                                                                                                   |
| {% icon check %}︎ | └─➔&nbsp;`amount`            | `integer`    | {% include field-description-amount.md currency="NOK" %}                                                                                                                                                                                                  |
| {% icon check %}︎ | └─➔&nbsp;`vatAmount`         | `integer`    | {% include field-description-vatamount.md currency="NOK" %}                                                                                                                                                                                               |
| {% icon check %}︎ | └➔&nbsp;`description`        | `string(40)` | {% include field-description-description.md %}                                                                                                                                                                              |
| {% icon check %}︎ | └➔&nbsp;`userAgent`          | `string`     | The user agent reference of the payer's browser - [see user agent][user-agent]                                                                                                                                                                         |
| {% icon check %}︎ | └➔&nbsp;`language`           | `string`     | {% include field-description-language.md %}                                                                                                                                                                                          |
| {% icon check %}︎ | └➔&nbsp;`urls`               | `object`     | The object containing URLs relevant for the `payment`.                                                                                                                                                                                                    |
| {% icon check %}︎ | └─➔&nbsp;`hostUrls`          | `array`      | The array of URIs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                       |
| {% icon check %}︎ | └─➔&nbsp;`completeUrl`       | `string`     | The URI that Swedbank Pay will redirect back to when the payment page is completed. This does not indicate a successful payment, only that it has reached a completion state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`][complete-url] for details. |
|                  | └─➔&nbsp;`cancelUrl`         | `string`     | The URI to redirect the payer to if the payment is canceled, either by the payer or by the merchant trough an `abort` request of the `payment`.                                                                                                           |
|                  | └─➔&nbsp;`paymentUrl`        | `string`     | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the `payment`. See [`paymentUrl`][paymenturl] for details.                                                                                                      |
|                  | └─➔&nbsp;`callbackUrl`       | `string`     | The URI that Swedbank Pay will perform an HTTP `POST` request against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                           |
|                  | └─➔&nbsp;`logoUrl`           | `string`     | {% include field-description-logourl.md %}                                                                                                                       |
|                  | └─➔&nbsp;`termsOfServiceUrl` | `string`     | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                      |
| {% icon check %}︎ | └➔&nbsp;`payeeInfo`          | `object`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                        |
| {% icon check %}︎ | └─➔&nbsp;`payeeId`           | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                     |
| {% icon check %}︎ | └─➔&nbsp;`payeeReference`    | `string(30)` | {% include field-description-payee-reference.md %}                                                                                                                                                                          |
|                  | └─➔&nbsp;`payeeName`         | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                   |
|                  | └─➔&nbsp;`productCategory`   | `strin`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                            |
|                  | └─➔&nbsp;`orderReference`    | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|                  | └─➔&nbsp;`subsite`           | `string(40)` | The `subsite` field can be used to perform split settlement on the payment. The `subsites` must be resolved with Swedbank Pay reconciliation before being used.                                                                                           |
|                  | └➔&nbsp;`payer`              | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | └─➔&nbsp;`payerReference`    | `string`     | {% include field-description-payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | └➔&nbsp;`prefillInfo`             | `object`      | An object that holds prefill information that can be inserted on the payment page.                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`msisdn`                 | `string`      | Number will be prefilled on payment page, if valid. Only Norwegian phone numbers are supported. The country code prefix is +47                                                                                                                                                                     |

{:.code-view-header}
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
        "amount": 0,
        "description": "Vipps Test",
        "initiatingSystemUserAgent": "PostmanRuntime/7.2.0",
        "userAgent": "Mozilla/5.0 weeeeee",
        "language": "nb-NO",
        "prices": { "id": "/psp/vipps/payments/{{ page.payment_id }}/prices" },
        "urls": { "id": "/psp/vipps/payments/{{ page.payment_id }}/urls" },
        "payeeInfo": { "id": "/psp/vipps/payments/{{ page.payment_id }}/payeeinfo" },
        "payers": { "id": "/psp/vipps/payments/{{ page.payment_id }}/payers" },
        "metadata": { "id": "/psp/vipps/payments/{{ page.payment_id }}/metadata" }
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

{:.code-view-header}
**Request**

```json
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
| `redirect-authorization` | Used to redirect the payer to Swedbank Pay Payments and the authorization UI.    |
| `create-capture`         | Creates a [`capture`][capture] transaction.                                      |
| `create-cancellation`    | Creates a [`cancellation`][cancel] transaction.                                  |
| `create-reversal`        | Creates a [`reversal`][reverse] transaction.                                     |

## Vipps transactions

All Vipps after payment transactions are described below.

## Authorizations

The `authorizations` resource contains information about the authorization
transactions made on a specific payment.

{:.code-view-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-response.md transaction="authorization" %}

{:.code-view-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-response.md transaction="authorization" %}

## Cancellations

The `cancellations` resource lists the cancellation transactions on a
specific payment.

{:.code-view-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md transaction="cancel" %}

## Create cancellation transaction

A payment may be cancelled if the `rel` `create-cancellation` is available. You
can only cancel a payment, or part of it, if it has yet to be captured. To
revert a capture, or part of a capture, you must perform a `reversal`.
Performing a cancellation will cancel all the remaining authorized amount on a
payment.

{:.code-view-header}
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

{% include transaction-response.md transaction="cancel" %}

## Reversals

The `reversals` resource lists the reversal transactions (one or more)
on a specific payment.

{:.code-view-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md transaction="reversal" %}

### Create reversal transaction

A `reversal` transaction can be created if the `rel` `create-reversal` is
available.

{:.code-view-header}
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
|     Required     | Field                    | Type         | Description                                                                      |
| :--------------: | :----------------------- | :----------- | :------------------------------------------------------------------------------- |
| {% icon check %} | `transaction`            | `object`     | The transaction object.                                                           |
| {% icon check %} | └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md currency="NOK" %}                         |
| {% icon check %} | └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md currency="NOK" %}                      |
| {% icon check %} | └➔&nbsp;`description`    | `string`     | A textual description of the capture                                             |
| {% icon check %} | └➔&nbsp;`payeeReference` | `string(50)` | {% include field-description-payee-reference.md %} |

{% include transaction-response.md transaction="reversal" %}

{% include abort-reference.md %}

{% include iterator.html
        prev_href="capture"
        prev_title="Capture"
        next_href="features"
        next_title="Features" %}

[abort]: /payment-instruments/vipps/after-payment#abort
[callback]: /payment-instruments/vipps/features/technical-reference/callback
[cancel]: #cancellations
[capture]: #captures
[complete-url]: /payment-instruments/vipps/features/technical-reference/complete-url
[expand-parameter]: /introduction#expansion
[paymenturl]: /payment-instruments/vipps/features/technical-reference/payment-url
[prices]: /payment-instruments/vipps/features/technical-reference/prices
[reverse]: #reversals
[user-agent]: https://en.wikipedia.org/wiki/User_agent
