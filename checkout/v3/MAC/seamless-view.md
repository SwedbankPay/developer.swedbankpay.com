---
title: Seamless View
estimated_read: 10
description: |
  The Seamless View purchase scenario shows you how to implement the payment
  menu directly in your webshop.
menu_order: 300
---

The **MAC Seamless View** integration consists of three main steps. **Creating**
the payment order, **displaying** the payment menu in an iframe, and
**capturing** the funds. In addition, there are other post purchase options you
need. We get to them later on.

If you want to get an overview before proceeding, you can look at the [sequence
diagram][sequence-diagram]. It is also available in the sidebar if you want to
look at it later. Let´s get going with the two first steps of the integration.

## Step 1: Create Payment Order

When the payer has been checked in and the purchase initiated, you need to
create a payment order.

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

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [core features][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`.

{% include payment-url.md when="selecting the payment instrument Vipps or in the
3-D Secure verification for Card Payments" %}

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-mac.md integration_mode="seamless-view" %}

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
            "href": "https://ecom.externalintegration.payex.com/payment/core/js/px.payment.client.js?token=dd728a47e3ec7be442c98eafcfd9b0207377ce04c793407eb36d07faa69a32df&culture=sv-SE",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        },
    ]
}
```

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
                checkoutContainer: "checkout-container"
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
  < !DOCTYPE html >
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

The payment menu should appear with the payer information displayed above the
menu. The payer can select their preferred payment instrument and pay. The
example with shipping address is for all goods (physical and digital), the one
without shipping address is for digital products only.

{:.text-center}
![screenshot of the authenticated implementation seamless view payment menu mixed][seamless-payment-menu-mixed]<br/>
{:.text-center}
![screenshot of the authenticated implementation seamless view payment menu digital][seamless-payment-menu-digital]<br/>
Once the payer has completed the purchase, you can perform a GET towards the
`paymentOrders` resource to see the purchase state.

You can read about the different [Seamless View Events][seamless-view-events] in
the feature section.

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="post-purchase"
                         next_title="Post Purchase" %}

[abort-feature]: /checkout/v3/mac/features/core/abort
[seamless-view-events]: /checkout/v3/mac/features/technical-reference/seamless-view-events
[sequence-diagram]: /checkout/v3/sequence-diagrams/#mac-seamless-view
[seamless-payment-menu-digital]: /assets/img/checkout/v3/payment-menu-seamless-digital.png
[seamless-payment-menu-mixed]: /assets/img/checkout/v3/payment-menu-seamless-mixed-products.png
