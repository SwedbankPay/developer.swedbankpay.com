---
section: Merchant Authenticated Consumer (MAC)
title: Introduction
estimated_read: 3
hide_from_sidebar: false
description: |
  **MAC** is the Checkout option for merchants with their own consumer
  authentication. Visit our 
  [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop) and test 
  this integration for yourself!
menu_order: 300
---

## Introduction

You should choose our MAC integration model if

-   you collect the payer information needed to complete an order yourself.
-   you **do not** need payer information from Swedbank Pay to calculate
    shipping costs.
-   you **have** a strong payer authentication login.
-   you want your payers to access stored payment information in Swedbank Pay
    Checkout for an easier payment process.

### Requirements

-   You need a Checkout agreement to use this product.

There are two different ways of integrating the MAC model.
**Redirect** and **Seamless View**.

**Redirect** sends the payer to a Swedbank Pay page where we handle the
payment process. The payer will be redirected back to you when the purchase
is completed or if the payer aborts the payment. The payment page will be
styled by Swedbank Pay.

With **Seamless View**, the payer stays at your site, and you initiate the
Swedbank Pay payment module in an iframe. The payment component will be styled
by Swedbank Pay.

Read more about our two integration alternatives by clicking the links below.

{% include languages.md %}

{% include iterator.html next_href="redirect"
                         next_title="Implement Redirect" %}

{% include iterator.html next_href="seamless-view"
                         next_title="Implement Seamless View" %}

[after-payment-capture]: /checkout/v3/capture
[https]: /introduction#connection-and-protocol
