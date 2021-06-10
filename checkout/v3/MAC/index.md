---
section: Checkout Merchant Authenticated Consumer (MAC)
title: Introduction
estimated_read: 3
hide_from_sidebar: false
description: |
  **Checkout MAC** is the Checkout option for merchants with their own consumer 
  authentication. Visit our 
  [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop) and test 
  this integration for yourself!
menu_order: 300
---

## Introduction

You should choose our Checkout MAC integration model if

-   you collect the consumer information needed to complete an order yourself.
-   you **do not** need consumer information from Swedbank Pay to calculate
    shipping costs.
-   you **have** a secure consumer authentication login.
-   you want your payers to access stored payment information in Swedbank Pay
    Checkout for an easier payment process.

There are two different ways of integrating the MAC model.
**Redirect** and **Seamless View**.

**Redirect** sends the consumer to a Swedbank Pay page where we handle the
payment process. The consumer will be redirected back to you when the purchase
is completed or if the consumer aborts the payment. The payment page will be
styled by Swedbank Pay.

With **Seamless View**, the consumer stays at your site, and you initiate the
Swedbank Pay payment module in an iframe. The payment component will be styled
by Swedbank Pay.

Read more about our two integration alternatives by clicking the links below.

{% include languages.md %}

{% include iterator.html next_href="redirect"
                         next_title="Implement Redirect" %}

{% include iterator.html next_href="samless-view"
                         next_title="Implement Seamless View" %}

[after-payment-capture]: /checkout/v3/capture
[https]: /introduction#connection-and-protocol
