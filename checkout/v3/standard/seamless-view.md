---
title: Seamless View
redirect_from: /payments/card/seamless-view
estimated_read: 10
description: |
  The Seamless View purchase scenario shows you how to implement the payment
  menu directly in your webshop.
menu_order: 300
---

Below, you will see a sequence diagram of a Seamless View integration.

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
            SwedbankPay -->> Merchant: Payment Details
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

In some instances you need the possibility to abort purchases. This could be if
a payer does not complete the purchase within a reasonable timeframe. For those
instances we have `abort`, which you can read about in the [core
features][abort-feature]. You can only use `abort` if the payer **has not**
completed an `authorize` or a `sale`.

{% include payment-url.md when="selecting the payment instrument Vipps or in the
3-D Secure verification for Card Payments" %}

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-standard.md integration_mode="seamless_view" %}

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
refresh by invoking the POST to create the payment order through Ajax and then
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
        // Checkin inside 'checkin-container'.

        // to open the Checkin
        window.payex.hostedView.checkout({
            container: {
                checkinContainer: "checkin-container",
                paymentMenuContainer: "payment-menu-container",
            },
            culture: 'nb-No',
            onShippingDetailsAvailable: function onShippingDetailsAvailable(shippingDetailsAvailableEvent) {
                console.log(shippingDetailsAvailableEvent);
            },
        }).open("checkin");
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

After you have received the shipping details, you can update the payment order
with shipping costs, then proceed to initialize the payment menu.

{:.code-view-header}
**JavaScript**

```js
//to open the Payment Menu
window.payex.hostedView.checkout({
    container: {
        checkinContainer: "checkin-container",
        paymentMenuContainer: "payment-menu-container",
    },
    culture: 'nb-No',
}).open("paymentmenu");
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
            <div id="checkin-container"></div>
            <div id="payment-menu-container"></div>
            <!-- Here you can specify your own javascript file -->
            <script src="<Your-JavaScript-File-Here>"></script>
        </body>
    </html>
```

The result should look like this. First you will see a Checkin module where the
payer can enter their email and phone number.

{:.text-center}
![screenshot of the authentication model seamless view checkin][seamless-view-checkin]

After checking in, the contact details and shipping address are displayed, along
with the available shipping option(s). When the payer chooses a shipping option,
the payment menu will appear. The payer can then proceed with the purchase.

{:.text-center}
![screenshot of the standard model seamless view contact details and shipping options][seamless-view-details-shipping]

{:.text-center}
![screenshot of the standard model seamless view is shipping confirmed and payment methods][seamless-view-details-shipping]

Once a purchase is complete, you can perform a GET towards the `paymentOrders`
resource to see the purchase state.

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

[abort-feature]: /checkout/v3/standard/features/core/abort
[callback]: /checkout/v3/authentication/features/technical-reference/callback
[seamless-view-checkin]: /assets/img/checkout/authentication-seamless-view-checkin.png
[seamless-view-events]: /checkout/v3/authentication/features/technical-reference/seamless-view-events
[seamless-view-payment-menu]: /assets/img/checkout/authentication-seamless-view-payment-menu.png