---
title: Change UI Option
permalink: /:path/ui-migration/
description: |
    Walking you through switching from Seamless View to Redirect
menu_order: 7
---

Due to changes in [PCI-DSS requirements][pci]{:target="_blank"} coming with v4
in March 2025, using [Seamless View][seamless-view] to display the payment UI
will give you, as a merchant, more responsibilities than using our
[Redirect][redirect] integration. This is because Seamless View is hosted by
you. As the Redirect page is hosted by us, we also handle the responsibilities.

To learn more about how PCI-DSS affects you, we have further reading avaliable
in [Danish][da]{:target="_blank"}, [Finnish][fi]{:target="_blank"},
[Norwegian][no]{:target="_blank"} and [Swedish][se]{:target="_blank"}.

If you currently have a Seamless View integration and don't want the impending
responsibilities, switcing to Redirect is a very manageable task. Here's what
you need to do:

#### Use Redirect Operation

In the operations node of the [payment response][post-response], right next to
`view-checkout` which you should currently be using, you'll find
`redirect-checkout`. The corresponding `href` contains a url which leads to the
Redirect UI. All you need to do is send the payer to this address.

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

#### Remove Seamless View Code

You can remove all code related to the `<script>` element used to load the
Seamless View.

#### Change URLs

Finally, you need to do some changes to the `urls` node in your
[payment request][post-request]. The `hostUrls` and `paymentUrl` fields are
specific to Seamless View and can be **removed**.

The url you need to **add** is the `cancelUrl`, so we know where to redirect the
payer if they chose to cancel, or you chose to abort the payment.

If you have permission to [add your own logo][custom-logo], a `logoUrl` is also
needed. If no `logoUrl` is added or no agreement is in place to have your own
logo, Swedbank Pay's logo will be shown by default.

The `completeUrl` and `callbackUrl` is universal and most be included regardless
of your UI choice.

{% capture request_content %}{
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "paymentUrl": "https://example.com/perform-payment"
        }
}{% endcapture %}

{% include code-example.html
    title='Seamless View Specific URLs'
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

[custom-logo]: /checkout-v3/features/customize-ui/custom-logo/
[post-response]: /checkout-v3/get-started/payment-request-3-1/#payment-order-response
[post-request]: /checkout-v3/get-started/payment-request-3-1/#payment-order-request
[pci]: https://www.swedbankpay.se/globalassets/global-documents/risk-and-security/pci-dss-v4-0-saq-a-r2.pdf
[seamless-view]: /checkout-v3/get-started/display-payment-ui/seamless-view
[redirect]: /checkout-v3/get-started/display-payment-ui/redirect
[da]: https://www.swedbankpay.dk/risiko-og-sikkerhed/pci-sadan-bliver-du-pavirketswe
[fi]: https://www.swedbankpay.fi/riskit-ja-turvallisuus/nain-pci-vaikuttaa-sinuun
[no]: https://www.swedbankpay.no/risiko-og-sikkerhet/pci-slik-pavirkes-dus
[se]: https://www.swedbankpay.se/risk-och-sakerhet/pci-sa-paverkas-du
