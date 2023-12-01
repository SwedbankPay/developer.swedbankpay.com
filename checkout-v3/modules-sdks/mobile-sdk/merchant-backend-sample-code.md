---
title: Merchant Backend Sample Code
permalink: /:path/merchant-backend-sample-code/
description: |
  You can use Swedbank Pay provided sample code to jump-start your
  **Swedbank Pay Mobile SDK** application.
menu_order: 900
---

You can find sample implementations of the Merchant Backend at [this Github
repository][backend-samples]. Currently there are available the following:

*   [node.js][node-sample]
*   [Java][java-sample]

Please refer to the sample code documentation for instructions for running a
local development server, and/or deploying to selected cloud services. Do note
that if you are running a local server over http, you will need to allow
insecure communications in the mobile application; otherwise any payments will
immediately fail due to a security error.

The samples provide a fully functioning API for the SDK, but the implementations
are, of course, devoid of any business logic. They should, nevertheless, provide
a good starting point toward integration with your business systems.

{% include iterator.html prev_href="merchant-backend"
                         prev_title="Merchant Backend"
                         next_href="android"
                         next_title="Android" %}

[backend-samples]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant
[node-sample]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/tree/main/examples/node.js/README.md
[java-sample]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/tree/main/examples/java/merchant/README.md
