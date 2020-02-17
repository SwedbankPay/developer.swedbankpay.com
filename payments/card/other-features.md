---
title: Swedbank Pay Card Payments – Other Features
sidebar:
  navigation:
  - title: Card Payments
    items:
    - url: /payments/card/
      title: Introduction
    - url: /payments/card/redirect
      title: Redirect
    - url: /payments/card/seamless-view
      title: Seamless View
    - url: /payments/card/direct
      title: Direct
    - url: /payments/card/after-payment
      title: After Payment
    - url: /payments/card/other-features
      title: Other Features
---

{% include jumbotron.html body="Welcome to Other Features - a subsection of
Credit Card. This section has extented code examples and features that were not
covered by the other subsections." %}

{% include payment-resource.md show_status_operations=true %}

{% include payment-transaction-states.md %}

{% include create-payment.md %}

## Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a `capture`, `cancellation` or `reversal` transaction.

An example of a request is provided below. Each individual Property of the JSON
document is described in the following section.

{% include alert-risk-indicator.md %}

{% include card-purchase.md full_reference=true %}

{% include recur.md %}

{% include unscheduled-purchase.md %}

{% include payout.md %}

{% include verify.md %}

{% include one-click-payments.md %}

{% include callback-reference.md payment_instrument="creditcard" %}

{% include payment-link.md %}

{% include payee-info.md payment_instrument="creditcard" %}

{% include prices.md %}

{% include settlement-reconciliation.md %}

{% include card-problem-messages.md %}

{% include iterator.html prev_href="after-payment" prev_title="Back: After
payment"  %}

[purchase]: #purchase
[user-agent-definition]: https://en.wikipedia.org/wiki/User_agent
[cancel]: /payments/card/after-payment#cancellations
[capture]: /payments/card/after-payment#Capture
[callback]: /payments/card/other-features#callback
[mcc]: https://en.wikipedia.org/wiki/Merchant_category_code
[price-resource]: /payments/card/other-features#prices
[redirect]: /payments/card/redirect
[hosted-view]: /payments/card/seamless-view
[one-click-payments]: #one-click-payments
[split-settlement]: #split-settlement
[settlement-and-reconciliation]: #settlement-and-reconciliation
[recurrence]: #recur
[verify]: #verify
[payout]: #payout
[card-payment]: /assets/img/payments/card-payment.png
