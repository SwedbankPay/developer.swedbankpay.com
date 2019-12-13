---
title: Swedbank Pay Payments Direct Debit
sidebar:
  navigation:
  - title: Direct Debit Payments
    items:
    - url: /payments/direct-debit
      title: Introduction
    - url: /payments/direct-debit/redirect
      title: Redirect
    - url: /payments/direct-debit/after-payment
      title: After Payment
    - url: /payments/direct-debit/other-features
      title: Other Features
---

{% include alert-development-section.md %}

## Direct Debit Payments

>Swedbank Pay offer Direct Debit bank payments in the Baltics
(Estonia, Latvia and Lithuania).

{:.table .table-striped}
| Country                                                | Supported banks |
| :----------------------------------------------------- | :-------------- |
| ![Estonia](/assets/img/estonia-flag.png) Estonia       | Swedbank        |
| ![Latvia](/assets/img/latvia-flag.png) Latvia          | Swedbank        |
| ![Lithuania](/assets/img/lithuania-flag.png) Lithuania | Swedbank        |

## Introduction

* When the consumer/end-user starts the purchase process in your
  merchant/webshop site, you need to make a `POST` request towards Swedbank Pay
  with your Purchase information. You receive a Redirect URL in return.
* You need to redirect the consumer/end-user's browser to the Redirect URL.
* A bank selection page will be presented to the consumer/end-user.
* The consumer/end-user will be redirect to the choosen bank's login page
  where she have to verify her identity to continue the payment process.
* Swedbank Pay will redirect the consumer/end-user's browser to one of two
  specified URLs, depending on whether the payment session is followed through
  completely or cancelled beforehand.
  Please note that both a successful and rejected payment reach completion,
  in contrast to a cancelled payment.
* When you detect that the consumer/end-user reach your completeUrl,
  you need to do a GET request to receive the state of the transaction.

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).
The options you can choose from when creating a payment with key operation set
to Value Purchase are listed below.

### Type of authorization (Intent)

**Sale**: A direct debit payment will always have intent: Sale, creating a
one-phase sales transaction.

#### General

**Defining CallbackURL**: When implementing a scenario, it is optional to
set a [CallbackURL][callbackurl-reference] in the `POST` request.
If callbackURL is set Swedbank Pay will send a postback request to this URL
when the consumer has fulfilled the payment.

## Purchase flow

The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase.
The links will take you directly to the API
description for the specific request.
The diagram also shows in high level, the sequence of the process of a
complete purchase.

```mermaid
sequenceDiagram
  Consumer->>Merchant: start purchase
  Activate Merchant
  Merchant->>PayEx: POST [directdebit payments] (operation=PURCHASE)
  note left of Merchant: First API request
  Activate PayEx
  PayEx-->>Merchant: payment resource (Rel redirect-sale).
  Deactivate PayEx

  Merchant-->>Consumer: Redirect to bank selection.
  Deactivate Merchant
  note left of Merchant: Redirect to Swedbank Pay Payments.
  Consumer->>PayEx: Select bank
  Activate PayEx

  PayEx-->>Consumer: redirect to bank and customer identification
  note left of PayEx: Redirect to\n the selected bank's identification page.
  Deactivate PayEx

  Consumer->> Bank: Bank identification and confirmation process
  Ban-->>Consumer: Redirect back to payment page

  Consumer->>PayEx: Confirmation status in payment page.
  PayEx-->>Consumer: Redirect back to merchant
  Activate PayEx
  Activate Merchant
  Consumer->>Merchant : Redirect
  note left of Merchant: Second API request
  Merchant->>PayEx: GET [directdebit payments]
  PayEx-->>Merchant: payment resource
  Deactivate PayEx
  Merchant-->>Consumer: Display purchase result
  Deactivate Merchant
```

### Next up

Read how to implement _Direct Debit_ using Redirect next.

{% include iterator.html next_href="redirect"
                         next_title="Next: Implement Redirect" %}

[callbackurl-reference]: /payments/direct-debit/other-features#callback
