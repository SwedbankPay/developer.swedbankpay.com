---
title: Swish
permalink: /:path/swish-presentation/
hide_from_sidebar: true
description: |
  An introduction to Swish and use tips for an optimal user experience.
menu_order: 400
---

<section class="panel panel-brand">
 <header>
 <h3 class="panel-title">Sweden’s preferred payment method!</h3>
 <p class="panel-sub-title"></p>
 </header>
 <div class="panel-body">
<div>
 Swish is used by over two-thirds of Sweden's population. It delivers a simple,
 fast, and secure payment experience, whether online or in-store.

 With Swish, your customers are seamlessly redirected to the Swish app on their
 mobile or can easily scan a QR code on their desktop to complete the payment.

 Payments are processed instantly, with funds transferred directly to your
 account in real time. No delays, just immediate transactions. Embrace Swish and
 provide your customers with the smooth, trusted payment solution they expect.
 </div>
 </div>
</section>

## Mobile Commerce (M-Com) Flow

The m-com flow is where you initiate the payment on a mobile and Swish launches
automatically on the same device. When returning from the Swish app, you will
notice that you have been returned to a new tab or browser. The previously used
tab/browser will still be open, but the page itself will not update or change.
This is done deliberately to ensure a consistent payment experience with Swish
in m-com mode.

As various users may have different browser settings or devices, we force a new
page to open up to make sure you will only receive one single `OnPaid` or
`OnPaymentCompleted` event.

If you include the `PaymentUrl` field, a new query parameter will be added to
the tail of that link, formatted like this: `"Swp_Ut=...`. If the `PaymentUrl`
originally is `https://www.example.com/payment`, it will change to
`https://www.example.com/payment?swp=ut=00000000`. Please do not use the same
query parameter in your `PaymentUrl` to avoid any distruption to your payment
flow.

If you are an existing merchant and have relied on Swish returning you to the
same page in the same tab, please get in touch with our [support][support] for
more information on how you can adapt your existing solution to this change.

[support]: mailto:support.psp@swedbankpay.se
