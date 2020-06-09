---
title: Swedbank Pay Trustly Payments – Redirect
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

## Introduction

*   When properly set up in your merchant/webshop site and the payer starts the
    purchase process, you need to make a `POST` request towards Swedbank Pay with
    your Purchase information. This will generate a `payment` resource with a unique
    `id`. You will receive a **redirect URL** to a Swedbank Pay payment
    page (`redirect-sale` operation).
*   You need to redirect the payer's browser to that specified URL so that the
    payer can enter the payment details in a secure Swedbank Pay environment.
*   Swedbank Pay will redirect the payer's browser to one of two specified URLs,
    depending on whether the payment session is followed through completely or
    cancelled beforehand. Please note that both a successful and rejected payment
    reach completion, in contrast to a cancelled payment.
*   When you detect that the payer reach your `completeUrl`, you need to do a
    `GET` request to receive the state of the transaction, containing the
    `id` URI generated in the first step, to receive the state of the
    transaction.

## Step 1: Create a payment

{% include alert-callback-url.md api_resource="trustly" %}

To initiate the payment process, you need to make a `POST` request to Swedbank Pay.

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
|     Required     | Field                        | Type          | Description                                                                                                                                                                                                                                                                                        |
| :--------------: | :--------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `payment`                    | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`operation`          | `string`      | The operation that the `payment` is supposed to perform. For Trustly, this will always be `Purchase` as it is currently the only available operation.                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`intent`             | `string`      | `Sale` is the only intent option for Trustly. Performs the payment when the end-user gets redirected and completes the payment, and is followed by a [cancellation][cancel] or [reversal][reversal] of funds.                                                                                      |
| {% icon check %} | └➔&nbsp;`currency`                | `string`      | `SEK`, `EUR`. The currency of the provided `amount`.                                                                                                                                                                                                                                                                                            |
| {% icon check %} | └➔&nbsp;`prices`             | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`type`              | `string`      | Use the `Trustly` type here                                                                                                                                                                                                                                                                        |
| {% icon check %} | └─➔&nbsp;`amount`            | `integer`     | {% include field-description-amount.md %}                                                                                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`vatAmount`         | `integer`     | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                       |
| {% icon check %} | └➔&nbsp;`description`        | `string(40)`  | {% include field-description-description.md documentation_section="trustly" %}                                                                                                                                                                                                                     |
|                  | └➔&nbsp;`payerReference`     | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                   |
| {% icon check %} | └➔&nbsp;`userAgent`          | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-definition]                                                                                                                                                                                            |
| {% icon check %} | └➔&nbsp;`language`           | `string`      | {% include field-description-language.md api_resource="trustly" %}                                                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`urls`               | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
|                  | └─➔&nbsp;`hostUrl`           | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless View. If not supplied, view-operation will not be available.                                                                                                                                                                        |
| {% icon check %} | └─➔&nbsp;`completeUrl`       | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. |
|                  | └─➔&nbsp;`cancelUrl`         | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                            |
|                  | └─➔&nbsp;`callbackUrl`       | `string`      | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                            |
|                  | └─➔&nbsp;`logoUrl`           | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                |
|                  | └─➔&nbsp;`termsOfServiceUrl` | `string`      | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`payeeInfo`          | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeId`           | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeReference`    | `string(30*)` | A unique reference from the merchant system, which is used as a receipt/invoice number in Trustly Payments. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [`payeeReference`][payee-reference] for details.                                          |
|                  | └─➔&nbsp;`payeeName`         | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                            |
|                  | └─➔&nbsp;`productCategory`   | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|                  | └─➔&nbsp;`orderReference`    | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|                  | └─➔&nbsp;`subsite`           | `String(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                        |
|                  | └─➔&nbsp;`prefillInfo`       | `object`      | Object representing information of what the UI text fields should be populated with                                                                                                                                                                                                                |
|                  | └─➔&nbsp;`firstName`         | `string`      | Prefilled value to put in the first name text box.                                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`lastName`          | `string`      | Prefilled value to put in the last name text box.                                                                                                                                                                                                                                                  |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/trustly/payments/{{ page.payment_id }}",
        "number": 99590008046,
        "created": "2020-05-26T12:31:19.3106483Z",
        "updated": "2020-05-26T12:31:19.4513673Z",
        "instrument": "Trustly",
        "operation": "Purchase",
        "intent": "Sale",
        "state": "Ready",
        "currency": "SEK",
        "prices": {
            "id": "/psp/trustly/payments/{{ page.payment_id }}/prices"
        },
        "amount": 0,
        "description": "Test Purchase",
        "payerReference": "SomeReference",
        "initiatingSystemUserAgent": "PostmanRuntime/7.25.0",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/trustly/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/trustly/payments/{{ page.payment_id }}/payeeinfo"
        },
        "metadata": {
            "id": "/psp/trustly/payments/{{ page.payment_id }}/metadata"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/trustly/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/trustly/payments/{{ page.payment_id }}/sales",
            "rel": "create-sale"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/trustly/payments/sales/8f3ba6c8f4e3f6125ae6c18bec15c612747cf2c35dc5cac35d4bebc10cf7317e",
            "rel": "redirect-sale"
        }
    ]
}
```

## Trustly flow

This is an example of the Redirect scenario. For other integrations, take a
look at the respective sections. The sequence diagram below shows the two
requests you have to send to Swedbank Pay to make a purchase.

Swedbank Pay Trustly Payments uses the [`Deposit`][deposit] to perform
a payment. After this, the end-user will be presented with the returned `iframe`
URL in order to perform the payment with their prefered bank.
Once the user has completed the payment, Swedbank Pay will receive a
notification asynchronously from Trustly, hence why
the UI will initiate polling toward our back-end. The payment status after being
redirect to `completeUrl` will then indicate if the payment was successful or
not, or if the payment is still in progress. If the payment is still in
progress, when reaching `completeUrl`, the Swedbank Pay has then not received a
notification from Trustly that the payment has gone through yet.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay
    participant Merchant
    participant Consumer
    participant Trustly

    Consumer->>Merchant: Start purchase
    activate Merchant
    note left of Merchant: First API request
    Merchant->>-SwedbankPay: POST <Trustly Payment> (operation=Purchase)
    activate SwedbankPay
    SwedbankPay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Consumer: authorization page
    activate Consumer
    note left of Consumer: redirect to Swedbank Pay
    Consumer->>-SwedbankPay: enter consumer details
    activate SwedbankPay
    SwedbankPay-->-Trustly: perform payment in Trustly
    activate Trustly
    Trustly-->>-Consumer: redirect to merchant
    activate Consumer
    note left of Consumer: redirect back to Merchant
    Consumer->>-Merchant: access merchant page
    activate Merchant
    note left of Merchant: Second API request
    Merchant->>-SwedbankPay: GET <Trustly payment>
    activate SwedbankPay
    SwedbankPay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Consumer: display purchase result
```

## Options after posting a payment

Head over to [after payment][after-payment]
to see what you can do when a payment is completed.
Here you will also find info on `Cancel`, and `Reversal`.

{% include iterator.html prev_href="./" prev_title="Back: Introduction"
next_href="seamless-view" next_title="Next: Seamless View" %}

[deposit]: https://trustly.com/en/developer/api#/deposit
[after-payment]: /payments/trustly/after-payment
[callback]: /payments/trustly/other-features#callback
[cancel]: /payments/trustly/after-payment#cancellations
[reversal]: /payments/trustly/after-payment#reversals
[payee-reference]: /payments/trustly/other-features#payeeinfo
[recur]: /payments/trustly/other-features#recur
[user-agent-definition]: https://en.wikipedia.org/wiki/User_agent
[verify]: /payments/trustly/other-features#verify
