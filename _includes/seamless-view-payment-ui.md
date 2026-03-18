{: .h2 .pt-3 }

### Display Seamless View

<div class="slab mb-5">
  <ul class="toc-list" role="navigation" aria-label="Article content">
    <li>
      <a href="#load-the-seamless-view">
       Load the Seamless View
      </a>
    </li>
    <li>
      <a href="#seamless-view-events-and-functions">
        Seamless View Events and Functions
      </a>
    </li>
    <li>
      <a href="#how-seamless-view-looks">
        How Seamless View Looks
      </a>
    </li>
    <li>
      <a href="#seamless-view-sequence-diagram">
        Seamless View Sequence Diagram
      </a>
    </li>
    <li>
      <a href="#change-from-seamless-view-to-redirect-ui">
        Change from Seamless View to Redirect UI
      </a>
      <ul role="list">
        <li>
          <a href="#use-redirect-operation">
          Use Redirect Operation
          </a>
        </li>
        <li>
          <a href="#remove-seamless-view-code">
          Remove Seamless View Code
          </a>
        </li>
        <li>
          <a href="#change-urls">
          Change URLs
          </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#monitoring-the-script-url">
        Monitoring the Script URL
      </a>
    </li>
    <li>
      <a href="#seamless-view---next-steps">
        Seamless View - Next Steps
      </a>
    </li>
  </ul>
</div>

Among the operations in the POST `paymentOrder` response, you will find the
`view-checkout`. This is the one you need to display the purchase module.

{% capture response_content %}{
    "paymentOrder": {},
    "operations": [
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/client/1c168a5f971f0cacd00124d1b9ee13e5ecf6e3e74e59cb510035973b38c2c3b3?culture=sv-SE&_tc_tid=123a825592f2002942e5f13eee012b11",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        },
    ]
}{% endcapture %}

 {% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{: .h2 }

### Load the Seamless View

{% include alert-nested-iframe-unsupported.md %}

Section Keywords:

*   Container - The HTML element where the payment UI iframe is rendered.
*   Client script - The script returned from the payment creation `POST` response
which loads the payment UI on your page.
*   Events - Optional handlers which allow you to respond to events from the
payment UI.
*   Functions - Client-side actions used to control the payment UI, such as
opening, refreshing, or updating the view.

As advised by [WCAG v2.2][wcag]{:target="_blank"} section **1.3.1** and
**2.4.3**, we recommend that you mark the container where you host you iframe
as either `<main>` or `role=<main>`.

{:.code-view-header}
**HTML**

```html
<!DOCTYPE html>
<html>
    <head>
        <title>Swedbank Pay Example Container</title>
    </head>
    <body>
        <main id="payex-checkout"></main>
        <script src="<Your-JavaScript-File-Here>"></script>
    </body>
</html>
```

To display the UI, use the `href` from the previously created
[`POST` request][payment-request] and add it to a `script` element on the
webpage. This URL points to the client script that loads the payment UI.

When the script has loaded, you can call `payex.hostedView.checkout().open()` to
render the payment menu.

There are a few parameters we can set to further customize the menu itself,
which are shown in the example below. This includes the place we want to
open up the menu (container), the language we want the menu to
display (culture), and any events we want to override.

{:.code-view-header}
**Your-JavaScript-File-Here**

```js
const url = new URL("https://ecom.externalintegration.payex.com/checkout/client/1c168a5f971f0cacd00124d1b9ee13e5ecf6e3e74e59cb510035973b38c2c3b3?culture=sv-SE&_tc_tid=123a825592f2002942e5f13eee012b11");

const script = document.createElement("script");
script.src = url.href;
script.type = "text/javascript";
script.id = "payex-checkout-script";
script.onload = function() {
    payex.hostedView.checkout({container: {checkout: "payex-checkout"}}).open();
}
document.body.insertAdjacentElement("afterbegin", script);
```

{: .h3 }

#### Configuration of the Script

After placing the client script onto your website and providing it with a
container, you can start using the functions to load the payment UI, but before
you can _open_ the UI, you need to configure it.

{:.code-view-header}
**Configuring the UI**

```js
payex.hostedView.checkout({
    container: { "checkout": "string" },
    culture: "en-US",
    style: { "object" },
    integration: "HostedView"
});
```

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f container, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The container object</div></div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f checkout %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            The <code>id</code> of the <code>DOM</code> element you want to
            embed the Payment UI inside.
          </div>
        </div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f culture, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Locale identifier string for the language the Payment UI should launch
        with: <code>da-DK</code>, <code>de-DE</code>, <code>et-EE</code>, <code>en-US</code>, <code>es-ES</code>, <code>fi-FI</code>, <code>fr-FR</code>, <code>lt-LT</code>, <code>lv-LV</code>, <code>nb-NO</code>, <code>pl-PL</code>, <code>ru-RU</code> or <code>sv-SE</code>. if the input is invalid, the culture will default to
        <code>en-US</code>. If no culture is set, it will default to the language
        set in the payment order.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f style, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Key/Value object with the details of the colors and borders you want for
        the various components of the payment button. Read more about your options
        for <a href="https://developer.swedbankpay.com/checkout-v3/features/customize-ui/">customizing your UI</a>.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f integration, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Specify the integration used for the UI: <code>HostedView</code> (Seamless View), <code>Redirect</code> and <code>App</code>.
      </div>
    </div>
  </details>
</div>

{: .text-right}
[Top of page](#display-seamless-view)

{: .h2 }

### Seamless View Events and Functions

When you integrate using the Seamless View implementation, you can subscribe to
events, which are notifications from our system about actions that have
happened. There are also functions, which are command messages you can send to
us, either to trigger actions or override the events.

These range from changing what happens when the payer completes or cancels their
payment, to when we resize the payment menu itself. While optional, this gives
you more flexibility and control over the payment flow, during and after the
payer completes and/or cancels their payment attempt.

Check out the sections for Seamless View [Events][seamless-view-events] or
[Functions][seamless-view-functions] for complete lists of both.

{: .text-right}
[Top of page](#display-seamless-view)

{: .h2 }

### How Seamless View Looks

After opening up the client script, the menu itself will load inside of an
iframe in the container you provided us earlier. From here, the payer can select
their preferred payment method and pay.

{:.text-center}
![screenshot of the enterprise implementation seamless view payment menu][seamless-enterprise-menu]

Once the payer completes their purchase, you can then perform a GET towards the
`paymentOrders` resource to check the purchase state.

{: .text-right}
[Top of page](#display-seamless-view)

{: .h2 }

### Seamless View Sequence Diagram

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
    Merchant ->>+ SwedbankPay: POST /psp/paymentorders (hostUrls, paymentUrl, payer information)
    SwedbankPay -->>- Merchant: rel:view-checkout
    Merchant -->>- Payer: Display SwedbankPay Checkout on Merchant Page
    Payer ->> Payer: Initiate Purchase step
    Payer ->>+ SwedbankPay: Do purchase logic
    activate SwedbankPay

    opt Payer performs purchase out of iFrame
        SwedbankPay ->>- Payer: Redirect to 3rd party required
        Payer ->>+ 3rdParty: Redirecting to 3rd party URL
        3rdParty -->>- Payer: Redirect back to paymentUrl (merchant)
        Payer ->> Payer: Initiate Checkout Seamless View (open iframe)
        Payer ->>+ SwedbankPay: Check purchase status
    end

    SwedbankPay -->>- Payer: Purchase status
    deactivate SwedbankPay

    alt If the purchase is completed
        Payer ->>+ SwedbankPay: GET <paymentorder.id>
        SwedbankPay ->>- Payer: Status: Paid/Failed
        Payer ->> Payer: Show Purchase complete
        Payer ->> Payer: Event: onPaid ①
        note right of Payer: Unless you override OnPaid, this will<br/>cause a redirect to the CompleteUrl
    else If the purchase attampt has failed
        Payer ->>+ SwedbankPay: GET {paymentorder.id}
        SwedbankPay -->>- Payer: Payment Status: Failed
        Payer -->> Payer: Display error message in the Payment UI
        Payer ->> Payer: Event: onPaymentAttemptFailed ①
    end

    opt PaymentOrder Callback (if callbackUrls is set) ②
        SwedbankPay ->> Merchant: POST Purchase Callback
    end

    deactivate Payer
end

rect rgba(81,43,43,0.1)
    note right of Payer: Capture
    Merchant ->>+ SwedbankPay: rel:capture
    SwedbankPay -->>- Merchant: Capture status
    note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>payment methods that support <br>Authorizations.
end
```

*   ① See [seamless view events][payments-seamless-view-events] for further information.
*   ② Read more about [callback][payments-callback] handling in the technical reference.

{: .text-right}
[Top of page](#display-seamless-view)

{: .h2 }

### Change From Seamless View To Redirect UI

As parts of the PCI-DSS best practice became requirements with
[PCI-DSS v4][pci]{:target="_blank"} in April 2025, using the **Seamless View**
integration to display the payment UI puts more responsibilities on merchants
than before. This is because Seamless View is hosted by you. As the **Redirect**
integration is hosted by Swedbank Pay, we also handle these responsibilities.

The PCI-DSS v4 requirements include stricter controls and monitoring,
particularly around the security of your checkout process. Merchants are
responsible for ensuring the integrity of the HTML script used in their
integration, including monitoring what is loaded into or over it. Specifically,
Seamless View merchants must verify that the script URL embedded in their iframe
originates from Swedbank Pay or another trusted domain. It is important to note
that Swedbank Pay’s PCI responsibility is strictly limited to the content within
the payment iframe.

For further details, refer to section **4.6.3** and **11.6.1** in the linked
PCI-DSS document.

Please note that this only applies to payment methods that are affected by
PCI-DSS (Card and Click to Pay). If you only offer payment methods not affected
by PCI-DSS, no actions are necessary. If you want to add PCI-DSS affected
payment methods later, this is something you need to consider.

To learn more about how PCI-DSS affects you, we also have reading available
in [Danish][da]{:target="_blank"}, [Finnish][fi]{:target="_blank"},
[Norwegian][no]{:target="_blank"} and [Swedish][se]{:target="_blank"}.

If you currently have a Seamless View integration and don't want the new
responsibilities, switcing to Redirect is a very manageable task. Here's what
you need to do:

{: .text-right}
[Top of page](#display-seamless-view)

#### Use Redirect Operation

In the operations node of the [payment response][post-response], right next to
`view-checkout` which you should currently be using, you'll find
`redirect-checkout`. The corresponding `href` contains a url which leads to a
Swedbank Pay domain where the payment UI will be displayed and processed. All
you need to do is direct the Payer to this url and wait until one of the
functions are called (`completeUrl`, `cancelUrl` or `callbackUrl`) to proceed
with the payment process.

{% capture response_content %}{
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
    title='Redirect-Checkout Operation'
    header=response_header
    json= response_content
    %}

{: .text-right}
[Top of page](#display-seamless-view)

#### Remove Seamless View Code

You can remove all code related to the `<script>` element used to load the
Seamless View.

{: .text-right}
[Top of page](#display-seamless-view)

#### Change URLs

Finally, you need to do some changes to the `urls` node in your
[payment request][post-request]. The `paymentUrl` field is specific to Seamless
View and can be **removed**.

The url you need to **add** is the `cancelUrl`, so we know where to redirect the
payer if they chose to cancel, or you chose to abort the payment.

If you have permission to [add your own logo][custom-logo] in the payment UI and
want to add one, you also need to include a `logoUrl`. Follow the guidelines in
the section linked above. If no `logoUrl` is added, Swedbank Pay's logo will be
shown by default.

The `completeUrl`, `hostUrls` and `callbackUrl` is universal and must be
included regardless of your UI choice.

{% capture request_content %}{
        "urls": {
            "paymentUrl": "https://example.com/perform-payment"
        }
}{% endcapture %}

{% include code-example.html
    title='Seamless View Specific URL'
    header=request_header
    json= request_content
    %}

{% capture request_content %}{
        "urls": {
            "cancelUrl": "https://example.com/payment-cancelled",
            "logoUrl": "https://example.com/logo.png" //Optional
        }
}{% endcapture %}

{% include code-example.html
    title='Redirect Specific URLs'
    header=request_header
    json= request_content
    %}

{: .text-right}
[Top of page](#display-seamless-view)

{: .h2 }

### Monitoring The Script URL

If you choose to stay with Seamless View, please take the following under
advisement.

To ensure compliance, we recommend implementing Content Security
Policy rules to monitor and authorize scripts.

Merchants must whitelist the following domains to restrict browser content
retrieval to approved sources. While https://*.payex.com and
https://*.swedbankpay.com cover most payment methods, digital wallets such as
Apple Pay, Click to Pay, and Google Pay are delivered via Payair. Alongside the
Payair URL, these wallets may also generate URLs from Apple, Google, MasterCard,
and Visa. See the table below for more information.

When it comes to ACS URLs, nothing is loaded from the ACS domain in the
merchant’s end. It will either happen within Swedbank Pay’s domain or as a
redirect, which will repeal the merchant’s CSP.

The list below includes important URLs, but may not be exhaustive. Merchants
need to stay up to date in case of URL changes, or if you need to whitelist URLs
not listed here.

For further details, refer to section 4.6.3 and 11.6.1 in this [PCI-DSS document][pci-url].

{:.table .table-striped}

| URL                       | Description                                                                                                  |
| :------------------------ | :----------------------------------------------------------------------------------------------------------- |
| https://*.cdn-apple.com   | URL needed for Apple Pay.                                                                                    |
| https://*.google.com      | URL needed for Google Pay.                                                                                   |
| https://*.gstatic.com     | Domain used by Google that hosts images, CSS, and javascript code to reduce bandwidth usage online.          |
| https://*.mastercard.com  | URL needed for Click to Pay.                                                                                 |
| https://*.payair.com      | URL for the digital wallets Apple Pay, Click to Pay and Google Pay.                                          |
| https://*.payex.com       | Universal URL for all payment methods except the digital wallets Apple Pay, Click to Pay and Google Pay.     |
| https://*.swedbankpay.com | Universal URL for all payment methods except the digital wallets Apple Pay, Click to Pay and Google Pay.     |
| https://*.visa.com        | URL needed for Click to Pay.                                                                                 |

{: .text-right}
[Top of page](#display-seamless-view)

{: .h2 }

### Seamless View - Next Steps

You are now ready to validate the payment's status. Follow the link below to
read more about how this is done.

{: .text-right}
[Top of page](#display-seamless-view)

{% include iterator.html prev_href="/checkout-v3/get-started/payment-request"
                         prev_title="Back To Payment Request"
                         next_href="/checkout-v3/get-started/validate-status"
                         next_title="Validate Status" %}

[seamless-view-events]: /checkout-v3/technical-reference/seamless-view-events
[seamless-view-functions]: /checkout-v3/technical-reference/seamless-view-functions
[seamless-enterprise-menu]: /assets/img/wcag-seamless.png
[payments-callback]: /checkout-v3/features/payment-operations/callback
[payment-request]: /checkout-v3/get-started/payment-request/
[payments-seamless-view-events]: /checkout-v3/technical-reference/seamless-view-events
[custom-logo]: /checkout-v3/features/customize-ui/custom-logo/
[post-response]: /checkout-v3/get-started/payment-request/#payment-order-response-v31
[post-request]: /checkout-v3/get-started/payment-request/#payment-order-request-v31
[pci]: /assets/documents/PCI-DSS-v4-0-1-SAQ-A.pdf
[pci-url]: /assets/documents/guidance-for-pci-dss-points.pdf
[da]: https://www.swedbankpay.dk/risiko-og-sikkerhed/pci-sadan-bliver-du-pavirket
[fi]: https://www.swedbankpay.fi/riskit-ja-turvallisuus/nain-pci-vaikuttaa-sinuun
[no]: https://www.swedbankpay.no/risiko-og-sikkerhet/pci-slik-pavirkes-du
[se]: https://www.swedbankpay.se/risk-och-sakerhet/pci-sa-paverkas-du
[wcag]: https://www.w3.org/WAI/WCAG22/quickref/
