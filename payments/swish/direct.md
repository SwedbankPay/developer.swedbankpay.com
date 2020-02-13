---
title: Swedbank Pay Payments Swish
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


{% include alert.html type="neutral"
                      icon="info"
                      body="Swish is a one-phase payment instrument supported by the
                      major Swedish banks. In the direct scenario,
                      Swedbank Pay receives the Swish registered mobile number
                      directly from the merchant UI. Swedbank Pay performs a
                      payment that the payer confirms using her Swish mobile
                      app." %}

## Introduction

* When the payer starts the purchase process, you make a `POST` request towards
  Swedbank Pay with the collected Purchase information.
* The next step is to collect the consumer's Swish registered mobile number
  and make a `POST` request towards Swedbank Pay to create a sales transaction.
* Swedbank Pay will handle the dialogue with Swish and the consumer will have to
  confirm the purchase in the Swish app.
* If `callbackURL` is set, you will receive a payment callback when the Swish
  dialogue is completed.
* Make a `GET` request to check the payment status.

## Purchase flow

The sequence diagram below shows the three requests you have to send to
Swedbank Pay to make a purchase.

```mermaid
sequenceDiagram
  activate Browser
  Browser->>-Merchant: start purchase
  activate Merchant
  Merchant->>-SwedbankPay: POST <Swish payment> (operation=PURCHASE)
  activate  SwedbankPay
  note left of Merchant: First API request
   SwedbankPay-->>-Merchant: payment resource
   activate Merchant

  Merchant-->>- SwedbankPay: POST <Sales Transaction> (operation=create-sale)
  activate  SwedbankPay
   SwedbankPay-->>-Merchant: sales resource
  activate Merchant
  note left of Merchant: POST containing MSISDN
  Merchant--x-Browser: Tell consumer to open Swish app
  Swish_API->>Swish_App: Ask for payment confirmation
  activate Swish_App
  Swish_App-->>-Swish_API: Consumer confirms payment
  activate Swish_API

  Swish_API-->>- SwedbankPay: Payment status
  activate  SwedbankPay
   SwedbankPay-->>-Swish_API: Callback response
  activate Swish_API
  Swish_API->>-Swish_App: Start redirect
  activate Swish_App

  Swish_App--x-Browser: Redirect
  activate Merchant
  Merchant->>- SwedbankPay: GET <Sales transaction>
  activate  SwedbankPay
   SwedbankPay-->>-Merchant: Payment response
  activate Merchant
  Merchant-->>-Browser: Payment Status
```

## Operations

The API requests are displayed in the [purchase flow][purchase] above.
Swish is a one-phase payment instrument that is based on sales transactions not
involving `capture` or `cancellation` operations.
The options you can choose from when creating a payment with key operation
set to value `Purchase` are listed below.

### General

{% include alert.html type="success" icon="link" body=" **Defining CallbackURL**:
When implementing a scenario, it is strongly recommended to set a
[`callbackURL`][callback-url] in the `POST` request. If `callbackURL` is set,
Swedbank Pay will send a postback request to this URL when the consumer has
fulfilled the payment." %}

## Purchase

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
        "enableEcomOnly": false{% comment %},
        "paymentRestrictedToAgeLimit": 18,
        "paymentRestrictedToSocialSecurityNumber": "{{ page.consumer_ssn_se }}"
        {% endcomment %}
    }

}
```

{:.table .table-striped}
| Required | Property                                           | Type          | Description                                                                                                                                                                                                                                                                                        |
| :------: | :------------------------------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `payment`                                          | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`                                | `string`      | The operation that the `payment` is supposed to perform. The [`purchase`][purchase] operation is used in our example.                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`                                   | `string`      | `Authorization`.                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`                                 | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                         |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`                                   | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`                                    | `string`      | Swish                                                                                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`                                  | `integer`     | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 SEK 5000 = 50.00 SEK.                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`                               | `integer`     | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                 |  |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`                              | `string(40)`  | A textual description max 40 characters of the purchase.                                                                                                                                                                                                                                           |
|          | └➔&nbsp;`payerReference`                           | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                   |
|          | └➔&nbsp;`payeeName`                                | `string`      | The payee name will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                                                      |
|  ✔︎︎︎︎︎  | └➔&nbsp;`userAgent`                                | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent]                                                                                                                                                                                                       |
|  ✔︎︎︎︎︎  | └➔&nbsp;`language`                                 | `string`      | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                                                                       |
|  ✔︎︎︎︎︎  | └➔&nbsp;`urls`                                     | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`                             | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. |
|          | └─➔&nbsp;`cancelUrl`                               | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                              |
|          | └─➔&nbsp;`callbackUrl`                             | `string`      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback-url] for details.                                                                                                                                          |
|          | └─➔&nbsp;`logoUrl`                                 | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                |
|          | └─➔&nbsp;`termsOfServiceUrl`                       | `string`      | A URL that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeenInfo`                               | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeId`                                 | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeReference`                          | `string(50*)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [`payeeReference`][payee-reference] for details.                                                                                                         |
|          | └─➔&nbsp;`payeeName`                               | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                            |
|          | └─➔&nbsp;`productCategory`                         | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|          | └─➔&nbsp;`orderReference`                          | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|          | └─➔&nbsp;`subsite`                                 | `String(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                        |
|          | └─➔&nbsp;`msisdn`                                  | `String`      | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                                                             |
|          | └➔&nbsp;`swish`                                    | `object`      | An object that holds different scenarios for Swish payments.                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`ecomOnlyEnabled`                         | `boolean`     | `true` if to only enable Swish on web based transactions.; otherwise `false` to also enable Swish transactions via in-app payments                                                                                                                                                                 |
{% comment %}
|          | └─➔&nbsp;`paymentRestrictedToAgeLimit`             | `integer`     | Positive number that sets the required age  needed to fulfill the payment. To use this feature it has to be configured in the contract.                                                                                                                                                            |
|          | └─➔&nbsp;`paymentRestrictedToSocialSecurityNumber` | `string`      | When provided, the payment will be restricted to a specific social security number. Format: yyyyMMddxxxx. To use this feature it has to be configured in the contract.                                                                                                                             |
{% endcomment %}

{:.code-header}
**Response**

```http
POST /psp/swish/payments HTTP/1.1
Authorization: Bearer <AccessToken>
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
        "description": "Test Purchase",
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

## Create Sale transaction

This operation creates a sales transaction in the direct payment scenario.
This is managed either by sending a `POST` request as seen
below, or by directing the end-user to the hosted payment pages. Note that the
`msisdn` value (the consumer/end-user's mobile number) is required in this
request.

{:.code-header}
**Request**

```http
POST /psp/swish/payments/{{ page.payment_id }}/sales HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "msisdn": "+46739000001"
    }
}

```

{% include transaction-response.md showRequest=false payment_instrument="swish" transaction="sale" %}

{% include iterator.html prev_href="introduction" prev_title="Back: Introduction"
next_href="redirect" next_title="Next: Redirect" %}

[swish-redirect-view]: /assets/screenshots/swish/redirect-view/view/windows-small-window.png
[callback-url]: /payments/swish/other-features#callback
[redirect]: /payments/swish/redirect
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[payee-reference]: /payments/swish/other-features#payee-reference
[purchase]: /payments/swish/direct#purchase-flow
[sales-transaction]: /payments/swish/other-features#sales
