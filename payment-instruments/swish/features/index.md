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
- title: Cancel
  description: Cancelling the authorization and releasing the funds
  url: /payment-instruments/swish/features/core-features/cancel
  icon:
    content: pan_tool
    outlined: true
- title: Capture
  description: Capturing the authorized funds
  url: /payment-instruments/swish/features/core-features/capture
  icon:
    content: compare_arrows
    outlined: true
- title: Reversal
  description: How to reverse a payment
  url: /payment-instruments/swish/features/core-features/reversal
  icon:
    content: keyboard_return
    outlined: true
- title: Settlement & Reconciliation
  description: Balancing the books
  url:  /payment-instruments/swish/features/core-features/settlement-reconciliation
  icon:
    content: description
    outlined: true
card_list_2:
- title: Callback
  description: Getting updates about payment or transaction changes
  url:  /payment-instruments/swish/features/technical-reference/callback-reference
  icon:
    content: low_priority
    outlined: true
- title: CompleteUrl
  description: Where you go when the payment is completed
  url:  /payment-instruments/swish/features/technical-reference/complete-url
  icon:
    content: link
    outlined: true
- title: Description
  description: The purchase summed up in a few words
  url:  /payment-instruments/swish/features/technical-reference/description
  icon:
    content: assignment
    outlined: true
- title: Metadata
  description: Store payment associated data for later use
  url:  /payment-instruments/swish/features/technical-reference/metadata
  icon:
    content: code
    outlined: true
- title: PayeeInfo
  description: Payment specific merchant information
  url:  /payment-instruments/swish/features/technical-reference/payee-info
  icon:
    content: account_box
    outlined: true
- title: PayeeReference
  description: The merchant's reference for a specific payment
  url:  /payment-instruments/swish/features/technical-reference/payee-reference
  icon:
    content: assignment_ind
    outlined: true
- title: PaymentUrl
  description: Redirecting the payer back to your site
  url:  /payment-instruments/swish/features/technical-reference/payment-url
  icon:
    content: link
    outlined: true
- title: Prices
  description: The payment's prices resource
  url:  /payment-instruments/swish/features/technical-reference/prices
  icon:
    content: attach_money
    outlined: true
- title: Problems
  description: Information when something goes wrong
  url:  /payment-instruments/swish/features/technical-reference/problems
  icon:
    content: report
    outlined: true
- title: Seamless View Events
  description: Possible events during Seamless View payments
  url:  /payment-instruments/swish/features/technical-reference/seamless-view-events
  icon:
    content: event
    outlined: true
card_list_3: 
- title: Recur
  description: Setting up subscriptions and recurring payments
  url:  /payment-instruments/swish/features/optional-features/recur
  icon:
    content: cached
    outlined: true
---

{:.heading-line}

// Core Features

{% include card-list.html card_list=page.card_list
    col_class="col-lg-4" %}

// Technical Reference

{% include card-list.html card_list=page.card_list_2
    col_class="col-lg-4" %}

// Optional Features

{% include card-list.html card_list=page.card_list_3
    col_class="col-lg-4" %}
