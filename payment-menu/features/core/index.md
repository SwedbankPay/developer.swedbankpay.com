---
title: Core Features
description: |
  This section details the Payment Menu features that are essential for the
  payment process.
permalink: /:path/
icon:
  content: remove_red_eye
additional: true
menu_order: 1100
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
---

{:.heading-line}

## Core Features

{% include card-list.html card_list=page.card_list
    col_class="col-lg-4" %}
