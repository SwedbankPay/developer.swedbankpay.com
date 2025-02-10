---
title: Redirect
permalink: /:path/redirect/
description: |
  How to display the Seamless View UI in your webshop.
menu_order: 5
---

## Display Redirect

Among the operations in the POST `paymentOrder`s response, you will find
`redirect-checkout`. This is the one you need to display the payment UI.

{% capture response_content %}{
    "paymentOrder": {
    "operations": [
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/payment/menu/b934d6f84a89a01852eea01190c2bbcc937ba29228ca7502df8592975ee3bb0d?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
    ]
}{% endcapture %}

 {% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## How Redirect Looks

The redirect link opens the payment menu in a new page where the payer can
select their preferred payment method and pay.

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
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>Payment Methods that support <br>Authorizations.
        end
```

*   ① Read more about [callback][payments-callback] handling in the technical reference.

{% include iterator.html prev_href="/checkout-v3/get-started/display-payment-ui/"
                         prev_title="Display Payment UI"
                         next_href="/checkout-v3/get-started/post-purchase"
                         next_title="Post-Purchase v3.0" %}
{% include iterator.html next_href="/checkout-v3/get-started/post-purchase-3-1"
                         next_title="Post-Purchase v3.1" %}

[redirect-payments-only-menu]: /assets/img/redirect-wcag.png
[payments-callback]: /checkout-v3/features/payment-operations/callback
