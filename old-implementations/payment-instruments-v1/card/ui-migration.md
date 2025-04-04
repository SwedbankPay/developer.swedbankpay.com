---
title: Change UI Option
permalink: /:path/ui-migration/
description: |
    Walking you through switching from Seamless View to Redirect
menu_order: 600
---

As parts of the PCI-DSS best practice becomes requirements with
[PCI-DSS v4][pci]{:target="_blank"} coming in April 2025, using the
[Seamless View][seamless-view] integration to display the payment UI will give
merchants more responsibilities than they currently have. This is because
Seamless View is hosted by you. As the [Redirect][redirect] integration is
hosted by Swedbank Pay, we also handle these responsibilities.

The updated requirements will include stricter controls and monitoring,
particularly around the security of your checkout process. Merchants are
responsible for ensuring the integrity of the HTML script used in their
integration, including monitoring what is loaded into or over it. Specifically,
Seamless View merchants must verify that the script URL embedded in their iframe
originates from Swedbank Pay or another trusted domain. It is important to note
that Swedbank Pay’s PCI responsibility is strictly limited to the content within
the payment iframe.

For further details, refer to section **4.6.3** and **11.6.1** in the linked
PCI-DSS document.

To learn more about how PCI-DSS affects you, we also have reading available
in [Danish][da]{:target="_blank"}, [Finnish][fi]{:target="_blank"},
[Norwegian][no]{:target="_blank"} and [Swedish][se]{:target="_blank"}.

If you currently have a Seamless View integration and don't want the impending
responsibilities, switcing to Redirect is a very manageable task. While you can
make the change and keep on using your payment method integration(s), we
**strongly recommend** switching to [Digital Payments][dp] when you are already
making changes to your integration.

If you choose to continue using payment method integrations, here's what you
need to do:

#### Use Redirect Operation

In the operations node of the [payment response][post-response], right next to
`view-authorization` which you should currently be using, you'll find
`redirect-authorization`. The corresponding `href` contains a url which leads to
a Swedbank Pay domain where the payment UI will be displayed and processed. All
you need to do is direct the Payer to this url and wait until one of the
functions are called (`completeUrl`, `cancelUrl` or `callbackUrl`) to proceed
with the payment process.

{% capture response_content %}{
    "operations": [
        {
          "method": "GET",
          "href": "https://ecom.externalintegration.payex.com/creditcard/payments/authorize/5a17c24e-d459-4567-bbad-aa0f17a76119",
          "rel": "redirect-authorization",
          "contentType": "text/html"
        },
    ]
}{% endcapture %}

 {% include code-example.html
    title='Redirect-Authorization Operation'
    header=response_header
    json= response_content
    %}

#### Remove Seamless View Code

You can remove all code related to the `<script>` element used to load the
Seamless View.

#### Change URLs

Finally, you need to do some changes to the `urls` node in your
[payment request][post-request]. The `paymentUrl` field is specific to Seamless
View and can be **removed**.

The url you need to **add** is the `cancelUrl`, so we know where to redirect the
payer if they chose to cancel, or you chose to abort the payment.

If you have permission to add your own logo in the payment UI and want to add
one, you also need to include a `logoUrl`. Follow the guidelines in the section
linked above. If no `logoUrl` is added, Swedbank Pay's logo will be shown by
default.

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

## Monitoring The Script URL

If you choose to stay with Seamless View, please take the following under
advisement.

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

[dp]: /checkout-v3/
[pci]: /assets/documents/PCI-DSS-v4-0-1-SAQ-A.pdf
[post-response]: /old-implementations/payment-instruments-v1/card/redirect#card-payment-response
[post-request]: /old-implementations/payment-instruments-v1/card/redirect#card-payment-request
[seamless-view]: /old-implementations/payment-instruments-v1/card/seamless-view
[redirect]: /old-implementations/payment-instruments-v1/card/redirect
[da]: https://www.swedbankpay.dk/risiko-og-sikkerhed/pci-sadan-bliver-du-pavirket
[fi]: https://www.swedbankpay.fi/riskit-ja-turvallisuus/nain-pci-vaikuttaa-sinuun
[no]: https://www.swedbankpay.no/risiko-og-sikkerhet/pci-slik-pavirkes-du
[se]: https://www.swedbankpay.se/risk-och-sakerhet/pci-sa-paverkas-du
[csp]: https://www.w3.org/TR/CSP2/
