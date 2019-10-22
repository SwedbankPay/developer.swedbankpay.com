---
title: Swedbank Pay Payments Credit Card
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

```
The basic redirect purchase scenario is the most common way to implement card payments.
```
# Card Payment Pages

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

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

### Options after posting a payment

* *Abort:* It is possible to abort the process, if the payment has no successful transactions. [See the PATCH payment description](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HAbort).  
* If the payment shown above is done as a two phase (`Authorization`), you will need to implement the `Capture` and `Cancel` requests.  
* For `reversals`, you will need to implement the Reversal request.  
* If you did a `PreAuthorization`, you will have to send a [Finalize request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HFinalize) to finalize the transaction.  
* *If CallbackURL is set:* Whenever changes to the payment occur a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the callbackUrl, which was generated when the payment was created.  

#### Capture Sequence

Capture can only be done on a authorized transaction. It is possible to do a part-capture where you only capture a part of the authorization amount. You can later do more captures on the same payment up to the total authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=3" style="max-width:100%">

#### Cancel Sequence

Cancel can only be done on a authorized transaction. If you do cancel after doing a part-capture you will cancel the different between the capture amount and the authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=4" style="max-width:100%">

#### Reversal Sequence

Reversal can only be done on a payment where there are some captured amount not yet reversed.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/WebHome?xpage=plain&amp;uml=5" style="max-width:100%">


# Card Payment Pages in Mobile Apps

```
The implementation sequence for this scenario is identical to the standard Redirect scenario, but also includes explanations of how to include this redirect in mobile apps or in mobile web pages.
```

## Introduction

* When properly set up in your merchant/webshop site and the payer starts the purchase process in your merchant/webshop site, you need to make a POST request towards PayEx with your Purchase information. This will generate a payment object with a unique paymentID. You either receive a redirect URL to a hosted page or a JavaScript source in response.  
* You need to [redirect](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HRedirectimplementation) the payer to the Redirect payment page or embed the script source on you site to create a [Hosted View](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HostedViewimplementation) in an iFrame;  so that she can enter credit card details in a secure PayEx hosted environment.  
* PayEx will handle 3D-secure authentication when this is required.  
* PayEx will redirect the payer's browser to - or display directly in  the iFrame - one of two specified URLs, depending on whether the payment session is followed through completely or cancelled beforehand. Please note that both a successful and rejected payment reach completion, in contrast to a cancelled payment.  
* When you detect that the payer reach your completeUrl , you need to do a `GET` request, containing the paymentID generated in the first step, to receive the state of the transaction.  

### Payment Url

For our hosted view, the URL property called paymentUrl will be used if the consumer is redirected out of the hosted view frame through our [Credit Card API](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/). The consumer is redirected out of frame when at the 3d secure verification for credit card payments. The URL should represent the page of where the payment hosted view was hosted originally, such as the checkout page, shopping cart page, or similar. Basically, paymentUrl should be set to the same URL as that of the page where the JavaScript for the hosted payment view was added to in order to initiate the payment. Please note that the paymentUrl must be able to invoke the same JavaScript URL from the same Payment as the one that initiated the payment originally, so it should include some sort of state identifier in the URL. The state identifier is the ID of the order, shopping cart or similar that has the URL of the Payment stored.


With paymentUrl in place, the retry process becomes much more convenient for both the integration and the payer.

## Screenshots

You will redirect the consumer/end-user to PayEx hosted pages to collect the credit card information.

![Redirect image](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages-in-mobile-apps/WebHome/1551693930590-433.png?width=400&height=711)

## API-requests

The API requests are displayed in the[ purchase flow](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages-in-mobile-apps/#HPurchaseflow). The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).


### Options before posting a payment

All valid options when posting in a payment with `operation` equal to `Purchase`, are described in [the technical reference](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/).

#### Type of authorization (Intent).

* **PreAuthorization**: If you specify that the `intent` of the `purchase` is `PreAuthorization`, it's almost the same as an authorization, _except that no money will be reserved_ from the consumers credit card, [before you finalize the transaction](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HFinalize)
* **Authorization (two-phase):** If you want the credit card to reserve the amount, you will have to specify that the `intent` of the `purchase` is `Authorization`. The amount will be reserved but not charged. You will later (i.e. when you are ready to ship the purchased products) have to make a [Capture](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HCaptures) or [Cancel](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HCancellations) request.

#### Type of capture (Intent)

* **AutoCapture (one-phase):** If you want the credit card to be charged right away, you will have to specify that the `intent` of the purchase is `AutoCapture`. The credit card will be charged and you don't need to do any more financial operations to this purchase.

#### General

* **No 3D Secure and card acceptance**: There are optional paramers that can be used in relation to 3d-secure and card acceptance. By default, most credit card agreements with an acquirer will require that you use 3D-Secure for card holder authentication. However, if your agreement allows you to make a card payment without this authentication, or that specific cards can be declined, you may adjust these optional parameters when posting in the payment. This is specified in the technical reference section for creating credit card payments  - you will find the link in the sequence diagram below.
* **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs) in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Purchase flow

The sequence diagram below shows a high level description of a complete purchase, and the two requests you have to send to PayEx. The links will take you directly to the corresponding API description.

When dealing with credit card payments, 3D-Secure authentication of the cardholder is an essential topic. There are three alternative outcome of a credit card payment:

* 3D-Secure enabled - by default, 3D-secure should be enabled, and PayEx will check if the card is enrolled with 3D-secure. This depends on the issuer of the card. If the card is not enrolled with 3D-Secure, no authentication of the cardholder is done.
* Card supports 3D-Secure - if the card is enrolled with 3D-Secure, PayEx will redirect the cardholder to the autentication mechanism that is decided by the issuing bank. Normally this will be done using BankID or Mobile BankID. 
* No 3D-Secure - if this is specified in the request (see options above), no authentication is requested.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages-in-mobile-apps/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

### Detailed Sequence Diagram enabing 3D-secure authentication

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages-in-mobile-apps/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

## Options after posting a payment

* If the payment shown above is done as a two-phase (Authorize), you will need to implement the Capture and Cancel requests.
* **Abort:** It is possible to [abort a payment](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HAbort) if the payment has no successful transactions.
* For reversals, you will need to implement the Reversal request.
* If you did a `PreAuthorization`, you will have to send a `Finalize` to the transaction using [PATCH on the Authorization](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HFinalize).
* **Callback from PayEx:** Whenever changes to the payment occur  a [Callback request](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the `callbackUrl`, generated when the payment was created.

### Capture Sequence

Capture can only be done on a authorized transaction. It is possible to do a part-capture where you only capture a smaller amount than the authorization amount. You can later do more captures on the sam payment upto the total authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages-in-mobile-apps/WebHome?xpage=plain&amp;uml=3" style="max-width:100%">

### Cancel Sequence

Cancel can only be done on a authorized transaction. If you do cancel after doing a part-capture you will cancel the different between the capture amount and the authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages-in-mobile-apps/WebHome?xpage=plain&amp;uml=4" style="max-width:100%">

### Reversal Sequence

Reversal can only be done on a payment where there are some captured amount not yet reversed.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages-in-mobile-apps/WebHome?xpage=plain&amp;uml=5" style="max-width:100%">

# Direct Card Payments

## Introduction

```
The direct payment scenario **is used by customers that are compliant with PCI-DSS regulations**, and is a way to implement card payments without using PayEx Hosted payment pages.  
```

{% include alert.html type="error"
                      icon="error"
                      header="PCI-DSS Complicance"
                      body="The direct integration option requires you to collect the card data on your website, which means it must be [PCI-DSS Compliant](https://www.pcisecuritystandards.org/)." %}
                      

* The payer places an order and you make a `POST` request towards PayEx with gathered `Purchase` information. The action taken next is the `direct-authorization` operation that is returned in the first request. 
* You `POST` the payer's card data to the URL in the [`direct-authorization operation](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HCreateauthoriationtransaction).
* If 3D-secure authentication is required, you will then receive a URL where you will have to redirect the payer.
* When the payment is completed, the payer needs to be redirected back to your merchant/webshop site.
* Finally you make a `GET` request towards PayEx with the `paymentID` received in the first step, which will return the purchase result.

## API Requests

The API requests are displayed in the [purchase flow](#HPurchaseflow). The options you can choose from when creating a payment with key `operation` set to Value `Purchase` are listed below. The general REST based API model is described in the [technical reference](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment

All valid options when posting in a payment with `operation` equal to `Purchase`, are described in [the technical reference](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/).

#### Type of authorization (Intent).

* **PreAuthorization**: If you specify that the `intent` of the `purchase` is `PreAuthorization`, it's almost the same as an authorization, _except that no money will be reserved_ from the consumers credit card, [before you finalize the transaction](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HFinalize)
* **Authorization (two-phase):** If you want the credit card to reserve the amount, you will have to specify that the `intent` of the `purchase` is `Authorization`. The amount will be reserved but not charged. You will later (i.e. when you are ready to ship the purchased products) have to make a [Capture](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HCaptures) or [Cancel](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HCancellations) request.

#### Type of capture (Intent)

* **AutoCapture (one-phase):** If you want the credit card to be charged right away, you will have to specify that the `intent` of the purchase is `AutoCapture`. The credit card will be charged and you don't need to do any more financial operations to this purchase.

#### General

* **No 3D Secure and card acceptance**: There are optional paramers that can be used in relation to 3d-secure and card acceptance. By default, most credit card agreements with an acquirer will require that you use 3D-Secure for card holder authentication. However, if your agreement allows you to make a card payment without this authentication, or that specific cards can be declined, you may adjust these optional parameters when posting in the payment. This is specified in the technical reference section for creating credit card payments  - you will find the link in the sequence diagram below.
* **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Purchase flow

The sequence diagram below shows a high level description of a complete purchase, and the requests you have to send to PayEx. The links will take you directly to the corresponding API description.

When dealing with credit card payments, 3D-Secure authentication of the cardholder is an essential topic. There are three alternative outcomes of a credit card payment:

* 3D-Secure enabled - by default, 3D-secure should be enabled, and PayEx will check if the card is enrolled with 3D-secure. This depends on the issuer of the card. If the card is not enrolled with 3D-Secure, no authentication of the cardholder is done.
* Card supports 3D-Secure - if the card is enrolled with 3D-Secure, PayEx will redirect the cardholder to the autentication mechanism that is decided by the issuing bank. Normally this will be done using BankID or Mobile BankID.
* No 3D-Secure - if this is specified in the request (see options above), no authentication is requested.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/direct-card-payments/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/direct-card-payments/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

## Options after posting a purchase payment

* If the payment shown above is done as a two-phase (Authorization), you will need to implement the Capture and Cancel requests.
* **Abort:** It is possible to [abort a payment](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HAbort) if the payment has no successful transactions.
* For reversals, you will need to implement the Reversal request.
* If you did a PreAuthorization, you will have to send a Finalize to the transaction using [PATCH on the Authorization](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HFinalize).
* **Callback from PayEx:** Whenever changes to the payment occur a [Callback request](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the `callbackUrl`, generated when the payment was created.

### Capture Sequence

Capture can only be done on a authorized transaction. It is possible to do a part-capture where you only capture a smaller amount than the authorization amount. You can later do more captures on the sam payment upto the total authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/direct-card-payments/WebHome?xpage=plain&amp;uml=3" style="max-width:100%">

### Cancel Sequence

Cancel can only be done on a authorized transaction. If you do cancel after doing a part-capture you will cancel the different between the capture amount and the authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/direct-card-payments/WebHome?xpage=plain&amp;uml=4" style="max-width:100%">

### Reversal Sequence

Reversal can only be done on a payment where there are some captured amount not yet reversed.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/direct-card-payments/WebHome?xpage=plain&amp;uml=5" style="max-width:100%">

One-Click Payments utilize a previously generated payment token to prefill payment details for credit card or invoice payments pages - which means that the payer don't need to enter these details for every purchase. 

# One-Click Payments

```
One-Click Payments utilize a previously generated payment token to prefill payment details for credit card or invoice payments pages - which means that the payer don't need to enter these details for every purchase.  
```

## Introduction

The main purchase flow and implementation is exactly the same as described in the [Redirect](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HRedirectimplementation) and [Hosted View](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HHostedViewimplementation) scenarios for [card](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/) and [financing invoice](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-redirect/) payments, the difference being the use of a paymentToken. The details in this section describe explicitly the parameters that must be set to enable one-click purchases.

### Payment Url

For our hosted view, the URL property called `paymentUrl` will be used if the consumer is redirected out of the hosted view frame through our [Credit Card API](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/). The consumer is redirected out of frame when at the 3d secure verification for credit card payments. The URL should represent the page of where the payment hosted view was hosted originally, such as the checkout page, shopping cart page, or similar. Basically, `paymentUrl` should be set to the same URL as that of the page where the JavaScript for the hosted payment view was added to in order to initiate the payment. Please note that the `paymentUrl` must be able to invoke the same JavaScript URL from the same Payment as the one that initiated the payment originally, so it should include some sort of state identifier in the URL. The state identifier is the ID of the order, shopping cart or similar that has the URL of the Payment stored.

With paymentUrl in place, the retry process becomes much more convenient for both the integration and the payer.

## API requests to generate paymentToken

When making the initial purchase request, you need to generate a `paymentToken`. You can do this either by by setting `generatePaymentToken` to `true` when doing a card purchase, or set the initial operation to `Verify`.

{:.table .table-striped}

| **Instrument** | **Operation** | **paymentToken**|
| Credit card |	Purchase or Verify | If Purchase, generatePaymentToken must be set to true. A verification payment generates a paymentToken automatically. |

```
generatePaymentToken property
"generatePaymentToken": "true"
```

When the purchase is followed through a `paymentToken` will linked to the payment.  You can return the value by making a `GET` request payment resource ([expanding](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HExpansion) either the authorizations or verifications sub-resource), after the consumer successfully has completed the purchase.

```HTTP
GET https://api.payex.com/psp/creditcard/payments/d23a0e69-3c35-4e6b-cb3c-08d73b3d9f95?$expand=[authorizations|verifications] HTTP/1.1
Host: api.payex.com
```

**paymentToken**
```
"paymentToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
```

You need to store the paymentToken in your system and keep track of the corresponding consumer-ID in your system.

## Returning purchases

When a known consumer (where you have attained a consumer-ID or similar) returns to your system, you can use the payment token, using already stored payment data, to initiate enable one-click payments. You will need to make a standard redirect purchase, following the sequence as specified in the Redirect scenarios for  [credit-card](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/) and [financing invoice](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-redirect/). When making the first `POSTrequest you insert the `paymentToken attribute. This must be the  `paymentToken you received in the initial purchase, where you specified the `generatePaymentToken to <span style="font-family:monospace">true.

See the technical reference, for how to create a [card](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HCreatePayment) and [invoice](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/invoice-payments/#HCreatePayment) payment.

**Request**

```JS
POST /psp/creditcard/payments HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json      

{
  "payment": {
    "operation": "Verify",
    "currency": "NOK",
    "description": "Test Verification",
    "payerReference": "AB1234",
    "userAgent": "Mozilla/5.0...",
    "language": "nb-NO",
    "generatePaymentToken": true,
    "generateRecurrenceToken": false,
    "urls": {
      "hostUrls": ["http://test-dummy.net"],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://example.com/perform-payment",
      "logoUrl": "https://test-dummy.net/payment-logo.png",
      "termsOfServiceUrl": "https://test-dummy.net/payment-terms.html"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",
      "productCategory": "A123",
      "orderReference": "or-12456",
      "subsite": "MySubsite"
    }
  },
  "creditCard": {
    "rejectCreditCards": false,
    "rejectDebitCards": false,
    "rejectConsumerCards": false,
    "rejectCorporateCards": false
  }
}
```

When redirecting to PayEx (as specified in [the Redirect scenario](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/)) the payment page will be prefilled with the payer's card details.

## Screenshots

![1551694133222-896.png](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/card-payments/one-click-card-payments/WebHome/1551694133222-896.png?width=483&height=424)

## Delete payment token

Please see [Delete payment token](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HRemovepaymenttoken)

# Payout to Card

```
"Payout to Card" is an add-on service that enable you to deposit winnings directly to your end-users' credit cards. This without  the need to collect card details from the end-user a second time. 
```

## Introduction

* Acquirer for this service is Swedbank. You require a separate Swedbank acquiring number to ensure that payout transactions and regular card transactions are kept separate.
* You need to have the 3D-secure protocol enabled.
* The service is available both through hosted payment pages and through direct API integration.
* The current implementation is only available for gaming transactions (Merchant MCC: 7995).
* The payout service is not a part of PayEx Settlement Service.

## API requests

The API requests are displayed in the [payout flow](#HPayoutflow).  You create a payout by performing a `POST` creditcard payments with key `operation` set to `payout`. See more details in the [Card Payment pages](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HPayout) of the technical reference. The general REST based API model is described in the [technical reference](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

The general REST based API model is described [here](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Payout flow

You must set `Operation` to `Payout` in the initial `POST` request. 

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/card-payments/payout-to-card/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

# Recurring Card Payments

A recurring payment enables you to charge a credit card without any consumer interaction. When an initial payment token is generated subsequent payments is made through server-to-server requests. 

Prerequisites
-------------

Prior to making any server-to-server requests, you need to supply the payment instrument details and a payment token to PayEx by initial purchase or [card verification](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/verify-payment/).

There are two ways to initiate recurring payments procedures, depending on if you want to make an initial charge or not:

* Initiate a recurring payment flow and** charge the credit card. **This is done by creating a "Purchase Payment" and generating a recurrence token.

* Initiate a recurring payment flow** without charging the credit card. **This is done by creating  a "Verify Payment" and generating a recurrence token.

### Generate RecurrenceToken

* When posting a Purchase payment, you need to make sure that the attribute generateRecurrenceToken is set to true

**Attribute**
```
"generateRecurrenceToken": "true"
```

* When posting a `Verify` payment, a payment token will be generated automatically.

### Creating a Payment

* You need to `POST` a [Purchase payment](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HPurchase)  / and generate a recurrence token (safekeep for later recurring use).

* You need to `POST` a [Verify payment](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HVerify), that will automatically generate a recurrence token (for later recurring use).

### Retreive Recurrence Token

The recurrence token can then be retrieved by doing a `GET` request against the payment. You need to store this recurrenceToken in your system and keep track of the corresponding consumer-ID.

### Delete Recurrence Token

You can delete a created recurrence token with a `PATCH`\-request. Please see technical reference for details [here](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HRemovepaymenttoken)

Recurring purchases
-------------------

When you have a Recurrence token stored away. You can use the same token in a subsequent [recurring payment](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HRecur) `POST`. This will be a server-to-server affair, as we have both payment instrument details and recurrence token from the initial payment. Please note that this POSTrequest is made directly on the payment level, and will not create a payment order.

### Options after a payment

You have the following options after a server-to-server Recur payment `POST`.

#### Autorization (intent)

* **Authorization (two-phase):** If you want the credit card to reserve the amount, you will have to specify that the intent of the purchase is Authorization. The amount will be reserved but not charged. You will later (i.e. when you are ready to ship the purchased products) have to make a [Capture](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HCaptures) or [Cancel](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HCancellations) request.

#### Capture (intent)

* **AutoCapture (one-phase): **If you want the credit card to be charged right away, you will have to specify that the intent of the purchase is AutoCapture. The credit card will be charged and you don't need to do any more financial operations to this purchase.​​​​​

#### General

* **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

The Verify operation lets you post verification payments, which are used to confirm validity of card information without reserving or charging any amount.

# Verifications

```
The Verify operation lets you post verification payments, which are used to confirm validity of card information without reserving or charging any amount.
```

Introduction
------------

This option is commonly used when initiating a subsequent [One-click card payment](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/one-click-card-payments/) or a [recurring card payment](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/recurring-card-payments/) flow - where you do not want to charge the consumer right away.

#### Verification through PayEx Payment Pages

* When properly set up in your merchant/webshop site and the payer initiates a verification operation, you make a `POST` request towards PayEx with your Verify information. This will generate a payment object with a unique paymentID. You either receive a Redirect URL to a hosted page or a JavaScript source in response.
* You need to [redirect](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HRedirectimplementation) the payer's browser to that specified URL, or embed the script source on your site to create a [Hosted View](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HHostedViewimplementation) in an iFrame; so that she can enter the credit card details in a secure PayEx hosted environment.
* PayEx will handle 3D-secure authentication when this is required.
* PayEx will redirect the payer's browser to - or display directly in the iFrame - one of two specified URLs, depending on whether the payment session is followed through completely or cancelled beforehand. Please note that both a successful and rejected payment reach completion, in contrast to a cancelled payment.
* When you detect that the payer reach your completeUrl , you need to do a `GET` request to receive the state of the transaction.
* Finally you will make a `GET` request towards PayEx with the paymentID received in the first step, which will return the payment result and a paymentToken that can be used for subsequent [One-Click Payments](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/one-click-card-payments/) and [recurring server-to-server based payments](/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/recurring-card-payments/) .

Screenshots
-----------

You will redirect the consumer/end-user to PayEx hosted pages to collect the credit card information.

![1551694389702-244.png](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/card-payments/verify-payment/WebHome/1551694389702-244.png?width=488&height=536)

API Requests
------------

The API requests are displayed in the [Verification flow](#HVerificationflow). The options you can choose from when creating a payment with key operation set to Value Verify are listed below. The general REST based API model is described in the [technical reference](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment

All valid options when posting in a payment with operation equal to `Verify`, are described in [the technical reference](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/).

#### General

* **No 3D Secure and card acceptance**: There are optional paramers that can be used in relation to 3d-secure and card acceptance. By default, most credit card agreements with an acquirer will require that you use 3D-Secure for card holder authentication. However, if your agreement allows you to make a card payment without this authentication, or that specific cards can be declined, you may adjust these optional parameters when posting in the payment. This is specified in the technical reference section for creating credit card payments  - you will find the link in the sequence diagram below.
* **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

Verification flow
-----------------

The sequence diagram below shows the two requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request. The diagram also shows in high level, the sequence of the process of a complete purchase.  
When dealing with credit card payments, 3D-Secure authentication of the cardholder is an essential topic. There are three alternative outcome of a credit card payment:

* 3D-Secure enabled - by default, 3D-secure should be enabled, and PayEx will check if the card is enrolled with 3D-secure. This depends on the issuer of the card. If the card is not enrolled with 3D-Secure, no authentication of the cardholder is done.
* Card supports 3D-Secure - if the card is enrolled with 3D-Secure, PayEx will redirect the cardholder to the autentication mechanism that is decided by the issuing bank. Normally this will be done using BankID or Mobile BankID.
* No 3D-Secure - if this is specified in the request (see options above), no authentication is requested.

### Options after posting a payment

* Do a `GET` [request](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HPaymentResource) to view the paymentToken that is created automatically when posting a verification.
* **Abort:** It is possible to [abort a payment](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HAbort) if the payment has no successful transactions.
* Be prepared to [receive a Callback from PayEx](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback).

Technical reference
-------------------

You find the full technical reference [here](/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/).