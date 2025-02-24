---
title: Swish
permalink: /:path/swish-presentation/
hide_from_sidebar: true
description: |
  Useful tips for an optimal Swish user experience.
menu_order: 400
---

## M-Com

When returning from Swish after being launched automatically on the same device
(m-com flow), you will notice that a new tab or browser will open up. The old
tab/browser that was used previously will still be opened, but the page itself
will not update or change. This is done deliberately to ensure a consistent
payment experience with Swish in m-com mode.

As various users may have different browser settings or devices, we force a new
page to open up to make sure you will only receive one single `OnPaid` or
`OnPaymentCompleted` event. We will add a new query parameter to the
`PaymentUrl` (if included): `"Swp_Ut=...`. Please do not use the same query
parameter in your `PaymentUrl` to avoid any distruption to your payment flow.

If you are an existing merchant and have relied on Swish returning you to the
same page in the same tab, please get in touch with our [support][support] for
more information on how you can adapt your existing solution to this change.

[support]: mailto:support.psp@swedbankpay.se
