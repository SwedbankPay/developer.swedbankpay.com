---
title: Redirect
estimated_read: 12
description: |
  Redirect is our simplest integration, where Swedbank Pay handles the
  purchase, so you can focus on your core activities. When ready to pay, the
  payer will be redirected to a secure Swedbank Pay hosted site, authenticate
  the Checkout profile and choose their payment instrument. After the purchase,
  the payer will be redirected back to your website.
menu_order: 200
---

Below, you can see a sequence diagram of a Swedbank Pay
checkout integration using the Redirect solution.

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, Payer refers to the merchant front-end
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
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders (completeUrl, payer information)
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel:redirect-checkout
            deactivate SwedbankPay
            Merchant -->>- Payer: Redirect payer to SwedbankPay purchase page.
            activate Payer
            Payer ->> Payer: Initiate Authenticate step
               Payer ->> SwedbankPay: Show Checkin component
    deactivate Payer
    activate SwedbankPay
    SwedbankPay ->> Payer: Payer identification process
    activate Payer
    Payer ->> SwedbankPay: Payer identification process
    deactivate Payer
    SwedbankPay -->> Payer: show payer completed iframe
    activate Payer
    Payer ->> Payer: Initiate Purchase step

    deactivate Payer
    SwedbankPay ->>+ Payer: Do purchase logic
    Payer ->> SwedbankPay: Do purchase logic
    deactivate Payer
    deactivate SwedbankPay

                    opt Payer perform purchase out of iFrame
                    activate Payer
                    Payer ->> Payer: Redirect to 3rd party
                    Payer ->>+ 3rdParty: Redirect to 3rdPartyUrl URL
                    deactivate Payer
                    3rdParty -->>+ Payer: Redirect back to SwedbankPay
                    deactivate 3rdParty
                    Payer ->> Payer: Initiate Payment Menu
                    Payer ->>+ SwedbankPay: Show Purchase UI page in iframe
                    deactivate Payer
                end

                activate SwedbankPay
                SwedbankPay -->> Payer: Purchase status
                deactivate SwedbankPay

            alt If Purchase is completed
            activate Payer
            Payer ->> Payer: Redirect back to CompleteUrl
            Payer ->>+ Merchant: Check Purchase status
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
            end

activate Merchant
Merchant -->>- Payer: Show Purchase complete
         opt PaymentOrder Callback (if callbackUrls is set) ①
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

*   ① Read more about [callback][callback] handling in the technical reference.

## Step 1: Create Payment Order And Checkin

When the purchase is initiated, you need to create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

Two new fields have been added to the payment order request in this integration.
`requireConsumerInfo` and `digitalProducts`. They are a part of the `payer`
node. Please note that `shippingAdress` is only required if `digitalProducts` is
set to `false`. `requireConsumerInfo` **must** be set to `false`.

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-order-checkout-authenticate.md integration_mode="redirect" %}

Supported features for this integration are subscriptions (`recur` and
`unscheduled MIT`), split settlement (`subsite`) and the possibility to use your
own `logo`.

## Step 2: Display Payment Menu And Checkin

Among the operations in the POST `paymentOrders` response, you will find the
`redirect-paymentmenu`. This is the one you need to display the checkin and
payment menu.

{:.code-view-header}
**Response**

```
{
    "paymentOrder": {
    "operations": [
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/payment/menu/b934d6f84a89a01852eea01190c2bbcc937ba29228ca7502df8592975ee3bb0d",
            "rel": "redirect-paymentmenu",
            "contentType": "text/html"
        },
    ]
}
```

The redirect link opens the payment menu in checkin state. The first page will
be the checkin page where the payer provides their email and phone number.

{:.text-center}
![screenshot of the authentication model redirect checkin][redirect-checkin]

After checking in, the payment menu will appear on a new page with the payer
information displayed above the menu. The payer can select their preferred
payment instrument and pay.

{:.text-center}
![screenshot of the authentication model redirect payment menu][redirect-payment-menu]

Once the payer has completed the purchase, you can perform a GET towards the
`paymentOrders` resource to see the purchase state.

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="post-purchase"
                         next_title="Post Purchase" %}

[callback]: /checkout/v3/authentication/features/technical-reference/callback
[redirect-checkin]: /assets/img/checkout/authentication-redirect-checkin.png
[redirect-payment-menu]: /assets/img/checkout/authentication-redirect-payment-menu.png
