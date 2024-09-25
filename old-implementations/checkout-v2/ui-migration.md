---
title: Change UI Option
permalink: /:path/ui-migration/
description: |
    Walking you through switching from Seamless View to Redirect
menu_order: 11
---

Due to changes in [PCI-DSS requirements][pci]{:target="_blank"} coming with v4
in March 2025, using [Seamless View][seamless-view] to display the payment UI
will give you, as a merchant, more responsibilities than using our Redirect
integration. This is because Seamless View is hosted by you. As the Redirect
page is hosted by us, we also handle the responsibilities.

To learn more about how PCI-DSS affects you, we have further reading avaliable
in [Danish][da]{:target="_blank"}, [Finnish][fi]{:target="_blank"},
[Norwegian][no]{:target="_blank"} and [Swedish][se]{:target="_blank"}.

If you currently have a Seamless View integration and don't want the impending
responsibilities, switcing to Redirect is normally possible, but the Checkin
module used in Checkout v2 is only available using Seamless View. As the Checkin
function is sunsetting and will be deprecated during the summer of 2025, we
**strongly recommend** switching to the newest version of [Digital Payments][dp]
and choose the Redirect UI option. We have written a [migration guide][mp] to
help you.

[dp]: /checkout-v3/
[mp]: /checkout-v3/migration-guide/
[pci]: https://www.swedbankpay.se/globalassets/global-documents/risk-and-security/pci-dss-v4-0-saq-a-r2.pdf
[seamless-view]: /old-implementations/checkout-v2/payment-menu/#step-4-display-the-payment-menu
[da]: https://www.swedbankpay.dk/risiko-og-sikkerhed/pci-sadan-bliver-du-pavirketswe
[fi]: https://www.swedbankpay.fi/riskit-ja-turvallisuus/nain-pci-vaikuttaa-sinuun
[no]: https://www.swedbankpay.no/risiko-og-sikkerhet/pci-slik-pavirkes-dus
[se]: https://www.swedbankpay.se/risk-och-sakerhet/pci-sa-paverkas-du
