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
    - url: /payments/mobile-pay/redirect
      title: Mobile Pay Redirect
    - url: /payments/mobile-pay/seamless-view
      title: Mobile Pay Seamless View
    - url: /payments/mobile-pay/after-payment
      title: Mobile Pay After Payment
    - url: /payments/mobile-pay/optional-features
      title: Mobile Pay Optional Features
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/vipps
      title: Vipps Payments
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}




## Payment Link

### Options after posting a payment with Payment Link

*  If the payment enable a two-phase flow (Authorize), you will need to implement the Capture and Cancel requests.
*  It is possible to "abort" the validity of the Payment Link by making a PATCH on the payment. [See the PATCH payment description][technical-reference-abort].
*  For reversals, you will need to implement the Reversal request.
*  If you did a PreAuthorization, you will have to send a Finalize to the transaction using [PATCH on the Authorization][technical-reference-card-payments].
*  When implementing the Payment Link scenario, it is optional to set a CallbackURL in the POST request. If CallbackURL is set PayEx will send a postback request to this URL when the consumer as fulfilled the payment. [See the Callback API description here.][technical-reference-callback]

### Capture Sequence

Capture can only be perfomed on a payment with a successfully authorized transaction. It is possible to do a part-capture where you only capture a smaller amount than the authorized amount. You can later do more captures on the same payment up to the total authorization amount.

```mermaid
sequenceDiagram
  Merchant->PayEx: POST [creditcard captures][credit-card-capture]
  Activate Merchant
  Activate PayEx
  PayEx-->Merchant: transaction resource
  Deactivate PayEx
  Deactivate Merchant
```

### Cancel Sequence

Cancel can only be done on a authorized transaction. If you do cancel after doing a part-capture you will cancel the difference between the captured amount and the authorized amount.

```mermaid
sequenceDiagram
  Merchant->PayEx: POST [creditcard cancellations][credit-card-cancel]
  Activate Merchant
  Activate PayEx
  PayEx-->Merchant: transaction resource
  Deactivate PayEx
  Deactivate Merchant
```

### Reversal Sequence

Reversal can only be done on a payment where there are some captured amount not yet reversed.

```mermaid
sequenceDiagram
  Merchant->PayEx: POST [creditcard reversals][credit-card-reversal]
  Activate Merchant
  Activate PayEx
  PayEx-->Merchant: transaction resource
  Deactivate PayEx
  Deactivate Merchant
```