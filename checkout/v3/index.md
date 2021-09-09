---
section: Checkout v3
title: Introduction
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
- title: Standard
  description: |
    Coming soon...
  url:  /checkout/v3/standard
  disabled: true
  icon:
    content: shopping_cart
    outlined: true
- title: Authentication
  description: |
    Use this implementation when you have consumer data, but want to access Swedbank Pay checkout for an easier purchase flow.
  url:  /checkout/v3/authentication
  icon:
    content: shopping_cart
    outlined: true
- title: Merchant Authenticated Consumer
  description: Use this implementation when you have consumer data and consumers authentication on your site, but want to access Swedbank Pay checkout for an easier purchase flow.
  url:  /checkout/v3/mac
  icon:
    content: shopping_cart
    outlined: true
---

{:.heading-line}
{% include card-list.html card_list=page.card_list col_class="col-lg-4" %}

[checkout-3-authentication]: /checkout/v3/authentication
[checkout-3-standard]: /checkout/v3/standard
[checkout-3-mac]: /checkout/v3/mac

## Checkout

Swedbank Pay Checkout allows the payer to be identified by Swedbank Pay,
enabling existing Swedbank Pay Checkout users to pay with their favorite payment
methods in just a few simple steps.

## Prerequisites

To start integrating Swedbank Pay Checkout, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes Swedbank Pay Checkout.
*   Obtained credentials (Merchant Access Token) from Swedbank Pay through
    Swedbank Pay Admin.

## Introduction

To get started with Swedbank Pay Checkout v3, you should learn about its
different components and how they work together. Swedbank Pay Checkout consists
of two related concepts: **Checkin** and **Payment Menu**. Checkin identifies
the consumer in our Consumer API, and Payment Menu authorizes the payment with
our Payment Menu API.

While Checkin is necessary to store personal information and access features
like storing cards, it is not mandatory. If the payer is from a country where we
don't support consumer profiles, or if the payer does not want to store data,
that's fine. The Payment Menu can still be used as a **guest**.

[https]: /introduction#connection-and-protocol
