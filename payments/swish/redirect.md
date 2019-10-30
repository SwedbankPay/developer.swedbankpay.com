---
title: Swedbank Pay Payments Swish Redirect
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

>Swish is an one-phase payment method supported by the major Swedish banks. In the redirect e-commerce scenario, PayEx performs a payment that the payer confirms using her Swish mobile app. The consumer initiates the payment by supplying the Swish registered mobile number (MSISDN), connected to the Swish app.

## Introduction

*   When the payer starts the purchase process, you make a `POST` request towards PayEx with the collected Purchase information. This will generate a payment object with a unique paymentID. You either receive a Redirect URL to a hosted page or a JavaScript source in response.
*   You need to [redirect][redirect] the payer to the Redirect payment page or embed the script source on you site to create a [Hosted View][hosted-view] in an iFrame;  where she is prompted to enter the Swish registered mobile number. This triggers the initiation of a sales transaction.
*   PayEx handles the dialogue with Swish and the consumer confirms the purchase in the Swish app.
*   PayEx will redirect the payer's browser to - or display directly in the iFrame - one of two specified URLs, depending on whether the payment session is followed through completely or cancelled beforehand. Please note that both a successful and rejected payment reach completion, in contrast to a cancelled payment.
*   If CallbackURL is set you will receive a payment callback when the Swish dialogue is completed. You need to do a `GET` request, containing the paymentID generated in the first step, to receive the state of the transaction.

## Screenshots

The consumer/end-user is redirected to PayEx hosted pages and prompted to insert her phone number to initiate the sales transaction.

![Consumer paying with Swish using PayEx][1551695199059-994.png]

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).  Swish is a one-phase payment method that is based on sales transactions not involving capture or cancellation operations.  The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference][technical-reference].

### Options before posting a payment

All valid options when posting in a payment with operation equal to Purchase, are described in [the technical reference][swish-payments].

#### General

*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL][callback-url] in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here][technical-reference-callback].

## Purchase flow

The sequence diagram below shows the requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request. 

```mermaid
sequenceDiagram
  Activate Browser
  Browser->Merchant: start purchase
  Activate Merchant
  Merchant->PayEx: POST <Swish create payments> (operation=PURCHASE)
  note left of Merchant: First API request
  Activate PayEx
  PayEx-->Merchant: payment resource
  Deactivate PayEx
  Merchant-->Browser: redirect to payments page
  Deactivate Merchant
  
  note left of PayEx: redirect to PayEx (If Redirect scenario)
  Browser->PayEx: enter mobile number
  Activate PayEx

  PayEx--xBrowser: Tell consumer to open Swish app
  Deactivate PayEx 
  Activate Swish_API
  Activate Swish_App
  Swish_API->Swish_App: Ask for payment confirmation
  Swish_App-->Swish_API: Consumer confirms payment
  Deactivate Swish_App
  
  opt Callback
  Activate PayEx
  Swish_API-->PayEx: Payment status
  PayEx-->Swish_API: Callback response
  Deactivate Swish_API
  PayEx--xMerchant: Transaction callback
  end
  PayEx-->Browser: Redirect to merchant (If Redirect scenario)
  Deactivate PayEx
  
  Browser-->Merchant: Redirect
  Activate PayEx
  Activate Merchant
  Merchant->PayEx: GET <Swish payment>
  PayEx-->Merchant: Payment response
  Merchant-->Browser: Payment Status  
  Deactivate Merchant 
  Deactivate Browser
```

## Options after posting a payment

*   **If CallbackURL is set: **Whenever changes to the payment occur a [Callback request][technical-reference-callback] will be posted to the callbackUrl, which was generated when the payment was created.
*   You can create a reversal transactions by implementing the Reversal request. You can also access and reverse a payment through your merchant pages in the [PayEx admin portal][payex-admin-portal].

### Reversal Sequence

A reversal transcation need to match the Payee reference of a completed sales transaction.

```mermaid
sequenceDiagram
  Merchant->PayEx: POST <Swish reversal>
  Activate Merchant
  Activate PayEx
  PayEx-->Merchant: transaction resource
  Deactivate PayEx
  Deactivate Merchant
```

[1551695199059-994.png]: /assets/img/1551695199059-994.png
{:width="467px" height="364px"}
[callback-url]: #
[hosted-view]: #
[payex-admin-portal]: #
[redirect]: #
[swish-payments]: #
[technical-reference-callback]: #
[technical-reference]: #
