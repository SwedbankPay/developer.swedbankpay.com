---
title: Other Features
redirect_from: /payments/card/other-features
estimated_read: 90
description: |
  Welcome to Other Features - a subsection of Credit Card.
  This section has extented code examples and features that were not
  covered by the other subsections.
menu_order: 1000
---

{% include payment-resource.md show_status_operations=true %}

{% include payments-operations.md %}

{% include payment-transaction-states.md %}

{% include payment-state.md %}

{% include create-payment.md %}

## Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a `capture`, `cancellation` or `reversal` transaction.

An example of a request is provided below. Each individual field of the JSON
document is described in the following section.

{% include alert-risk-indicator.md %}

{% include card-purchase.md full_reference=true %}

{% include complete-url.md %}

{% include description.md %}

{% include recur.md %}

{% include unscheduled-purchase.md %}

{% include payout.md %}

{% include verify.md %}

{% include one-click-payments.md %}

{% include moto.md %}

{% include payment-url.md full_reference=true when="at the 3-D Secure
verification for credit card payments" %}

{% include callback-reference.md %}

{% include payment-link.md %}

{% include transactions.md %}

{% include card-authorization-transaction.md %}

{% include payee-info.md %}

{% include prices.md %}

{% include transaction-on-file.md %}

{% include 3d-secure-2.md %}

## Co-badge Card Choice for Dankort

Due to new [EU regulations from 2016-06-09][eu-regulation] regarding cards that
have more than one payment application, we have developed support for the end
users of Dankort to be able to choose their preferred payment application on the
Swedbank Pay payment page. If you are a Dankort user, read more about this
feature at [Dankort][dankort-eu].

As a merchant you can set a priority selection of payment application by
contacting [Swedbank Pay Support][swedbankpay-support]. The payer will always
be able to override this priority selection on the payment page.

If you want more information about Co-badge Card Choice for Dankort users,
please contact [Swedbank Pay Support][swedbankpay-support]. The example below
shows the payment window where the payer can choose between Dankort or Visa
before completing the payment.

![Co-badge Dankort cards with option to choose between Dankort and Visa before paying][card-badge]{:height="620px" width="475px"}

{% include metadata.md %}

{% include settlement-reconciliation.md %}

{% include problems/problems.md %}

{% include seamless-view-events.md %}

{% include iterator.html prev_href="after-payment" prev_title="After
payment" %}

[callback]: /payment-instruments/card/other-features#callback
[cancel]: /payment-instruments/card/after-payment#cancellations
[capture]: /payment-instruments/card/capture
[card-badge]: /assets/img/card-badge.png
[card-payment]: /assets/img/payments/card-payment.png
[dankort-eu]: https://www.dankort.dk/Pages/Dankort-eller-Visa.aspx
[eu-regulation]: https://ec.europa.eu/commission/presscorner/detail/en/MEMO_16_2162
[hosted-view]: /payment-instruments/card/seamless-view
[mcc]: https://en.wikipedia.org/wiki/Merchant_category_code
[one-click-payments]: #one-click-payments
[payee-reference]: #payee-reference
[payout]: #payout
[price-resource]: /payment-instruments/card/other-features#prices
[purchase]: #purchase
[recurrence]: #recur
[redirect]: /payment-instruments/card/redirect
[settlement-and-reconciliation]: #settlement-and-reconciliation
[split-settlement]: #split-settlement
[swedbankpay-support]: https://www.swedbankpay.se/support
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[verify]: #verify
