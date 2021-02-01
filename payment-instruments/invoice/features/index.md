---
title: Features
redirect_from: /payment-instruments/invoice/other-features
card_overview: true
description: |
  In this section you can read more about the different features of Invoice.
icon:
  content: remove_red_eye
additional: true
menu_order: 1000
card_list:
- title: Abort
  description: Aborting a created payment
  url: /payment-instruments/invoice/features/core/abort-reference
  icon:
    content: pan_tool
    outlined: true
- title: Cancel
  description: Cancelling the authorization and releasing the funds
  url: /payment-instruments/invoice/features/core/cancel
  icon:
    content: pan_tool
    outlined: true
- title: Capture
  description: Capturing the authorized funds
  url: /payment-instruments/invoice/features/core/capture
  icon:
    content: compare_arrows
    outlined: true
- title: Payment Resource
  description: When initiating a payment process
  url: /payment-instruments/invoice/features/core/payment-resource
  icon:
    content: credit_card
    outlined: true
- title: Reversal
  description: How to reverse a payment
  url: /payment-instruments/invoice/features/core/reversal
  icon:
    content: keyboard_return
    outlined: true
- title: Settlement & Reconciliation
  description: Balancing the books
  url:  /payment-instruments/invoice/features/core/settlement-reconciliation
  icon:
    content: description
    outlined: true
card_list_2:
- title: Callback
  description: Getting updates about payment or transaction changes
  url:  /payment-instruments/invoice/features/technical-reference/callback
  icon:
    content: low_priority
    outlined: true
- title: CompleteUrl
  description: Where you go when the payment is completed
  url:  /payment-instruments/invoice/features/technical-reference/complete-url
  icon:
    content: link
    outlined: true
- title: Create Payment
  description: When initiating a payment process
  url: /payment-instruments/invoice/features/technical-reference/create-payment
  icon:
    content: credit_card
    outlined: true
- title: Delete Token
  description: How to delete tokens
  url:  /payment-instruments/invoice/features/technical-reference/delete-token
  icon:
    content: assignment
    outlined: true
- title: Description
  description: The purchase summed up in a few words
  url:  /payment-instruments/invoice/features/technical-reference/description
  icon:
    content: assignment
    outlined: true
- title: Metadata
  description: Store payment associated data for later use
  url:  /payment-instruments/invoice/features/technical-reference/metadata
  icon:
    content: code
    outlined: true
- title: Operations
  description: The operations of the payments
  url:  /payment-instruments/invoice/features/technical-reference/operations
  icon:
    content: shopping_basket
    outlined: true
- title: PayeeInfo
  description: Payment specific merchant information
  url:  /payment-instruments/invoice/features/technical-reference/payee-info
  icon:
    content: account_box
    outlined: true
- title: PayeeReference
  description: The merchant's reference for a specific payment
  url:  /payment-instruments/invoice/features/technical-reference/payee-reference
  icon:
    content: assignment_ind
    outlined: true
- title: Payment State
  description: Different states in the payment process
  url: /payment-instruments/invoice/features/technical-reference/payment-state
  icon:
    content: credit_card
    outlined: true
- title: Payment & Transactions States
  description: Possible states of the payments and transactions
  url:  /payment-instruments/invoice/features/technical-reference/payment-transaction-states
  icon:
    content: hdr_weak
- title: PaymentUrl
  description: Redirecting the payer back to your site
  url:  /payment-instruments/invoice/features/technical-reference/payment-url
  icon:
    content: link
    outlined: true
- title: Prices
  description: The payment's prices resource
  url:  /payment-instruments/invoice/features/technical-reference/prices
  icon:
    content: attach_money
    outlined: true
- title: Problems
  description: Information when something goes wrong
  url:  /payment-instruments/invoice/features/technical-reference/problems
  icon:
    content: report
    outlined: true
- title: Seamless View Events
  description: Possible events during Seamless View payments
  url:  /payment-instruments/invoice/features/technical-reference/seamless-view-events
  icon:
    content: event
    outlined: true
- title: Transactions
  description: The transactions making up a specific payment
  url:  /payment-instruments/invoice/features/technical-reference/transactions
  icon:
    content: done_all
    outlined: true
card_list_3:
- title: Payment Link
  description: Sending the payment via mail or SMS
  url:  /payment-instruments/invoice/features/optional/payment-link
  icon:
    content: link
    outlined: true
- title: Recur
  description: Setting up subscriptions and recurring payments
  url:  /payment-instruments/invoice/features/optional/recur
  icon:
    content: cached
    outlined: true
- title: Verify
  description: Validating the payer's payment details
  url:  /payment-instruments/invoice/features/optional/verify
  icon:
    content: verified_user
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
