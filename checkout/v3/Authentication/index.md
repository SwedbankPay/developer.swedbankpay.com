---
section: Checkout Authentication
title: Introduction
estimated_read: 2
description: |
  **Checkout Authentication** is 
  Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
  and test this integration for yourself!
menu_order: 100
---


## Introduction

You should choose our **Checkout Authentication** integration model if

-   you collect the consumer information needed to complete an order yourself.
-   you **do not** need consumer information from Swedbank Pay to calculate
    shipping costs.
-   you **do not** have a consumer authentication login.
-   you want your payers to access stored payment information in Swedbank Pay
    Checkout for an easier payment process.

There are two different ways of integrating the Authentication model.
**Redirect** and **Seamless View**.

**Redirect** sends the consumer to a Swedbank Pay page where we handle the
authentication and payment process. The consumer will be redirected back to you
when the purchase is completed or if the consumer aborts the payment. The
payment page will be styled by Swedbank Pay.

With **Seamless View**, the consumer stays at your site, and you initiate the
Swedbank Pay authentication and payment module in an iframe. The checkin and
payment component will be styled by Swedbank Pay.

Read more about our two integration alternatives by clicking the links below.

{% include languages.md %}

{% include iterator.html next_href="redirect"
                         next_title="Implement Redirect" %}

{% include iterator.html next_href="seamless-view"
                         next_title="Implement Seamless View" %}

[after-payment-capture]: /checkout/v3/capture
[https]: /introduction#connection-and-protocol
