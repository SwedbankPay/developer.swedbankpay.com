---
title: Swedbank Pay Payments Credit Account
sidebar:
  navigation:
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



> PayEx Credit Account is an online payment instrument allowing payers to split a purchase into several payments.

{% include alert.html type="info"
                      icon="info"
                      body="PayEx Credit Account is only available as a payment instrument in PayEx Checkout and Sweden at the moment." %}

## Sequence with unsigned CreditAccount  
Payment sequence when signing is required.

```mermaid
sequenceDiagram
  Payer -> Merchant: Request purchase
  activate Merchant
  Merchant -> ecomAPI: POST [/psp/creditaccount/payments][payments-post-reference]
  activate ecomAPI
      ecomAPI ->> ecomAPI: validate input
      ecomAPI ->> ecomAPI: get contract
      ecomAPI ->> ecomAPI: get customer (merchant)
      ecomAPI ->> ecomAPI: create payment
      ecomAPI --> Merchant: RedirectURL
  deactivate ecomAPI
  Merchant ->> Payer: Redirect to RedirectURL
  deactivate Merchant

  Payer ->> ecomUI: Access paymentpage
    activate ecomUI
    ecomUI ->> ecomAPI: GET [/psp/creditaccount/payments/][payments-get-reference] (PaymentId retrieved from token)
    activate ecomAPI
    ecomAPI --> ecomUI: Payment response
    deactivate ecomAPI
    Payer --> ecomUI: Payer enter SSN and ZIP
    ecomUI -> ecomAPI: PATCH [/psp/creditaccount/payments/<paymentId>/][payments-patch-reference] (Operation: ConsumerData)
    activate ecomAPI
    ecomAPI -> PxR: GetAddressbyPaymentMethod
    activate PxR
    PxR --> ecomAPI: address response
    deactivate PxR
    ecomAPI --> ecomUI: masked address response
    deactivate ecomAPI

    Payer -> ecomUI: Payer approves address info

    ecomUI -> ecomAPI: POST [/psp/creditaccount/payments/<paymentId>/authorizations][payments-post-authorizations]
    activate ecomAPI
    ecomAPI -> PxR: PurchaseCreditAccountOrder
        activate PxR
        PxR --> ecomAPI: RedirectURL
        deactivate PxR
    ecomAPI --> ecomUI: RedirectUrl
    deactivate ecomAPI

    ecomUI --> Payer: Redirect signing
    deactivate ecomUI
    Payer -> PxR: Access signing page
    activate PxR
    opt Signing
        PxR -> Signing: Request signing
        activate Signing
        Payer -> Signing: Sign with BankId
    Signing-->PxR: Signing OK
    deactivate Signing
    end
    PxR-->Payer: redirect
    deactivate PxR

    Payer -> ecomUI: Access payment page
    activate ecomUI

    ecomUI -> ecomAPI: GET [/psp/creditaccount/payments/][payments-get-reference] (PaymentId retrieved from token)
    activate ecomAPI
    ecomAPI -> PxR: PurchaseCreditAccountStatus
    activate PxR
    PxR --> ecomAPI: Status
    deactivate PxR

    ecomAPI --> ecomUI: CompleteURL
    deactivate ecomAPI
    ecomUI --> Payer: Redirect CompleteURL
    deactivate ecomUI
  Payer -> Merchant: CompleteURL

  activate Merchant
  Merchant -> ecomAPI: GET [payments-get-paymentid][/psp/creditaccount/payments/<paymentId>]
  activate ecomAPI
  ecomAPI --> Merchant: payment resource
  deactivate ecomAPI
  Merchant --> Payer: Display purchase result
  deactivate Merchant
```

## Sequence with signed CreditAccount  
Payment sequence when signing is not required.

```mermaid
sequenceDiagram
  Payer -> Merchant: Request purchase
  activate Merchant
  Merchant -> ecomAPI: POST [/psp/creditaccount/payments][creditaccount-post-payments]
  activate ecomAPI
      ecomAPI -> ecomAPI: validate input
      ecomAPI -> ecomAPI: get contract
      ecomAPI -> ecomAPI: get customer (merchant)
      ecomAPI -> ecomAPI: create payment
      Merchant --> ecomAPI: RedirectURL
  deactivate ecomAPI
  Payer --> Merchant: Redirect to RedirectURL
  deactivate Merchant


  Payer -> ecomUI: Access paymentpage
      activate ecomUI
      ecomUI -> ecomAPI: GET [/psp/creditaccount/payments/][creditaccount-get-payments] (PaymentId retrieved from token)
      activate ecomAPI
      ecomUI --> ecomAPI: Payment response
      deactivate ecomAPI

      Payer -> ecomUI: Payer enter SSN and ZIP

      ecomUI -> ecomAPI: PATCH [/psp/creditaccount/payments/<paymentId>/][creditaccount-patch-payment] (Operation: ConsumerData)
      activate ecomAPI
      ecomAPI -> PxR: GetAddressbyPaymentMethod
      activate PxR
      PxR --> ecomAPI: address response
      deactivate PxR
      ecomAPI --> ecomUI: masked address response
      deactivate ecomAPI

      Payer -> ecomUI: Payer approves address info

      ecomUI -> ecomAPI:  POST [/psp/creditaccount/payments/<paymentId>/authorizations][credditaccount-post-payments]
      activate ecomAPI
      ecomAPI -> PxR: PurchaseCreditAccountOrder
          activate PxR
          PxR --> ecomAPI: Purchase OK
          deactivate PxR
      ecomAPI --> ecomUI: CompleteURL
      deactivate ecomAPI
      ecomUI --> Payer: Redirect to CompleteURL
      deactivate ecomUI
  Payer -> Merchant: CompleteURL

  activate Merchant
  Merchant -> ecomAPI: GET [/psp/creditaccount/payments/<paymentId>][creditaccount-get-paymentId]
  activate ecomAPI
  ecomAPI --> Merchant: Payment resource
  deactivate ecomAPI
  Merchant --> Payer: Display purchase result
  deactivate Merchant
```

[payments-post-reference]: #
[payments-get-reference]: #
[payments-patch-reference]: #
[payments-post-authorizations]: #
[payments-get-paymentid]: #
[creditaccount-post-payments]: #
[creditaccount-get-payments]: #
[creditaccount-patch-payment]: #
[creditaccount-get-paymentId]: #
