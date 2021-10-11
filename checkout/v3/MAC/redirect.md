---
title: Redirect
estimated_read: 10
description: |
 Redirect is our simplest integration. The payer will be redirected to a secure
 Swedbank Pay hosted site and choose payment instrument. After the purchase,
 the payer will be redirected back to your website.
menu_order: 200
---

The **MAC Redirect** integration consists of three main steps. **Creating** the
payment order, **displaying** the payment menu, and **capturing** the funds. In
addition, there are other post purchase options you need. We get to them later
on.

If you want to get an overview before proceeding, you can look at the [sequence
diagram][sequence-diagram]. It is also available in the sidebar if you want to
look at it later. Let´s get going with the two first steps of the integration.

## Step 1: Create Payment Order

When the purchase is initiated, you need to create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

A new field has been added to the payment order request in this integration.
This is called `productName` and is a part of the `payer` node. This field is
required if you want to use Checkout v3, as the needed operations won't be
available in the response if it's not included.

When `productName` is set to `checkout3`, `requireConsumerInfo` will have its
default value set to false. while `digitalProducts` will default to true.

Please note that `shippingAdress` is only required if `digitalProducts` is set
to `false`. `requireConsumerInfo` **must** be set to `false`.

Supported features for this integration are subscriptions (`recur` and
`unscheduled MIT`), split settlement (`subsite`) and the possibility to use your
own `logo`.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [core features][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`.

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-mac.md integration_mode="redirect" %}

## Step 2: Display Payment Menu

Among the operations in the POST `paymentOrders` response, you will find the
`redirect-checkout`. This is the one you need to display payment menu.

{:.code-view-header}
**Response**

```
{
    "paymentOrder": {
    "operations": [
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/payment/menu/b934d6f84a89a01852eea01190c2bbcc937ba29228ca7502df8592975ee3bb0d",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
    ]
}
```

The redirect link opens the payment menu on a new page with the payer
information displayed above the menu. The payer can select their preferred
payment instrument and pay. The example with shipping address is for all goods
(physical and digital), the one without shipping address is for digital
products only.

{:.text-center}
![screenshot of the authenticated implementation redirect payment menu mixed][redirect-payment-menu-mixed]

{:.text-center}
![screenshot of the authenticated implementation redirect payment menu digital][redirect-payment-menu-digital]

Once the payer has completed the purchase, you can perform a `GET` towards the
`paymentOrders` resource to see the purchase state.

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="post-purchase"
                         next_title="Post Purchase" %}

[abort-feature]: /checkout/v3/mac/features/core/abort
[callback]: /checkout/v3/mac/features/technical-reference/callback
[sequence-diagram]: /checkout/v3/sequence-diagrams/#mac-redirect
[redirect-payment-menu-digital]: /assets/img/checkout/v3/payment-menu-redirect-digital.png
[redirect-payment-menu-mixed]: /assets/img/checkout/v3/payment-menu-redirect-mixed-products.png
[sequence-diagram]: /checkout/v3/sequence-diagrams/#mac-redirect
