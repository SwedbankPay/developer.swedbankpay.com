---
title: Features
redirect_from: /gift-cards/other-features
card_overview: true
description: |
  In this section you can read more about the different features of
  Swedbank Pay Gift Cards.
permalink: /:path/
icon:
  content: remove_red_eye
additional: true
menu_order: 1000
card_list:
- title: Authentication
  description: Authenticating the gift card
  url:  /gift-cards/features/core/authentication
  icon:
    content: verified_user
- title: Balance
  description: Checking the gift card's balance.
  url: /gift-cards/features/core/balance
  icon:
    content: compare_arrows
    outlined: true
- title: Deposit
  description: Deposit funds to the gift card
  url: /gift-cards/features/core/deposit
  icon:
    content: local_atm
    outlined: true
- title: Purchase
  description: The bread and butter of the payments
  url: /gift-cards/features/core/purchase
  icon:
    content: shopping_basket
    outlined: true
card_list_2:

card_list_3:
---

{:.heading-line}

## Core Features

{% include card-list.html card_list=page.card_list col_class="col-lg-4" %}

## Technical Reference

{% include card-list.html card_list=page.card_list_2 col_class="col-lg-4" %}

## Optional Features

{% include card-list.html card_list=page.card_list_3 col_class="col-lg-4" %}
