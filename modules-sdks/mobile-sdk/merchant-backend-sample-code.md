---
title: Merchant Backend Sample Code
sidebar:
  navigation:
  - title: Mobile SDK
    items:
    - url: /modules-sdks/mobile-sdk
      title: Mobile SDK
    - url: /modules-sdks/mobile-sdk/merchant-backend
      title: Merchant Backend
    - url: /modules-sdks/mobile-sdk/merchant-backend-sample-code
      title: Merchant Backend Sample Code
    - url: /modules-sdks/mobile-sdk/android
      title: Android
    - url: /modules-sdks/mobile-sdk/ios
      title: iOS
    - url: /modules-sdks/mobile-sdk/process-diagrams
      title: Process Diagrams
    - url: /modules-sdks/mobile-sdk/plain-webview
      title: Plain Webview
---

{% capture disclaimer %}
The SDK is at an early stage of development
and is not supported as of yet by Swedbank Pay. It is provided as a
convenience to speed up your development, so please feel free to play around.
However, if you need support, please wait for a future, stable release.
{% endcapture %}

{% include alert.html type="warning" icon="warning" header="Unsupported"
body=disclaimer %}

{% include jumbotron.html body="You can use Swedbank Pay provided sample code to jump-start your **Swedbank Pay Mobile SDK** application." %}

You can find sample implementations of the Merchant Backend at [this Github repository][backend-samples]. Currently there are available the following:

*   [node.js][node-sample]
*   [Java][java-sample]

Please refer to the sample code documentation for instructions for running a local development server, and/or deploying to selected cloud services. Do note that if you are running a local server over http, you will need to allow insecure communications in the mobile application; otherwise any payments will immediately fail due to a security error.

The samples provide a fully functioning API for the SDK, but the implementations are, of course, devoid of any business logic. They should, nevertheless, provide a good starting point toward integration with your business systems.

{% include iterator.html prev_href="merchant-backend"
                         prev_title="Back: Merchant Backend"
                         next_href="android"
                         next_title="Next: Android" %}

[backend-samples]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant
[node-sample]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/tree/master/examples/node.js
[java-sample]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/tree/master/examples/java/merchant
