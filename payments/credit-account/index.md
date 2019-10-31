---
title: Swedbank Pay Payments Credit Account
sidebar:
  navigation:
  - title: Credit Account Payments
    items:
    - url: /payments/credit-account/
      title: Introduction
    - url: /payments/credit-account/after-payment
      title: After Payment
    - url: /payments/credit-account/other-features
      title: Other Features
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
