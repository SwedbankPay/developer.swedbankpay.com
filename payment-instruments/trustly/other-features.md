---
title: Other Features
redirect_from: /payments/trustly/other-features
estimated_read: 50
menu_order: 1200
---

{% include payment-resource.md api_resource="trustly"
documentation_section="trustly" %}

{% include alert-callback-url.md api_resource="trustly" %}s

{% include payment-transaction-states.md %}

{% include payment-state.md api_resource="trustly" %}

{% include payments-operations.md api_resource="trustly" documentation_section="trustly" %}

## Create Payment

In Trustly Payments, you can create one type of payment and you can inspect and alter the details of the
individual transactions within the payment.

To create a Trustly payment, you perform an HTTP `POST` against the `payments`
resource. Trustly payments does currently only support the `Purchase` operation and `Sale` intent.

{:.code-view-header}
**Request**

```http
POST /psp/trustly/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Sale",
        "currency": "SEK",
        "prices": [
            {
                "type": "Trustly",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "payerReference": "SomeReference",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "hostUrls": [ "https://example.com" ],
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf",
            "paymentUrl": "https://example.com/perform-payment"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "PR123",
            "payeeName": "Merchant1",
            "productCategory": "PC1234",
            "subsite": "MySubsite"
        },
        "prefillInfo": {
            "firstName": "Ola",
            "lastName": "Nordmann"
        }
    }
}
```

{:.table .table-striped}
|     Required     | Field                        | Type          | Description                                                                                                                                                                                                                                                                                        |
| :--------------: | :--------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `payment`                    | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`operation`          | `string`      | The operation that the `payment` is supposed to perform. For Trustly, this will always be `Purchase` as it is currently the only available operation.                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`intent`             | `string`      | `Sale` is the only intent option for Trustly. Performs the payment when the payer gets redirected and completes the payment.                                                                                                                                                                    |
| {% icon check %} | └➔&nbsp;`currency`           | `string`      | `SEK`, `EUR`. The currency of the provided `amount`.                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`prices`             | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`type`              | `string`      | Use the `Trustly` type here                                                                                                                                                                                                                                                                        |
| {% icon check %} | └─➔&nbsp;`amount`            | `integer`     | {% include field-description-amount.md %}                                                                                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`vatAmount`         | `integer`     | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                       |
| {% icon check %} | └➔&nbsp;`description`        | `string(40)`  | {% include field-description-description.md documentation_section="trustly" %}                                                                                                                                                                                                                     |
|                  | └➔&nbsp;`payerReference`     | `string`      | {% include field-description-payer-reference.md documentation_section="trustly" %}                                                                                                                                                                                   |
| {% icon check %} | └➔&nbsp;`userAgent`          | `string`      | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`language`           | `string`      | {% include field-description-language.md api_resource="trustly" %}                                                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`urls`               | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`completeUrl`       | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`](#completeurl) for details. |
|                  |
| {% icon check %} | └─➔&nbsp;`cancelUrl`         | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios.                                                                                                                                                                                                      |
|                  |
|                  | └─➔&nbsp;`hostUrl`           | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless View. If not supplied, view-operation will not be available.                                                                                                                                                                        |
|                  | └─➔&nbsp;`callbackUrl`       | `string`      | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                            |
|                  | └─➔&nbsp;`logoUrl`           | `string`      | {% include field-description-logourl.md documentation_section="trustly" %}                                                                                                                                                                |
|                  | └─➔&nbsp;`termsOfServiceUrl` | `string`      | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                               |
|                  | └─➔&nbsp;`paymentUrl`        | `string`      | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment.                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`payeeInfo`          | `object`      | {% include field-description-payeeinfo.md documentation_section="trustly" %}                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeId`           | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeReference`    | `string(30*)` | {% include field-description-payee-reference.md documentation_section="trustly" %}                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`payeeName`         | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                            |
|                  | └─➔&nbsp;`productCategory`   | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|                  | └─➔&nbsp;`orderReference`    | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|                  | └─➔&nbsp;`subsite`           | `String(40)`  | {% include field-description-subsite.md %}                                                                                                                                        |
|                  | └─➔&nbsp;`prefillInfo`       | `object`      | Object representing information of what the UI text fields should be populated with                                                                                                                                                                                                                |
|                  | └─➔&nbsp;`firstName`         | `string`      | Prefilled value to put in the first name text box.                                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`lastName`          | `string`      | Prefilled value to put in the last name text box.                                                                                                                                                                                                                                                  |

{% include transactions.md api_resource="trustly" documentation_section="trustly" %}

{% include callback-reference.md api_resource="trustly" %}

{% include complete-url.md %}

{% include description.md api_resource = "trustly" %}

{% include payee-info.md api_resource="trustly" documentation_section="trustly" %}

{% include settlement-reconciliation.md documentation_section="trustly" %}

{% include metadata.md api_resource="trustly" %}

{% include problems/problems.md documentation_section="trustly" %}

{% include seamless-view-events.md api_resource="trustly" %}

{% include iterator.html prev_href="after-payment" prev_title="After
Payment" %}

[callback]: #callback
[financing-consumer]: #financing-consumer
[trustly-payment]: /assets/img/checkout/trustly-seamless-view.png
[recur]: #recur
[redirect]: /payment-instruments/trustly/redirect
[seamless-view]: /payment-instruments/trustly/seamless-view
[verification-flow]: #verification-flow
[verify]: #verify
