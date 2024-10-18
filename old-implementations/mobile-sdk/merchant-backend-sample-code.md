---
title: Merchant Backend Sample Code
permalink: /:path/merchant-backend-sample-code/
description: |
  You can use Swedbank Pay provided sample code to jump-start your
  **Swedbank Pay Mobile SDK** application.
menu_order: 200
---

You can find sample implementations of the Merchant Backend at
[this Github repository][backend-samples]{:target="_blank"}. Currently there are
available the following:

*   [node.js][node-sample]{:target="_blank"}
*   [Java][java-sample]{:target="_blank"}

Please refer to the sample code documentation for instructions for running a
local development server, and/or deploying to selected cloud services. Do note
that if you are running a local server over http, you will need to allow
insecure communications in the mobile application; otherwise any payments will
immediately fail due to a security error.

The samples provide a fully functioning API for the SDK, but the implementations
are, of course, devoid of any business logic. They should, nevertheless, provide
a good starting point toward integration with your business systems.

{% include iterator.html prev_href="/old-implementations/mobile-sdk/merchant-backend"
                         prev_title="Back: Merchant Backend V3"
                         next_href="/old-implementations/mobile-sdk/merchant-backend-v2"
                         next_title="Next: Merchant Backend V2" %}

[backend-samples]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant
[node-sample]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/tree/main/examples/node.js/README.md
[java-sample]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/tree/main/examples/java/merchant/README.md
