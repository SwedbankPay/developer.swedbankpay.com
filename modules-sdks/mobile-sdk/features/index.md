---
title: Features
redirect_from: /modules-sdks/mobile-sdk/other-features
card_overview: true
description: |
  In this section you can read more about the different features of
  Swedbank Pay mobile SDKs.
permalink: /:path/
icon:
  content: remove_red_eye
additional: true
menu_order: 1000
card_list:
- title: Payment Orders
  description: Initiating the payment order
  url:  /modules-sdks/mobile-sdk/features/core/payment-orders
  icon:
    content: shopping_basket
- title: Purchase Payments
  description: Setting the purchase operation
  url: /modules-sdks/mobile-sdk/features/core/purchase-payments
  icon:
    content: shopping_basket
    outlined: true
card_list_2:
- title: Android View Model Provider Key
  description: Communicating with the payment fragment
  url:  /modules-sdks/mobile-sdk/features/technical-reference/android-view-model-provider-key
  icon:
    content: vpn_key
- title: Android Default UI
  description: Controlling the default UI
  url: /modules-sdks/mobile-sdk/features/technical-reference/
  icon:
    content: phone_android
    outlined: true
- title: Observing The Payment Process
  description: Helping your app react to different payment states
  url: /modules-sdks/mobile-sdk/features/technical-reference/observing-the-payment-process
  icon:
    content: video_camera_back
    outlined: true
- title: Problems
  description: Information when something goes wrong
  url: /modules-sdks/mobile-sdk/features/technical-reference/problems
  icon:
    content: report
    outlined: true
card_list_3:
- title: Debugging Features
  description: Helping you investigate when a bug appears
  url:  /modules-sdks/mobile-sdk/features/optional/debugging-features
  icon:
    content: bug_report
- title: Instrument Mode
  description: The Payment Menu with one payment instrument
  url: /modules-sdks/mobile-sdk/features/optional/instrument-mode
  icon:
    content: looks_one
    outlined: true
- title: Payer Aware Payment Menu
  description: A payment menu tailored to the payer
  url: /modules-sdks/mobile-sdk/features/optional/payer-aware-payment-menu
  icon:
    content: event
    outlined: true
- title: Verify
  description: Setting the verify operation
  url: /modules-sdks/mobile-sdk/features/optional/verify
  icon:
    content: verified_user
    outlined: true
---

{:.heading-line}

## Core Features

{% include card-list.html card_list=page.card_list col_class="col-lg-4" %}

## Technical Reference

{% include card-list.html card_list=page.card_list_2 col_class="col-lg-4" %}

## Optional Features

{% include card-list.html card_list=page.card_list_3 col_class="col-lg-4" %}
