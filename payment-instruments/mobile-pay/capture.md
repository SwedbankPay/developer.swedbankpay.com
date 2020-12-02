---
title: Capture
redirect_from: /payments/mobilepay/capture
estimated_read: 5
description: |
  When the authorization is completed, it is time to capture the funds. How you
  go about doing that is explained in this section.
menu_order: 700
---

{% include alert-two-phase-payments.md %}

{% include mobilepay-payments-capture.md %}

**Et voilà!** The payment should now be complete, secure and
everyone should be happy. But, sometimes you also need to implement the
cancellation and reversal operations described in After Payment.

{% include iterator.html prev_href="redirect"
                         prev_title="Redirect"
                         next_href="after-payment"
                         next_title="After Payment" %}
