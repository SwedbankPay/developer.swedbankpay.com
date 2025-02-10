---
title: After Payment
permalink: /:path/after-payment/
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

{% include iterator.html prev_href="/old-implementations/checkout-v2/capture"
                         prev_title="Capture"
                         next_href="/old-implementations/checkout-v2/features"
                         next_title="Features" %}
