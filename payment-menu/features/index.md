---
title: Features
redirect_from: /payment-menu/other-features
card_overview: true
description: |
  In this section you can read more about the different features of the
  Swedbank Pay Payment Menu.
permalink: /:path/
icon:
  content: remove_red_eye
additional: true
menu_order: 1000
card_list:
- title: 3-D Secure 2
  description: Authenticating the cardholder
  url:  /payment-menu/features/core/3d-secure-2
  icon:
    content: 3d_rotation
- title: Abort
  description: Aborting a created payment
  url: /payment-menu/features/core/payment-order-abort
  icon:
    content: pan_tool
    outlined: true
- title: Cancel
  description: Cancelling the authorization and releasing the funds
  url: /payment-menu/features/core/cancel
  icon:
    content: pan_tool
    outlined: true
- title: Capture
  description: Capturing the authorized funds
  url: /payment-menu/features/core/payment-order-capture
  icon:
    content: compare_arrows
    outlined: true
- title: Payment Order
  description: Creating the payment order
  url:  /payment-menu/features/core/payment-order
  icon:
    content: credit_card
    outlined: true
- title: Reversal
  description: How to reverse a payment
  url: /payment-menu/features/core/reversal
  icon:
    content: keyboard_return
    outlined: true
- title: Settlement & Reconciliation
  description: Balancing the books
  url:  /payment-menu/features/core/settlement-reconciliation
  icon:
    content: description
    outlined: true
- title: Update Payment Order
  description: Updating the payment order
  url:  /payment-menu/features/core/update-payment-order
  icon:
    content: cached
    outlined: true
card_list_2:
- title: Callback
  description: Getting updates about payment or transaction changes
  url:  /payment-menu/features/technical-reference/callback
  icon:
    content: low_priority
    outlined: true
- title: CompleteUrl
  description: Where you go when the payment is completed
  url:  /payment-menu/features/technical-reference/complete-url
  icon:
    content: link
    outlined: true
- title: Delete Token
  description: How to delete tokens
  url:  /payment-menu/features/technical-reference/delete-token
  icon:
    content: assignment
    outlined: true
- title: Description
  description: The purchase summed up in a few words
  url:  /payment-menu/features/technical-reference/description
  icon:
    content: assignment
    outlined: true
- title: Items
  description: Information about the items field
  url:  /payment-menu/features/technical-reference/items
  icon:
    content: article
    outlined: true
- title: Metadata
  description: Store payment associated data for later use
  url:  /payment-menu/features/technical-reference/metadata
  icon:
    content: code
    outlined: true
- title: Operations
  description: Possible operations for a payment order
  url: /payment-menu/features/technical-reference/operations
  icon:
    content: settings
    outlined: true
- title: Order Items
  description: Information about the order items
  url: /payment-menu/features/technical-reference/order-items
  icon:
    content: article
    outlined: true
- title: PayeeInfo
  description: Payment specific merchant information
  url:  /payment-menu/features/technical-reference/payee-info
  icon:
    content: account_box
    outlined: true
- title: PayeeReference
  description: The merchant's reference for a specific payment
  url:  /payment-menu/features/technical-reference/payee-reference
  icon:
    content: assignment_ind
    outlined: true
- title: Payment Menu Events
  description: Possible events during Payment Menu payments
  url: /payment-menu/features/technical-reference/payment-menu-events
  icon:
    content: event
    outlined: true
- title: Operations
  description: Possible operations for a payment order
  url: /payment-menu/features/technical-reference/operations
  icon:
    content: settings
    outlined: true
- title: Payment State
  description: Different states in the payment process
  url: /payment-menu/features/technical-reference/payment-state
  icon:
    content: credit_card
    outlined: true
- title: PaymentUrl
  description: Redirecting the payer back to your site
  url:  /payment-menu/features/technical-reference/payment-url
  icon:
    content: link
    outlined: true
- title: Prices
  description: The payment's prices resource
  url:  /payment-menu/features/technical-reference/prices
  icon:
    content: attach_money
    outlined: true
- title: Problems
  description: Information when something goes wrong
  url:  /payment-menu/features/technical-reference/problems
  icon:
    content: report
    outlined: true
- title: Seamless View Events
  description: Possible events during Seamless View payments
  url:  /payment-menu/features/technical-reference/seamless-view-events
  icon:
    content: event
    outlined: true
- title: Transactions
  description: The transactions making up a specific payment
  url:  /payment-menu/features/technical-reference/transactions
  icon:
    content: done_all
    outlined: true
card_list_3:
- title: Custom Logo
  description: How to add your own logo
  url: /payment-menu/features/optional/custom-logo
  icon:
    content: copyright
    outlined: true
- title: Instrument Mode
  description: The Payment Menu with one payment instrument
  url:  /payment-menu/features/optional/instrument-mode
  icon:
    content: looks_one
    outlined: true
- title: MOTO
  description: Mail Order / Telephone Order
  url:  /payment-menu/features/optional/moto
  icon:
    content: dns
    outlined: true
- title: One-Click Payments
  description: Prefilling the payment details using payment tokens
  url:  /payment-menu/features/optional/one-click-payments
  icon:
    content: touch_app
    outlined: true
- title: Payer Aware Payment Menu
  description: A payment menu tailored to the payer
  url:  /payment-menu/features/optional/payer-aware-payment-menu
  icon:
    content: event
    outlined: true
- title: Recur
  description: Setting up subscriptions and recurring payments
  url:  /payment-menu/features/optional/recur
  icon:
    content: cached
    outlined: true
- title: TransactionOnFile
  description: Submitting subsequent transactions via file
  url:  /payment-menu/features/optional/transaction-on-file
  icon:
    content: cached
    outlined: true
- title: Verify
  description: Validating the payer's payment details
  url:  /payment-menu/features/optional/verify
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
