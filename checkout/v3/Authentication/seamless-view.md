---
title: Seamless View
redirect_from: /payments/card/seamless-view
estimated_read: 10
description: |
  The Seamless View purchase scenario
  represents the opportunity to implement card payments
  directly in your webshop.
menu_order: 300
---

Below, you will see a sequence diagram a Swedbank Pay
checkout integration using the Seamless view solution.

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
            note left of Payer: Checkout Authenticate seamless view
            activate Payer
            Payer ->>+ Merchant: Initiate Purchase
            deactivate Payer
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders (hostUrls, paymentUrl, payer information)
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel:view-paymentmenu
            deactivate SwedbankPay
            Merchant -->>- Payer: Display SwedbankPay Payment Menu on Merchant Page
            activate Payer
            Payer ->> Payer: Initiate Authentication Step
               Payer ->>+ SwedbankPay: Show Checkin component in iframe ③
    deactivate Payer
    SwedbankPay ->>- Payer: Consumer identification process
    activate Payer
    Payer ->>+ SwedbankPay: Consumer identification process
    deactivate Payer
    SwedbankPay -->>- Payer: show consumer completed iframe
    activate Payer
    Payer ->> Payer: EVENT: onConsumerIdentified ④
    Payer ->> Payer: Initiate Payment step
            deactivate Payer
            SwedbankPay ->>+ Payer: Do payment logic
            deactivate SwedbankPay
            Payer ->> SwedbankPay: Do payment logic
            deactivate Payer

                opt Consumer perform payment out of iFrame
                    activate Payer
                    Payer ->> Payer: Redirect to 3rd party
                    Payer ->>+ 3rdParty: Redirect to 3rdPartyUrl URL
                    deactivate Payer
                    3rdParty -->>+ Payer: Redirect back to paymentUrl (merchant)
                    deactivate 3rdParty
                    Payer ->> Payer: Initiate Payment Menu Seamless View (open iframe)
                    Payer ->>+ SwedbankPay: Show Payment UI page in iframe
                    deactivate Payer
                end

        SwedbankPay -->> Payer: Payment status

            alt If payment is completed
            activate Payer
            Payer ->> Payer: Event: onPaymentCompleted
            Payer ->>+ Merchant: Check payment status
            deactivate Payer
            Merchant ->>+ SwedbankPay: GET <paymentorder.id>
            deactivate Merchant
            SwedbankPay ->>+ Merchant: rel: paid-paymentorder
            deactivate SwedbankPay
            opt Get PaymentOrder Details (if paid-paymentorder operation exist)
            activate Payer
            deactivate Payer
            Merchant ->>+ SwedbankPay: GET rel: paid-paymentorder
            deactivate Merchant
            SwedbankPay -->> Merchant: Payment Details
            deactivate SwedbankPay
            end
            end

                opt If payment is failed
                activate Payer
                Payer ->> Payer: Event: OnPaymentFailed
                Payer ->>+ Merchant: Check payment status
                deactivate Payer
                Merchant ->>+ SwedbankPay: GET {paymentorder.id}
                deactivate Merchant
                SwedbankPay -->>+ Merchant: rel: failed-paymentorder
                deactivate SwedbankPay
                opt Get PaymentOrder Details (if failed-paymentorder operation exist)
                activate Payer
                deactivate Payer
                Merchant ->>+ SwedbankPay: GET rel: failed-paymentorder
                deactivate Merchant
                SwedbankPay -->> Merchant: Payment Details
                deactivate SwedbankPay
                end
                end
        activate Merchant
        Merchant -->>- Payer: Show Purchase complete
            opt PaymentOrder Callback (if callbackUrls is set)
            activate Payer
            deactivate Payer
                SwedbankPay ->> Merchant: POST Payment Callback
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

## Step 1: Create Payment Order And Checkin

When the purchase is initiated, you need to create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

Two new fields have been added to the payment order request in this integration.
`requireConsumerInfo` and `digitalProducts`. They are a part of the `payer`
node. Please note that `shippingAdress` is only required if `digitalProducts` is
set to `false`.

{% include payment-url.md when="selecting the payment instrument Vipps or in the
3-D Secure verification for Card Payments" %}

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-authenticate.md %}

## Step 2: Display Payment Menu And Checkin

Among the operations in the POST `paymentOrders` response, you will find the
`view-paymentmenu`. This is the one you need to display the payment.

{:.code-view-header}
**Response**

```
{
    "paymentOrder": {
    "operations": [
        {
            "method": "GET",
            "href": "https://ecom.stage.payex.com/payment/core/js/px.payment.client.js?token=dd728a47e3ec7be442c98eafcfd9b0207377ce04c793407eb36d07faa69a32df&culture=sv-SE",
            "rel": "view-paymentmenu",
            "contentType": "text/html"
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
                        return o.rel === 'view-paymentmenu';
                    });
                    script.setAttribute('src', operation.href);
                    script.onload = function () {
                        // When the 'view-paymentmenu' script is loaded, we can initialize the
                        // Payment Menu inside our 'payment-menu' container.
                        payex.hostedView.paymentMenu({
                            container: 'payment-menu',
                            culture: 'sv-SE'
                        }).open();
                    };
                    // Append the Payment Menu script to the <head>
                    var head = document.getElementsByTagName('head')[0];
                    head.appendChild(script);
                });
                // Like before, you should replace the address here with
                // your own endpoint.
                request.open('GET', '<Your-Backend-Endpoint-Here>', true);
                request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
                request.send();
```

The result should look like this. First you will see a Checkin module where the
payer can enter their email and phone number.

{:.text-center}
![screenshot of the authentication model seamless view checkin][seamless-view-checkin]

After checking in, the payment menu will appear with the payer information
displayed above the menu. The payer can select their preferred payment
instrument and pay.

{:.text-center}
![screenshot of the authentication model seamless view payment menu][seamless-view-payment-menu]

Once the payer has completed the purchase, you can perform a GET towards the
`paymentOrders` resource to see the payment state.

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

You are now ready to capture the funds. Follow the link below to read more.

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="capture"
                         next_title="Capture" %}

[seamless-view-checkin]: /assets/img/checkout/authentication-seamless-view-checkin.png
[seamless-view-events]: /checkout/v3/authentication/features/technical-reference/seamless-view-events
[seamless-view-payment-menu]: /assets/img/checkout/authentication-seamless-view-payment-menu.png
