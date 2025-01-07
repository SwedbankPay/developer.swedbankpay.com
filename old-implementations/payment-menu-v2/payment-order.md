---
title: Payment Order
permalink: /:path/payment-order/
description: |
  **Payment Order** lets the payer complete their purchase.
menu_order: 300
---

{% assign view_payment_order_javascript_url = "{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=sv-SE"%}

## Step 1: Create Payment Order

We start by performing a `POST` request towards the `paymentorder` resource in
order to create a Payment Order.

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

{% include payment-url.md payment_order=true
when="selecting the payment instrument Vipps or in the 3-D Secure verification
for Credit Card Payments" %}

### Request

{% include payment-order-purchase.md %}

### Response

The response should include this (abbreviated for brevity):


{% capture response_header %}HTTP/1.1 201 Created
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}"
    },
    "operations": [
        {
            "href": "{{ view_payment_order_script_url }}&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-paymentorder",
            "method": "GET",
            "contentType": "application/javascript"
        }
    ]
}{% endcapture %}

 {% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field          | Type     | Description                                                                        |
| :------------- | :------- | :--------------------------------------------------------------------------------- |
| {% f paymentOrder, 0 %} | `object` | The payment order object.                                                          |
| {% f id %}   | `string` | {% include fields/id.md resource="paymentorder" %}                      |
| {% f operations, 0 %}   | `array`  | {% include fields/operations.md %} |

The `paymentorder` object is abbreviated since it's just the `id` and
`operations` we are interested in. Store the `id` of the Payment Order
in your system to look up status on the completed payment later.

{% include alert.html type="informative" icon="info" header="URL Storage"
body="The `id` of the Payment Order should be stored for later retrieval. [Read
more about URL usage](/checkout-v3/get-started/fundamental-principles#url-usage)." %}

Then find the `view-paymentorder` operation and embed its `href` in a `<script>`
element. That script will then load the Seamless View for the Payment Menu. We
will look into how to hook that up next.

{% include alert-nested-iframe-unsupported.md %}

{% include alert.html type="informative" icon="info" body="`orderReference` must
be sent as a part of the `POST` request to `paymentorders` and must represent
the order ID of the webshop or merchant website." %}

## Step 2: Display the Payment Menu

To load the payment menu from the JavaScript URL obtained in the back end API
response, it needs to be set as a `script` element's `src` attribute in an HTML
document.

You can cause a page reload and do this with backend-rendered HTML or you can
avoid the page refresh by invoking the POST to create the payment order through
Ajax and then create the script element with JavaScript. We will demonstrate how
to do a JavaScript-based integration below.

First the minimum HTML required to initialize the Payment Menu:

{:.code-view-header}
**HTML**

```html
<!DOCTYPE html>
<html>
    <head>
        <title>Swedbank Pay Payment Menu v2</title>
    </head>
    <body>
        <div id="payment-menu"></div>
        <!-- Here you can specify your own JavaScript file -->
        <script src="<Your-JavaScript-File>"></script>
    </body>
</html>
```

What happens inside `<Your-JavaScript-File>` should look something alike the
following:

{:.code-view-header}
**JavaScript**

```js
var request = new XMLHttpRequest();
request.addEventListener('load', function () {
    response = JSON.parse(this.responseText);
    var script = document.createElement('script');
    // The JavaScript expects a JSON response looking like the created
    // Payment Order, containing the operation 'view-paymentorder.
    var operation = response.operations.find(function (o) {
        return o.rel === 'view-paymentorder';
    });
    script.setAttribute('src', operation.href);
    script.onload = function () {
        // Initialize the Payment Menu and inject it into the 'payment-menu'
        // container <div> defined in the HTML document above.
        payex.hostedView.paymentMenu({
            container: 'payment-menu',
            culture: 'sv-SE'
        }).open();
    };
    // Append the Payment Menu script to the <head>
    var head = document.getElementsByTagName('head')[0];
    head.appendChild(script);
});
// You should replace the address here with your own backend endpoint.
request.open('POST', '<Your-Backend-Endpoint>', true);
request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
// We will send an object containing the amount the Payment Order should be
// created with. This should of course not be hard coded and you may want to
// send more data from the front-end to the back-end to create a Payment Order
// for your particular use-case.
request.send(JSON.stringify({ amount: 1200 }));
```

## Monitoring The Script URL

With the [PCI-DSS v4][pci]{:target="_blank"} changes taking effect on March 31st
2025, merchants are responsible for ensuring the integrity of the HTML script
used in their integration, including monitoring what is loaded into or over it.
Specifically, Seamless View merchants must verify that the script URL embedded
in their iframe originates from Swedbank Pay or another trusted domain. It is
important to note that Swedbank Pay’s PCI responsibility is strictly limited to
the content within the payment iframe. For further details, refer to section
4.6.3 in the linked document.

To ensure compliance, we recommend implementing [Content Security Policy][csp]{:target="_blank"}
rules to monitor and authorize scripts.

Merchants must whitelist the following domains to restrict browser content
retrieval to approved sources. While `https://*.payex.com` and
`https://*.swedbankpay.com` cover most payment methods, digital wallets such as
Apple Pay, Click to Pay, and Google Pay are delivered via Payair. Alongside the
Payair URL, these wallets may also generate URLs from Apple, Google, MasterCard,
and Visa. See the table below for more information.

When it comes to ACS URLs, nothing is loaded from the ACS domain in the
merchant's end. It will either happen within Swedbank Pay's domain or as a
redirect, which will repeal the merchant's CSP.

{% include alert.html type="success" icon="info" body="The list below includes
important URLs, but may not be exhaustive. Merchants need to stay up to date in
case of URL changes, or if you need to whitelist URLs not listed here." %}

{:.table .table-striped}
| URL    | Description             |
| :------ | :--------------- |
| https://*.cdn-apple.com | URL needed for Apple Pay.     |
| https://*.google.com | URL needed for Google Pay.     |
| https://*.gstatic.com | Domain used by Google that hosts images, CSS, and javascript code to reduce bandwidth usage online.     |
| https://*.mastercard.com | URL needed for Click to Pay.     |
| https://*.payair.com | URL for the digital wallets Apple Pay, Click to Pay and Google Pay.     |
| https://*.payex.com    | Universal URL for all payment methods except the digital wallets Apple Pay, Click to Pay and Google Pay.     |
| https://*.swedbankpay.com | Universal URL for all payment methods except the digital wallets Apple Pay, Click to Pay and Google Pay.     |
| https://*.visa.com | URL needed for Click to Pay.     |

This should bring up the Payment Menu in a Seamless View. It should look like
this, depending on whether the payer is identified (top) or a guest user
(bottom):

{:.text-center}
![Payment Menu v2 with payer identified in and card payment opened][login-payment-menu-image]{:width="450" height="900"}

{:.text-center}
![Payment Menu v2 with guest payer and card payment opened][guest-payment-menu-image]{:width="450" height="850"}

When the payer completes the payment, the Payment Menu script will be
signaled and a full redirect to the `completeUrl` sent in with the
Payment Order will be performed. When the `completeUrl` on your server is hit,
you can inspect the status on the stored `paymentorder.id` on the server, and
then perform `capture`.

If the payment is a `Sale` or one-phase purchase, it will be automatically
captured. A third scenario is if the goods are sent physically to the payer;
then you should not do a capture until the goods are sent.

You may open and close the payment menu using `.open()` and `.close()`
functions. You can also invoke `.refresh()` to
[update the Payment Menu][operations] after any changes to the
order.

Below, you will see a complete overview of the payment menu process.
Notice that there are two ways of performing the payment:

*   Payer performs payment **out** of `iframe`.
*   Payer performs payment **within** `iframe`.

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

rect rgba(138, 205, 195, 0.1)
            activate Payer
            note left of Payer: Payment Menu
            Payer ->>+ Merchant: Initiate Purchase
            deactivate Payer
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders (paymentUrl, payer)
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel:view-paymentorder
            deactivate SwedbankPay
            Merchant -->>- Payer: Display Payment Menu on Merchant Page
            activate Payer
            Payer ->> Payer: Initiate Payment Menu Seamless View (open iframe)
            Payer -->>+ SwedbankPay: Show Payment UI page in iframe
            deactivate Payer
            SwedbankPay ->>+ Payer: Do payment logic
            deactivate SwedbankPay

                opt Payer perform payment out of iFrame
                    Payer ->> Payer: Redirect to 3rd party
                    Payer ->>+ 3rdParty: Redirect to 3rdPartyUrl URL
                    deactivate Payer
                    3rdParty -->>+ Payer: Redirect back to paymentUrl (merchant)
                    deactivate 3rdParty
                    Payer ->> Payer: Initiate Payment Menu Seamless View (open iframe)
                    Payer ->>+ SwedbankPay: Show Payment UI page in iframe
                    deactivate Payer
                    SwedbankPay ->> Payer: Do payment logic
                end

        SwedbankPay -->> Payer: Payment status
        deactivate SwedbankPay

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
```

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="/old-implementations/payment-menu-v2/capture"
                         next_title="Capture" %}

[guest-payment-menu-image]: /assets/img/checkout/guest-payment-menu.png
[login-payment-menu-image]: /assets/img/checkout/swedish-logged-in-payment-menu.png
[operations]: /old-implementations/checkout-v2/features/technical-reference/operations
[pci]: https://www.swedbankpay.se/globalassets/global-documents/risk-and-security/pci-dss-v4-0-saq-a-r2.pdf
[csp]: https://www.w3.org/TR/CSP2/
