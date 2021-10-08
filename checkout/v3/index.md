---
section: Checkout v3
title: Introduction
hide_from_sidebar: true
description: |
  **Swedbank Pay Checkout** is a complete reimagination
  of the checkout experience, integrating seamlessly into the merchant website
  through highly customizable and flexible components.
  Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
  and try Swedbank Pay Checkout for yourself!
icon:
  content: remove_red_eye
additional: true
menu_order: 200
card_list:
- title: Standard
  description: |
    Coming soon...
  url:  /checkout/v3/standard
  disabled: true
  icon:
    content: shopping_cart
    outlined: true
- title: Authenticated
  description: |
    Use this implementation if you have consumer data, but want to access Swedbank Pay Checkout for an easier purchase flow.
  url:  /checkout/v3/authenticated
  icon:
    content: shopping_cart
    outlined: true
- title: Merchant Authenticated Consumer
  description: Use this implementation if you have consumer data and consumer authentication on your site, but want to access Swedbank Pay Checkout for an easier purchase flow.
  url:  /checkout/v3/mac
  icon:
    content: shopping_cart
    outlined: true
---

{:.heading-line}
{% include card-list.html card_list=page.card_list col_class="col-lg-4" %}

[checkout-3-authenticated]: /checkout/v3/authenticated
[checkout-3-standard]: /checkout/v3/standard
[checkout-3-mac]: /checkout/v3/mac

## Prerequisites

To start integrating Swedbank Pay Checkout, you need:

*   An [HTTPS][https] enabled web server.
*   An agreement that includes Swedbank Pay Checkout.
*   Obtained credentials (Merchant Access Token) from Swedbank Pay through
    Swedbank Pay Admin.

[https]: /introduction#connection-and-protocol
