---
section: Introduction
title: Enterprise
permalink: /:path/introduction/
hide_from_sidebar: false
description: |
  **Enterprise** is the Checkout for merchants with their
  own consumer authentication, but don´t want to store the consumer information.
menu_order: 200
---

**Enterprise** is the option if you have a strong customer authentication login
and collect consumer information yourself, so you don't need payer information
from us to calculate shipping costs. We store the consumer information for you
and offer the full range of available payment methods.

There are two ways of integrating the **Enterprise** implementation.
**Redirect** and **Seamless View**.

With **Redirect**, the payer is sent to a Swedbank Pay page, where we handle the
authentication and purchase process. The payer is redirected back to you when
the purchase is completed or if the payer aborts the purchase. The purchase page
will be styled by Swedbank Pay.

With **Seamless View**, the payer stays at your site, and you initiate the
Swedbank Pay purchase module in an iframe. The purchase component will be styled
by Swedbank Pay.

Read more about our two integration alternatives by clicking the links below.

This product supports Danish `da-DK`, English (US) `en-US`, Finnish `fi-FI`,
Norwegian `nb-NO`, and Swedish `sv-SE`.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started"
                         next_href="/old-implementations/enterprise/redirect"
                         next_title="Integrate Redirect" %}
{% include iterator.html next_href="/old-implementations/enterprise/seamless-view"
                         next_title="Integrate Seamless View" %}
