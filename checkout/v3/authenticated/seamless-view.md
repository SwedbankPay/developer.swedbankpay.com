---
title: Seamless View
redirect_from: /payments/card/seamless-view
estimated_read: 10
description: |
  The Seamless View purchase scenario shows you how to implement the payment
  menu directly in your webshop.
menu_order: 300
---

Below is a sequence diagram of a Seamless View integration.

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay
    participant 3rdParty

        rect rgba(238, 112, 35, 0.05)
            activate Payer
            Payer ->>+ Merchant: Initiate Purchase
            deactivate Payer
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders (hostUrls, paymentUrl, payer information)
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel:view-checkout
            deactivate SwedbankPay
            Merchant -->>- Payer: Display SwedbankPay Payment Menu on merchant page
            activate Payer
            Payer ->> Payer: Initiate Authenticate step
               Payer ->> SwedbankPay: Show Checkin component in iframe
    deactivate Payer
    activate SwedbankPay
    SwedbankPay ->> Payer: Payer identification process
    activate Payer
    Payer ->> SwedbankPay: Payer identification process
    deactivate Payer
    SwedbankPay -->> Payer: show payer completed iframe
    activate Payer
    Payer ->> Payer: EVENT: onConsumerIdentified ①
    Payer ->> Payer: Initiate Purchase step
    deactivate Payer
    SwedbankPay ->>+ Payer: Do purchase logic
    Payer ->> SwedbankPay: Do purchase logic
    deactivate Payer
    deactivate SwedbankPay

                    opt Payer performs purchase out of iFrame
                    activate Payer
                    Payer ->> Payer: Redirect to 3rd party
                    Payer ->>+ 3rdParty: Redirect to 3rdPartyUrl URL
                    deactivate Payer
                    3rdParty -->>+ Payer: Redirect back to paymentUrl (merchant)
                    deactivate 3rdParty
                    Payer ->> Payer: Initiate Payment Menu Seamless View (open iframe)
                    Payer ->>+ SwedbankPay: Show Purchase UI page in iframe
                    deactivate Payer
                end

                activate SwedbankPay
                SwedbankPay -->> Payer: Purchase status
                deactivate SwedbankPay

            alt If purchase is completed
            activate Payer
            Payer ->> Payer: Event: onPaymentCompleted ①
            Payer ->>+ Merchant: Check purchase status
            deactivate Payer
            Merchant ->>+ SwedbankPay: GET <paymentorder.id>
            deactivate Merchant
            SwedbankPay ->>+ Merchant: rel: paid-paymentorder
            deactivate SwedbankPay
            opt Get PaymentOrder Details (if paid-paymentorder operation exist)
            Merchant ->>+ SwedbankPay: GET rel: paid-paymentorder
            deactivate Merchant
            SwedbankPay -->> Merchant: Purchase Details
            deactivate SwedbankPay
            end
                        activate Merchant
Merchant -->>- Payer: Show Purchase complete
            end

            alt If purchase is failed
            activate Payer
            Payer ->> Payer: Event: OnPaymentFailed ①
            Payer ->>+ Merchant: Check purchase status
            deactivate Payer
            Merchant ->>+ SwedbankPay: GET {paymentorder.id}
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel: failed-paymentorder
            deactivate SwedbankPay
            opt Get PaymentOrder Details (if failed-paymentorder operation exist)
            Merchant ->>+ SwedbankPay: GET rel: failed-paymentorder
            deactivate Merchant
            SwedbankPay -->> Merchant: Purchase Details
            deactivate SwedbankPay
            end
            activate Merchant
            Merchant -->>- Payer: Display SwedbankPay Payment Menu on merchant page
            end

         opt PaymentOrder Callback (if callbackUrls is set) ②
                activate SwedbankPay
                SwedbankPay ->> Merchant: POST Purchase Callback
                deactivate SwedbankPay
         end
         end

    rect rgba(81,43,43,0.1)
        activate Merchant
        note left of Payer: Capture
        Merchant ->>+ SwedbankPay: rel:create-paymentorder-capture
        deactivate Merchant
        SwedbankPay -->>- Merchant: Capture status
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>PaymentInstruments that support <br>Authorizations.
        end
```

*   ① See [seamless view events][seamless-view-events] for further information.
*   ② Read more about [callback][callback] handling in the technical reference.

## Step 1: Create Payment Order And Checkin

When the purchase is initiated, you need to create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

Two new fields have been added to the payment order request in this integration.
`requireConsumerInfo` and `digitalProducts`. They are a part of the `payer`
node. Please note that `shippingAdress` is only required if `digitalProducts` is
set to `false`. `requireConsumerInfo` **must** be set to `false`.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [core features][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`.

{% include payment-url.md when="selecting the payment instrument Vipps or in the
3-D Secure verification for Card Payments" %}

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-authenticate.md integration_mode="seamless_view" %}

## Step 2: Display Payment Menu And Checkin

Among the operations in the POST `paymentOrders` response, you will find the
`view-checkout`. This is what you need to display the checkin and payment
module.

{:.code-view-header}
**Response**

```
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
        // Checkin and Payment Menu inside 'checkout-container'.
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

```
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

First you will see a Checkin module where the payer can enter their email and
phone number.

{:.text-center}
![screenshot of the authenticated implementation seamless view checkin][login-checkin]

A known payer will be sent directly to the payment menu shown below. If we
detect that the payer is new, we give them the option to save their details or
proceed without saving. If that happens, these checkin steps will appear. Notice
the lack of address input for digital products (bottom screenshot).

{:.text-center}
![screenshot of the seamless view checkin when the payer is new][checkin-new-payer]

{:.text-center}
![screenshot of the seamless view checkin when entering details][checkin-enter-details-mixed]

{:.text-center}
![screenshot of the seamless view checkin when entering details][checkin-enter-details-digital]

After checking in, the payment menu will appear with the payer information
displayed above the menu. The payer can select their preferred payment
instrument and pay. The example with shipping address is for all goods (physical
and digital), the one without shipping address is for digital products only.

{:.text-center}
![screenshot of the authenticated implementation seamless view payment menu mixed][seamless-payment-menu-mixed]

{:.text-center}
![screenshot of the authenticated implementation seamless view payment menu digital][seamless-payment-menu-digital]

Once the payer has completed the purchase, you can perform a GET towards the
`paymentOrders` resource to see the purchase state.

You can read about the different [Seamless View Events][seamless-view-events] in
the feature section.

If you want to see the payer activities, they are visible in the history node:

```
{
 "name": "CheckinInitiated",
 "initiatedBy": "System"
}
{
 "name": "PayerCheckedIn",
 "initiatedBy": "Consumer"
}
{
 "name": "PayerDetailsRetrieved",
 "initiatedBy": "System"
}
{
 "name": "MerchantAuthenticatedConsumerCheckedIn",
 "initiatedBy": "System"
}
```

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="post-purchase"
                         next_title="Post Purchase" %}

[abort-feature]: /checkout/v3/authenticated/features/core/abort
[callback]: /checkout/v3/authenticated/features/technical-reference/callback
[checkin-enter-details-digital]:
[checkin-enter-details-mixed]:
[checkin-new-payer]:
[seamless-view-events]: /checkout/v3/authenticated/features/technical-reference/seamless-view-events
[seamless-payment-menu-digital]: /assets/img/checkout/v3/payment-menu-seamless-digital.png
[seamless-payment-menu-mixed]: /assets/img/checkout/v3/payment-menu-seamless-mixed-products.png
