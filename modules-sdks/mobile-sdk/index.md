---
section: Mobile SDK
title: Introduction
estimated_read: 4
description: |
  **Swedbank Pay Mobile SDK** provides an easy way of integrating Swedbank Pay
  Checkout to your Android and iOS applications.
  The Mobile SDK consists of three components: An Android library, an iOS
  library, and a backend component with example implementations in Node.js
  and Java.
menu_order: 700
---

{% capture disclaimer %}
The SDK is at an early stage of development
and is not supported as of yet by Swedbank Pay. It is provided as a
convenience to speed up your development, so please feel free to play around.
However, if you need support, please wait for a future, stable release.
{% endcapture %}

{% include alert.html type="warning" icon="warning" header="Unsupported"
body=disclaimer %}

The mobile libraries provide standard UI components (a Fragment on Android, a UIViewController on iOS) that you can integrate in your mobile application in the usual fashion. The backend component has an API designed to transparently reflect the Swedbank Pay API, and the data types used to configure the mobile libraries allow you to organically discover the capabilities of the system.

The SDK is designed to integrate the Swedbank Pay UI inside your application's native UI. It generates any html pages required to show the Swedbank Pay UI internally; it does not support using a Checkout or Payments web page that you host yourself. If doing the latter fits your case better, you can show your web page in a Web View instead. In that case, you may benefit from the [collection of information about showing Checkout or Payments in a Web View][plain-webview].

## Prerequisites

To start integrating the Swedbank Pay Mobile SDK, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes [Swedbank Pay Checkout][checkout].
*   Obtained credentials (merchant Access Token) from Swedbank Pay through
    Swedbank Pay Admin. Please observe that Swedbank Pay Checkout encompass
    both the **`consumer`** and **`paymentmenu`** scope.

Note that while it is not difficult to implement the Mobile SDK API on any platform and in any language, example implementations are provided for Node.js and Java.

## Introduction

As the Mobile SDK is built on top of [Checkout][checkout], it is a good idea to familiarize yourself with it first. The rest of this document will assume some familiarity with Checkout concepts. Note, however, that you need not build a working Checkout example with web technologies to use the Mobile SDK.

The scope of the Mobile SDK is to provide a mobile interface and supporting https APIs for the [Checkin][checkin] and [Payment Menu][payment-menu] parts of Checkout. The [After-Payment][after-payment-capture] part is the same as when using Checkout on a web page, and is thus intentionally left out of the scope of the SDK.

See below for a sequence diagram of a payment made using the Mobile SDK. This is a high-level diagram. More detailed views highlighting platform differences will follow for each step.

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, SDK refers to the Mobile SDK Android or iOS component, and Merchant refers to the merchant back-end, running the Mobile SDK backend component, possibly using the example implementation." %}

```mermaid
sequenceDiagram
    participant App
    participant SDK
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    rect rgba(238, 112, 35, 0.05)
        note left of App: Configuration
        App ->> SDK: Set URL of Merchant Backend
        opt Advanced Configuration
            App ->> SDK: Set certificate pin(s)
            App ->> SDK: Set custom headers
        end
    end

    rect rgba(138, 205, 195, 0.1)
        note left of App: Payment
        opt Unless guest payment
            App ->> App: Prepare Consumer to identify
        end
        App ->> App: Prepare Payment Order to create
        App ->> SDK: Create payment UI component with prepared Consumer and Payment Order
        SDK ->> Merchant: Discover API endpoints: GET /
        Merchant -->> SDK: { "consumers": "/consumers", "paymentorders": "/paymentorders" }
        opt Unless guest payment
            SDK ->> Merchant: Start identification session: POST /consumers
            Merchant ->> SwedbankPay: Forward call to Swedbank Pay: POST /psp/consumers
            SwedbankPay -->> Merchant: rel: view-consumer-identification
            Merchant -->> SDK: Forward response to SDK: rel: view-consumer-identification
            SDK ->> SDK: Compose and show html using view-consumer-identification link
            SwedbankPay ->> SDK: Consumer identification process
            SDK ->> SwedbankPay: Consumer identification process
            SwedbankPay ->> SDK: consumerProfileRef
            SDK ->> SDK: paymentOrder.payer = { consumerProfileRef }
        end
        SDK ->> Merchant: Create Payment Order: POST /paymentorders
        Merchant ->> SwedbankPay: Forward call to Swedbank Pay: POST /psp/paymentorders
        SwedbankPay -->> Merchant: rel:view-paymentorder
        Merchant -->> SDK: Forward response to SDK: rel: view-paymentorder
        SDK ->> SDK: Compose and show html using view-paymentorder link
        SwedbankPay ->> SDK: Payment process ①
        SDK ->> SwedbankPay: Payment process
        SwedbankPay -->> SDK: Notify: Payment completed
        SDK ->> App: Callback: Payment completed
        App ->> App: Remove payment UI component
    end

    rect rgba(81,43,43,0.1)
        note left of App: Capture (not in scope of SDK)
        Merchant ->>+ SwedbankPay: rel:create-paymentorder-capture
        SwedbankPay -->> Merchant: Capture status
    end
```

*   ① The payment process may navigate to 3rd party web pages. This is glossed over in this diagram, but the process and its implications are discussed further in the next pages.

### The Checkin Flow

Internally, the SDK uses the same [Checkin][checkin] flow as would be used on a web page. The flow described on the Checkin page reflects closely what happens inside the SDK. From the perspective of the app using the SDK, that is an implementation detail, and is therefore not reflected in the above diagram. You should, nevertheless, read up on the Checkin documentation before continuing with the SDK documentation.

{% include iterator.html next_href="merchant-backend"
                         next_title="Merchant Backend" %}

[plain-webview]: plain-webview
[checkout]: /checkout
[https]: /home/technical-information#connection-and-protocol
[checkin]: /checkout/checkin
[payment-menu]: /checkout/payment-menu
[after-payment-capture]: /checkout/capture
