---
title: Card Payments – Other Features
estimated_read: 30
description: |
  Welcome to Other Features - a subsection of Credit Card.
  This section has extented code examples and features that were not
  covered by the other subsections.
menu_order: 900
---

{% include payment-resource.md api_resource="creditcard"
documentation_section="card" show_status_operations=true %}

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

{% include recur.md documentation_section="card" %}

{% include unscheduled-purchase.md %}

{% include payout.md %}

{% include verify.md %}

{% include one-click-payments.md %}

{% include payment-url.md api_resource="card" documentation_section="card"
when="at the 3-D Secure verification for credit card payments" full_reference=true %}

{% include callback-reference.md api_resource="creditcard" %}

{% include payment-link.md %}

{% include transactions.md api_resource="creditcard" documentation_section="card" %}

{% include card-authorization-transaction.md %}

{% include payee-info.md api_resource="creditcard" documentation_section="card" %}

{% include prices.md %}

{% include 3d-secure-2.md api_resource="creditcard" documentation_section="card" %}

## Co-badge Card Choice for Dankort

Due to new [EU regulations from 2016-06-09][eu-regulation] regarding cards that 
have more than one payment application, we have developed support for the end 
users of Dankort to be able to choose their preferred payment application on the
Swedbank Pay payment page. If you are a Dankort user, read more about this
feature at [Dankort][dankort-eu].

As a merchant you are able to set a priority selection of payment application by
contacting [Swedbank Pay Support][swedbankpay-support]. The end user will always
be able to override this priority selection on the payment page.

If you want more information about Co-badge Card Choice for Dankort users please
contact [Swedbank Pay Support][swedbankpay-support]. The example below shows the
payment window where there payer can choose between Dankort or Visa before
completing the payment.

![Co-badge Dankort cards with option to choose between Dankort and Visa before paying][card-badge]{:height="620px" width="475px"}

{% include metadata.md api_resource="creditcard" %}

{% include settlement-reconciliation.md documentation_section="card" %}

{% include problems/problems.md documentation_section="card" %}

{% include seamless-view-events.md api_resource="creditcard" %}

{% include iterator.html prev_href="after-payment" prev_title="Back: After
payment"  %}

[purchase]: #purchase
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[cancel]: /payments/card/after-payment#cancellations
[capture]: /payments/card/capture
[callback]: /payments/card/other-features#callback
[card-badge]: /assets/img/card-badge.png
[dankort-eu]: https://www.dankort.dk/Pages/Dankort-eller-Visa.aspx
[eu-regulation]: https://ec.europa.eu/commission/presscorner/detail/en/MEMO_16_2162
[mcc]: https://en.wikipedia.org/wiki/Merchant_category_code
[price-resource]: /payments/card/other-features#prices
[redirect]: /payments/card/redirect
[hosted-view]: /payments/card/seamless-view
[one-click-payments]: #one-click-payments
[payee-reference]: #payee-reference
[split-settlement]: #split-settlement
[settlement-and-reconciliation]: #settlement-and-reconciliation
[swedbankpay-support]: https://www.swedbankpay.se/support
[recurrence]: #recur
[verify]: #verify
[payout]: #payout
[card-payment]: /assets/img/payments/card-payment.png
