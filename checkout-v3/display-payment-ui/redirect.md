---
title: Redirect
description: |
  How to display the Seamless View UI in your webshop.
menu_order: 4
---

## Step 2: Display Redirect

There are a couple of decisions to be made when you are presenting your payment
UI. You have the choice between a payment menu with all the payment instruments
you want to offer, or to present the `paymentOrder` with a single available
payment instrument using instrument mode.

Regardless of the number of instruments available to the payer, you also need to
choose between `Redirect` and `Seamless View`.

With `Redirect`, the payer is sent to a Swedbank Pay page where we handle the
purchase process. The payer is redirected back to you when the purchase is
completed or if the payer aborts the purchase. The page will be styled by
Swedbank Pay.

With `Seamless View`, the payer stays at your site and you initiate the
Swedbank Pay purchase module in an iframe. The purchase component will be styled
by Swedbank Pay.

Among the operations in the POST `paymentOrder`s response, you will find the
`redirect-checkout`. This is the one you need to display payment menu.

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

## How Redirect Looks

The redirect link opens the payment menu on a new page with the payer
information displayed above the menu. The payer can select their preferred
payment instrument and pay.

{:.text-center}
![screenshot of the merchant managed implementation redirect payment menu][redirect-payments-only-menu]

Once the payer has completed the purchase, you can perform a `GET` towards the
`paymentOrders` resource to see the purchase state.

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.

## Redirect Sequence Diagram

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
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders (completeUrl, payer information)
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel:redirect-checkout
            deactivate SwedbankPay
            Merchant -->>- Payer: Redirect payer to SwedbankPay purchase page.
    activate SwedbankPay
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
            SwedbankPay ->>+ Merchant: Status: Paid
            deactivate SwedbankPay
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
        Merchant ->>+ SwedbankPay: rel:capture
        deactivate Merchant
        SwedbankPay -->>- Merchant: Capture status
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>PaymentInstruments that support <br>Authorizations.
        end
```

*   ① Read more about [callback][payments-callback] handling in the technical reference.

{% include iterator.html prev_href="/checkout-v3/display-payment-UI"
                         prev_title="Display Payment UI"
                         next_href="/checkout-v3/post-purchase"
                         next_title="Post Purchase" %}

[redirect-payments-only-menu]: /assets/img/checkout/checkout-v3-redirect-menu.png
[payments-callback]: /checkout-v3/features/core/callback
