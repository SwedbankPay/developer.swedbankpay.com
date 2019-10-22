---
title: Swedbank Pay Payments Mobile Pay
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
# MobilePay Online Payments

>Add MobilePay Online to your PayEx payment methods and take advantage of [PayEx Settlement Service](https://developer.payex.comhttps://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/reconciliation-and-settlement/) to get consolidated payments and reporting, for all your payment methods.

# MobilePay Online Payment Pages

>The basic redirect **purchase** scenario is the supported way to implement MobilePay payments.

## Introduction

* When you have prepared your merchant/webshop site, you make a `POST` request towards PayEx with your  Purchase information. You will receive a Redirect URL, leading to a secure PayEx hosted environment, in response, .
* You need to redirect the browser of the end-user/consumer to that URL so that she may enter her MobilePay details .
* When the payment is completed, PayEx will redirect the browser back to your merchant/webshop site.
* Finally you need to make a `GET` request towards PayEx with the paymentID received in the first step, which will return the purchase result.

## Screenshots

![MobilePay.png](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/mobilepay-payments/mobilepay-payment-pages/WebHome/MobilePay.png)

![MobilePay approval](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/mobilepay-payments/mobilepay-payment-pages/WebHome/MobilePay-approval.png)

## API Requests

The API requests are displayed in the [purchase flow](#HPurchaseflow). The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment

All valid options when posting in a payment with operation equal to Purchase, are described in [the technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/mobilepay-payments/).

#### Type of authorization (Intent).

* **Authorization (two-phase)**: The intent of a MobilePay purchase is always Authorization. The amount will be reserved but not charged. You will later (i.e. if a physical product, when you are ready to ship the purchased products) have to make a [Capture](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/mobilepay-payments/#HCaptures) or [Cancel](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/mobilepay-payments/#HCancellations) request.

#### General

* **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the POST request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Purchase flow

The sequence diagram below shows the two requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request. The diagram also shows in high level, the sequence of the process of a complete purchase.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/mobilepay-payments/mobilepay-payment-pages/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

### Options after posting a payment

* **Abort:** It is possible to [abort a payment](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HAbort) if the payment has no successful transactions.
* If the payment shown above is done as a twophase (`authorization`), you will need to implement the Capture and Cancel requests.
* For reversals, you will need to implement the Reversal request.
* **If CallbackURL is set:** Whenever changes to the payment occur  a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the callbackUrl, generated when the payment was created.

### Capture Sequence

Capture can only be done on a authorized transaction. It is possible to do a part-capture where you only capture a smaller amount than the authorization amount. You can later do more captures on the sam payment upto the total authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/mobilepay-payments/mobilepay-payment-pages/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

### Cancel Sequence

Cancel can only be done on a authorized transaction. If you do cancel after doing a part-capture you will cancel the different between the capture amount and the authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/mobilepay-payments/mobilepay-payment-pages/WebHome?xpage=plain&amp;uml=3" style="max-width:100%">

### Reversal Sequence

Reversal can only be done on a payment where there are some captured amount not yet reversed.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/mobilepay-payments/mobilepay-payment-pages/WebHome?xpage=plain&amp;uml=4" style="max-width:100%">

## Payment Link

>The implementation sequence for this scenario is a variant of the purchase sequence in a [Hosted Payment Pages redirect scenario](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HRedirectimplementation). The consumer is not redirected to the payment pages directly but will instead receive a payment link via mail/SMS. When the consumer clicks on the link a payment window opens.

## Introduction

*  The Payment Link can be implemented for payment methods listed below, using the Redirect platform and hosted payment pages.  
  *  [Credit card](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/card-payment-pages/)
  *  [MobilePay](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/mobilepay-payments/mobilepay-payment-pages/)
  *  [Swish m-commerce](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/swish-payments/swish-m-commerce-redirect/) and [Swish e-commerce]xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/swish-payments/swish-e-commerce-redirect/)
  *  [Vipps](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/vipps-payments/vipps-payment-pages/)
*  When the consumer/end-user starts the purchase process in your merchant/wehshop site, you need to make a `POST` request towards PayEx with your Purchase information. You receive a Payment Link (same as redirect URL) in response. 
*  You have to distribute the Payment Link to the customer through your order system, using channels like e-mail or SMS.
  *  NOTE: When sending information in e-mail/SMS, it is strongly recommended that you add information about your terms and conditions, including purchase information and price. **See recommendations in the next paragraph.**
*  When the consumer clicks on the Payment Link, the PayEx payment page will open, letting the consumer enter the payment details (varying depending on payment instrument) in a secure PayEx hosted environment. When paying with credit card and if required, PayEx will handle 3D-secure authentication 
*  After completion, PayEx will redirect the browser back to your merchant/webshop site.
*  If [CallbackURL](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs) is set the merchant system will receive a callback from PayEx, enabling you to make a `GET` request towards PayEx with the paymentID received in the first step, which will return the purchase result.

## Recommendations regarding Payment Link in E-mail/SMS

When you as a merchant sends an e-mail or SMS to the consumer about the Payment Link, it is recommended to include contextual information that help the consumer understand what will happen when clicking on the Payment Link. We recommend that you include following information:

*  The name of the merchant/shop that initiates the payment
*  An understandable product description, describing what kind of service the consumer will pay for.
*  Some order-id (or similar) that exists in the merchant order system.
*  The price and currency.
*  Details about shipping method and expected delivery (if physical goods will be sent  to the consumer).
*  Directions to (a link to a page) the merchant's terms and conditions (such as return policy) and information of how the consumer can contact the merchant. [See example here.](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/common-payment-scenarios/payment-link/WebHome/Example_Betingelser_nettbutikk.pdf)
*  Details informing the consumer that he or she accepts the Terms&Conditions when clicking on the Payment Link.

## Recommendations about receipt

We recommend that you send an e-mail or SMS confirmation with a receipt to the consumer when the payment has been fulfilled.

## API requests

The API-requests depend on the payment method you are using when implementing the Payment Link scenario, see [purchase flow](#HPurchaseflow). One-phase payment metods will not implement capture, cancellation or reversal. The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

## Screenshots

When clicking the payment link, the consumer will be directed to a payment page, similar to the examples below, where payment information can be entered.

![1551694498854-650.png](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/common-payment-scenarios/payment-link/WebHome/1551694498854-650.png?width=481&height=535)

### Options

All valid options when posting in a payment with operation Purchase, are described in each payment method's respective API reference. Please see the general sequence diagrams for more information about payments in one-phase (e.g. [Swish](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/swish-payments/) and credit card with autocapture) and two-phase (e.g. [Credit card](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/card-payments/), [MobilePay](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/mobilepay-payments/), [Vipps](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/vipps-payments/)).

#### Authorization

*  PreAuthorization (Credit card):
  *  If you specify that the _intent _of the _purchase _is PreAuthorize, it's almost the same as an authorization, **except that no money will be reserved** from the consumers credit card, [before you make a finalize on this transaction (using the PATCH on the Autorization).](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/#HFinalize)

*  Authorize (two-phase):
  *  When using two-phase flows you reserve the amount with an authorization, you will have to specify that the intent of the purchaseis Authorize. The amount will be reserved but not charged. You will later (i.e. when you are ready to ship the purchased products) have to make a Capture or Cancel request.

#### Capture

*  Autocapture (one-phase credit card):
  *  If you want the credit card to be charged right away, you will have to specify that the intent of the purchaseis Autocapture. The credit card will be charged and you don't need to do any more financial operations to this purchase.

#### General

*  When implementing the Payment Link scenario, it is optional to set a [CallbackURL](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs) in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer as fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Purchase flow

The sequence diagrams display the high level process of the purchase, from generating a Payment Link to receving a Callback. This in a generalized flow as well as a specific 3D-secure enabled credit card scenario.  

**Please note that the the callback may come either before, after or in the same moment as the consumer are being redirected to the status page at the merchant site when the purchase is fulfilled.**

When dealing with credit card payments, 3D-Secure authentication of the cardholder is an essential topic. There are three alternative outcome of a credit card payment:

* 3D-Secure enabled - by default, 3D-secure should be enabled, and PayEx will check if the card is enrolled with 3D-secure. This depends on the issuer of the card. If the card is not enrolled with 3D-Secure, no authentication of the cardholder is done.
* Card supports 3D-Secure - if the card is enrolled with 3D-Secure, PayEx will redirect the cardholder to the autentication mechanism that is decided by the issuing bank. Normally this will be done using BankID or Mobile BankID. 

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/common-payment-scenarios/payment-link/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

### Options after posting a payment

*  If the payment enable a two-phase flow (Authorize), you will need to implement the Capture and Cancel requests.
*  It is possible to "abort" the validity of the Payment Link by making a PATCH on the payment. [See the PATCH payment description](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HAbort).
*  For reversals, you will need to implement the Reversal request.
*  If you did a PreAuthorization, you will have to send a Finalize to the transaction using [PATCH on the Authorization](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/card-payments/).
*  When implementing the Payment Link scenario, it is optional to set a CallbackURL in the POST request. If CallbackURL is set PayEx will send a postback request to this URL when the consumer as fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

### Capture Sequence

Capture can only be perfomed on a payment with a successfully authorized transaction. It is possible to do a part-capture where you only capture a smaller amount than the authorized amount. You can later do more captures on the same payment up to the total authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/common-payment-scenarios/payment-link/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

### Cancel Sequence

Cancel can only be done on a authorized transaction. If you do cancel after doing a part-capture you will cancel the difference between the captured amount and the authorized amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/common-payment-scenarios/payment-link/WebHome?xpage=plain&amp;uml=3" style="max-width:100%">

### Reversal Sequence

Reversal can only be done on a payment where there are some captured amount not yet reversed.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/common-payment-scenarios/payment-link/WebHome?xpage=plain&amp;uml=4" style="max-width:100%">
