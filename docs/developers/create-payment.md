---
title: Create Payment
description: |
 Here you will learn about creating a payment and redirect the payer to our secure hosted paymentmenu.
menu_order: 600
---

The integration consists of three main steps.
**Creating** the payment order, **redirecting** the payer to the paymentmenu, and
**capturing** the funds.

If you want to get an overview before proceeding, you can look at the [sequence
diagram][sequence-diagram]. It is also available in the sidebar if you want to
look at it later. Let´s get going with the two first steps of the integration.

## Step 1: Create Payment Order

When the purchase is initiated, you need to create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [core features][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`.

{% include payment-order-base.md integration_mode="redirect" %}

## Step 2: Display Payment Menu

Among the operations in the POST `paymentOrders` response, you will find the
`redirect-paymetnmenu`. This is the one you need to display payment menu.

{:.code-view-header}
**Response**

```json
{
    "paymentOrder": {
    "operations": [
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/payment/menu/b934d6f84a89a01852eea01190c2bbcc937ba29228ca7502df8592975ee3bb0d?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
    ]
}
```

## How It Looks

The redirect link opens the payment menu on a new page with the payer
information displayed above the menu. The payer can select their preferred
payment instrument and pay.

{:.text-center}
![screenshot of the merchant managed implementation redirect payment menu][redirect-payments-only-menu]

Once the payer has completed the purchase, they will be redirected to the url set in the `completeUrl` field. You can then perform a `GET` towards the
`paymentOrders` resource to see the purchase state.

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.

{% include iterator.html prev_href="./"
                         prev_title="Developer Guide"
                         next_href="post-purchase"
                         next_title="Post Purchase" %}

[abort-feature]: /paymetnmenu/payments-only/features/core/abort
[sequence-diagram]: /paymetnmenu/sequence-diagrams#payments-only-redirect
[redirect-payments-only-menu]: /assets/img/checkout/pay-redirect-menu.png
