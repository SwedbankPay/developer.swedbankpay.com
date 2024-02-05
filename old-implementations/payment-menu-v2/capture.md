---
title: Capture
permalink: /:path/capture/
menu_order: 400
---

{% include alert-two-phase-payments.md %}

{% include payment-order-capture.md %}

**Et voilà!** The payment should now be complete and everyone should be happy.
But, sometimes you also need to implement the cancellation and reversal
operations described in [After Payment][after-payment].

{% include authorizations-timeout.md %}

{% include iterator.html prev_href="payment-order"
                         prev_title="Payment Order"
                         next_href="after-payment"
                         next_title="After Payment" %}

[after-payment]: /old-implementations/payment-menu-v2/after-payment
