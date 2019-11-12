---
title: Swedbank Pay Payments Direct Debit After Payment
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


## Options after posting a payment

* **Abort:** It is possible to 
  [abort a payment][technical-reference-abort-payment] if the payment has no 
  successful transactions.
* For reversals, you will need to implement the Reversal request.
* **If CallbackURL is set:** Whenever changes to the payment occur a 
  [Callback request][technical-reference-callbackurl] will be posted to the 
  [CallbackURL][callbackurl-reference], which was generated when the payment 
  was created.

### Reversal Sequence

Reversal can only be done on a payment where there are some captured amount 
not yet reversed.

```mermaid
sequenceDiagram
  Participant PayEx
  Merchant->>PayEx: POST <direct debit reversal>
  Activate Merchant
  Activate PayEx
  PayEx-->>Merchant: transaction resource
  Deactivate PayEx
  Deactivate Merchant
```

{% include iterator.html next_href="other-features"
                         next_title="Next: Other Features" 
                         prev_href="redirect"
                         prev_title="Back: Redirect" %}

[callbackurl-reference]: #
[direct-debit-payment-post-reversal]: #
[direct-debit-technical-reference]: #
[technical-reference-abort-payment]: #
[technical-reference-callbackurl]: #
[technical-reference-create-direct-debit]: #
[technical-reference-expansion]: #
[technical-reference-payeereference]: #
[technical-reference-price-object]: #
[technical-reference-transactions]: #
[technical-reference]: #
[user-agent]: https://en.wikipedia.org/wiki/User_agent
