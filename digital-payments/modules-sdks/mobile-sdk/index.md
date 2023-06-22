---
section: Mobile SDK
title: Introduction
description: |
  **Swedbank Pay Mobile SDK** provides an easy way of integrating Swedbank Pay
  Digital Payments to your Android and iOS applications.
  The Mobile SDK consists of three components: An Android library, an iOS
  library, and a backend component with example implementations in Node.js
  and Java.
permalink: /:path/
menu_order: 600
---

The mobile libraries provide standard UI components (a Fragment on Android, a
UIViewController on iOS) that you can integrate in your mobile application in
the usual fashion. To work, these components need data from the Swedbank Pay
APIs, which you must retrieve through your own servers. At the core, the
libraries are agnostic as to how the communication between your app and your
servers happens, but an implementation is provided for a server that implements
what we call the Merchant Backend API. The Merchant Backend API is designed to
transparently reflect the Swedbank Pay API, and the data types used to configure
the mobile libraries allow you to organically discover the capabilities of the
system.

The SDK is designed to integrate the Swedbank Pay UI inside your application's
native UI. It generates any html pages required to show the Swedbank Pay UI
internally; it does not support using a Checkout or Payments web page that you
host yourself. If doing the latter fits your case better, you can show your web
page in a Web View instead. In that case, you may benefit from the [collection
of information about showing Checkout or Payments in a Web View][plain-webview].

## Prerequisites

To start integrating the Swedbank Pay Mobile SDK, you need the following:

*   An [HTTPS][https] enabled web server.
*   An agreement that includes [Swedbank Pay Digital Payments][checkout],
    specifically [Enterprise][checkout-enterprise] or [Payments
    Only][checkout-payments-only].
*   Obtained credentials (merchant Access Token) from Swedbank Pay through
    the Merchant Portal. Please observe that the Swedbank Pay Digital Payments
    implementations currently available encompasses the **`paymentmenu`** scope.

It is important to secure all communication between your app and your servers.
If you wish to use the Merchant Backend API to communicate between your app and
your server, an example implementation is provided for Node.js and for Java.

## Introduction

As the Mobile SDK is built on top of [Digital Payments][checkout]. It is a good
idea to familiarize yourself with it first, as the rest of this document will
assume some familiarity with Checkout concepts. Note, however, that you need not
build a working Digital Payments example with web technologies to use the Mobile
SDK.

The Mobile SDK currently provides a mobile component to show Digital Payments
[Enterprise][checkout-enterprise] or [Payments Only][checkout-payments-only] in
a mobile application. The integrating application must set a Configuration,
which is responsible for making the necessary calls to your backend. A
Configuration for a server implementing the Merchant Backend API is bundled with
the SDK, but it is simple to implement a Configuration for your custom server.
The [Post-Purchase][post-purchase-capture] part is the same as when using
Checkout on a web page, and is thus intentionally left out of the scope of the
SDK.

See below for a sequence diagram of a payment made using the Mobile SDK. This is
a high-level diagram. More detailed views highlighting platform differences will
follow for each step.

{% include iterator.html next_href="configuration"
                         next_title="Next: Configuration" %}

[plain-webview]: /digital-payments/modules-sdks/mobile-sdk/plain-webview
[checkout]: /digital-payments
[checkout-enterprise]: /digital-payments/enterprise
[checkout-payments-only]: /digital-payments
[https]: /digital-payments/resources/fundamental-principles#connection-and-protocol
[post-purchase-capture]: /digital-payments/post-purchase#capture
