---
section: Introduction
title: Payments Only
hide_from_sidebar: false
description: |
  **Payments Only** is the Checkout for merchants who does everything but the
  payment menu.
menu_order: 200
---

**Payments Only** is where you get to be in charge of everything. You handle
the consumer verification with a strong customer authentication, collect the
consumer information needed to calculate shipping costs, and store the
information yourself. We provide you with our full range of payment methods.

There are two ways of integrating the **Payments Only** implementation.
**Redirect** and **Seamless View**.

With **Redirect**, the payer is sent to a Swedbank Pay page, where we handle the
purchase process. The payer is redirected back to you when the purchase is
completed or if the payer aborts the purchase. The purchase page will be styled
by Swedbank Pay.

With **Seamless View**, the payer stays at your site, and you initiate the
Swedbank Pay purchase module in an iframe. The purchase component will be styled
by Swedbank Pay.

Read more about our two integration alternatives by clicking the links below.

This product supports Danish `da-DK`, English (US) `en-US`, Finnish `fi-FI`,
Norwegian `nb-NO`, and Swedish `sv-SE`.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started"
                         next_href="redirect"
                         next_title="Integrate Redirect" %}
{% include iterator.html next_href="seamless-view"
                         next_title="Integrate Seamless View" %}
