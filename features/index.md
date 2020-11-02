---
title: Features
estimated_read: 10
card_overview: true
description: |
    In this section you find various resources for Swedbank Pay’s API Platform.
icon:
  content: remove_red_eye
additional: true
menu_order: 1000
card_list: 
- title: 3D Secure 2
  description: Initialize payment process containing the order
  url:  /features/core-features#3-d-secure-2
  icon:
    content: autorenew
- title: Payment resource
  description: When initiating a payment process
  url: /features/core-features#payment-resouce
  icon:
    content: view_list
    outlined: true
- title: Settlement & Reconciliation
  description: Initialize payment process containing the order
  url:  /features/core-features#settlement-and-reconciliation
  icon:
    content: description
    outlined: true
card_list_2:
- title: Callback
  description: Initialize payment process containing the order
  url:  /features/technical-references#callback
  icon:
    content: undo
    outlined: true
- title: Card authorization transaction
  description: Initialize payment process containing the order
  url:  /features/technical-references#card-authorization-transaction
  icon:
    content: construction
    outlined: true
- title: CompleteUrl
  description: Initialize payment process containing the order
  url:  /features/technical-references#completeurl
  icon:
    content: 
    outlined: true
- title: Create Payment
  description: Initialize payment process containing the order
  url:  /features/technical-references#create-payment
  icon:
    content: shopping_basket
    outlined: true
- title: Description
  description: Initialize payment process containing the order
  url:  /features/technical-references#description
  icon:
    content: description
    outlined: true
- title: Metadata
  description: Initialize payment process containing the order
  url:  /features/technical-references#metadata
  icon:
    content: construction
    outlined: true
- title: PayeeInfo
  description: Initialize payment process containing the order
  url:  /features/technical-references#payeeinfo
  icon:
    content: account_box
    outlined: true
- title: PayeeReference
  description: Initialize payment process containing the order
  url:  /features/technical-references#payee-reference
  icon:
    content: construction
    outlined: true
- title: Payment & Transactions States
  description: Initialize payment process containing the order
  url:  /features/technical-references#payment-and-transaction-states
  icon:
    content: http
- title: PaymentUrl
  description: Initialize payment process containing the order
  url:  /features/technical-references#payment-url
  icon:
    content: 
    outlined: true
- title: Prices
  description: Initialize payment process containing the order
  url:  /features/technical-references#prices
  icon: 
    content: attach_money
    outlined: true
- title: Problems
  description: Initialize payment process containing the order
  url:  /features/technical-references#problems
  icon:
    content: report_problems
    outlined: true
- title: Purchase
  description: Initialize payment process containing the order
  url:  /features/technical-references#purchase
  icon:
    content: shopping_basket
    outlined: true
- title: Seamless View Events
  description: Initialize payment process containing the order
  url:  /features/technical-references#seamless-view-events
  icon:
    content: construction
    outlined: true
- title: Transactions
  description: Initialize payment process containing the order
  url:  /features/technical-references#transactions
  icon:
    content: construction
    outlined: true
card_list_3: 
- title: Co-badge Card Choice for Dankort
  description: Initialize payment process containing the order
  url:  /features/optional-features#co-badge-card-choice-for-dankort
  icon:
    content: construction
    outlined: true
- title: MOTO
  description: Initialize payment process containing the order
  url:  /features/optional-features#moto
  icon:
    content: construction
    outlined: true
- title: One-Click Payments
  description: Initialize payment process containing the order
  url:  /features/optional-features#one-click-payments
  icon:
    content: construction
    outlined: true
- title: Payment Link
  description: Initialize payment process containing the order
  url:  /features/optional-features#payment-link
  icon:
    content: construction
    outlined: true
- title: Payout
  description: Initialize payment process containing the order
  url:  /features/optional-features#payout
  icon:
    content: construction
    outlined: true
- title: Recur
  description: Initialize payment process containing the order
  url:  /features/optional-features#recur
  icon:
    content: construction
    outlined: true
- title: Unscheduled Purchase
  description: Initialize payment process containing the order
  url:  /features/optional-features#unscheduled-purchase
  icon:
    content: construction
    outlined: true
- title: Verify
  description: Initialize payment process containing the order
  url:  /features/optional-features#verify
  icon:
    content: construction
    outlined: true
---

{:.heading-line}

## Core Features

{% include card-list.html card_list=page.card_list
    col_class="col-lg-4" %}

## Technical Reference

{% include card-list.html card_list=page.card_list_2
    col_class="col-lg-4" %}

## Optional Features

{% include card-list.html card_list=page.card_list_3
    col_class="col-lg-4" %}

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
