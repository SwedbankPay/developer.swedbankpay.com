---
title: Swedbank Pay Payments Mobile Pay Other Features
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

{% include settlement-reconciliation.md %}

{% include one-click-payments.md %}

{% include payment-link.md %}

{% include recurring-card-payments.md %}

{% include subsite.md %}