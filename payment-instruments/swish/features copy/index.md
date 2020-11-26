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
  url:  /checkout/features/core-features#3-d-secure-2
  icon:
    content: 3d_rotation
- title: Cancel
  description: Cancelling the authorization and releasing the funds
  url: /checkout/features/core-features#cancel
  icon:
    content: pan_tool
    outlined: true
- title: Capture
  description: Capturing the authorized funds
  url: /checkout/features/core-features#capture
  icon:
    content: compare_arrows
    outlined: true
- title: Reversal
  description: How to reverse a payment
  url: /checkout/features/core-features#reversal
  icon:
    content: keyboard_return
    outlined: true
- title: Settlement & Reconciliation
  description: Balancing the books
  url:  /checkout/features/core-features#settlement-and-reconciliation
  icon:
    content: description
    outlined: true
card_list_2:
- title: Callback
  description: Getting updates about payment or transaction changes
  url:  /checkout/features/technical-reference#callback
  icon:
    content: low_priority
    outlined: true
- title: Checkin Events
  description: Possible events during Checkin
  url: /checkout/features/technical-reference#checkin-events
  icon:
    content: event
    outlined: true
- title: CompleteUrl
  description: Where you go when the payment is completed
  url:  /checkout/features/technical-reference#completeurl
  icon:
    content: link
    outlined: true
- title: Description
  description: The purchase summed up in a few words
  url:  /checkout/features/technical-reference#description
  icon:
    content: assignment
    outlined: true
- title: Metadata
  description: Store payment associated data for later use
  url:  /checkout/features/technical-reference#metadata
  icon:
    content: code
    outlined: true
- title: PayeeInfo
  description: Payment specific merchant information
  url:  /checkout/features/technical-reference#payeeinfo
  icon:
    content: account_box
    outlined: true
- title: PayeeReference
  description: The merchant's reference for a specific payment
  url:  /checkout/features/technical-reference#payee-reference
  icon:
    content: assignment_ind
    outlined: true
- title: Payment Menu Events
  description: Possible events during Payment Menu payments
  url: /checkout/features/technical-reference#payment-menu-events
  icon:
    content: event
    outlined: true
- title: Payment Order Operations
  description: Possible operations for a payment order
  url: /checkout/features/technical-reference#payment-order-operations
  icon:
    content: settings
    outlined: true
- title: PaymentUrl
  description: Redirecting the payer back to your site
  url:  /checkout/features/technical-reference#payment-url
  icon:
    content: link
    outlined: true
- title: Prices
  description: The payment's prices resource
  url:  /checkout/features/technical-reference#prices
  icon:
    content: attach_money
    outlined: true
- title: Problems
  description: Information when something goes wrong
  url:  /checkout/features/technical-reference#problems
  icon:
    content: report
    outlined: true
- title: Purchase
  description: The bread and butter of the payments
  url:  /checkout/features/technical-reference#purchase
  icon:
    content: shopping_basket
    outlined: true
- title: Seamless View Events
  description: Possible events during Seamless View payments
  url:  /checkout/features/technical-reference#seamless-view-events
  icon:
    content: event
    outlined: true
card_list_3: 
- title: Custom Logo
  description: How to add your own logo
  url: /checkout/features/optional-features#custom-logo
  icon:
    content: copyright
    outlined: true
- title: Delegated Strong Consumer Authentication
  description: The Checkin alternative
  url: /checkout/features/optional-features#delegated-strong-consumer-authentication 
  icon:
    content: verified
    outlined: true
- title: Recur
  description: Setting up subscriptions and recurring payments
  url:  /checkout/features/optional-features#recur
  icon:
    content: cached
    outlined: true
- title: Verify
  description: Validating the payer's payment details
  url:  /checkout/features/optional-features#verify
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
