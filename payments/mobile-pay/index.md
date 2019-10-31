---
title: Swedbank Pay Payments Mobile Pay
sidebar:
  navigation:
  - title: MobilePay Payments
    items:
    - url: /payments/mobile-pay
      title: Introduction
    - url: /payments/mobile-pay/redirect
      title: Redirect
    - url: /payments/mobile-pay/seamless-view
      title: Seamless View
    - url: /payments/mobile-pay/after-payment
      title: After Payment
    - url: /payments/mobile-pay/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

>Add MobilePay Online to your PayEx payment methods and take advantage of [payex-reconciliation-and-settlement][PayEx Settlement Service] to get consolidated payments and reporting, for all your payment methods.

# MobilePay Online Payment Pages

Read our documentation on [MobilePay Redirect][/payments/mobile-pay/redirect] to learn how to implement MobilePay in the redirect scenario.

## Payment Link

>The implementation sequence for this scenario is a variant of the purchase sequence in a [Hosted Payment Pages redirect scenario][redirect-implementation]. The consumer is not redirected to the payment pages directly but will instead receive a payment link via mail/SMS. When the consumer clicks on the link a payment window opens.

## Introduction

*  The Payment Link can be implemented for payment methods listed below, using the Redirect platform and hosted payment pages.  
  *  [Credit card][credit-card]
  *  [MobilePay][mobile-pay]
  *  [Swish m-commerce][swish-m-commerce] and [Swish e-commerce][swish-e-commerce]
  *  [Vipps][vipps]
*  When the consumer/end-user starts the purchase process in your merchant/wehshop site, you need to make a `POST` request towards PayEx with your Purchase information. You receive a Payment Link (same as redirect URL) in response. 
*  You have to distribute the Payment Link to the customer through your order system, using channels like e-mail or SMS.
  *  NOTE: When sending information in e-mail/SMS, it is strongly recommended that you add information about your terms and conditions, including purchase information and price. **See recommendations in the next paragraph.**
*  When the consumer clicks on the Payment Link, the PayEx payment page will open, letting the consumer enter the payment details (varying depending on payment instrument) in a secure PayEx hosted environment. When paying with credit card and if required, PayEx will handle 3D-secure authentication 
*  After completion, PayEx will redirect the browser back to your merchant/webshop site.
*  If [CallbackURL][technical-reference-callbackurl] is set the merchant system will receive a callback from PayEx, enabling you to make a `GET` request towards PayEx with the paymentID received in the first step, which will return the purchase result.

## Recommendations regarding Payment Link in E-mail/SMS

When you as a merchant sends an e-mail or SMS to the consumer about the Payment Link, it is recommended to include contextual information that help the consumer understand what will happen when clicking on the Payment Link. We recommend that you include following information:

*  The name of the merchant/shop that initiates the payment
*  An understandable product description, describing what kind of service the consumer will pay for.
*  Some order-id (or similar) that exists in the merchant order system.
*  The price and currency.
*  Details about shipping method and expected delivery (if physical goods will be sent  to the consumer).
*  Directions to (a link to a page) the merchant's terms and conditions (such as return policy) and information of how the consumer can contact the merchant. [See example here.][paymentlink-pdf]
*  Details informing the consumer that he or she accepts the Terms&Conditions when clicking on the Payment Link.

## Recommendations about receipt

We recommend that you send an e-mail or SMS confirmation with a receipt to the consumer when the payment has been fulfilled.

## API requests

The API-requests depend on the payment method you are using when implementing the Payment Link scenario, see [purchase flow](#purchase-flow). One-phase payment metods will not implement capture, cancellation or reversal. The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference][technical-reference].

## Screenshots

When clicking the payment link, the consumer will be directed to a payment page, similar to the examples below, where payment information can be entered.

![Payex payment menu][1551694498854-650]

### Options

All valid options when posting in a payment with operation Purchase, are described in each payment method's respective API reference. Please see the general sequence diagrams for more information about payments in one-phase (e.g. [Swish][swish-m-commerce] and credit card with autocapture) and two-phase (e.g. [Credit card][credit-card], [MobilePay][mobile-pay], [Vipps][vipps]).

#### Authorization

*  PreAuthorization (Credit card):
  *  If you specify that the _intent _of the _purchase _is PreAuthorize, it's almost the same as an authorization, **except that no money will be reserved** from the consumers credit card, [before you make a finalize on this transaction (using the PATCH on the Autorization)][tecnical-reference-finalize].

*  Authorize (two-phase):
  *  When using two-phase flows you reserve the amount with an authorization, you will have to specify that the intent of the purchaseis Authorize. The amount will be reserved but not charged. You will later (i.e. when you are ready to ship the purchased products) have to make a Capture or Cancel request.

#### Capture

*  Autocapture (one-phase credit card):
  *  If you want the credit card to be charged right away, you will have to specify that the intent of the purchaseis Autocapture. The credit card will be charged and you don't need to do any more financial operations to this purchase.

#### General

*  When implementing the Payment Link scenario, it is optional to set a [CallbackURL][technical-reference-callbackurl] in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer as fulfilled the payment. [See the Callback API description here][technical-reference-callback].

## Purchase flow

The sequence diagrams display the high level process of the purchase, from generating a Payment Link to receving a Callback. This in a generalized flow as well as a specific 3D-secure enabled credit card scenario.  

**Please note that the the callback may come either before, after or in the same moment as the consumer are being redirected to the status page at the merchant site when the purchase is fulfilled.**

When dealing with credit card payments, 3D-Secure authentication of the cardholder is an essential topic. There are three alternative outcome of a credit card payment:

* 3D-Secure enabled - by default, 3D-secure should be enabled, and PayEx will check if the card is enrolled with 3D-secure. This depends on the issuer of the card. If the card is not enrolled with 3D-Secure, no authentication of the cardholder is done.
* Card supports 3D-Secure - if the card is enrolled with 3D-Secure, PayEx will redirect the cardholder to the autentication mechanism that is decided by the issuing bank. Normally this will be done using BankID or Mobile BankID. 

```mermaid
sequenceDiagram
  Consumer->MerchantOrderSystem: consumer starts purchase
  Activate MerchantOrderSystem
  MerchantOrderSystem->Merchant: start purchase process
  Activate Merchant  
  Merchant->PayEx: POST [payment] (operation=PURCHASE)
  note left of Merchant: First API request
  Activate PayEx
  PayEx-->Merchant: payment resource with payment URL 
  Deactivate PayEx
  Merchant-->MerchantOrderSystem: Payment URL sent to order system
  Deactivate Merchant
  MerchantOrderSystem-->Consumer: Distribute Payment URL through e-mail/SMS
  Deactivate MerchantOrderSystem
  
  note left of Consumer: Payment Link in e-mail/SMS
  Consumer->PayEx: Open link and enter payment information
  Activate PayEx
  
  opt Card supports 3-D Secure
  PayEx-->Consumer: redirect to IssuingBank
  Deactivate PayEx
  Consumer->IssuingBank: 3-D Secure authentication process
  Consumer->PayEx: access authentication page
  Activate PayEx
  end
  
  PayEx-->Consumer: redirect to merchant site
  note left of PayEx: redirect back to merchant
  Deactivate PayEx
  
  Consumer->Merchant: access merchant page
  Activate Merchant
  Merchant->PayEx: GET [payment]
  note left of Merchant: Second API request
  Activate PayEx
  PayEx-->Merchant: payment resource
  Deactivate PayEx
  Merchant-->Consumer: display purchase result
  Deactivate Merchant
```


[1551694498854-650]: /assets/img/1551694498854-650.png
[credit-card]: #
[mobile-pay]: #
[payex-reconciliation-and-settlement]: #
[paymentlink-pdf]: #
[redirect-implementation]: #
[swish-e-commerce]: #
[swish-m-commerce]: #
[technical-reference-callback]: #
[technical-reference-callbackurl]: #
[technical-reference]: #
[tecnical-reference-finalize]: #
[vipps]: #
