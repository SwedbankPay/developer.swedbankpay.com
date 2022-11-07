---
title: Redirect
estimated_read: 12
description: |
  Redirect is our simplest integration. The payer will be redirected to a secure
  Swedbank Pay hosted site, authenticate their Checkout profile and choose
  payment instrument. After the purchase, the payer will be redirected back to
  your website.
menu_order: 300
---

The **Business Redirect** integration consists of three main steps.
**Creating** the payment order and checkin, **displaying** the payment menu and
checkin module, and finally **capturing** the funds. In addition, there are
other post purchase options you need. We get to them later on.

If you want to get an overview before proceeding, you can look at the [sequence
diagram][sequence-diagrams]. It is also available in the sidebar if you want to
look at it later. Let´s get going with the two first steps of the integration.

## Step 1: Create Payment Order And Checkin

When the purchase is initiated, you need to create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

We have added `productName` to the payment order request in this integration.
You can find it in the `paymentorder` field. This is required if you want to use
Checkout v3. If it isn´t included in your request, you won't get the correct
operations in the response.

When `productName` is set to `checkout3`, `digitalProducts` will be set to
`false` by default.

Supported features for this integration are subscriptions (`recur` and
`unscheduled MIT`), instrument mode, split settlement (`subsite`) and the
possibility to use your own `logo`.

There is also a guest mode option for the payers who don't wish to store their
information. When using **Business**, this is triggered when the payer
chooses not to store credentials during checkin.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [core features][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`.

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-business.md integration_mode="redirect" %}

## Step 2: Display Payment Menu And Checkin

Among the operations in the POST `paymentOrders` response, you will find the
`redirect-checkout`. This is the one you need to display the checkin and
payment menu.

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

The redirect link opens the payment menu in checkin state. The first page will
be the checkin page where the payer provides their email and phone number.

{:.text-center}
![screenshot of the business implementation redirect checkin][login-checkin]

A known payer will be sent directly to the payment menu shown further below. If
we detect that the payer is new, we give them the option to store their details
or proceed without storing. If that happens, these checkin steps will appear.

{:.text-center}
![screenshot of asking the payer to store details][checkin-new-payer]

After choosing yes or no, the payer must enter their SSN.

{:.text-center}
![screenshot of asking the payer to enter SSN while storing details][checkin-new-payer-ssn]

With digital products, the payer will be sent directly to the payment menu after
selecting to store their details. For mixed goods, the SSN input view will
expand and the payer must enter their shipping address. Payers choosing not to
store credentials (guests) must also enter their shipping address.

{:.text-center}
![screenshot of the seamless view checkin when entering details][checkin-enter-details-mixed]

After checking in, the payment menu will appear with the payer information
displayed above the menu. Note the new "Remember me" checkbox. The first time
the payer checks in, the box will appear blank. If checked during a purchase, it
will appear like the screenshot below during future check-ins, with a "Not you?"
option in the top right corner.

The payer can select their preferred payment instrument and pay.

{:.text-center}
![screenshot of the business implementation redirect payment menu mixed][redirect-payment-menu-mixed]

Once the payer has completed the purchase, you can perform a `GET` towards the
`paymentOrders` resource to see the purchase state.

You are now ready to `capture` the funds. Follow the link below to read more
about capture and the other options you have after the purchase.

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="post-purchase"
                         next_title="Post Purchase" %}

[abort-feature]: /checkout-v3/business/features/core/abort
[sequence-diagrams]: /checkout-v3/sequence-diagrams#business-redirect
[login-checkin]: /assets/img/checkout/checkin.png
[redirect-payment-menu-mixed]: /assets/img/checkout/checkout-v3-business-redirect.png
[checkin-enter-details-mixed]: /assets/img/checkout/checkin-enter-shipping-address.png
[checkin-new-payer]: /assets/img/checkout/checkin-new-payer.png
[checkin-new-payer-ssn]: /assets/img/checkout/checkin-new-payer-ssn.png
