---
title: Other Features
redirect_from: /payments/vipps/other-features
estimated_read: 60
menu_order: 1100
---

{% include payment-resource.md show_status_operations=true %}

{% include payment-transaction-states.md %}

{% include payment-state.md %}

{% include payments-operations.md %}

### Create Payment

To create a Vipps payment, you perform an HTTP `POST` against the
`/psp/vipps/payments` resource.

An example of a payment creation request is provided below.
Each individual field of the JSON document is described in the following
section.
Use the [expand][technical-reference-expansion] request parameter to get a
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
| {% icon check %}︎ | └➔&nbsp;`userAgent`          | `string`     | The user agent reference of the payer's browser - [see user agent][user-agent]]                                                                                                                                                                        |
| {% icon check %}︎ | └➔&nbsp;`language`           | `string`     | {% include field-description-language.md %}                                                                                                                                                                                          |
| {% icon check %}︎ | └➔&nbsp;`urls`               | `object`     | The object containing URLs relevant for the `payment`.                                                                                                                                                                                                    |
| {% icon check %}︎ | └─➔&nbsp;`hostUrls`          | `array`      | The array of URIs valid for embedding of Swedbank Pay Hosted Views.                                                                                                                                                                                       |
| {% icon check %}︎ | └─➔&nbsp;`completeUrl`       | `string`     | The URI that Swedbank Pay will redirect back to when the payment page is completed. This does not indicate a successful payment, only that it has reached a completion state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`](#completeurl) for details. |
|                  | └─➔&nbsp;`cancelUrl`         | `string`     | The URI to redirect the payer to if the payment is canceled, either by the payer or by the merchant trough an `abort` request of the `payment`.                                                                                                           |
|                  | └─➔&nbsp;`paymentUrl`        | `string`     | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the `payment`. See [`paymentUrl`](#paymenturl) for details.                                                                                                      |
|                  | └─➔&nbsp;`callbackUrl`       | `string`     | The URI that Swedbank Pay will perform an HTTP `POST` request against every time a transaction is created on the payment. See [callback][callbackreference] for details.                                                                                  |
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
        "prices": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/prices"
        },
        "amount": 0,
        "description": "Vipps Test",
        "initiatingSystemUserAgent": "PostmanRuntime/7.2.0",
        "userAgent": "Mozilla/5.0 weeeeee",
        "language": "nb-NO",
        "urls": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/payeeinfo"
        },
        "payers": {
           "id": "/psp/vipps/payments/{{ page.payment_id }}/payers"
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

{:.code-view-header}
**Request**

```json
{
    "payment": {
        "operation": "Purchase"
    }
}
```

{% include complete-url.md %}

{% include payment-url.md full_reference=true %}

{% include prices.md %}

{% include description.md %}

{% include payee-info.md %}

{% include payee-reference.md %}

{% include transactions.md %}

{% include callback-reference.md %}

{% include payment-link.md %}

{% include metadata.md %}

{% include problems/problems.md %}

{% include seamless-view-events.md %}

{% include settlement-reconciliation.md %}

{% include iterator.html prev_href="after-payment"
        prev_title="After Payment" %}

[callbackreference]: #callback
[prices]: #prices
[technical-reference-expansion]: /introduction#expansion
[user-agent]: https://en.wikipedia.org/wiki/User_agent
