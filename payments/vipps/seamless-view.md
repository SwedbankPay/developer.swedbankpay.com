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

>Vipps is a two-phase payment method supported by the major norwegian banks. 
 In the redirect to Swedbank Pay payment pages scenario, 
 Swedbank Pay receives a mobile number (MSISDN) from the payer through Payex 
 payment pages.
 Swedbank Pay performs a payment that the payer must confirm through the 
 Vipps mobile app.

## Introduction

* When the payer starts the purchase process, you make a `POST` request towards 
  Swedbank Pay with the collected `Purchase` information. This will generate a 
  payment object with a unique `paymentID`. You either receive a Redirect URL 
  to a hosted page or a JavaScript source in response.
* You need to [redirect][reference-redirect] the payer to the Redirect payment 
  page or embed the script source on you site to create a 
  [Hosted View][hosted-view] in an `iFrame`; where she is prompted to enter the 
  registered mobile number. This triggers a `POST` towards PayEx.
* Swedbank Pay handles the dialogue with Vipps and the consumer confirms the 
  purchase in the Vipps app.
* If CallbackURL is set you will receive a payment callback when the Vipps 
  dialogue is completed. You need to do a `GET` request, containing the 
  `paymentID` generated in the first step, 
  to receive the state of the transaction.

![Vipps_flow_PaymentPages.png]

### Payment Url

For our hosted view, the URL property called `paymentUrl` will be used when the 
consumer is redirected out of the hosted view frame through our 
[Vipps API][vipps-payments]. 
The consumer is redirected out of frame when selecting Vipps as payment method. 
The URL should represent the page of where the payment hosted view was hosted 
originally, 
such as the checkout page, shopping cart page, or similar. Basically, 
`paymentUrl` should be set to the same URL as that of the page where the 
JavaScript for the hosted payment view was added to in order to initiate the 
payment. 
Please note that the `paymentUrl` must be able to invoke the same JavaScript 
URL from the same Payment as the one that initiated the payment originally, 
so it should include some sort of state identifier in the URL. 
The state identifier is the ID of the order, shopping cart or similar that has 
the URL of the Payment stored.

With `paymentUrl` in place, the retry process becomes much more convenient for 
both the integration and the payer.

## Screenshots 

You redirect the payer to Swedbank Pay hosted payment pages to collect the 
consumers mobile number.


![Vipps mobile payment pages]
[Vipps-screenshot-1]{:width="426px" :height="632px"}
![Vipps payment pages][Vipps-screenshot-2]{:width="427px" :height="694px"}

### API Requests 

The API requests are displayed in the [purchase flow](#purchase-flow). 
The options you can choose from when creating a payment with key `operation` 
set to Value `Purchase` are listed below. 

### Options before posting a payment 

All valid options when posting a payment with operation equal to Purchase, 
are described in [the technical reference][vipps-payments].

#### Type of authorization (Intent).

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

## Purchase flow

The sequence diagram below shows the two requests you have to send to 
Swedbank Pay to make a purchase. 
The links will take you directly to the API description for the specific 
request. 

```mermaid
sequenceDiagram
  Browser->>Merchant: start purchase (pay with VIPPS)
  activate Merchant

  Merchant->>PayEx.FrontEnd: POST <Create  Vipps payment>
  note left of Merchant: First API request
  activate PayEx.FrontEnd
  PayEx.FrontEnd-->>Merchant: payment resource
  deactivate PayEx.FrontEnd
  Merchant-->>Browser: Redirect to payment page
  note left of Browser:redirect to PayEx
  Browser-->>PayEx.FrontEnd: enter mobile number
  activate PayEx.FrontEnd

  PayEx.FrontEnd-->>Vipps.API: Initialize Vipps payment
  activate Vipps.API
  Vipps.API-->>PayEx.FrontEnd: response
  PayEx.FrontEnd-->>Browser: Authorization response (State=Pending)
  note left of Browser: check your phone
  deactivate Merchant
  
  Vipps.API-->>Vipps_App: Confirm Payment UI
  Vipps_App-->>Vipps_App: Confirmation Dialogue
  Vipps_App-->>Vipps.API: Confirmation
  Vipps.API-->>PayEx.BackEnd: make payment
  activate PayEx.BackEnd
  PayEx.BackEnd-->>PayEx.BackEnd: execute payment
  PayEx.BackEnd-->>Vipps.API: response
  deactivate PayEx.BackEnd
  deactivate Vipps.API
  PayEx.BackEnd-->>PayEx.FrontEnd: authorize result
  Merchant-->>Browser: Display authorize result
```

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
