---
title: Change UI Option
permalink: /:path/ui-migration/
description: |
    Walking you through switching from Seamless View to Redirect
menu_order: 11
---

As parts of the PCI-DSS best practice becomes requirements with
[PCI-DSS v4][pci] coming in March 2025, using the [Seamless View][seamless-view]
integration to display the payment UI will give merchants more responsibilities
than they currently have. This is because Seamless View is hosted by you. As the
[Redirect][redirect] integration is hosted by Swedbank Pay, we also handle these
responsibilities. The two main points affecting you in this context is **6.4.3**
and **11.6.1** in the PCI-DSS link above.

To learn more about how PCI-DSS affects you, we also have reading avaliable
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
          "href": "https://ecom.externalintegration.payex.com/paymentmenu/5a17c24e-d459-4567-bbad-aa0f17a76119?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-paymentorder",
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

While you need permission to [add your own logo][custom-logo] when using
Seamless View, no such agreement is needed for Redirect. If you want to add one,
you also need to include a `logoUrl`. Follow the guidelines in the section
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

[custom-logo]: /old-implementations/payment-instruments-v1/card/features/optional/custom-logo
[dp]: /checkout-v3/
[pci]: https://www.swedbankpay.se/globalassets/global-documents/risk-and-security/pci-dss-v4-0-saq-a-r2.pdf
[post-response]: /old-implementations/payment-instruments-v1/card/redirect#card-payment-response
[post-request]: /old-implementations/payment-instruments-v1/card/redirect#card-payment-request
[seamless-view]: /old-implementations/payment-instruments-v1/card/seamless-view
[redirect]: /old-implementations/payment-instruments-v1/card/redirect
[da]: https://www.swedbankpay.dk/risiko-og-sikkerhed/pci-sadan-bliver-du-pavirketswe
[fi]: https://www.swedbankpay.fi/riskit-ja-turvallisuus/nain-pci-vaikuttaa-sinuun
[no]: https://www.swedbankpay.no/risiko-og-sikkerhet/pci-slik-pavirkes-dus
[se]: https://www.swedbankpay.se/risk-och-sakerhet/pci-sa-paverkas-du
