---
title: Payment Request v3.1
permalink: /:path/payment-request-3-1/
hide_from_sidebar: false
description: |
  How to create payments when using Digital Payments v3.1.
menu_order: 5
---

The integration consists of three main steps. **Creating** the payment order,
**displaying** the payment menu, and **capturing** the funds. In addition, there
are other post-purchase options you need. We get to them later on.

## Create Payment Order

When your customer has initiated a purchase, you need to create a payment order.
Start by performing a `POST` request towards the `paymentorder` resource with
payer information and a `completeUrl`.

The `productName` field has been removed in v3.1, and you identify the
`paymentOrder` version as v3.1 in the header instead.

`POST`, `PATCH`, `GET` and `PUT` requests use this header:

`Content-Type: application/json;version=3.1`

`GET` requests can also use this header:

`Accept: application/json;version=3.1`

Valid versions are **3.1**, **3.0** and **2.0**. If you do not add a version,
the request will default to **2.0**. Using the `productName` and setting it to
`checkout3` will default to **3.0**.

To accompany the new version, we have also added a
[v3.1 post-purchase section][post-31], [v3.1 callback][callback-31], a new
resource model for [`failedPostPurchaseAttempts`][fppa] and additions to the
[`history`][history] resource model.

Supported features for this integration are subscriptions (`recur`, `one-click`
and `unscheduled MIT`), `MOTO`, instrument mode, split settlement (`subsite`)
and the possibility to use your own `logo`.

There is also a guest mode option for the payers who don't wish to store their
information. The way to trigger this is to not include the `payerReference`
field in your `paymentOrder` request. If the `payer` field is included in your
request, you can find the `payerReference` there.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [payment operations][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`. If the payer is performing an action at a 3rd party, like the MobilePay,
Swish or Vipps apps, `abort` is unavailable.

To avoid unnecessary calls, we recommend doing a `GET` on your `paymentOrder` to
check if `abort` is an available operation before performing it.

## Before You Start

Depending on what you plan to include in your offering, we recommend stopping
by the pages specific to each payment method.

Some of them – like the digital wallets [Apple Pay][apple-pay]{:target="_blank"},
[Click to Pay][c2p]{:target="_blank"} and [Google Pay][google-pay]{:target="_blank"} –
have steps which must be completed before the payment method can be activated.

For [Swish][swish]{:target="_blank"} and [Trustly][trustly]{:target="_blank"},
we provide useful integration recommendations.

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-3-1.md %}

## Adding To Your Request

The request shown above includes what you need to create the payment, but you
can add more sections if you need or want.

Examples can be to include [order items][order-items] by adding a separate node,
or provide risk indicators and information about the payer to
[make the payment process as frictionless as possible][frictionless].

Read more about possible additions to the request in our
[feature section][features].

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Introduction"
                         next_href="/checkout-v3/get-started/display-payment-ui/"
                         next_title="Display Payment UI" %}

[abort-feature]: /checkout-v3/features/payment-operations/abort
[callback-31]: /checkout-v3/features/payment-operations/callback
[features]: /checkout-v3/features/
[fppa]: /checkout-v3/features/technical-reference/resource-sub-models#failedpostpurchaseattempts
[frictionless]: /checkout-v3/features/customize-payments/frictionless-payments
[history]: /checkout-v3/features/technical-reference/resource-sub-models#history
[order-items]: /checkout-v3/features/optional/order-items
[post-31]: /checkout-v3/get-started/post-purchase-3-1
[trustly]: /checkout-v3/trustly-presentation
[swish]: /checkout-v3/swish-presentation
[apple-pay]: /checkout-v3/apple-pay-presentation
[c2p]: /checkout-v3/click-to-pay-presentation
[google-pay]: /checkout-v3/google-pay-presentation
