---
title: Swedbank Pay Payment Menu– Introduction
sidebar:
  navigation:
  - title: Payment Menu
    items:
    - url: /payment-menu/
      title: Introduction
    - url: /payment-menu/payment-order
      title: Payment Order
    - url: /payment-menu/capture
      title: Capture
    - url: /payment-menu/after-payment
      title: After Payment
    - url: /payment-menu/other-features
      title: Other Features
---
## Prerequisites

To start integrating Swedbank Pay Payment Menu, you need the following:

* [HTTPS][https] enabled web server.
* Agreement that includes Swedbank Pay Payment Menu.
* Obtained credentials (merchant Access Token) from Swedbank Pay through
  Swedbank Pay Admin. Please observe that Swedbank Pay Checkout encompass
  both the **`consumer`** and **`paymentmenu`** scope.

## Introduction

To get started with Swedbank Pay Checkout, you should learn about its different
components and how they work together. **Payment Menu** authorizes the
payment with our Payment Menu API. The next step is to **Capture** the payment.
You can either capture the total amount, or do a part-capture (as described
under [After Payment][after-payment-capture]). Connect these steps and you have
Swedbank Pay Checkout.

Under, you will see a sequence diagram showing the sequence of a Swedbank Pay
Payment Menu.

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

[after-payment-capture]: /payment-menu/capture
[https]: /home/technical-information#connection-and-protocol
[payment-order]: /payment-menu/other-features#payment-orders
