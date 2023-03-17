---
title: After Payment
redirect_from: /checkout/after-payment
description: |
  When the consumer has **completed** the entire
  [Checkin](/old-implementations/checkout-v2/checkin) and
  [Payment Menu](/old-implementations/checkout-v2/payment-menu) you need to
  implement the relevant **after-payment operations** in your order system.
  Which these operations are and how they are executed is described below.
menu_order: 500
---

{% include payment-order-after-payment.md %}

{% include iterator.html prev_href="capture"
                         prev_title="Capture"
                         next_href="features"
                         next_title="Features" %}
