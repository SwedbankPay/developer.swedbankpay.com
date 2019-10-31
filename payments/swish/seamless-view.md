---
title: Swedbank Pay Payments Swish Seamless View
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

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

>Swish is a one-phase payment method supported by the major Swedish banks. In the direct e-commerce scenario, PayEx receives the Swish registered mobile number directly from the merchant UI. PayEx performs a payment that the payer confirms using her Swish mobile app.

## Introduction

*   When the payer starts the purchase process, you make a `POST` request towards PayEx with the collected Purchase information.
*   After that you need to collect the consumer's Swish registered mobile number and make a POST request towards PayEx, to create a sales transaction.
*   PayEx will handle the dialogue with Swish and the consumer will have to confirm the purchase in the Swish app.
*   If CallbackURL is set you will receive a payment callback when the Swish dialogue is completed, and you will have to make a `GET` request to check the payment status.
*   The flow is explained in the sequence diagram below.

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).  Swish is a one-phase payment method that is based on sales transactions not involving capture or cancellation operations.  The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference][technical-reference].

### Options before posting a payment

All valid options when posting in a payment with operation equal to Purchase, are described in [the technical reference][swish-payments].

#### General

*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL][callback-url] in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here][technical-reference-callback].

## Purchase flow

The sequence diagram below shows the three requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request. 

```mermaid
sequenceDiagram
  Activate Browser
  Browser->Merchant: start purchase
  Activate Merchant
  Merchant->PayEx: POST <Create Swish payment> (operation=PURCHASE)
  note left of Merchant: First API request
  Activate PayEx
  PayEx-->Merchant: payment resource

  Merchant-->PayEx: POST <Create Sales Transaction> (operation=create-sale)
  PayEx-->Merchant: sales resource
  Deactivate PayEx
  
  note left of Merchant: POST containing MSISDN
  Merchant--xBrowser: Tell consumer to open Swish app
  
  Activate Swish_API
  Activate Swish_App
  Swish_API->Swish_App: Ask for payment confirmation
  Swish_App-->Swish_API: Consumer confirms payment
  Deactivate Swish_App

  Activate PayEx
  Swish_API-->PayEx: Payment status
  PayEx-->Swish_API: Callback response
  Activate Swish_App
  Swish_API->Swish_App: Start redirect
  Deactivate Swish_API
  
  Swish_App--xBrowser: Redirect
  Deactivate Swish_App
  Merchant->PayEx: GET <Sales transaction>
  PayEx-->Merchant: Payment response
  Merchant-->Browser: Payment Status
  Deactivate Merchant 
  Deactivate Browser
  Deactivate PayEx
```

**Redirect and Payment Status**  
After the payment is confirmed, the consumer will be redirected from the Swish app to the completeUrl set in the first API request `POST` [Create payment][create-payment] and you need to retrieve payment status with `GET` [Sales transaction][sales-transaction] before presenting a confirmation page to the consumer.

## Options after posting a payment

*   **If CallbackURL is set: **Whenever changes to the payment occur a [Callback request][technical-reference-callback] will be posted to the callbackUrl, which was generated when the payment was created.
*   You can create a reversal transactions by implementing the Reversal request. You can also access and reverse a payment through your merchant pages in the [PayEx admin portal][payex-admin-portal].

### Reversal Sequence

A reversal transcation need to match the Payee reference of a completed sales transaction.

```mermaid
sequenceDiagram
  Merchant->PayEx: POST [Swish reversals][reversal-reference]
  Activate Merchant
  Activate PayEx
  PayEx-->Merchant: transaction resource
  Deactivate PayEx
  Deactivate Merchant
```

[create-payment]: #
[payex-admin-portal]: #
[sales-transaction]: #
[swish-payments]: #
[technical-reference-callback]: #
[technical-reference]: #
