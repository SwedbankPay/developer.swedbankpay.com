---
title: Swedbank Pay Payments Swish Redirect
sidebar:
  navigation:
  - title: Swish Payments
    items:
    - url: /payments/swish
      title: Introduction
    - url: /payments/swish/direct
      title: Direct
    - url: /payments/swish/redirect
      title: Redirect
    - url: /payments/swish/seamless-view
      title: Seamless View
    - url: /payments/swish/after-payment
      title: After Payment
    - url: /payments/swish/other-features
      title: Other Features
---

{% include jumbotron.html body="Swish is a one-phase payment instrument supported by the
major Swedish banks. **Swish Payments Redirect** is where Swedbank
Pay performs a payment that the payer confirms in the Swish mobile app.
The consumer initiates the payment by supplying the Swish registered mobile
number (msisdn), connected to the Swish app." %}

## Introduction

*   When the payer starts the purchase process, you make a `POST` request
    towards Swedbank Pay with the collected Purchase information. This will
    generate a payment object with a unique `paymentID`. You either receive a
    Redirect URL to a hosted page or a JavaScript source in response.
*   You need to redirect the payer to the payment page to enter the Swish
    registered mobile number.
    This triggers the initiation of a sales transaction.
*   Swedbank Pay handles the dialogue with Swish and the consumer confirms the
    purchase in the Swish app.
*   Swedbank Pay will redirect the payer's browser to - or display directly in
    the iFrame - one of two specified URLs, depending on whether the payment
    session is followed through completely or cancelled beforehand.
    Please note that both a successful and rejected payment reach completion,
    in contrast to a cancelled payment.

The consumer/end-user is redirected to Swedbank Pay hosted pages and prompted
to insert her phone number to initiate the sales transaction.

Swish is a one-phase payment instrument that is based on sales transactions
**not** involving `capture` or `cancellation` operations.

![Consumer paying with Swish using Swedbank Pay]
[swish-redirect-image]{:width="467px" height="364px"}

{% include alert-callback-url.md api_resource="swish" %}

## Step 1: Create a Purchase

All valid options when posting in a payment with operation equal to `Purchase`.
The `Purchase` example shown below.

{:.code-header}
**Request**

```http
POST /psp/swish/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Sale",
        "currency": "SEK",
        "prices": [
            {
                "type": "Swish",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": [ "https://example.com" ],
            "paymentUrl": "https://example.com/perform-payment",
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "ref-123456",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        },
        "prefillInfo": {
            "msisdn": "+46739000001"
        }
    },
    "swish": {
        "enableEcomOnly": false,
        "paymentRestrictedToAgeLimit": 18,
        "paymentRestrictedToSocialSecurityNumber": "{{ page.consumer_ssn_se }}"
    }
}
```

{:.table .table-striped}
|     Required     | Field                        | Type          | Description                                                                                                                                                                                                                                                                                        |
| :--------------: | :--------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `payment`                    | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`operation`          | `string`      | The operation that the `payment` is supposed to perform. The [`Purchase`][purchase] operation is used in our example.                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`intent`             | `string`      | `Sale`.                                                                                                                                                                                                                                                                                            |
| {% icon check %} | └➔&nbsp;`currency`           | `string`      | `SEK`.                                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`prices`             | `object`      | The `prices` array lists the prices related to a specific payment.                                                                                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`type`              | `string`      | `Swish`.                                                                                                                                                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`amount`            | `integer`     | {% include field-description-amount.md %}                                                                                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`vatAmount`         | `integer`     | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                       |
| {% icon check %} | └➔&nbsp;`description`        | `string(40)`  | {% include field-description-description.md documentation_section="swish" %}                                                                                                                                                                                                                       |
|                  | └─➔&nbsp;`paymentAgeLimit`   | `integer`     | Positive number sets required age limit to fulfill the payment.                                                                                                                                                                                                                                    |
|                  | └➔&nbsp;`payerReference`     | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                   |
| {% icon check %} | └➔&nbsp;`userAgent`           | `string`      | The [`User-Agent` string][user-agent] of the consumer's web browser.                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`language`           | `string`      | {% include field-description-language.md api_resource="swish" %}                                                                                                                                                                                                                                   |
| {% icon check %} | └➔&nbsp;`urls`               | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`completeUrl`       | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. |
|                  | └─➔&nbsp;`cancelUrl`         | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                              |
|                  | └─➔&nbsp;`callbackUrl`       | `string`      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback-url] for details.                                                                                                                                          |
|                  | └─➔&nbsp;`logoUrl`           | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                |
|                  | └─➔&nbsp;`termsOfServiceUrl` | `string`      | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`payeeInfo`          | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeId`           | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeReference`    | `string(50*)` | {% include field-description-payee-reference.md documentation_section="swish" %}                                                                                                                                                                                                                   |
|                  | └─➔&nbsp;`payeeName`         | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                            |
|                  | └─➔&nbsp;`productCategory`   | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|                  | └─➔&nbsp;`orderReference`    | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|                  | └─➔&nbsp;`subsite`           | `string(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                        |
|                  | └➔&nbsp;`prefillInfo`        | `object`      | An object holding information which, when available, will be prefilled on the payment page.                                                                                                                                                                                                        |
|                  | └─➔&nbsp;`msisdn`            | `string`      | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                                                             |
|                  | └➔&nbsp;`swish`              | `object`      | An object that holds different scenarios for Swish payments.                                                                                                                                                                                                                                       |
|                  | └─➔&nbsp;`enableEcomOnly`    | `boolean`     | `true` if to only enable Swish on browser based transactions.; otherwise `false` to also enable Swish transactions via in-app payments.                                                                                                                                                            |
|          | └─➔&nbsp;`paymentRestrictedToAgeLimit`             | `integer`     | Positive number that sets the required age  needed to fulfill the payment. To use this feature it has to be configured in the contract.                                                                                                                                                            |
|                 | └─➔&nbsp;`paymentRestrictedToSocialSecurityNumber` | `string`      | When provided, the payment will be restricted to a specific social security number to make sure its the same logged in customer who is also the payer. Format: yyyyMMddxxxx. To use this feature it has to be configured in the contract.                                                                                                                             |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
      "id": "/psp/swish/payments/{{ page.payment_id }}",
      "number": 1234567890,
      "instrument": "Swish",
      "created": "2016-09-14T13:21:29.3182115Z",
      "updated": "2016-09-14T13:21:57.6627579Z",
      "state": "Ready",
      "operation": "Purchase",
      "intent": "Sale",
      "currency": "SEK",
      "amount": 0,
      "remainingCaptureAmount": 1500,
      "remainingCancellationAmount": 1500,
      "remainingReversalAmount": 0,
      "description": "Test Purchase",
      "payerReference": "AB1234",
      "initiatingSystemUserAgent": "Mozilla/5.0.",
      "userAgent": "Mozilla/5.0...",
      "language": "sv-SE",
      "prices": { "id": "/psp/swish/payments/{{ page.payment_id }}/prices" },
      "transactions": { "id": "/psp/swish/payments/{{ page.payment_id }}/transactions" },
      "captures": { "id": "/psp/swish/payments/{{ page.payment_id }}/captures" },
      "reversals": { "id": "/psp/swish/payments/{{ page.payment_id }}/reversals" },
      "cancellations": { "id": "/psp/swish/payments/{{ page.payment_id }}/cancellations" },
      "urls" : { "id": "/psp/swish/payments/{{ page.payment_id }}/urls" },
      "payeeInfo" : { "id": "/psp/swish/payments/{{ page.payment_id }}/payeeInfo" },
      "settings": { "id": "/psp/swish/payments/{{ page.payment_id }}/settings" }
    },
    "operations": [
      {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/swish/payments/{{ page.payment_id }}/sales",
            "rel": "create-sale"
      },
      {
            "method": "GET",
            "href": "{{ page.front_end_url }}/swish/payments/authorize/{{ page.payment_token }}",
            "rel": "redirect-sale",
      },
      {
            "method": "PATCH",
            "href": "{{ page.api_url }}/swish/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort"
      },
    ]
}
```

## Redirect Purchase flow

The sequence diagram below shows the requests you have to send to Swedbank Pay
to make a purchase. The Callback response is a simplified example
in this flow. Go to the [Callback][callback-url] section to view the complete flow.

```mermaid
sequenceDiagram
    activate Browser
    Browser->>-Merchant: Start purchase
    activate Merchant
    Merchant->>-SwedbankPay: POST <Swish create payment> (operation=PURCHASE)
    activate SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>-Merchant: Payment resource
    activate Merchant
    Merchant-->>-Browser: Response with redirectUrl
    activate Browser
    Browser->>-SwedbankPay: Redirect to Payment page
    note left of SwedbankPay: Redirect to Swedbank Pay
    activate Browser
    Browser->>-SwedbankPay: Enter mobile number
    activate Merchant
    Merchant->>-SwedbankPay: POST <Sale transaction>
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Transaction Resource
    activate SwedbankPay
    SwedbankPay--x-Browser: Tell consumer to open Swish app
    Swish_API->>Swish_App: Ask for payment confirmation
    activate Swish_App
    Swish_App-->>-Swish_API: Consumer confirms payment
    activate Swish_API

        alt Callback
        Swish_API-->>-SwedbankPay: Payment status
        activate SwedbankPay
        SwedbankPay-->>-Swish_API: Callback response
        activate Swish_API
        SwedbankPay-->-Merchant: Transaction callback
        end

    activate SwedbankPay
    SwedbankPay->>-Browser: Redirect to merchant
    activate Browser
    Browser-->>-Merchant: Redirect
    activate Merchant
    Merchant->>-SwedbankPay: GET <Swish payment>
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Payment response
    activate Merchant
    Merchant-->>-Browser: Payment Status
```

{% include iterator.html prev_href="direct" prev_title="Back: Direct"
next_href="seamless-view" next_title="Next: Seamless View" %}

[callback-url]: /payments/swish/other-features#callback
[payee-reference]: /payments/swish/other-features#payee-reference
[purchase]: /payments/swish/other-features#purchase-flow
[redirect]: /payments/swish/redirect
[seamless-view]: /payments/swish/seamless-view
[swish-redirect-image]: /assets/screenshots/swish/redirect-view/view/windows-small-window.png
[technical-reference-callback]: /payments/swish/other-features#callback
[user-agent]: https://en.wikipedia.org/wiki/User_agent
