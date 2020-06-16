---
title: Swedbank Pay Payment Menu – Capture
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

{% include payment-order-capture.md documentation_section="payment-menu"%}

**Et voilà!** The payment should now be complete and
everyone should be happy. But, sometimes you also need to implement the
cancellation and reversal operations described in [After Payment][after-payment].

{% include iterator.html prev_href="payment-order"
                         prev_title="Back: Payment Order"
                         next_href="after-payment"
                         next_title="Next: After Payment" %}

[after-payment]: /payment-menu/after-payment
