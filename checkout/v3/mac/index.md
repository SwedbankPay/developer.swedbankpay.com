---
section: Merchant Authenticated Consumer (MAC)
title: Introduction
estimated_read: 3
hide_from_sidebar: false
description: |
  **MAC** is the Checkout option for merchants with their own consumer
  authentication. Visit our
  [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop) and test
  this implementation for yourself!
menu_order: 300
---

## Introduction

You should choose the **MAC** implementation if

-   you collect the payer information needed to complete an order yourself.
-   you **do not** need payer information from Swedbank Pay to calculate
    shipping costs.
-   you **have** a strong payer authentication login.
-   you want your payers to access stored purchase information in Swedbank Pay
    Checkout for an easier purchase process.

### Requirements

-   You need a Checkout agreement to use this product.

Please contact our Sales department regarding this requirement.

There are two ways of integrating the MAC implementation.
**Redirect** and **Seamless View**.

With **Redirect**, the payer is sent to a Swedbank Pay page, where we handle the
authentication and purchase process. The payer is redirected back to you
when the purchase is completed or if the payer aborts the purchase. The
purchase page will be styled by Swedbank Pay.

With **Seamless View**, the payer stays at your site, and you initiate the
Swedbank Pay purchase module in an iframe. The purchase component will be styled
by Swedbank Pay.

Read more about our two integration alternatives by clicking the links below.

{% include languages.md %}

{% include iterator.html next_href="redirect"
                         next_title="Integrate Redirect" %}

{% include iterator.html next_href="seamless-view"
                         next_title="Integrate Seamless View" %}
