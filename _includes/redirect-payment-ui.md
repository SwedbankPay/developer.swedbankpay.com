---
title: Redirect
permalink: /:path/redirect-payment-ui/
description: |
  How to display the Redirect UI in your webshop.
menu_order: 5
---

{: .h2 }

### Display Redirect

Among the operations in the POST `paymentOrder`s response, you will find
`redirect-checkout`. This is the one you need to display the payment UI.

{% capture response_content %}{
    "paymentOrder": {}
    "operations": [
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/6445a0d8d9a7f80a37f4e46fc600a0534a832e4b6ec0dbb6768dd362d9401a8b?_tc_tid=30f2168171e142d38bcd4af2c3721959",
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

{: .h2 }

### How Redirect Looks

{% include alert.html type="informative" icon="info" body="
We strongly advice against displaying the redirect page inside of an iFrame.
If you need to be able to show the checkout page on your site, rather than
redirecting to our page, we recommend you implement the Seamless View
solution instead." %}

With the link, you only need to redirect the payer to the site to give them the
option to select their preferred payment method to pay with.

{:.text-center}
![screenshot of the merchant managed implementation redirect payment menu][redirect-payments-only-menu]

Once the payer has completed the purchase, you can perform a `GET` towards the
`paymentOrders` resource to see the purchase state.

[Top of page](#display-redirect)

{: .h2 }

### Redirect Sequence Diagram

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
    Merchant ->>+ SwedbankPay: POST /psp/paymentorders (completeUrl, payer information)
    SwedbankPay -->>- Merchant: rel:redirect-checkout
    Merchant -->>- Payer: Redirect payer to SwedbankPay purchase page.
    Payer ->> Payer: Initiate Purchase step
    Payer ->>+ SwedbankPay: Do purchase logic
    activate SwedbankPay

    opt Payer perform purchase out of iFrame
        SwedbankPay ->>- Payer: Redirect to 3rd party required
        Payer ->>+ 3rdParty: Redirect to 3rdPartyUrl URL
        3rdParty -->>- Payer: Redirect back to SwedbankPay
        Payer ->> Payer: Initiate Payment Menu
        Payer ->>+ SwedbankPay: Show Purchase UI page in iframe
    end

    SwedbankPay -->>- Payer: Purchase status

    alt If Purchase is completed
        Payer ->> Payer: Redirect back to CompleteUrl
        Payer ->>+ Merchant: Check Purchase status
        Merchant ->>+ SwedbankPay: GET <paymentorder.id>
        SwedbankPay ->>- Merchant: Status: Paid
    end

    Merchant -->>- Payer: Show Purchase complete
    deactivate Payer

    opt PaymentOrder Callback (if callbackUrls is set) ①
        SwedbankPay ->> Merchant: POST Purchase Callback
    end
end

rect rgba(81,43,43,0.1)
    note right of Payer: Capture
    Merchant ->>+ SwedbankPay: rel:capture
    SwedbankPay -->>- Merchant: Capture status
    note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>Payment Methods that support <br>Authorizations.
end
```

*   ① Read more about [callback][payments-callback] handling in the technical reference.

{: .h2 }

### Next Steps

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.

[Top of page](#display-redirect)

{% include iterator.html prev_href="/checkout-v3/get-started/payment-request"
                         prev_title="Back To Payment Request"
                         next_href="/checkout-v3/get-started/validate-status"
                         next_title="Validate Status" %}

[redirect-payments-only-menu]: /assets/img/redirect-wcag.png
[payments-callback]: /checkout-v3/features/payment-operations/callback
