---
section: Payment Menu v2
sidebar_icon: menu_book
redirect_from: /old-implementations/payment-menu-v2/other-features
description: |
  The **Swedbank Pay Payment Menu v2** integrates
  seamlessly into the merchant website, allowing the payer to choose between the
  increasing number of payment instrument Swedbank Pay has on offer and
  remembering which instrument they prefer and have paid with previously.
permalink: /:path/
menu_order: 6
---

Swedbank Pay Payment Menu v2 allows your customers to pay with their favorite
payment instruments in just a few simple steps.

## Prerequisites

To start integrating Swedbank Pay Payment Menu v2, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes Swedbank Pay Payment Menu v2.
*   Obtained credentials (merchant Access Token) from Swedbank Pay through
    the Merchant Portal.

## Introduction

To get started with Swedbank Pay Payment Menu v2, you should learn about its
different components and how they work together. **Payment Menu v2** authorizes
the payment with our Payment Menu API. The next step is to **Capture** the
payment. You can either capture the total amount, or do a part-capture (as
described under [After Payment][after-payment-capture]). Connect these steps and
you have Swedbank Pay Payment Menu v2.

{% include iterator.html next_href="payment-order"
                         next_title="Payment Order" %}

[after-payment-capture]: /old-implementations/payment-menu-v2/capture
[https]: /introduction#connection-and-protocol
