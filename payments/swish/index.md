---
title: Swedbank Pay Payments Swish
sidebar:
  navigation:
  - title: Payments
    items:
    - url: /payments/
      title: Introduction
    - url: /payments/credit-account
      title: Credit Account Payments
    - url: /payments/credit-card
      title: Credit Card Payments
    - url: /payments/invoice
      title: Invoice Payments
    - url: /payments/direct-debit
      title: Direct Debit Payments
    - url: /payments/mobile-pay
      title: Mobile Pay Payments
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/vipps
      title: Vipps Payments
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

# Swish Payments

>Add Swish to your PayEx payment methodsand take advantage of **[PayEx Settlement Service](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/reconciliation-and-settlement/) **to get consolidated payments and reporting, for all your payment methods.

## How do you get started with Swish through PayEx?

We recommend that you apply for Swish as part of  [PayEx Settlement Service](https://developer.payex.comhttps://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/reconciliation-and-settlement/) and utilize the PayEx Technical Supplier Certificate. A [PayEx sales representative](mailto:sales@payex.com) can assist you getting started with that. Otherwise, you can contact one of the following banks offering Swish Handel: [Danske Bank](https://danskebank.se/sv-se/foretag/medelstora-foretag/onlinetjanster/pages/swish-handel.aspx), [Swedbank](https://www.swedbank.se/foretag/betala-och-ta-betalt/ta-betalt/swish/swish-handel/index.htm), [SEB](https://seb.se/foretag/digitala-tjanster/swish-handel), [Länsförsäkringar](https://www.lansforsakringar.se/stockholm/foretag/bank/lopande-ekonomi/betalningstjanster/swish-handel/), [Sparbanken Syd](https://www.sparbankensyd.se/vardagstjanster/betala/swish-foretag/), [Sparbanken Öresund](https://www.sparbankenskane.se/foretag/digitala-tjanster/swish/swish-for-handel/index.htm), [Nordea](https://www.nordea.se/foretag/produkter/betala/swish-handel.html), [Handelsbanken](https://www.handelsbanken.se/sv/foretag/konton-betalningar/ta-betalt/swish-for-foretag), in order to get an acquiring agreement, a merchant number/payee and access to [Swish Certificate Management system](https://comcert.getswish.net/cert-mgmt-web/authentication.html).

## Implementation models and commerce flows:

PayEx supports both e-commerce and m-commerce flows (as a Merchant you should implement both) - through PayEx Payment Pages or PayEx Direct API integration.
![swish]

### Swish m-commerce, Redirect to payment pages
_Available in ![se]_

Swish payments from a mobile device made either through an app or via a mobile browser on the mobile device that hosts the Swish app. The flow redirects the payment dialogue to PayEx Payment Pages, that will handle the required user dialogue.


### Swish e-commerce, Redirect to payment pages

_Available in ![se]_

Swish payments initiated by the consumer in a browser in equipment other than the mobile device that hosts the Swish app. The flow redirects the payment dialogue to PayEx Payment Pages, that will handle the required user dialogue / mobile number input.


### Swish m-commerce, Direct API integration

_Available in ![se]_
Swish payments from a mobile device made either through an app or via a mobile browser on the same mobile device.

### Swish e-commerce, Direct API integration
_Available in ![se]_

Swish payments initiated by the consumer in a browser in equipment other than the mobile device that hosts the Swish app.

### Payment Link
_Available in ![se]_

Generate a Payment Link that can be sent to the consumer via e-mail or SMS, so the consumer may pay at a later moment. Payment links can be implemented for all payment methods supporting Redirect to hosted payment pages

### Technical Reference

_Available in ![se]_

Technical reference for Swish API resources and their properties.

[If you are missing a scenario, please let us know what you need! ](mailto:support.ecom@payex.com)

## Merchant Swish Simulator (MSS)

[MSS](https://developer.getswish.se/faq/which-test-tools-are-available/) is a test server application that simulates the commerce interaction with Swish API. It can answer the calls to Swish API and returns correct formatted return messages and also the error messages.

Click on the following [link](https://www.getswish.se/dokument/Guide_Testverktyg_20151210.pdf) to know more about the error codes that are used in Merchant Swish Simulator.

# Swish e-commerce Direct API

>Swish is a one-phase payment method supported by the major Swedish banks. In the direct e-commerce scenario, PayEx receives the Swish registered mobile number directly from the merchant UI. PayEx performs a payment that the payer confirms using her Swish mobile app.

## Introduction

*   When the payer starts the purchase process, you make a `POST` request towards PayEx with the collected Purchase information.
*   After that you need to collect the consumer's Swish registered mobile number and make a POST request towards PayEx, to create a sales transaction.
*   PayEx will handle the dialogue with Swish and the consumer will have to confirm the purchase in the Swish app.
*   If CallbackURL is set you will receive a payment callback when the Swish dialogue is completed, and you will have to make a `GET` request to check the payment status.
*   The flow is explained in the sequence diagram below.

## API Requests

The API requests are displayed in the [purchase flow](#HPurchaseflow).  Swish is a one-phase payment method that is based on sales transactions not involving capture or cancellation operations.  The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment

All valid options when posting in a payment with operation equal to Purchase, are described in [the technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/swish-payments/).

#### General

*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Purchase flow

The sequence diagram below shows the three requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request. 

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/swish-payments/swish-e-commerce-direct/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

**Redirect and Payment Status**  
After the payment is confirmed, the consumer will be redirected from the Swish app to the completeUrl set in the first API request `POST` [Create payment](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/swish-payments/#HCreatePayment) and you need to retrieve payment status with `GET` [Sales transaction](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/swish-payments/#HSales) before presenting a confirmation page to the consumer.

## Options after posting a payment

*   **If CallbackURL is set: **Whenever changes to the payment occur a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the callbackUrl, which was generated when the payment was created.
*   You can create a reversal transactions by implementing the Reversal request. You can also access and reverse a payment through your merchant pages in the [PayEx admin portal](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/resources/admin/).

### Reversal Sequence

A reversal transcation need to match the Payee reference of a completed sales transaction.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/swish-payments/swish-e-commerce-direct/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

# Swish e-commerce Redirect

>Swish is an one-phase payment method supported by the major Swedish banks. In the redirect e-commerce scenario, PayEx performs a payment that the payer confirms using her Swish mobile app. The consumer initiates the payment by supplying the Swish registered mobile number (MSISDN), connected to the Swish app.

## Introduction

*   When the payer starts the purchase process, you make a `POST` request towards PayEx with the collected Purchase information. This will generate a payment object with a unique paymentID. You either receive a Redirect URL to a hosted page or a JavaScript source in response.
*   You need to [redirect](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HRedirectimplementation) the payer to the Redirect payment page or embed the script source on you site to create a [Hosted View](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HostedViewimplementation) in an iFrame;  where she is prompted to enter the Swish registered mobile number. This triggers the initiation of a sales transaction.
*   PayEx handles the dialogue with Swish and the consumer confirms the purchase in the Swish app.
*   PayEx will redirect the payer's browser to - or display directly in the iFrame - one of two specified URLs, depending on whether the payment session is followed through completely or cancelled beforehand. Please note that both a successful and rejected payment reach completion, in contrast to a cancelled payment.
*   If CallbackURL is set you will receive a payment callback when the Swish dialogue is completed. You need to do a `GET` request, containing the paymentID generated in the first step, to receive the state of the transaction.

## Screenshots

The consumer/end-user is redirected to PayEx hosted pages and prompted to insert her phone number to initiate the sales transaction.

![1551695199059-994.png](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/swish-payments/swish-e-commerce-redirect/WebHome/1551695199059-994.png?width=467&height=364)

## API Requests

The API requests are displayed in the [purchase flow](#HPurchaseflow).  Swish is a one-phase payment method that is based on sales transactions not involving capture or cancellation operations.  The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment

All valid options when posting in a payment with operation equal to Purchase, are described in [the technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/swish-payments/).

#### General

*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Purchase flow

The sequence diagram below shows the requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request. 

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/swish-payments/swish-e-commerce-redirect/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

## Options after posting a payment

*   **If CallbackURL is set: **Whenever changes to the payment occur a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the callbackUrl, which was generated when the payment was created.
*   You can create a reversal transactions by implementing the Reversal request. You can also access and reverse a payment through your merchant pages in the [PayEx admin portal](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/resources/admin/).

### Reversal Sequence

A reversal transcation need to match the Payee reference of a completed sales transaction.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/swish-payments/swish-e-commerce-redirect/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

# Swish m-commerce Direct API

>Swish is an one-phase payment method supported by the major Swedish banks.  When implementing the direct m-commerce scenario, PayEx performs a payment that the consumer/end-user confirms directly through the Swish mobile app.

## Introduction

*   When the consumer/end-user starts the purchase process, you make a `POST` request towards PayEx with the collected Purchase information.
*   You need to make a  POST  request towards PayEx to create a sales transaction. The payment flow is identified as m-commerce, as the purchase is initiated from the device that hosts the Swish app.
*   PayEx will handle the dialogue with Swish and the consumer will have to confirm the purchase in the Swish app.
*   If CallbackURL is set you will receive a payment callback when the Swish dialogue is completed, and you will have to make a `GET` request to check the payment status.
*   The flow is explained in the sequence diagram below.

## API Requests

The API requests are displayed in the [purchase flow](#HPurchaseflow).  Swish is a one-phase payment method that is based on sales transactions not involving capture or cancellation operations.  The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment

All valid options when posting in a payment with operation equal to Purchase, are described in [the technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/swish-payments/).

#### General

*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Purchase flow

The sequence diagram below shows the three requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request. 

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/swish-payments/swish-m-commerce-direct/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

**Redirect and Payment Status**  
After the payment is confirmed, the consumer will be redirected from the Swish app to the completeUrl set in the first API request `POST` [Create payment](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/swish-payments/#HCreatePayment) and you need to retrieve payment status with `GET` [Sales transaction](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/swish-payments/#HSales) before presenting a confirmation page to the consumer.

## Options after posting a payment

*   **If CallbackURL is set: **Whenever changes to the payment occur a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the callbackUrl, which was generated when the payment was created.
*   You can create a reversal transactions by implementing the Reversal request. You can also access and reverse a payment through your merchant pages in the [PayEx admin portal](https://developer.payex.com/xwiki/wiki/developer/create/Main/ecommerce-copy/2.%20Merchant%20Resources/admin/WebHome?parent=Main.ecommerce.payex-payment-instruments.swish-payments.swish-m-commerce-direct.WebHome).

### Reversal Sequence

A reversal transcation need to match the Payee reference of a completed sales transaction.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/swish-payments/swish-m-commerce-direct/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

# Swish m-commerce Redirect

>Swish is an one-phase payment method supported by the major Swedish banks. In the redirect m-commerce scenario, PayEx performs a payment that the payer confirms directly through the Swish mobile app.

## Introduction

*   When the payer starts the purchase process, through a mobile device that hosts the her Swish app, you make a `POST` request towards PayEx with the collected Purchase information. This will generate a payment object with a unique paymentID. You either receive a Redirect URL to a hosted page or a JavaScript source in response.
*   You need to [redirect](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HRedirectimplementation) the payer to the Redirect payment page or embed the script source on you site to create a [Hosted View](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HostedViewimplementation) in an iFrame. The payment flow is identified as m-commerce, as the purchase is initiated from the device that hosts the Swish app.
*   PayEx handles the dialogue with Swish and the consumer confirms the purchase in the Swish app directly.
*   PayEx will redirect the payer's browser to - or display directly in the iFrame - one of two specified URLs, depending on whether the payment session is followed through completely or cancelled beforehand. Please note that both a successful and rejected payment reach completion, in contrast to a cancelled payment.
*   If CallbackURL is set you will receive a payment callback when the Swish dialogue is completed. You need to do a `GET` request, containing the paymentID generated in the first step, to receive the state of the transaction.

## Screenshots

The payer is redirected to PayEx hosted pages and prompted to initiate the sales transaction.

![1551695460586-802.png](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/swish-payments/swish-m-commerce-redirect/WebHome/1551695460586-802.png?width=400&height=711)

## API Requests

The API requests are displayed in the [purchase flow](#HPurchaseflow).  Swish is a one-phase payment method that is based on sales transactions not involving capture or cancellation operations.  The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment

All valid options when posting in a payment with operation equal to Purchase, are described in [the technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/swish-payments/).

#### General

*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Purchase flow

The sequence diagram below shows the requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/swish-payments/swish-m-commerce-redirect/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

## Options after posting a payment

*   **If CallbackURL is set: **Whenever changes to the payment occur a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the callbackUrl, which was generated when the payment was created.
*   You can create a reversal transactions by implementing the Reversal request. You can also access and reverse a payment through your merchant pages in the [PayEx admin portal](https://developer.payex.comhttps://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/resources/admin/).

### Reversal Sequence

A reversal transcation have to match the Payee reference of a completed sales transaction.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/swish-payments/swish-m-commerce-redirect/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

[se]: https://developer.payex.com/xwiki/skins/PayEx.XWiki.Skin/flags/4x3/se.svg
{:height="15px" width="15px"}
[swish]: https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/swish-payments/WebHome/swish.svg
{:height="50px" width="50px"}