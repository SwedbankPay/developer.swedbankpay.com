---
title: Post-Purchase
permalink: /:path/post-purchase/
description: |
  When the payer has **completed** the purchase, you need to implement the
  relevant **post-purchase operations** in your order system. These operations,
  and how they are executed, are described below.
menu_order: 8
---

{% include alert-two-phase-payments.md %}

{% include alert.html type="informative" icon="info" header="When something goes
wrong" body="When something fails during a post-purchase operation, you will get
an error message in the response in the form of a problem `json`." %}

See examples of the `jsons` in the [problems section][problems].

{% include payment-order-capture.md %}

The purchase should now be complete. But what if the purchase is cancelled or
the payer wants to return goods? For these instances, we have `cancel` and
`reversal`.

{% include payment-order-cancel.md %}

{% include payment-order-reversal.md %}

{% include iterator.html next_href="/checkout-v3/features/"
                         next_title="Add To Your Payment Request" %}

[problems]: /checkout-v3/features/technical-reference/problems
