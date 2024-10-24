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
particularly around the security of your checkout process. A script or other
monitoring needs to be in place to verify that the checkout URL is correct and
has not been tampered with. This is to avoid phishing or hijacking, and to
secure that the URL provided is from us at Swedbank Pay.

See points **6.4.3** and **11.6.1** in the PCI-DSS link above for more.

Please note that this only applies to payment methods that are affected by
PCI-DSS (Card, Vipps and/or Mobile Pay). If you only offer payment methods not
affected by PCI-DSS (Invoice, Swish and/or Trustly), no actions are necessary.
If you want to add PCI-DSS affected payment methods later, this is something
you need to consider.

To learn more about how PCI-DSS affects you, we also have reading available
in [Danish][da]{:target="_blank"}, [Finnish][fi]{:target="_blank"},
[Norwegian][no]{:target="_blank"} and [Swedish][se]{:target="_blank"}.

If you currently have a Seamless View integration and don't want the impending
responsibilities, switcing to Redirect is normally possible, but the Checkin
module used in Checkout v2 is only available using Seamless View. We
**strongly recommend** switching to the newest version of [Digital Payments][dp]
and choose the Redirect UI option. We have written a [migration guide][mp] to
help you.

[dp]: /checkout-v3/
[mp]: /checkout-v3/migration-guide/
[pci]: https://www.swedbankpay.se/globalassets/global-documents/risk-and-security/pci-dss-v4-0-saq-a-r2.pdf
[seamless-view]: /old-implementations/checkout-v2/payment-menu/#step-4-display-the-payment-menu
[da]: https://www.swedbankpay.dk/risiko-og-sikkerhed/pci-sadan-bliver-du-pavirket
[fi]: https://www.swedbankpay.fi/riskit-ja-turvallisuus/nain-pci-vaikuttaa-sinuun
[no]: https://www.swedbankpay.no/risiko-og-sikkerhet/pci-slik-pavirkes-du
[se]: https://www.swedbankpay.se/risk-och-sakerhet/pci-sa-paverkas-du
