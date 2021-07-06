---
section: Checkout v3
title: Introduction V3
description: |
  **Swedbank Pay Checkout** is a complete reimagination
  of the checkout experience, integrating seamlessly into the merchant website
  through highly customizable and flexible components.
  Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
  and try out Swedbank Pay Checkout for yourself!
icon:
  content: remove_red_eye
additional: true
menu_order: 200

card_list:
- title: Authentication
  description: |
    Use this integration when having consumer data but want to access Swedbank Pay checkout for easier payment flow for your consumers.
  url:  /checkout/v3/authentication
  icon:
    content: shopping_cart
    outlined: true
- title: Standard
  description: Coming soon…
  disabled: true
  url:  /checkout/v3/standard
  icon:
    content: shopping_cart
    outlined: true
- title: Merchant Authenticated Consumer
  description: Use this integration when having consumer data and consumers authenticate on your site, but want to access Swedbank Pay checkout for easier payment flow for your consumers.
  url:  /checkout/v3/mac
  icon:
    content: shopping_cart
    outlined: true
---

{:.heading-line}
{% include card-list.html card_list=page.card_list col_class="col-lg-4" %}

[checkout-3-Authentication]: /checkout/v3/authentication
[checkout-3-Standard]: /checkout/v3/standard
[checkout-3-MAC]: /checkout/v3/mac

## Checkout

Swedbank Pay Checkout allows your customers to be identified by Swedbank Pay,
enabling existing Swedbank Pay Checkout users to pay with their favorite payment
methods in just a few simple steps.

## Prerequisites

To start integrating Swedbank Pay Checkout, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes Swedbank Pay Checkout.
*   Obtained credentials (merchant Access Token) from Swedbank Pay through
    Swedbank Pay Admin.

## Introduction

To get started with Swedbank Pay Checkout v3, you should learn about its different
components and how they work together. Swedbank Pay Checkout consists of two
related concepts: **Checkin** and **Payment Menu**. Checkin
identifies the consumer in our Consumer API and Payment Menu authorizes the
payment with our Payment Menu API.

The next step is to **Capture** the payment. You can either capture the total
amount, or do a part-capture (as described under
[After Payment][after-payment-capture]). Connect these steps and you have
Swedbank Pay Checkout.

While Checkin is a necessary component to store personal information and access
features like storing cards, it is not a mandatory step for the Checkout process
to work. If the payer is from a country where we currently don't support
to create a consumer profile, or if he or she opts not to store their data, that's fine. The Payment
Menu can still be used as a **guest**.
