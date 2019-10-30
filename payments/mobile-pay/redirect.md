---
title: Swedbank Pay Payments Mobile Pay Redirect
sidebar:
  navigation:
  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/payment
      title: Checkout Payment
    - url: /checkout/after-payment
      title: Checkout After Payment
    - url: /checkout/other-features
      title: Checkout Other Features
  - title: Payments
    items:
    - url: /payments/
      title: Introduction
    - url: /payments/credit-card
      title: Credit Card Payments
    - url: /payments/credit-card/redirect
      title: Credit Card Redirect
    - url: /payments/credit-card/seamless-view
      title: Credit Card Seamless View
    - url: /payments/credit-card/after-payment
      title: Credit Card After Payments
    - url: /payments/credit-card/other-features
      title: Credit Card Other Features
    - url: /payments/invoice
      title: Invoice Payments
    - url: /payments/invoice/redirect
      title: Invoice Redirect
    - url: /payments/invoice/seamless-view
      title: Invoice Seamless View
    - url: /payments/invoice/after-payment
      title: Invoice After Payment
    - url: /payments/invoice/other-features
      title: Invoice Other Features
    - url: /payments/mobile-pay
      title: Mobile Pay Payments
    - url: /payments/mobile-pay/redirect
      title: Mobile Pay Redirect
    - url: /payments/mobile-pay/seamless-view
      title: Mobile Pay Seamless View
    - url: /payments/mobile-pay/after-payment
      title: Mobile Pay After Payment
    - url: /payments/mobile-pay/other-features
      title: Mobile Pay Other Features
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/swish/redirect
      title: Swish Redirect
    - url: /payments/swish/seamless-view
      title: Swish Seamless View
    - url: /payments/swish/after-payment
      title: Swish After Payment
    - url: /payments/swish/other-features
      title: Swish Other Features
    - url: /payments/vipps
      title: Vipps Payments
    - url: /payments/vipps/redirect
      title: Vipps Redirect
    - url: /payments/vipps/seamless-view
      title: Vipps Seamless View
    - url: /payments/vipps/after-payment
      title: Vipps After After Payment
    - url: /payments/vipps/other-features    
      title: Vipps Other Features
    - url: /payments/direct-debit
      title: Direct Debit Payments
    - url: /payments/direct-debit/redirect
      title: Direct Debit Redirect
    - url: /payments/direct-debit/seamless-view
      title: Direct Debit Seamless View
    - url: /payments/direct-debit/after-payment
      title: Direct Debit After Payments
    - url: /payments/direct-debit/other-features
      title: Direct Debit Other Features
    - url: /payments/credit-account
      title: Credit Account
    - url: /payments/credit-account/after-payment
      title: Credit Account After Payment
    - url: /payments/credit-account/other-features
      title: Credit Account Other Features
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/test-data
      title: Test Data
    - url: /resources/demoshop
      title: Demoshop
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}


>The basic redirect **purchase** scenario is the supported way to implement MobilePay payments.

## Introduction

* When you have prepared your merchant/webshop site, you make a `POST` request towards PayEx with your  Purchase information. You will receive a Redirect URL, leading to a secure PayEx hosted environment, in response, .
* You need to redirect the browser of the end-user/consumer to that URL so that she may enter her MobilePay details .
* When the payment is completed, PayEx will redirect the browser back to your merchant/webshop site.
* Finally you need to make a `GET` request towards PayEx with the paymentID received in the first step, which will return the purchase result.

## Screenshots

![mobilepay enter number][mobilepay-screenshot-1]

![mobilepay approve payment][mobilepay-screenshot-2]

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow). The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference][technical-reference].

### Options before posting a payment

All valid options when posting in a payment with operation equal to Purchase, are described in [the technical reference][technical-reference-mobilepay].

#### Type of authorization (Intent).

* **Authorization (two-phase)**: The intent of a MobilePay purchase is always Authorization. The amount will be reserved but not charged. You will later (i.e. if a physical product, when you are ready to ship the purchased products) have to make a [Capture][mobilepay-capture] or [Cancel][mobilepay-cancel] request.

#### General

* **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL][technical-reference-callbackurl] in the POST request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.][technical-reference-callback]

## Purchase flow

The sequence diagram below shows the two requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request. The diagram also shows in high level, the sequence of the process of a complete purchase.

```mermaid
sequenceDiagram
  Consumer->Merchant: start purchase
  Activate Merchant
  Merchant->PayEx: POST [mobilepay payments][technical-reference-purchase] (operation=PURCHASE)
  note left of Merchant: First API request
  Activate PayEx
  PayEx-->Merchant: payment resource
  Deactivate PayEx
  Merchant-->Consumer: redirect to authorize page
  Deactivate Merchant
  note left of Consumer: redirect to PayEx

  Consumer->PayEx: enter mobilepay info
  Activate PayEx
  PayEx->Consumer_App: Confirm payment
  Consumer_App-->PayEx: Payment confirmed
  Deactivate PayEx
  
  PayEx-->Consumer: redirect to merchant
  note left of PayEx: redirect back to merchant
  
  Consumer->Merchant: access merchant page
  Activate Merchant
  Merchant->PayEx: GET [mobilepay payments][technical-reference-mobilepay]
  note left of Merchant: Second API request
  Activate PayEx
  PayEx-->Merchant: payment resource
  Deactivate PayEx
  Merchant-->Consumer: display purchase result
  Deactivate Merchant
```

[mobilepay-screenshot-1]: /assets/img/mobilepay-screenshot-1.png
[mobilepay-screenshot-2]: /assets/img/mobilepay-screenshot-2.png
[mobilepay-cancel]: #
[mobilepay-capture]: #
[technical-reference-callback]: #
[technical-reference-callbackurl]: #
[technical-reference-mobilepay]: #
[technical-reference]: #
