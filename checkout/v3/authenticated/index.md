---
section: Authenticated
title: Introduction
estimated_read: 2
description: |
  **Authenticated** is the checkout option for
  Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
  and test this implementation for yourself!
menu_order: 100
---


## Introduction

You should choose the **Authenticated** implementation if

-   you collect the payer information needed to complete an order yourself.
-   you **do not** need payer information from Swedbank Pay to calculate
    shipping costs.
-   you **do not** have a strong payer authentication login.
-   you want your payers to access stored purchase information in Swedbank Pay
    Checkout for an easier purchase process.

### Requirements

-   You need a Checkout agreement to use this product.
-   You need a data exchange agreement since we receive payer data from you.

Please contact our [Sales department][contact-sales] regarding these
requirements.

There are two ways of integrating the **Authenticated** implementation.
**Redirect** and **Seamless View**.

**Redirect** sends the payer to a Swedbank Pay page where we handle the
authentication and purchase process. The payer will be redirected back to you
when the purchase is completed or if the payer aborts the purchase. The
purchase page will be styled by Swedbank Pay.

With **Seamless View**, the payer stays at your site, and you initiate the
Swedbank Pay authentication and purchase module in an iframe. The checkin and
purchase component will be styled by Swedbank Pay.

Read more about our two integration alternatives by clicking the links below.

{% include languages.md %}

{% include iterator.html next_href="redirect"
                         next_title="Integrate Redirect" %}

{% include iterator.html next_href="seamless-view"
                         next_title="Integrate Seamless View" %}

[contact-sales]: /contact/
