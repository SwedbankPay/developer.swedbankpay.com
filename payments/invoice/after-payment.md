---
title: Swedbank Pay Payments Invoice After Payments
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
    - url: /payments/invoice/redirect
      title: Invoice Payments Redirect
    - url: /payments/invoice/seamless-view
      title: Invoice Payments Seamless View
    - url: /payments/invoice/after-payment
      title: Invoice Payments After Payment
    - url: /payments/invoice/optional-features
      title: Invoice Payments Optional Features
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


## Options after posting a payment

*   **Abort:** It is possible to abort the process, if the payment has no successful transactions. [See the PATCH payment description][see-the-PATCH-payment-description].
*   You must always follow up an Invoice Authorization with a Capture or Cancel request.
*   For reversals, you will need to implement the Reversal request.
*   **If CallbackURL is set:** Whenever changes to the payment occur a [Callback request][callback-request] will be posted to the callbackUrl, which was generated when the payment was created.

### Capture Sequence

[Capture] can only be done on a successfully authorized transaction. It is possible to do a part-capture where you only capture a part of the authorization amount. You can later do more captures on the same payment up to the total authorization amount.


```mermaid
sequenceDiagram

Merchant->>PayEx: Post [Invoice captures][invoice-captures]
Activate Merchant
Activate PayEx
PayEx-->>Merchant: transaction resource
Deactivate Merchant
Deactivate PayEx
```

### Cancel Sequence

[Cancel] can only be done on a successfully authorized transaction, not yet captured. If you do cancel after doing a part-capture you will cancel the not yet captured amount only.


```mermaid
sequenceDiagram
Merchant->>PayEx: Post [Invoice cancellations][invoice-cancellations]
Activate Merchant
Activate PayEx
PayEx-->>Merchant: transaction resource
Deactivate Merchant
Deactivate PayEx
```

### Reversal Sequence

[Reversal] can only be done on an captured transaction where there are some captured amount not yet reversed.


```mermaid
sequenceDiagram
Merchant->>PayEx: Post [Invoice reversals][invoice-reversals]
Activate Merchant
Activate PayEx
PayEx-->>Merchant: transaction resource
Deactivate Merchant
Deactivate PayEx
```




----------------------------------------------------------
[see-the-PATCH-payment-description]: /payments/credit-card/after-payment
[callback-url]: #
[callback-api]: #
[callback-request]: #
[invoice-captures]: #
[invoice-cancellations]: #
[invoice-reversals]: #