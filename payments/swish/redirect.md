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

* When the payer starts the purchase process, you make a `POST` request towards
  Swedbank Pay with the collected Purchase information. This will generate a
  payment object with a unique `paymentID`. You either receive a Redirect URL to
  a hosted page or a JavaScript source in response.
* You need to redirect the payer to the payment page where she is
  prompted to enter the Swish registered mobile number.
  This triggers the initiation of a sales transaction.
* Swedbank Pay handles the dialogue with Swish and the consumer confirms the
  purchase in the Swish app.
* Swedbank Pay will redirect the payer's browser to - or display directly in the
  iFrame - one of two specified URLs, depending on whether the payment session
  is followed through completely or cancelled beforehand. Please note that both
  a successful and rejected payment reach completion, in contrast to a cancelled
  payment.

The consumer/end-user is redirected to Swedbank Pay hosted pages and prompted
to insert her phone number to initiate the sales transaction.

![Consumer paying with Swish using Swedbank Pay]
[swish-redirect-image]{:width="467px" height="364px"}

## Purchase flow

The sequence diagram below shows the requests you have to send to Swedbank Pay
to make a purchase.
The links will take you directly to the API description for the specific
request.

```mermaid
sequenceDiagram
  activate Browser
  Browser->>-Merchant: start purchase
  activate Merchant
  Merchant->>-SwedbankPay: POST <Swish create payment> (operation=PURCHASE)
  activate SwedbankPay
  note left of Merchant: First API request
  SwedbankPay-->>-Merchant: payment resource
  activate Merchant
  Merchant-->>-Browser: redirect to payments page
  activate Browser
  note left of SwedbankPay: redirect to Swedbank Pay (If Redirect scenario)
  Browser->>-SwedbankPay: enter mobile number
  activate SwedbankPay
  SwedbankPay--x-Browser: Tell consumer to open Swish app
  Swish_API->>Swish_App: Ask for payment confirmation
  activate Swish_App
  Swish_App-->>-Swish_API: Consumer confirms payment
  activate Swish_API
  opt Callback
  Swish_API-->>-SwedbankPay: Payment status
  activate SwedbankPay
  SwedbankPay-->>-Swish_API: Callback response
  activate Swish_API
  SwedbankPay--x-Merchant: Transaction callback
  end
  SwedbankPay-->>Browser: Redirect to merchant (If Redirect scenario)
  activate Browser
  
  Browser-->>-Merchant: Redirect
  activate Merchant
  Merchant->>-SwedbankPay: GET <Swish payment>
  activate SwedbankPay
  SwedbankPay-->>-Merchant: Payment response
  activate Merchant
  Merchant-->>-Browser: Payment Status  
```

## Operations

The API requests are displayed in the [purchase flow][purchase-flow].
Swish is a one-phase payment instrument that is based on sales transactions
**not** involving `capture` or `cancellation` operations.
The options you can choose from when creating a payment with key `operation` set
to value `Purchase` are listed below.

### General

{% include alert.html type="success" icon="link" body="
**Defining CallbackURL**: When implementing a scenario, it is strongly
recommended to set a [CallbackURL][callback-url] in the `POST` request.
If `callbackURL` is set Swedbank Pay will send a postback request to this
URL when the consumer has fulfilled the payment. You need to do a `GET` request,
containing the `paymentID` generated in the first step, to receive the state
of the transaction." %}

### API Requests

All valid options when posting in a payment with operation equal to `Purchase`.
The `purchase` example shown below.

{:.code-header}
**Request**

```http
POST /psp/swish/payments
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
            "hostUrls": "https://example.com",
            "paymentUrl": "http://example.com/perform-payment",
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
| Required | Property                                           | Type          | Description                                                                                                                                                                                                                                                                                        |
| :------: | :------------------------------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `payment`                                          | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`                                | `string`      | The operation that the `payment` is supposed to perform. The [`purchase`][purchase] operation is used in our example.                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`                                   | `string`      | `Sale`.                                                                                                                                                                                                                                                                                            |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`                                 | `string`      | `SEK`.                                                                                                                                                                                                                                                                                             |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`                                   | `object`      | The `prices` array lists the prices related to a specific payment.                                                                                                                                                                                                                                 |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`                                    | `string`      | `Swish`.                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`                                  | `integer`     | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 SEK 5000 = 50.00 SEK.                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`                               | `integer`     | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                 |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`                              | `string(40)`  | A textual description max 40 characters of the purchase.                                                                                                                                                                                                                                           |
|          | └─➔&nbsp;`paymentAgeLimit`                         | `integer`     | Positive number sets required age limit to fulfill the payment.                                                                                                                                                                                                                                    |
|          | └➔&nbsp;`payerReference`                           | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └➔&nbsp;`userAgent`                                | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-definition]                                                                                                                                                                                            |
|  ✔︎︎︎︎︎  | └➔&nbsp;`language`                                 | `string`      | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                                                                       |
|  ✔︎︎︎︎︎  | └➔&nbsp;`urls`                                     | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`                             | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. |
|          | └─➔&nbsp;`cancelUrl`                               | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                              |
|          | └─➔&nbsp;`callbackUrl`                             | `string`      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback-url] for details.                                                                                                                                          |
|          | └─➔&nbsp;`logoUrl`                                 | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                |
|          | └─➔&nbsp;`termsOfServiceUrl`                       | `string`      | A URL that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeInfo`                                | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeId`                                 | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeReference`                          | `string(50*)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.                                                                                                           |
|          | └─➔&nbsp;`payeeName`                               | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                            |
|          | └─➔&nbsp;`productCategory`                         | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|          | └─➔&nbsp;`orderReference`                          | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|          | └─➔&nbsp;`subsite`                                 | `string(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                        |
|          | └─➔&nbsp;`msisdn`                                  | `string`      | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                                                             |
|          | └➔&nbsp;`swish`                                    | `object`      | An object that holds different scenarios for Swish payments.                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`ecomOnlyEnabled`                         | `boolean`     | `true` if to only enable Swish on browser based transactions.; otherwise `false` to also enable Swish transactions via in-app payments.                                                                                                                                                            |
|          | └─➔&nbsp;`paymentRestrictedToAgeLimit`             | `integer`     | Positive number that sets the required age  needed to fulfill the payment. To use this feature it has to be configured in the contract.                                                                                                                                                            |
|          | └─➔&nbsp;`paymentRestrictedToSocialSecurityNumber` | `string`      | When provided, the payment will be restricted to a specific social security number. Format: yyyyMMddxxxx. To use this feature it has to be configured in the contract.                                                                                                                             |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/swish/payments/{{ page.payment_id }}",
        "number": 992308,
        "created": "2017-10-23T08:38:57.2248733Z",
        "instrument": "Swish",
        "operation": "Purchase",
        "intent": "Sale",
        "state": "Ready",
        "currency": "SEK",
        "amount": 0,
        "description": "Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "Mozilla/5.0",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/swish/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/swish/payments/{{ page.payment_id }}/payeeinfo"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/swish/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/swish/payments/{{ page.payment_id }}/sales",
            "rel": "create-sale"
        }
    ]
}
```

{% include iterator.html prev_href="./" prev_title="Back: Introduction"
next_href="seamless-view" next_title="Next: Seamless View" %}

[swish-redirect-image]: /assets/screenshots/swish/redirect-view/view/windows-small-window.png
[callback-url]: /payments/swish/other-fetures#callback
[seamless-view]: /payments/swish/seamless-view
[payee-reference]: /payments/swish/other-features#payeereference
[purchase-flow]: #purchase-flow
[redirect]: /payments/swish/redirect
[technical-reference-callback]: /payments/swish/other-fetures#callback
