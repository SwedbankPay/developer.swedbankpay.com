---
section: Checkout
title: Checkout
card_overview: true
description: |
  **Swedbank Pay Checkout** is a complete reimagination
  of the checkout experience, integrating seamlessly into the merchant website
  through highly customizable and flexible components.
  Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
  and try out Swedbank Pay Checkout for yourself!
icon:
  content: remove_red_eye
additional: true
menu_order: 100
card_list:
- title: Checkout v2
  description: |
    Checkout v3 was the generally available version of Checkout between 2018
    and 2021. Choose this if you have an <strong>existing Checkout v3
    integration</strong>.
  url:  /checkout/v2
  icon:
    content: shopping_cart
    outlined: true
- title: Checkout v3
  description: Coming soon…
  icon:
    content: shopping_cart
    outlined: true
---

{:.heading-line}

{% comment %}
Choose between [Swedbank Pay Checkout v2][checkout-2] and [Swedbank Pay
Checkout v3][checkout-3] below. For new integrations, **[Swedbank Pay
Checkout v3][checkout-3] is recommended**.
{% endcomment %}

{% include card-list.html card_list=page.card_list col_class="col-lg-4" %}

[checkout-2]: /checkout/v2
[checkout-3]: /checkout/v3
