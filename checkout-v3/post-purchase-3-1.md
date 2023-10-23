---
title: Post-Purchase v3.1
description: |
  When the payer has **completed** the purchase, you need to implement the
  relevant **post-purchase operations** in your order system. These operations,
  and how they are executed, are described below.
menu_order: 6
---

{% include alert-two-phase-payments.md %}

{% include payment-order-capture.md %}

The purchase should now be complete. But what if the purchase is cancelled or
the payer wants to return goods? For these instances, we have `cancel` and
`reversal`.

{% include payment-order-cancel.md %}

{% include payment-order-reversal.md %}

{% include iterator.html next_href="/checkout-v3/features/"
                         next_title="Add To Your Payment Request" %}