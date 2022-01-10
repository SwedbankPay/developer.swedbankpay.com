---
section: Standard
title: Introduction
description: |
  **Standard** Checkout is for you who want Swedbank Pay to handle everything.
menu_order: 100
---

This is the option where Swedbank Pay does it all. Verifying your consumer,
collecting billing and shipping addresses, storing consumer information and
providing you with the full range of available payment methods.

The only way of integrating our **Standard** implementation is **Seamless
View**.

With **Seamless View**, the payer stays at your site, and you initiate the
Swedbank Pay authentication and purchase module in an iframe. The checkin and
purchase component will be styled by Swedbank Pay.

Just like with our other implementations, it is always possible to pay as a
**guest**. In **Standard**, this is done when the payer chooses not to store
credentials during checkin. This way, the details will be used once.

Read more about the integration by clicking the link below.

This product supports English (US) `en-US`, Norwegian `nb-NO` and Swedish
`sv-SE`.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started"
                         next_href="seamless-view"
                         next_title="Integrate Seamless View" %}
