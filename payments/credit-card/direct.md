---
title: Swedbank Pay Payments Credit Card Direct
sidebar:
  navigation:
  - title: Credit Card Payments
    items:
    - url: /payments/credit-card/
      title: Introduction
    - url: /payments/credit-card/redirect
      title: Redirect
    - url: /payments/credit-card/direct
      title: Direct
    - url: /payments/credit-card/after-payment
      title: After Payment
    - url: /payments/credit-card/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

{% include alert.html type="warning"
                      icon="error"
                      header="PCI-DSS Complicance"
                      body="The direct integration option requires you to collect the card data on your website, which means it must be [PCI-DSS Compliant][PCI-link]." %}

{% include jumbotron.html body="The Direct Payment scenario **is used by
customers that are compliant with PCI-DSS regulations**, and is a way to
implement card payments without using PayEx Hosted payment pages.  " %}

* The payer places an order and you make a `POST` request towards PayEx with gathered `Purchase` information. The action taken next is the `direct-authorization` operation that is returned in the first request. 
* You `POST` the payer's card data to the URL in the [`direct-authorization` operation](#options-before-posting-a-payment-1).
* If 3D-secure authentication is required, you will then receive a URL where you will have to redirect the payer.
* When the payment is completed, the payer needs to be redirected back to your merchant/webshop site.
* Finally you make a `GET` request towards PayEx with the `paymentID` received in the first step, which will return the purchase result.

### API Requests

The API requests are displayed in the [purchase flow](#purchase-flow-2). The options you can choose from when creating a payment with key `operation` set to Value `Purchase` are listed below. The general REST based API model is described in the [technical reference](#).

#### Options before posting a payment

All valid options when posting in a payment with `operation` equal to `Purchase`, are described in [the technical reference].

##### Type of authorization (Intent).

* **PreAuthorization**: If you specify that the `intent` of the `purchase` is `PreAuthorization`, it's almost the same as an authorization, _except that no money will be reserved_ from the consumers credit card, [before you finalize the transaction][finalize-request]
* **Authorization (two-phase):** If you want the credit card to reserve the amount, you will have to specify that the `intent` of the `purchase` is `Authorization`. The amount will be reserved but not charged. You will later (i.e. when you are ready to ship the purchased products) have to make a [Capture][Capture] or [Cancel][Cancel] request.

##### Type of capture (Intent)

* **AutoCapture (one-phase):** If you want the credit card to be charged right away, you will have to specify that the `intent` of the purchase is `AutoCapture`. The credit card will be charged and you don't need to do any more financial operations to this purchase.

##### General

* **No 3D Secure and card acceptance**: There are optional paramers that can be used in relation to 3d-secure and card acceptance. By default, most credit card agreements with an acquirer will require that you use 3D-Secure for card holder authentication. However, if your agreement allows you to make a card payment without this authentication, or that specific cards can be declined, you may adjust these optional parameters when posting in the payment. This is specified in the technical reference section for creating credit card payments  - you will find the link in the sequence diagram below.
* **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL][CallbackURL] in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here][callback-API-description].

### Purchase flow

The sequence diagram below shows a high level description of a complete purchase, and the requests you have to send to PayEx. The links will take you directly to the corresponding API description.

When dealing with credit card payments, 3D-Secure authentication of the cardholder is an essential topic. There are three alternative outcomes of a credit card payment:

* 3D-Secure enabled - by default, 3D-secure should be enabled, and PayEx will check if the card is enrolled with 3D-secure. This depends on the issuer of the card. If the card is not enrolled with 3D-Secure, no authentication of the cardholder is done.
* Card supports 3D-Secure - if the card is enrolled with 3D-Secure, PayEx will redirect the cardholder to the autentication mechanism that is decided by the issuing bank. Normally this will be done using BankID or Mobile BankID.

```mermaid
sequenceDiagram
  Consumer->Merchant: start purchase
  activate Merchant
  Merchant->PayEx: POST [operation=PURCHASE][purchase-operation-link]
  note left of Merchant: First API request
  activate PayEx
  PayEx-->Merchant: payment resource

  Merchant -> PayEx: POST [Credit card direct authroization][credit-card-auth-direct]
  note left of Merchant: Second API request
  PayEx --> Merchant: transaction resource

  deactivate PayEx
  Merchant-->Consumer: display purchase result
  deactivate Merchant
```

```mermaid
sequenceDiagram
  Consumer->Merchant: start purchase
  activate Merchant
  Merchant->PayEx: POST [purchase-operation-link][purchace-operation-link] [operation=PURCHASE]
  note left of Merchant: First API request
  activate PayEx
  PayEx-->Merchant: payment resource

  Merchant -> PayEx: POST [Direct authorization][direct-authorization-reference]
  note left of Merchant: Second API request
  PayEx --> Merchant: transaction resource\n(operation redirect-authentication for 3DS)

  deactivate PayEx
  Merchant-->Consumer: redirect to 3D-secure page
  deactivate Merchant
  
  note left of Consumer: redirect to card issuing bank
  Consumer -> IssuingBank: 3D-secure authentication
  activate IssuingBank
  IssuingBank-->Consumer: redirect to merchant
  note left of Consumer: redirect back to merchant
  deactivate IssuingBank
  
  Consumer->Merchant: access merchant page
  activate Merchant
  Merchant->PayEx: GET [payments/credit-card/payments][get-payment-response]
  note left of Merchant: Third API request
  activate PayEx
  PayEx-->Merchant: payment resource
  deactivate PayEx
  Merchant-->Consumer: display purchase result
  deactivate Merchant
```

### Options after posting a purchase payment

* If the payment shown above is done as a two-phase (Authorization), you will need to implement the Capture and Cancel requests.
* **Abort:** It is possible to [abort a payment][abort] if the payment has no successful transactions.
* For reversals, you will need to implement the Reversal request.
* If you did a PreAuthorization, you will have to send a Finalize to the transaction using [PATCH on the Authorization][finalizing-the-transaction].
* **Callback from PayEx:** Whenever changes to the payment occur a [Callback request][callback-request] will be posted to the `callbackUrl`, generated when the payment was created.

[abort]: /payments/credit-card/after-payment
[callback-API-description]: #
[callback-request]: /payments/credit-card/after-payment
[CallbackURL]: #
[Cancel]: /payments/credit-card/after-after-payment
[Capture]: /payments/credit-card/after-after-payment
[finalize-request]: /payments/credit-card/after-payment
[finalizing-the-transaction]: /payments/credit-card/after-after-payment
[PCI-link]: https://www.pcisecuritystandards.org/