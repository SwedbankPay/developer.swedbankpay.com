---
section: Payment Menu
estimated_read: 3
description: |
  The **Swedbank Pay Payment Menu** integrates
  seamlessly into the merchant website, allowing the payer to choose between the
  increasing number of payment instrument Swedbank Pay has on offer and
  remembering which instrument they prefer and have paid with previously.
menu_order: 200
hide_from_sidebar: true
---

Swedbank Pay Payment Menu allows your customers to pay with their favorite payment
instruments in just a few simple steps.

## Prerequisites

To start integrating Swedbank Pay Payment Menu, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes Swedbank Pay Payment Menu.
*   Obtained credentials (merchant Access Token) from Swedbank Pay through
    Swedbank Pay Admin.

## Introduction

To get started with Swedbank Pay Payment Menu, you should learn about its different
components and how they work together. **Payment Menu** authorizes the
payment with our Payment Menu API. The next step is to **Capture** the payment.
You can either capture the total amount, or do a part-capture (as described
under [After Payment][after-payment-capture]). Connect these steps and you have
Swedbank Pay Payment Menu.

{% include iterator.html next_href="payment-order"
                         next_title="Payment Order" %}

[after-payment-capture]: /payment-menu/capture
[https]: /introduction#connection-and-protocol
