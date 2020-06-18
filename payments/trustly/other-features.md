---
title: Swedbank Pay Trustly Payments – Other Features
sidebar:
  navigation:
  - title: Trustly Payments
    items:
    - url: /payments/trustly
      title: Introduction
    - url: /payments/trustly/redirect
      title: Redirect
    - url: /payments/trustly/seamless-view
      title: Seamless View
    - url: /payments/trustly/after-payment
      title: After Payment
    - url: /payments/trustly/other-features
      title: Other Features
---

{% include payment-resource.md api_resource="trustly"
documentation_section="trustly" show_status_operations=true %}

{% include alert-callback-url.md api_resource="trustly" %}

{% include authorizations-resource.md api_resource="trustly" %}

{% include payment-transaction-states.md %}

## Create Payment

In Trustly Payments, you can create one type of payment and you can inspect and alter the details of the
individual transactions within the payment.

To create a Trustly payment, you perform an HTTP `POST` against the `payments`
resource. Trustly payments does currently only support the `Purchase` operation and `Sale` intent.

{:.code-header}
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
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
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
|     Required     | Field                             | Type          | Description                                                                                                                                                                                                                                                                                                           |
| :--------------: | :-------------------------------- | :------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `payment`                         | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`operation`               | `string`      | The operation that the `payment` is supposed to perform. For Trustly, this will always be `Purchase` as it is currently the only available operation. |
| {% icon check %} | └➔&nbsp;`intent`                  | `string`      | `Sale` is the only intent option for Trustly. Performs the payment when the end-user gets redirected and completes the payment.                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`currency`                | `string`      | `SEK`, `EUR`. The currency of the provided `amount`.                                                                                                                                                                                                                                                                                            |
| {% icon check %} | └➔&nbsp;`prices`                  | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`type`                   | `string`      | Use the `Trustly` type here                                                                                                                                                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`amount`                 | `integer`     | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`vatAmount`              | `integer`     | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                                          |
| {% icon check %} | └➔&nbsp;`description`             | `string(40)`  | {% include field-description-description.md documentation_section="trustly" %}                                                                                                                                                                                                                                           |
|                  | └➔&nbsp;`payerReference`          | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`userAgent`               | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-definition]                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`language`                | `string`      | {% include field-description-language.md api_resource="trustly" %}                                                                                                                                                                                                                                                                                          |
| {% icon check %} | └➔&nbsp;`urls`                    | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                |
|                  | └─➔&nbsp;`hostUrl`                | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless View. If not supplied, view-operation will not be available.                                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`completeUrl`            | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further.                    |
|                  | └─➔&nbsp;`cancelUrl`              | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                               |
|                  | └─➔&nbsp;`callbackUrl`            | `string`      | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                               |
|                  | └─➔&nbsp;`logoUrl`                | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                                   |
|                  | └─➔&nbsp;`termsOfServiceUrl`      | `string`      | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                                                  |
| {% icon check %} | └➔&nbsp;`payeeInfo`               | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`payeeId`                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`payeeReference`         | `string(30*)` | A unique reference from the merchant system, which is used as a receipt/invoice number in Trustly Payments. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [`payeeReference`][payee-reference] for details.                                                             |
|                  | └─➔&nbsp;`payeeName`              | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                                               |
|                  | └─➔&nbsp;`productCategory`        | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                        |
|                  | └─➔&nbsp;`orderReference`         | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                               |
|                  | └─➔&nbsp;`subsite`                | `String(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                                           |
|                  | └─➔&nbsp;`prefillInfo`            | `object`      | Object representing information of what the UI text fields should be populated with                                                                                                                                                                                                                                   |
|                  | └─➔&nbsp;`firstName`              | `string`      | Prefilled value to put in the first name text box.                                                                                                                                                                                                                                                                    |
|                  | └─➔&nbsp;`lastName`               | `string`      | Prefilled value to put in the last name text box.                                                                                                                                                                                                                                                                     |

{% include transactions-reference.md api_resource="trustly"
documentation_section="trustly" %}

{% include callback-reference.md api_resource="trustly" %}

{% include payment-link.md show_3d_secure=false %}

{% include complete-url.md %}

{% include description.md %}

{% include payee-info.md api_resource="trustly" %}

{% include prices.md api_resource="trustly" %}

{% include settlement-reconciliation.md %}

## Problems

When performing unsuccessful operations, the eCommerce API will respond with a
problem message. We generally use the problem message `type` and `status` code
to identify the nature of the problem. The problem `name` and `description` will
often help narrow down the specifics of the problem.

{% include common-problem-types.md %}

{% include seamless-view-events.md api_resource="trustly" %}

{% include iterator.html prev_href="after-payment" prev_title="Back: After
Payment" %}

[callback]: #callback
[cancel]: /payments/trustly/after-payment#cancellations
[financing-consumer]: #financing-consumer
[trustly-payment]: /assets/img/checkout/trustly-seamless-view.png
[recur]: #recur
[redirect]: /payments/trustly/redirect
[seamless-view]: /payments/trustly/seamless-view
[verification-flow]: #verification-flow
[verify]: #verify
