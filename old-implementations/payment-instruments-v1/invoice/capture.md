---
title: Capture
redirect_from: /payments/invoice/capture
menu_order: 800
---

{% include alert-two-phase-payments.md %}

## Capture

The final step in the integration process for Invoice [Redirect][redirect],
[Seamless View][seamless-view] and [Direct][direct] is to complete a `Capture`.

{% include invoice-capture.md %}

{% include iterator.html prev_href="direct" prev_title="Direct"
next_href="after-payment" next_title="After Payment" %}

[direct]: /old-implementations/payment-instruments-v1/invoice/direct
[redirect]: /old-implementations/payment-instruments-v1/invoice/redirect
[seamless-view]: /old-implementations/payment-instruments-v1/invoice/seamless-view
