---
title: Swedbank Pay Payment Menu – After Payment
sidebar:
  navigation:
  - title: Payment Menu
    items:
    - url: /payment-menu/
      title: Introduction
    - url: /payment-menu/payment-order
      title: Payment Order
    - url: /payment-menu/capture
      title: Capture
    - url: /payment-menu/after-payment
      title: After Payment
    - url: /payment-menu/other-features
      title: Other Features
---

{% include jumbotron.html body="When the payer is **done** interacting
with the Payment Menu, you need to implement the
relevant **after-payment operations** in your order system. Which these
operations are and how they are executed is described below." %}

{% include payment-order-after-payment.md %}

{% include iterator.html prev_href="capture"
                         prev_title="Back: Capture"
                         next_href="other-features"
                         next_title="Next: Other Features" %}


[payment-order]: /payment-menu/payment-order
