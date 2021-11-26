---
section: Merchant Authenticated Consumer (MAC)
title: Introduction
estimated_read: 3
hide_from_sidebar: false
description: |
  **Merchant Authenticated Consumer** is the Checkout for merchants with their
  own consumer authentication, but don´t want to store the consumer information.
menu_order: 300
---

**Merchant Authenticated Consumer** is the option if you have a strong consumer
authentication login and collect consumer information yourself, so you don't
need payer information from us to calculate shipping costs. We store the
consumer information for you and offer the full range of available payment
methods.

There are two ways of integrating the **Merchant Authenticated Consumer**
implementation. **Redirect** and **Seamless View**.

With **Redirect**, the payer is sent to a Swedbank Pay page, where we handle the
authentication and purchase process. The payer is redirected back to you
when the purchase is completed or if the payer aborts the purchase. The
purchase page will be styled by Swedbank Pay.

With **Seamless View**, the payer stays at your site, and you initiate the
Swedbank Pay purchase module in an iframe. The purchase component will be styled
by Swedbank Pay.

Just like with our other implementations, it is always possible to pay as a
**guest**. When using **Merchant Authenticated Consumer**, the way to do it is
to not include the `payerReference` and `nationalIdentifier` in the
`paymentOrder` request.

Read more about our two integration alternatives by clicking the links below.

{% include languages.md %}

{% include iterator.html prev_href=""
                         prev_title="Back to Get Started"
                         next_href="redirect"
                         next_title="Integrate Redirect" %}
{% include iterator.html next_href="seamless-view"
                         next_title="Integrate Seamless View" %}
