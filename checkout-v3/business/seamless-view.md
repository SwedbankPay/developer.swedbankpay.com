---
title: Seamless View
redirect_from: /payments/card/seamless-view
estimated_read: 10
description: |
  The Seamless View purchase scenario shows you how to implement the payment
  menu directly in your webshop.
menu_order: 400
---

The **Business Redirect** integration consists of three main steps.
**Creating** the payment order and checkin, **displaying** the payment menu and
checkin module in an iframe, and finally **capturing** the funds. In addition,
there are other post purchase options you need. We get to them later on.

If you want to get an overview before proceeding, you can look at the
[sequence diagram][sequence-diagrams]. It is also available in the sidebar if
you want to look at it later. Let´s get going with the two first steps of the
integration.

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
`unscheduled MIT`), instrument mode and split settlement (`subsite`).

There is also a guest mode option for the payers who don't wish to store their
information. When using **Business**, this is triggered when the payer
chooses not to store credentials during checkin.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [core features][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`.

{% include payment-url.md when="selecting the payment instrument Vipps or in the
3-D Secure verification for Card Payments" %}

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-business.md integration_mode="seamless_view" %}

## Step 2: Display Payment Menu And Checkin

Among the operations in the POST `paymentOrders` response, you will find the
`view-checkout`. This is what you need to display the checkin and payment
module.

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
        // Checkin and Payment Menu inside 'checkout-container'.
        payex.hostedView.checkout({
            container: {
                checkout: "checkout-container",
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

First you will see a Checkin module where the payer can enter their email and
phone number.

{:.text-center}
![screenshot of the business implementation seamless view checkin][login-checkin]

A known payer will be sent directly to the payment menu shown further below. If
we detect that the payer is new, we give them the option to store their details
or proceed without storing. If that happens, these checkin steps will appear.

{:.text-center}
![screenshot of asking the payer to store details][checkin-new-payer]

After choosing yes or no, the payer must enter their SSN.

{:.text-center}
![screenshot of asking the payer to enter SSN while storing details][checkin-new-payer-ssn]

With digital products, the payer will be sent directly to the payment menu after
they select to store their details. For mixed goods, the SSN input view will
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
![screenshot of the business implementation seamless view payment menu mixed][seamless-payment-menu-mixed]

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
                         next_href="post-purchase"
                         next_title="Post Purchase" %}

[abort-feature]: /checkout-v3/business/features/core/abort
[sequence-diagrams]: /checkout-v3/sequence-diagrams#business-seamless-view
[login-checkin]: /assets/img/checkout/checkin.png
[seamless-view-events]: /checkout-v3/business/features/technical-reference/seamless-view-events
[seamless-payment-menu-mixed]: /assets/img/checkout/checkout-v3-business-seamless-menu.png
[checkin-enter-details-mixed]: /assets/img/checkout/checkin-enter-shipping-address.png
[checkin-new-payer]: /assets/img/checkout/checkin-new-payer.png
[checkin-new-payer-ssn]: /assets/img/checkout/checkin-new-payer-ssn.png
