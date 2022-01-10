---
section: Introduction
title: Authenticated
estimated_read: 2
description: |
  **Authenticated** is the checkout option for merchants who want us to handle
  both consumer authentication and payment.
menu_order: 200
---

The option for merchants who want Swedbank Pay to do **almost** everything. You
collect and provide us with billing and shipping addresses, while we handle the
rest. Verifying the payer, storing the consumer info and providing you with
all the available payment instruments.

There are two ways of integrating the **Authenticated** implementation.
**Redirect** and **Seamless View**.

With **Redirect**, the payer is sent to a Swedbank Pay page, where we handle the
authentication and purchase process. The payer is redirected back to you
when the purchase is completed or if the payer aborts the purchase. The
purchase page will be styled by Swedbank Pay.

With **Seamless View**, the payer stays at your site, and you initiate the
Swedbank Pay authentication and purchase module in an iframe. The checkin and
purchase component will be styled by Swedbank Pay.

Read more about our two integration alternatives by clicking the links below.

This product supports English (US) `en-US`, Norwegian `nb-NO` and Swedish
`sv-SE`.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started"
                         next_href="redirect"
                         next_title="Integrate Redirect" %}
{% include iterator.html next_href="seamless-view"
                         next_title="Integrate Seamless View" %}
