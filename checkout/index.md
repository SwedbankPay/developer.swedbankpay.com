---
section: Checkout
title: Checkout
description: |
  **Swedbank Pay Checkout** is a complete reimagination
  of the checkout experience, integrating seamlessly into the merchant website
  through highly customizable and flexible components.
  Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
  and try out Swedbank Pay Checkout for yourself!
menu_order: 100
card_list:
- title: Checkout v2
  description: |
    Checkout v2 has been the generally available version of Checkout since 2018.
    Choose this if you have an <strong>existing Checkout v2
    integration</strong> or are currently completing one.
  url:  /checkout/v2
  icon:
    content: shopping_cart
    outlined: true
- title: Checkout v3
  description: Coming soon…
  disabled: true
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
