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


## E-commerce Direct API

{% include alert.html type="neutral"
                      icon="info"
                      body="Swish is a one-phase payment instrument supported by the
                      major Swedish banks. In the direct e-commerce scenario,
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
* If `CallbackURL` is set, you will receive a payment callback when the Swish
  dialogue is completed.
* Make a `GET` request to check the payment status.

This flow is explained in the sequence diagram below.

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).
Swish is a one-phase payment instrument that is based on sales transactions not
involving `capture` or `cancellation` operations.
The options you can choose from when creating a payment with key operation
set to value `Purchase` are listed below.

### Options before posting a payment

All valid options when posting in a payment with operation equal to `Purchase`.

#### General

* **Defining CallbackURL**: When implementing a scenario, it is optional to set
  a [CallbackURL][callback-url] in the `POST` request. If `callbackURL` is set,
  Swedbank Pay will send a postback request to this URL when the consumer has
  fulfilled the payment.

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

{
  "payment": {
    "id": "/psp/swish/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "number": 1234567890,
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "instrument": "swish",
    "operation": "Purchase",
    "intent": "Sale",
    "state": "Ready",
    "currency": "NOK",
    "amount": 1500,
    "remainingReversalAmount": 1500,
    "description": "Test Purchase",
    "payerReference": "AB1234",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "nb-NO",
    "prices": { "id": "/psp/swish/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices" },
    "transactions": { "id": "/psp/swish/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions" },
    "reversals": { "id": "/psp/swish/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals" },
    "sales": { "id": "/psp/swish/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/sales" },
    "urls" : { "id": "/psp/swish/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/swish/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/swish/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" }
  },
  "operations": [
    {
      "href": "http://localhost:5001/psp/swish/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
      "rel": "update-payment-abort",
      "method": "PATCH"
    }
  ]
}


{
    "href": "https://api.payex.com/psp/swish/payments/<paymentId>/aborted",
    "rel": "aborted-payment",
    "method": "GET",
    "contentType": "application/json"
}
{
   "href": "https://api.payex.com/psp/swish/payments/<paymentId>/paid",
   "rel": "paid-payment",
   "method": "GET",
   "contentType": "application/json"
}
{
   "href": "https://api.payex.com/psp/swish/payments/<paymentId>/failed",
   "rel": "failed-payment",
   "method": "GET",
   "contentType": "application/json+problem"
}

**Redirect and Payment Status**  
After the payment is confirmed, the consumer will be redirected from the Swish
app to the completeUrl set in the first API request `POST` [Create
payment][create-payment] and you need to retrieve payment status with `GET`
[Sales transaction][sales-transaction] before presenting a confirmation page to
the consumer.

## M-commerce Direct API

{% include alert.html type="neutral"
                      icon="info"
                      body="Swish is an one-phase payment instrument supported by
                      the major Swedish banks. When implementing the direct
                      m-commerce scenario, Swedbank Pay performs a payment that
                      the consumer/end-user confirms directly through the Swish
                      mobile app." %}

## Introduction

* When the consumer/end-user starts the purchase process, you make a `POST`
  request towards Swedbank Pay with the collected Purchase information.
* You need to make a `POST`  request towards Swedbank Pay to create a sales
  transaction. The payment flow is identified as m-commerce, as the purchase is
  initiated from the device that hosts the Swish app.
* Swedbank Pay will handle the dialogue with Swish and the consumer will have to
  confirm the purchase in the Swish app.
* If `CallbackURL` is set you will receive a payment callback when the Swish
  dialogue is completed, and you will have to make a `GET` request to check the
  payment status.

The flow is explained in the sequence diagram below.

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow-2). Swish
is a one-phase payment instrument that is based on sales transactions not
involving capture or cancellation operations. The options you can choose from
when creating a payment with key operation set to value `Purchase` are listed below.

### Options before posting a payment

All valid options when posting in a payment with operation equal to `Purchase`.

#### General

* **Defining CallbackURL**: When implementing a scenario, it is optional to set
  a [CallbackURL][callback-url] in the `POST` request. If `callbackURL` is set,
  Swedbank Pay will send a postback request to this URL when the consumer has
  fulfilled the payment.

## Purchase flow

The sequence diagram below shows the three requests you have to send to Swedbank
Pay to make a purchase. The links will take you directly to the API description
for the specific request.

```mermaid
sequenceDiagram
  activate Mobile_App
  Mobile_App->>-Merchant: start purchase
  activate Merchant
  Merchant->>-SwedbankPay: POST <Create payment> (operation=PURCHASE)
  activate  SwedbankPay
  note left of Merchant: First API request
  SwedbankPay-->>-Merchant: payment resource
  activate Merchant

  Merchant-->>- SwedbankPay: POST <Create Sales Transaction> (operation=create-sale)
  activate  SwedbankPay
  note left of  SwedbankPay: POST not containing MSISDN
   SwedbankPay-->>-Merchant: sales resource
  activate Merchant
  Merchant-x-Mobile_App: Open Swish app request
  activate Mobile_App
  Mobile_App->>-Swish_App: Open Swish app
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

  Swish_App--x-Mobile_App: Redirect
  Merchant->>SwedbankPay: GET <Sales transaction>
  activate SwedbankPay
   SwedbankPay-->>-Merchant: Payment response
   activate Merchant
  Merchant-->>-Mobile_App: Payment Status
```

[swish-redirect-view]: /assets/screenshots/swish/redirect-view/view/windows-small-window.png
[swish-hosted-view]: /assets/screenshots/swish/hosted-view/windows.png
[callback-url]: /payments/swish/other-fetures#callback
[create-payment]: /payments/swish/
[payex-admin-portal]: https://admin.payex.com/psp/login/
[payex-mailto]: mailto:sales@payex.com
[redirect]: /payments/swish/redirect
[sales-transaction]: /payments/swish/other-features#sales
[SEB-swish]: https://seb.se/foretag/digitala-tjanster/swish-handel
[support-mailto]: mailto:support.ecom@payex.com
[swedbank-swish]: https://www.swedbank.se/foretag/betala-och-ta-betalt/ta-betalt/swish/swish-handel/index.htm
[swish-certificate-management-system]: https://comcert.getswish.net/cert-mgmt-web/authentication.html
[technical-reference-callback]: /payments/swish/other-features#callback
