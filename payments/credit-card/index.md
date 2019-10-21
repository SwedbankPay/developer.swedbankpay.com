---
title: Swedbank Pay Payments Credit Card
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

```
The basic redirect purchase scenario is the most common way to implement card payments.
```

## Introduction

* When properly set up in your merchant/webshop site and the payer starts the purchase process, you need to make a POST request towards PayEx with your Purchase information. This will generate a payment object with a unique paymentID. You either receive a Redirect URL to a hosted page or a JavaScript source in response.
* You need to [redirect](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HRedirectimplementation) the payer's browser to that specified URL, or embed the script source on your site to create a Hosted View in an iFrame; so that she can enter the credit card details in a secure PayEx hosted environment.
* PayEx will handle 3D-secure authentication when this is required.
* PayEx will redirect the payer's browser to - or display directly in the iFrame - one of two specified URLs, depending on whether the payment session is followed through completely or cancelled beforehand. Please note that both a successful and rejected payment reach completion, in contrast to a cancelled payment.
* When you detect that the payer reach your completeUrl , you need to do a `GET` request to receive the state of the transaction, containing the paymentID generated in the first step, to receive the state of the transaction.

## Screenshots

You will redirect the payer to PayEx hosted pages to collect the credit card information.

![Screnshot](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome/1551693452568-441.png?width=490&height=485 "Screenshot")

## API Requests

The API requests are displayed in the [purchase flow](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/#HPurchaseflow). The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment

All valid options when posting in a payment with se, are described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

#### Type of authorization - Intent
* *PreAuthorization*: A purchase with PreAuthorization intent is handled in a similar manner as the ordinary authorization procedure. The notable difference is that the funds are put on hold for 30 days (for an ordinary authorization the funds are reserved for 7 days). Also, with a PreAuthorization, the captured amount can be higher than the preauthorized amount. The amount captured should not be higher than 20% of the original amount, due to card brand rules. You complete the purchase by [finalizing the transaction](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HFinalize).
* *Authorization (two-phase)*: If you want the credit card to reserve the amount, you will have to specify that the intent of the purchase is Authorization. The amount will be reserved but not charged. You will later (i.e. when you are ready to ship the purchased products) have to make a [Capture](payments/credit-card) or [Cancel](payments/credit-card) request.

#### General
* *No 3D Secure and card acceptance:* There are optional paramers that can be used in relation to 3d-secure and card acceptance. By default, most credit card agreements with an acquirer will require that you use 3D-Secure for card holder authentication. However, if your agreement allows you to make a card payment without this authentication, or that specific cards can be declined, you may adjust these optional parameters when posting in the payment. This is specified in the technical reference section for creating credit card payments  - you will find the link in the sequence diagram below.
* *Defining CallbackURL:* When implementing a scenario, it is optional to set a [CallbackURL](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs) in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback).

### Co-brand Visa/Dankort

Not yet supported

### Purchase flow
The sequence diagram below shows a high level description of a complete purchase, and the requests you have to send to PayEx. The links will take you directly to the corresponding API description.

When dealing with credit card payments, 3D-Secure authentication of the cardholder is an essential topic. There are three alternative outcome of a credit card payment:

* 3D-Secure enabled - by default, 3D-secure should be enabled, and PayEx will check if the card is enrolled with 3D-secure. This depends on the issuer of the card. If the card is not enrolled with 3D-Secure, no authentication of the cardholder is done.
* Card supports 3D-Secure - if the card is enrolled with 3D-Secure, PayEx will redirect the cardholder to the autentication mechanism that is decided by the issuing bank. Normally this will be done using BankID or Mobile BankID.
* No 3D-Secure - if this is specified in the request (see options above), no authentication is requested.

<embed src="/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

<embed src="/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

### Options after posting a payment

* *Abort:* It is possible to abort the process, if the payment has no successful transactions. [See the PATCH payment description](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HAbort).  
* If the payment shown above is done as a two phase (`Authorization`), you will need to implement the `Capture` and `Cancel` requests.  
* For `reversals`, you will need to implement the Reversal request.  
* If you did a `PreAuthorization`, you will have to send a [Finalize request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HFinalize) to finalize the transaction.  
* *If CallbackURL is set:* Whenever changes to the payment occur a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the callbackUrl, which was generated when the payment was created.  

#### Capture Sequence

Capture can only be done on a authorized transaction. It is possible to do a part-capture where you only capture a part of the authorization amount. You can later do more captures on the same payment up to the total authorization amount.

<embed src="/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=3" style="max-width:100%">

#### Cancel Sequence

Cancel can only be done on a authorized transaction. If you do cancel after doing a part-capture you will cancel the different between the capture amount and the authorization amount.

<embed src="/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=4" style="max-width:100%">

#### Reversal Sequence

Reversal can only be done on a payment where there are some captured amount not yet reversed.

<embed src="/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=5" style="max-width:100%">
