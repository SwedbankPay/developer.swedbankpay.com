---
title: Swedbank Pay Payments Swish
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
    - url: /payments/swish/redirect
      title: Swish Redirect
    - url: /payments/swish/seamless-view
      title: Swish Seamless View
    - url: /payments/swish/after-payment
      title: Swish After After Payment
    - url: /payments/swish/optional-features
      title: Swish Optional Features
    - url: /payments/vipps
      title: Vipps Payments
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

                      
## Options after posting a payment

*   **If CallbackURL is set: **Whenever changes to the payment occur a [Callback request][technical-reference-callback] will be posted to the callbackUrl, which was generated when the payment was created.
*   You can create a reversal transactions by implementing the Reversal request. You can also access and reverse a payment through your merchant pages in the [PayEx admin portal][payex-admin-portal].

#### Reversal Sequence

A reversal transcation have to match the Payee reference of a completed sales transaction.

```mermaid
sequenceDiagram
  Merchant->PAYEX: POST [Swish reversals][reversal-reference]
  Activate Merchant
  Activate PAYEX
  PAYEX-->Merchant: transaction resource
  Deactivate PAYEX
  Deactivate Merchant
```

### Capture

Swish does not support Capture

[technical-reference-callback]: #
[payex-admin-portal]: #
[reversal-reference]: #