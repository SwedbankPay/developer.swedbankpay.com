---
title: Core Features
description: |
  This section details the features of Card that are essential for the payment
  process.
icon:
  content: remove_red_eye
additional: true
menu_order: 1100
card_list:
- title: 3-D Secure 2
  description: Authenticating the cardholder
  url:  /payment-instruments/card/features/core/3d-secure-2
  icon:
    content: 3d_rotation
- title: Abort
  description: Aborting a created payment
  url: /payment-instruments/card/features/core/abort-reference
  icon:
    content: pan_tool
    outlined: true
- title: Cancel
  description: Cancelling the authorization and releasing the funds
  url: /payment-instruments/card/features/core/cancel
  icon:
    content: pan_tool
    outlined: true
- title: Capture
  description: Capturing the authorized funds
  url: /payment-instruments/card/features/core/capture
  icon:
    content: compare_arrows
    outlined: true
- title: Payment Resource
  description: The overall payment process
  url: /payment-instruments/card/features/core/payment-resource
  icon:
    content: credit_card
    outlined: true
- title: Reversal
  description: How to reverse a payment
  url: /payment-instruments/card/features/core/reversal
  icon:
    content: keyboard_return
    outlined: true
- title: Settlement & Reconciliation
  description: Balancing the books
  url:  /payment-instruments/card/features/core/settlement-reconciliation
  icon:
    content: description
    outlined: true
---

{:.heading-line}

## Core Features

{% include card-list.html card_list=page.card_list
    col_class="col-lg-4" %}
