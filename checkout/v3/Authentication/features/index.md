---
title: Features
redirect_from: /checkout/other-features
card_overview: true
description: |
  In this section you can read more about the different features of
  Swedbank Pay Checkout.
icon:
  content: remove_red_eye
additional: true
menu_order: 1000
card_list:
- title: 3-D Secure 2
  description: Authenticating the cardholder
  url:  /checkout/v3/authentication/features/core/3d-secure-2
  icon:
    content: 3d_rotation
- title: Cancel
  description: Cancelling the authorization and releasing the funds
  url: /checkout/v3/authentication/features/core/cancel
  icon:
    content: pan_tool
    outlined: true
- title: Capture
  description: Capturing the authorized funds
  url: /checkout/v3/authentication/features/core/payment-order-capture
  icon:
    content: compare_arrows
    outlined: true
- title: Reversal
  description: How to reverse a payment
  url: /checkout/v3/authentication/features/core/reversal
  icon:
    content: keyboard_return
    outlined: true
- title: Settlement & Reconciliation
  description: Balancing the books
  url:  /checkout/v3/authentication/features/core/settlement-reconciliation
  icon:
    content: description
    outlined: true
card_list_2:
- title: Callback
  description: Getting updates about payment or transaction changes
  url:  /checkout/v3/authentication/features/technical-reference/callback
  icon:
    content: low_priority
    outlined: true
- title: Checkin Events
  description: Possible events during Checkin
  url: /checkout/v3/authentication/features/technical-reference/checkin-events
  icon:
    content: event
    outlined: true
- title: CompleteUrl
  description: Where you go when the payment is completed
  url:  /checkout/v3/authentication/features/technical-reference/complete-url
  icon:
    content: link
    outlined: true
- title: Delete Token
  description: How to delete tokens
  url:  /checkout/v3/authentication/features/technical-reference/delete-token
  icon:
    content: assignment
    outlined: true
- title: Description
  description: The purchase summed up in a few words
  url:  /checkout/v3/authentication/features/technical-reference/description
  icon:
    content: assignment
    outlined: true
- title: Metadata
  description: Store payment associated data for later use
  url:  /checkout/v3/authentication/features/technical-reference/metadata
  icon:
    content: code
    outlined: true
- title: PayeeInfo
  description: Payment specific merchant information
  url:  /checkout/v3/authentication/features/technical-reference/payee-info
  icon:
    content: account_box
    outlined: true
- title: PayeeReference
  description: The merchant's reference for a specific payment
  url:  /checkout/v3/authentication/features/technical-reference/payee-reference
  icon:
    content: assignment_ind
    outlined: true
- title: Payment Menu Events
  description: Possible events during Payment Menu payments
  url: /checkout/v3/authentication/features/technical-reference/payment-menu-events
  icon:
    content: event
    outlined: true
- title: Operations
  description: Possible operations for a payment order
  url: /checkout/v3/authentication/features/technical-reference/operations
  icon:
    content: settings
    outlined: true
- title: Payment State
  description: Different states in the payment process
  url: /checkout/v3/authentication/features/technical-reference/payment-state
  icon:
    content: credit_card
    outlined: true
- title: PaymentUrl
  description: Redirecting the payer back to your site
  url:  /checkout/v3/authentication/features/technical-reference/payment-url
  icon:
    content: link
    outlined: true
- title: Prices
  description: The payment's prices resource
  url:  /checkout/v3/authentication/features/technical-reference/prices
  icon:
    content: attach_money
    outlined: true
- title: Problems
  description: Information when something goes wrong
  url:  /checkout/v3/authentication/features/technical-reference/problems
  icon:
    content: report
    outlined: true
- title: Seamless View Events
  description: Possible events during Seamless View payments
  url:  /checkout/v3/authentication/features/technical-reference/seamless-view-events
  icon:
    content: event
    outlined: true
card_list_3:
- title: Custom Logo
  description: How to add your own logo
  url: /checkout/v3/authentication/features/optional/custom-logo
  icon:
    content: copyright
    outlined: true
- title: Delegated Strong Consumer Authentication
  description: The Checkin alternative
  url: /checkout/v3/authentication/features/optional/dsca
  icon:
    content: verified
    outlined: true
- title: Recur
  description: Setting up subscriptions and recurring payments
  url:  /checkout/v3/authentication/features/optional/recur
  icon:
    content: cached
    outlined: true
- title: Verify
  description: Validating the payer's payment details
  url:  /checkout/v3/authentication/features/optional/verify
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
