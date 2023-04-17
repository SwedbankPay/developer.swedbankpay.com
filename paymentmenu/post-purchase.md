---
title: Post Purchase
description: |
  When the payer has **completed** the purchase and have been redirected back to you, you need to perform the correct post-payment operation based on the state of the payment.
  You need to implement the relevant **post purchase operations** in your order system. These operations,
  and how they are executed, are described below.
menu_order: 500
---

{% include alert-two-phase-payments.md %}

In most cases you will want to `capture` the payment.

{% include payment-order-capture.md %}

The purchase should now be complete. But what if the purchase is cancelled or
the payer wants to return goods? For these instances, we have `cancel` and
`reversal`.

{% include payment-order-cancel.md %}

{% include payment-order-reversal.md %}

{% include iterator.html prev_href="create-payment"
                         prev_title="Create Payment" %}
