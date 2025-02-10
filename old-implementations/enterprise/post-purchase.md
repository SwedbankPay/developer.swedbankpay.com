---
title: Post-Purchase
permalink: /:path/post-purchase/
description: |
  When the payer has **completed** the purchase, you need to implement the
  relevant **post-purchase operations** in your order system. These operations,
  and how they are executed, are described below.
menu_order: 500
---

{% include alert-two-phase-payments.md %}

{% include payment-order-capture.md %}

The purchase should now be complete. But what if the purchase is cancelled or
the payer wants to return goods? For these instances, we have `cancel` and
`reversal`.

{% include payment-order-cancel.md %}

{% include payment-order-reversal.md %}

{% include iterator.html prev_href="/old-implementations/enterprise/redirect"
                         prev_title="Implement Redirect" %}

{% include iterator.html prev_href="/old-implementations/enterprise/seamless-view"
                         prev_title="Implement Seamless View" %}
