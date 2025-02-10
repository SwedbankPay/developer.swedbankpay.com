---
title: Seamless View
permalink: /:path/seamless-view/
description: |
  The Seamless View purchase scenario shows you how to implement the payment
  menu directly in your webshop.
menu_order: 400
---

The **Enterprise Seamless View** integration consists of three main steps. **Creating**
the payment order, **displaying** the payment menu in an iframe, and
**capturing** the funds. In addition, there are other post-purchase options you
need. We get to them later on.

## Step 1: Create Payment Order

When the payer has been checked in and the purchase initiated, you need to
create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

We have added `productName` to the payment order request in this integration.
You can find it in the `paymentorder` field. This is required if you want to use
Digital Payments. If it isn´t included in your request, you won't get the
correct operations in the response.

When `productName` is set to `checkout3`, `digitalProducts` will be set to
`false` by default.

Supported features for this integration are subscriptions (`recur` and
`unscheduled MIT`), instrument mode and split settlement (`subsite`).

There is also a guest mode option for the payers who don't wish to store their
information. When using **Enterprise**, the way to trigger
this is to not include the `payerReference` or `nationalIdentifier` field in
your `paymentOrder` request. You find them in the `payer` field in the example
below.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [core features][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`.

{% include payment-url.md when="selecting the payment instrument Vipps or in the
3-D Secure verification for Card Payments" %}

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-enterprise.md integration_mode="seamless-view" %}

## Step 2: Display Payment Menu

Among the operations in the POST `paymentOrders` response, you will find the
`view-checkout`. This is the one you need to display the purchase module.

{:.code-view-header}
**Response**

```json
{
    "paymentOrder": {
    "operations": [
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/payment/core/js/px.payment.client.js?token=dd728a47e3ec7be442c98eafcfd9b0207377ce04c793407eb36d07faa69a32df&culture=sv-SE&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        },
    ]
}
```

## Loading The Seamless View

Embed the `href` in a `<script>` element. That script will then load the
Seamless View.

To load the Checkout from the JavaScript URL obtained in the backend API
response, it needs to be set as a script element’s `src` attribute. You can
cause a page reload and do this with static HTML, or you can avoid the page
refresh by invoking the POST to create the payment order through Ajax, and then
create the script element with JavaScript. The HTML code will be unchanged in
this example.

{:.code-view-header}
**JavaScript**

```js
var request = new XMLHttpRequest();
request.addEventListener('load', function () {
    response = JSON.parse(this.responseText);
    var script = document.createElement('script');
    var operation = response.operations.find(function (o) {
        return o.rel === 'view-checkout';
    });
    script.setAttribute('src', operation.href);
    script.onload = function () {
        // When the 'view-checkout' script is loaded, we can initialize the
        // Payment Menu inside 'checkout-container'.
        payex.hostedView.checkout({
            container: {
                checkout: "checkout-container"
            },
            culture: 'nb-No',
        }).open();
    };
    // Append the Checkout script to the <head>
    var head = document.getElementsByTagName('head')[0];
    head.appendChild(script);
});
// Like before, you should replace the address here with
// your own endpoint.
request.open('GET', '<Your-Backend-Endpoint-Here>', true);
request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
request.send();
```

{:.code-view-header}
**HTML**

```html
<!DOCTYPE html>
  <html>
      <head>
          <title>Swedbank Pay Checkout is Awesome!</title>
      </head>
      <body>
          <div id="checkout-container"></div>
          <!-- Here you can specify your own javascript file -->
          <script src="<Your-JavaScript-File-Here>"></script>
      </body>
  </html>
```

## How It Looks

The payment menu should appear with the payer information displayed above the
menu. The payer can select their preferred payment method and pay.

{:.text-center}
![screenshot of the enterprise implementation seamless view payment menu][seamless-enterprise-menu]

Once the payer has completed the purchase, you can perform a GET towards the
`paymentOrders` resource to see the purchase state.

### Events

When integrating Seamless View, we strongly recommend that you implement the
`onPaid` event, which will give you the best setup. Even with this implemented,
you need to check the payment status towards our APIs, as the payer can make
changes in the browser at any time.

You can read more about the different [Seamless View
Events][seamless-view-events] available in the feature section.

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="/old-implementations/enterprise/post-purchase"
                         next_title="Post-Purchase" %}

[abort-feature]: /old-implementations/enterprise/features/core/abort
[seamless-view-events]: /old-implementations/enterprise/features/technical-reference/seamless-view-events
[seamless-enterprise-menu]: /assets/img/checkout/checkout-v3-seamless-menu.png
