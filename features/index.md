---
title: Introduction
redirect_from:
estimated_read: 30
description: |
  Welcome to Other Features - a subsection of Credit Card.
  This section has extented code examples and features that were not
  covered by the other subsections.
menu_order: 1000
---

{% include payments-operations.md api_resource="creditcard" documentation_section="card" %}

{% include payment-transaction-states.md %}

{% include create-payment.md %}

## Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a `capture`, `cancellation` or `reversal` transaction.

An example of a request is provided below. Each individual field of the JSON
document is described in the following section.

{% include alert-risk-indicator.md %}

{% include card-purchase.md full_reference=true %}

{% include complete-url.md %}

{% include description.md api_resource="creditcard" %}

{% include payment-url.md api_resource="card" documentation_section="card"
when="at the 3-D Secure verification for credit card payments" full_reference=true %}

{% include callback-reference.md api_resource="creditcard" %}

{% include transactions.md api_resource="creditcard" documentation_section="card" %}

{% include card-authorization-transaction.md %}

{% include payee-info.md api_resource="creditcard" documentation_section="card" %}

{% include prices.md %}

{% include moto.md api_resource="creditcard" %}

{% include metadata.md api_resource="creditcard" %}

{% include problems/problems.md documentation_section="card" %}

{% include seamless-view-events.md api_resource="creditcard" %}

{% include iterator.html prev_href="after-payment" prev_title="Back: After
payment"  %}

[purchase]: #purchase
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[cancel]: /payment-instruments/card/after-payment#cancellations
[capture]: /payment-instruments/card/capture
[callback]: /payment-instruments/card/other-features#callback
[card-badge]: /assets/img/card-badge.png
[dankort-eu]: https://www.dankort.dk/Pages/Dankort-eller-Visa.aspx
[eu-regulation]: https://ec.europa.eu/commission/presscorner/detail/en/MEMO_16_2162
[mcc]: https://en.wikipedia.org/wiki/Merchant_category_code
[price-resource]: /payment-instruments/card/other-features#prices
[redirect]: /payment-instruments/card/redirect
[hosted-view]: /payment-instruments/card/seamless-view
[one-click-payments]: #one-click-payments
[payee-reference]: #payee-reference
[split-settlement]: #split-settlement
[settlement-and-reconciliation]: #settlement-and-reconciliation
[swedbankpay-support]: https://www.swedbankpay.se/support
[recurrence]: #recur
[verify]: #verify
[payout]: #payout
[card-payment]: /assets/img/payments/card-payment.png
