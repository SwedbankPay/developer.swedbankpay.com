---
title: Swedbank Pay Payments Swish Redirect
sidebar:
  navigation:
  - title: Swish Payments
    items:
    - url: /payments/swish
      title: Introduction
    - url: /payments/swish/redirect
      title: Redirect
    - url: /payments/swish/seamless-view
      title: Seamless View
    - url: /payments/swish/after-payment
      title: After Payment
    - url: /payments/swish/other-features
      title: Other Features
---

{% include alert-development-section.md %}

{% include jumbotron.html body="**Swish Payments Redirect** is where Swedbank
Pay performs a payment that the payer confirms using her Swish mobile app.
The consumer initiates the payment by supplying the Swish registered mobile
number (msisdn), connected to the Swish app." %}

## Introduction

* When the payer starts the purchase process, you make a `POST` request towards
  Swedbank Pay with the collected Purchase information. This will generate a
  payment object with a unique `paymentID`. You either receive a Redirect URL to
  a hosted page or a JavaScript source in response.
* You need to [redirect][redirect] the payer to the payment page where she is
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

## Operations

The API requests are displayed in the [purchase flow](#purchase-flow).
Swish is a one-phase payment instrument that is based on sales transactions not
involving `capture` or `cancellation` operations.
The options you can choose from when creating a payment with key operation set
to value `Purchase` are listed below.

### Intent

{% include intent.md %}

{% include alert.html type="success" icon="link" body="
**Defining CallbackURL**: When implementing a scenario, it is optional to set
a [CallbackURL][callback-url] in the `POST` request. If `callbackURL` is set
Swedbank Pay will send a postback request to this URL when the consumer has
fulfilled the payment. You need to do a `GET` request, containing the
`paymentID` generated in the first step, to receive the state of the transaction." %}

### API Requests

All valid options when posting in a payment with operation equal to `Purchase`.
The `purchase` example shown below. 

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

[swish-redirect-image]: /assets/screenshots/swish/redirect-view/view/windows-small-window.png
[callback-url]: /payments/swish/other-fetures#callback
[hosted-view]: /payments/swish/seamless-view
[payex-admin-portal]: https://admin.payex.com/psp/login/
[redirect]: /payments/swish/redirect
[technical-reference-callback]: /payments/swish/other-fetures#callback
