---
title: Swedbank Pay Payments Vipps Seamless View
sidebar:
  navigation:
  - title: Vipps Payments
    items:
    - url: /payments/vipps
      title: Introduction
    - url: /payments/vipps/redirect
      title: Redirect
    - url: /payments/vipps/seamless-view
      title: Seamless View
    - url: /payments/vipps/after-payment
      title: After Payment
    - url: /payments/vipps/other-features
      title: Other Features
---

{% include alert-development-section.md %}

{% include jumbotron.html body="The Seamless View scenario represents the opportunity to implement Vipps directly in your webshop." %}

## Introduction

Vipps is a two-phase payment instrument supported by the major norwegian banks.
In the Seamless View scenario, Swedbank Pay receives a mobile number (MSISDN)
from the payer through Swedbank Pay Payments. Swedbank Pay performs a payment
that the payer must confirm through the Vipps mobile app.

* When the payer starts the purchase process, you make a `POST` request towards
  Swedbank Pay with the collected `Purchase` information. This will generate a
  payment object with a unique `paymentID`. You either receive a Redirect URL
  to a hosted page or a JavaScript source in response.
* You need to [redirect][reference-redirect] the payer to the Redirect payment
  page or embed the script source on you site to create a
  [Hosted View][hosted-view] in an `iFrame`; where she is prompted to enter the
  registered mobile number. This triggers a `POST` towards Swedbank Pay.
* Swedbank Pay handles the dialogue with Vipps and the consumer confirms the
  purchase in the Vipps app.
* If CallbackURL is set you will receive a payment callback when the Vipps
  dialogue is completed. You need to do a `GET` request, containing the
  `paymentID` generated in the first step,
  to receive the state of the transaction.

![Vipps_flow_PaymentPages.png]

## Purchase flow

The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase.
The links will take you directly to the API description for the specific
request.

```mermaid
sequenceDiagram
    Browser->>Merchant: start purchase (pay with VIPPS)
    activate Merchant
    Merchant->>-SwedbankPay.FrontEnd: POST <Create  Vipps payment>
    activate SwedbankPay.FrontEnd
    note left of Merchant: First API request
    SwedbankPay.FrontEnd-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Browser: Redirect to payment page
    activate Browser
    note left of Browser:redirect to Swedbank Pay
    Browser-->>-SwedbankPay.FrontEnd: enter mobile number
    activate SwedbankPay.FrontEnd

    SwedbankPay.FrontEnd-->>-Vipps.API: Initialize Vipps payment
    activate Vipps.API
    Vipps.API-->>-SwedbankPay.FrontEnd: response
    activate SwedbankPay.FrontEnd
    SwedbankPay.FrontEnd-->>-Browser: Authorization response (State=Pending)
    activate Browser
    note left of Browser: check your phone

    Vipps.API-->>Vipps_App: Confirm Payment UI
    activate Vipps_App
    Vipps_App-->>Vipps_App: Confirmation Dialogue
    Vipps_App-->>-Vipps.API: Confirmation
    activate Vipps.API
    Vipps.API-->>-SwedbankPay.BackEnd: make payment
    activate SwedbankPay.BackEnd
    SwedbankPay.BackEnd-->>SwedbankPay.BackEnd: execute payment
    SwedbankPay.BackEnd-->>Vipps.API: response
    SwedbankPay.BackEnd-->>-SwedbankPay.FrontEnd: authorize result
    Merchant-->>Browser: Display authorize result
```

### Payment Url

{% include payment-url.md when="selecting Vipps as payment instrument" %}

## Screenshots

You redirect the payer to Swedbank Pay hosted payment page to collect the
consumers mobile number.

![Vipps mobile Payments]
[Vipps-screenshot-1]{:width="426px" :height="632px"}
![Vipps Payments][Vipps-screenshot-2]{:width="427px" :height="694px"}

### API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).
The options you can choose from when creating a payment with key `operation`
set to Value `Purchase` are listed below.

### Options before posting a payment

All valid options when posting a payment with operation equal to Purchase,
are described in [the technical reference][vipps-payments].

#### Type of authorization (Intent)

* **Authorization (two-phase)**: The intent of a Vipps purchase is always
  `Authorization`. The amount will be reserved but not charged.
  You will later (i.e. if a physical product, when you are ready to ship the
  purchased products) have to make a [Capture][captures] or
  [Cancel][cancellations] request.

#### General

* **Defining CallbackURL**: When implementing a scenario, it is optional to
  set a [`CallbackURL`][callbackurl] in the `POST` request.
  If `callbackURL` is set Swedbank Pay will send a postback request to this URL
  when the consumer has fulfilled the payment.



{% include iterator.html
        prev_href="redirect"
        prev_title="Back: Redirect"
        next_href="after-payment"
        next_title="Next: After payments" %}

[Vipps_flow_PaymentPages.png]: /assets/img/vipps-flow-paymentpages.png
[Vipps-screenshot-1]: /assets/img/checkout/vipps-hosted-payment.png
[Vipps-screenshot-2]: /assets/img/checkout/vipps-hosted-payment-no-paymenturl.png
[callback]: /payments/vipps/other-features#callback
[callbackurl]: /payments/vipps/other-features#callback
[cancellations]: /payments/vipps/other-features#cancel-sequence
[captures]: /payments/vipps/other-features#capture-sequence
[hosted-view]: /payments/vipps/seamless-view
[reference-redirect]: /payments/vipps/redirect
[vipps-payments]: /payments/vipps/other-features
