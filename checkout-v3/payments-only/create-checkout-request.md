---
section: Checkout Request
title: Payments Only
hide_from_sidebar: false
description: |
  How to create payments when using our Checkout.
menu_order: 200
---

The **Payments Only** integration consists of three main steps.
**Creating** the payment order, **displaying** the payment menu, and
**capturing** the funds. In addition, there are other post purchase options you
need. We get to them later on.

## Step 1: Create Payment Order

When your customer has initiated a purchase, you need to create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

We have added `productName` to the payment order request in this integration.
You can find it in the `paymentorder` field. This is required if you want to use
Checkout v3. If it isn´t included in your request, you won't get the correct
operations in the response.

When `productName` is set to `checkout3`, `digitalProducts` will be set to
`false` by default.

Supported features for this integration are subscriptions (`recur`, `one-click`
and `unscheduled MIT`), `MOTO`, instrument mode, split settlement (`subsite`)
and the possibility to use your own `logo`.

There is also a guest mode option for the payers who don't wish to store their
information. When using **Payments Only**, the way to trigger this is to not
include the `payerReference` field in your `paymentOrder` request. You can find
it in the `payer` field in the example below.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [core features][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`.

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-payments-only.md %}

## Adding To Your Request

The request shown above includes what you need to create the payment, but you
can add more sections if you need or want.

Examples can be to include [order items][order-items] by adding a separate node,
or provide risk indicators and information about the payer to
[make the payment process as frictionless as possible][frictionless].

Read more about possible additions to the request in our
[feature section][features].

## Step 2: Display Payment UI

There are a couple of decisions to be made when you are presenting your payment
UI. You have the choice between a payment menu with all the payment instruments
you want to offer, or to present the `paymentOrder` with a single available
payment instrument using instrument mode.

Regardless of the number of instruments available to the payer, you also need to
choose between the display options `Redirect` and `Seamless View`. Read more
about these by following the corresponding link.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started"
                         next_href="redirect"
                         next_title="Integrate Redirect" %}
{% include iterator.html next_href="seamless-view"
                         next_title="Integrate Seamless View" %}

[abort-feature]: /checkout-v3/payments-only/features/core/abort
[features]: /checkout-v3/payments-only/features/
[frictionless]: /checkout-v3/payments-only/features/core/frictionless-payments
[order-items]: /checkout-v3/payments-only/features/optional/order-items
