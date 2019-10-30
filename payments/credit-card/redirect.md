---
title: Swedbank Pay Payments Credit Card Seamless View
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
    - url: /payments/direct-debit
      title: Direct Debit Payments
    - url: /payments/mobile-pay
      title: Mobile Pay Payments
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/vipps
      title: Vipps Payments
---

>The basic redirect view purchase scenario is the most common way to implement card payments.

## Introduction

* When properly set up in your merchant/webshop site and the payer starts the purchase process, you need to make a POST request towards PayEx with your Purchase information. This will generate a payment object with a unique paymentID. You either receive a Redirect URL to a hosted page or a JavaScript source in response.
* You need to [redirect] the payer's browser to that specified URL, or embed the script source on your site to create a Hosted View in an iFrame; so that she can enter the credit card details in a secure PayEx hosted environment.
* PayEx will handle 3D-secure authentication when this is required.
* PayEx will redirect the payer's browser to - or display directly in the iFrame - one of two specified URLs, depending on whether the payment session is followed through completely or cancelled beforehand. Please note that both a successful and rejected payment reach completion, in contrast to a cancelled payment.
* When you detect that the payer reach your completeUrl , you need to do a `GET` request to receive the state of the transaction, containing the paymentID generated in the first step, to receive the state of the transaction.

## Screenshots

You will redirect the payer to PayEx hosted pages to collect the credit card information.

![Screnshot-1]

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow). The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference][technical-reference].

### Options before posting a payment

All valid options when posting in a payment with se, are described in the [technical reference][technical-reference].

#### Type of authorization - Intent
* *PreAuthorization*: A purchase with PreAuthorization intent is handled in a similar manner as the ordinary authorization procedure. The notable difference is that the funds are put on hold for 30 days (for an ordinary authorization the funds are reserved for 7 days). Also, with a PreAuthorization, the captured amount can be higher than the preauthorized amount. The amount captured should not be higher than 20% of the original amount, due to card brand rules. You complete the purchase by [finalizing-the-transaction][finalizing the transaction].
* *Authorization (two-phase)*: If you want the credit card to reserve the amount, you will have to specify that the intent of the purchase is Authorization. The amount will be reserved but not charged. You will later (i.e. when you are ready to ship the purchased products) have to make a [Capture] or [Cancel] request.

#### General
* *No 3D Secure and card acceptance:* There are optional paramers that can be used in relation to 3d-secure and card acceptance. By default, most credit card agreements with an acquirer will require that you use 3D-Secure for card holder authentication. However, if your agreement allows you to make a card payment without this authentication, or that specific cards can be declined, you may adjust these optional parameters when posting in the payment. This is specified in the technical reference section for creating credit card payments  - you will find the link in the sequence diagram below.
* *Defining CallbackURL:* When implementing a scenario, it is optional to set a [CallbackURL] in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here][callback-API-description].

### Co-brand Visa/Dankort

Not yet supported

### Purchase flow
The sequence diagram below shows a high level description of a complete purchase, and the requests you have to send to PayEx. The links will take you directly to the corresponding API description.

When dealing with credit card payments, 3D-Secure authentication of the cardholder is an essential topic. There are three alternative outcome of a credit card payment:

* 3D-Secure enabled - by default, 3D-secure should be enabled, and PayEx will check if the card is enrolled with 3D-secure. This depends on the issuer of the card. If the card is not enrolled with 3D-Secure, no authentication of the cardholder is done.
* Card supports 3D-Secure - if the card is enrolled with 3D-Secure, PayEx will redirect the cardholder to the autentication mechanism that is decided by the issuing bank. Normally this will be done using BankID or Mobile BankID.

```mermaid
sequenceDiagram
    Consumer->+Merchant: start purchase
    Merchant->+PayEx: POST [operation=PURCHASE](payments/credit-card/payments)
    Note left of PayEx: First API Request
    PayEx-->>-Merchant: payment resource
    Merchant-->>-Consumer: authorization page
    note left of consumer: redirect to PayEx (If Redirect scenario)

    Consumer->+Merchant: access merchant page
    Merchant->+PayEx: GET [payments/credit-card/payments](payments/credit-card/payments)
    note left of Merchant: Second API request
    PayEx-->-Merchant: payment resource
    Merchant-->-Consumer: display purchase result
```

```mermaid
sequenceDiagram
  Consumer->+Merchant: start purchase
  Merchant->+PayEx: POST [operation=PURCHASE](payments/credit-card/payments)
  note left of Consumer: First API request
  PayEx-->Merchant: payment resource
  deactivate PayEx
  Merchant-->Consumer: authorization page
  deactivate Merchant

  Consumer->+PayEx: access authorization page
  note left of Consumer: redirect to PayEx\n(If Redirect scenario)
  PayEx-->Consumer: display purchase information
  deactivate PayEx

  Consumer->Consumer: input creditcard information
  Consumer->+PayEx: submit creditcard information
  
  opt Card supports 3-D Secure
    PayEx-->Consumer: redirect to IssuingBank
    deactivate PayEx
    Consumer->IssuingBank: 3-D Secure authentication process
    Consumer->+PayEx: access authentication page
  end
  
  PayEx-->Consumer: redirect to merchant 
  deactivate PayEx
  note left of Consumer: redirect back to merchant\n(If Redirect scenario)
  
  Consumer->+Merchant: access merchant page
  Merchant->+PayEx: GET [payments/credit-card/payments](payments/credit-card/payments)
  note left of Merchant: Second API request
  PayEx-->Merchant: payment resource
  deactivate PayEx
  Merchant-->Consumer: display purchase result
  deactivate Merchant

  opt Callback is set
    PayEx->PayEx: Payment is updated
    activate PayEx
    PayEx->Merchant: send [Callback request](#)
    deactivate PayEx
  end
```

### Options after posting a payment

* *Abort:* It is possible to abort the process, if the payment has no successful transactions. [See the PATCH payment description][see-the-PATCH-payment-description].  
* If the payment shown above is done as a two phase (`Authorization`), you will need to implement the `Capture` and `Cancel` requests.  
* For `reversals`, you will need to implement the Reversal request.  
* If you did a `PreAuthorization`, you will have to send a [Finalize request] to finalize the transaction.  
* *If CallbackURL is set:* Whenever changes to the payment occur a [Callback request] will be posted to the callbackUrl, which was generated when the payment was created.  

[Screnshot-1]: /assets/img/creditcard-image-1.png
{:height="711px" width="400px"}
[creditcard-image-2]: /assets/img/creditcard-image-2.png
{:height="711px" width="400px"}
[redirect-image]: /assets/img/creditcard-image-3.png
{:height="711px" width="400px"}
[abort-a-payment]: #
[abort]: /payments/credit-card/after-payment
[approved-legal-address]: #
[before-you-finalize-the-transaction]: /payments/credit-card/after-payment
[callback-API-description]: #
[callback-api]: #
[callback-request]: /payments/credit-card/after-payment
[callback-url]: #
[CallbackURL]: #
[Cancel]: /payments/credit-card/after-after-payment
[Capture]: /payments/credit-card/after-after-payment
[card-payment-pages]: #
[card-verification]: #
[card]: #
[Credit Card API]: #
[credit-card-auth-direct]: #
[credit-card]: #
[creditcard]: #
[delete-payment-token]: #
[direct-authorization-reference]: #
[expanding]: #
[finalize-request]: /payments/credit-card/after-payment
[finalizing-the-transaction]: /payments/credit-card/after-after-payment
[financing invoice]: #
[get-payment-response]: payments/credit-card/payments
[hosted-view]: /..
[invoice-payments]: #
[invoice]: #
[no-png]: /assets/img/no.png
[one-click-card-payment]: #
[one-click-payments]: #
[PCI-link]: https://www.pcisecuritystandards.org/
[purchace-operation-link]: #
[purchase-payment]: #
[recurring-card-payment]: #
[recurring-payment]: #
[recurring-server-to-server-based-payments]: #
[redirect]: #
[remove-payment-token]: #
[see-the-PATCH-payment-description]: /payments/credit-card/after-payment
[setup-mail]: mailto:setup.ecom@PayEx.com
[technical-reference]: #
[Verification flow]: #
[verify-payment]: #
