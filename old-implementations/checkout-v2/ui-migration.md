---
title: Change UI Option
permalink: /:path/ui-migration/
description: |
    Walking you through switching from Seamless View to Redirect
menu_order: 11
---

As parts of the PCI-DSS best practice becomes requirements with
[PCI-DSS v4][pci] coming in April 2025, using the [Seamless View][seamless-view]
integration to display the payment UI will give merchants more responsibilities
than they currently have. This is because Seamless View is hosted by you. As the
Redirect integration is hosted by Swedbank Pay, we also handle these
responsibilities.

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

Please note that this only applies to payment methods that are affected by
PCI-DSS (Card and Click to Pay). If you only offer payment methods not affected
by PCI-DSS, no actions are necessary. If you want to add PCI-DSS affected
payment methods later, this is something you need to consider.

To learn more about how PCI-DSS affects you, we also have reading available
in [Danish][da]{:target="_blank"}, [Finnish][fi]{:target="_blank"},
[Norwegian][no]{:target="_blank"} and [Swedish][se]{:target="_blank"}.

If you currently have a Seamless View integration and don't want the impending
responsibilities, switcing to Redirect is normally possible, but the Checkin
module used in Checkout v2 is only available using Seamless View. We
**strongly recommend** switching to the newest version of [Digital Payments][dp]
and choose the Redirect UI option. We have written a [migration guide][mp] to
help you.

## Monitoring The Script URL

If you choose to stay with Seamless View, please take the following under
advisement.

To ensure compliance, we recommend implementing [Content Security Policy][csp]
rules to monitor and authorize scripts.

Merchants must whitelist the following domains to restrict browser content
retrieval to approved sources. While `https://*.payex.com` and
`https://*.swedbank.com` cover most payment methods, digital wallets such as
Apple Pay, Click to Pay, and Google Pay are delivered via Payair. Alongside the
Payair URL, these wallets may also generate URLs from Apple, Google, MasterCard,
and Visa. Merchants are responsible for whitelisting these domains and keeping
them up to date in case of changes.

When it comes to ACS URLs, nothing is loaded from the ACS domain in the
merchant's end. It will either happen within Swedbank Pay's domain or as a
redirect, which will repeal the merchant's CSP.

{:.table .table-striped}
| URL    | Description             |
| :------ | :--------------- |
| https://*.payex.com    | Universal URL for all payment methods except the digital wallets Apple Pay, Click to Pay and Google Pay.     |
| https://*.swedbank.com | Universal URL for all payment methods except the digital wallets Apple Pay, Click to Pay and Google Pay.     |
| https://*.payair.com | URL for the digital wallets Apple Pay, Click to Pay and Google Pay.     |

[dp]: /checkout-v3/
[mp]: /checkout-v3/migration-guide/
[pci]: https://www.swedbankpay.se/globalassets/global-documents/risk-and-security/pci-dss-v4-0-saq-a-r2.pdf
[seamless-view]: /old-implementations/checkout-v2/payment-menu/#step-4-display-the-payment-menu
[da]: https://www.swedbankpay.dk/risiko-og-sikkerhed/pci-sadan-bliver-du-pavirket
[fi]: https://www.swedbankpay.fi/riskit-ja-turvallisuus/nain-pci-vaikuttaa-sinuun
[no]: https://www.swedbankpay.no/risiko-og-sikkerhet/pci-slik-pavirkes-du
[se]: https://www.swedbankpay.se/risk-och-sakerhet/pci-sa-paverkas-du
[csp]: https://www.w3.org/TR/CSP2/
