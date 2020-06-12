---
title: Swedbank Pay Checkout – After Payment
sidebar:
  navigation:
  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/checkin
      title: Checkin
    - url: /checkout/payment-menu
      title: Payment Menu
    - url: /checkout/capture
      title: Capture
    - url: /checkout/after-payment
      title: After Payment
    - url: /checkout/other-features
      title: Other Features
---

{% include jumbotron.html body="When the consumer has **completed** the entire
[Checkin](checkin) and [Payment Menu](payment-menu), you need to implement the
relevant **after-payment operations** in your order system. Which these
operations are and how they are executed is described below." %}

{% include payment-order-after-payment.md %}

{% include iterator.html prev_href="capture"
                         prev_title="Back: Capture"
                         next_href="other-features"
                         next_title="Next: Other Features" %}