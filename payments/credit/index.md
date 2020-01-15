---
title: Swedbank Pay Credit Payments
sidebar:
  navigation:
  - title: Credit Payments
    items:
    - url: /payments/credit/
      title: Introduction
    - url: /payments/credit/redirect
      title: Redirect
    - url: /payments/credit/after-payment
      title: After Payment
    - url: /payments/credit/other-features
      title: Other Features
---

{% include alert-review-section.md %}

> Swedbank Pay Credit Account is an online payment instrument allowing payers
> to split a purchase into several payments.

{% include alert.html type="info"
                      icon="info"
                      body="Swedbank Pay Credit Account is only available as a
                      payment instrument in Swedbank Pay Checkout and Sweden
                      at the moment." %}

## Sequence with unsigned CreditAccount

Payment sequence when signing is required.

```mermaid
sequenceDiagram
  Payer ->> Merchant: Request purchase
  activate Merchant
  Merchant ->> ecomAPI: POST </psp/creditaccount/payments>
  activate ecomAPI
      ecomAPI ->> ecomAPI: validate input
      ecomAPI ->> ecomAPI: get contract
      ecomAPI ->> ecomAPI: get customer (merchant)
      ecomAPI ->> ecomAPI: create payment
      ecomAPI -->> Merchant: RedirectURL
  deactivate ecomAPI
  Merchant ->> Payer: Redirect to RedirectURL
  deactivate Merchant

  Payer ->> ecomUI: Access paymentpage
    activate ecomUI
    ecomUI ->> ecomAPI: GET </psp/creditaccount/payments/> (PaymentId retrieved from token)
    activate ecomAPI
    ecomAPI -->> ecomUI: Payment response
    deactivate ecomAPI
    Payer -->> ecomUI: Payer enter SSN and ZIP
    ecomUI ->> ecomAPI: PATCH </psp/creditaccount/payments/<paymentId>/> (Operation: ConsumerData)
    activate ecomAPI
    ecomAPI ->> PxR: GetAddressbyPaymentMethod
    activate PxR
    PxR -->> ecomAPI: address response
    deactivate PxR
    ecomAPI -->> ecomUI: masked address response
    deactivate ecomAPI

    Payer ->> ecomUI: Payer approves address info

    ecomUI ->> ecomAPI: POST </psp/creditaccount/payments/<paymentId>/authorizations>
    activate ecomAPI
    ecomAPI ->> PxR: PurchaseCreditAccountOrder
        activate PxR
        PxR -->> ecomAPI: RedirectURL
        deactivate PxR
    ecomAPI -->> ecomUI: RedirectUrl
    deactivate ecomAPI

    ecomUI -->> Payer: Redirect signing
    deactivate ecomUI
    Payer ->> PxR: Access signing page
    activate PxR
    opt Signing
        PxR ->> Signing: Request signing
        activate Signing
        Payer ->> Signing: Sign with BankId
    Signing-->PxR: Signing OK
    deactivate Signing
    end
    PxR-->Payer: redirect
    deactivate PxR

    Payer ->> ecomUI: Access payment page
    activate ecomUI

    ecomUI ->> ecomAPI: GET </psp/creditaccount/payments/> (PaymentId retrieved from token)
    activate ecomAPI
    ecomAPI ->> PxR: PurchaseCreditAccountStatus
    activate PxR
    PxR -->> ecomAPI: Status
    deactivate PxR

    ecomAPI -->> ecomUI: CompleteURL
    deactivate ecomAPI
    ecomUI -->> Payer: Redirect CompleteURL
    deactivate ecomUI
  Payer ->> Merchant: CompleteURL

  activate Merchant
  Merchant ->> ecomAPI: GET </psp/creditaccount/payments/<paymentId>/>
  activate ecomAPI
  ecomAPI -->> Merchant: payment resource
  deactivate ecomAPI
  Merchant -->> Payer: Display purchase result
  deactivate Merchant
```

## Sequence with signed CreditAccount

Payment sequence when signing is not required.

```mermaid
sequenceDiagram
  Payer ->> Merchant: Request purchase
  activate Merchant
  Merchant ->> ecomAPI: POST </psp/creditaccount/payments>
  activate ecomAPI
      ecomAPI ->> ecomAPI: validate input
      ecomAPI ->> ecomAPI: get contract
      ecomAPI ->> ecomAPI: get customer (merchant)
      ecomAPI ->> ecomAPI: create payment
      Merchant -->> ecomAPI: RedirectURL
  deactivate ecomAPI
  Payer -->> Merchant: Redirect to RedirectURL
  deactivate Merchant


  Payer ->> ecomUI: Access paymentpage
      activate ecomUI
      ecomUI ->> ecomAPI: GET </psp/creditaccount/payments/> (PaymentId retrieved from token)
      activate ecomAPI
      ecomUI -->> ecomAPI: Payment response
      deactivate ecomAPI

      Payer ->> ecomUI: Payer enter SSN and ZIP

      ecomUI ->> ecomAPI: PATCH </psp/creditaccount/payments/<paymentId>/> (Operation: ConsumerData)
      activate ecomAPI
      ecomAPI ->> PxR: GetAddressbyPaymentMethod
      activate PxR
      PxR -->> ecomAPI: address response
      deactivate PxR
      ecomAPI -->> ecomUI: masked address response
      deactivate ecomAPI

      Payer ->> ecomUI: Payer approves address info

      ecomUI ->> ecomAPI:  POST </psp/creditaccount/payments/<paymentId>/authorizations>
      activate ecomAPI
      ecomAPI ->> PxR: PurchaseCreditAccountOrder
          activate PxR
          PxR -->> ecomAPI: Purchase OK
          deactivate PxR
      ecomAPI -->> ecomUI: CompleteURL
      deactivate ecomAPI
      ecomUI -->> Payer: Redirect to CompleteURL
      deactivate ecomUI
  Payer ->> Merchant: CompleteURL

  activate Merchant
  Merchant ->> ecomAPI: GET </psp/creditaccount/payments/<paymentId>>
  activate ecomAPI
  ecomAPI -->> Merchant: Payment resource
  deactivate ecomAPI
  Merchant -->> Payer: Display purchase result
  deactivate Merchant
```

{% include iterator.html
        prev_href="../"
        prev_title="Back: Payments"
        next_href="after-payment"
        next_title="Next: After Payment" %}
