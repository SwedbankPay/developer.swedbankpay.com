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
  description: Authenticating the cardholder
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
  description: Balancing the books
  url:  /features/core-features#settlement-and-reconciliation
  icon:
    content: description
    outlined: true
card_list_2:
- title: Callback
  description: Getting updates about payment or transaction changes
  url:  /features/technical-references#callback
  icon:
    content: construction
    outlined: true
- title: Card authorization transaction
  description: Information about the payment's authorization(s)
  url:  /features/technical-references#card-authorization-transaction
  icon:
    content: construction
    outlined: true
- title: CompleteUrl
  description: Where you go when the payment is completed
  url:  /features/technical-references#completeurl
  icon:
    content: attach_money
    outlined: true
- title: Create Payment
  description: Creating the payment
  url:  /features/technical-references#create-payment
  icon:
    content: shopping_basket
    outlined: true
- title: Description
  description: The purchase summed up in a few words
  url:  /features/technical-references#description
  icon:
    content: construction
    outlined: true
- title: Metadata
  description: Store payment associated data for later use
  url:  /features/technical-references#metadata
  icon:
    content: construction
    outlined: true
- title: PayeeInfo
  description: Payment specific merchant information
  url:  /features/technical-references#payeeinfo
  icon:
    content: construction
    outlined: true
- title: PayeeReference
  description: The merchant's reference for a specific payment
  url:  /features/technical-references#payee-reference
  icon:
    content: construction
    outlined: true
- title: Payment & Transactions States
  description: Possible states of the payments and transactions
  url:  /features/technical-references#payment-and-transaction-states
  icon:
    content: http
- title: PaymentUrl
  description: Redirecting the payer back to your site
  url:  /features/technical-references#payment-url
  icon:
    content: undo
    outlined: true
- title: Prices
  description: The payment's prices resource
  url:  /features/technical-references#prices
  icon:
    content: construction
    outlined: true
- title: Problems
  description: Information when something goes wrong
  url:  /features/technical-references#problems
  icon:
    content: construction
    outlined: true
- title: Purchase
  description: The bread and butter of the payments
  url:  /features/technical-references#purchase
  icon:
    content: settings
    outlined: true
- title: Seamless View Events
  description: Possible events during Seamless View payments
  url:  /features/technical-references#seamless-view-events
  icon:
    content: construction
    outlined: true
- title: Transactions
  description: The transactions making up a specific payment
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
  description: Prefilling the payment details using payment tokens
  url:  /features/optional-features#one-click-payments
  icon:
    content: construction
    outlined: true
- title: Payment Link
  description: Sending the payment via mail or SMS
  url:  /features/optional-features#payment-link
  icon:
    content: construction
    outlined: true
- title: Payout
  description: Making deposits to payers' cards
  url:  /features/optional-features#payout
  icon:
    content: construction
    outlined: true
- title: Recur
  description: Setting up subscriptions and recurring payments
  url:  /features/optional-features#recur
  icon:
    content: construction
    outlined: true
- title: Unscheduled Purchase
  description: Merchant initiated transactions with absent cardholders
  url:  /features/optional-features#unscheduled-purchase
  icon:
    content: construction
    outlined: true
- title: Verify
  description: Validating the payer's payment details
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
