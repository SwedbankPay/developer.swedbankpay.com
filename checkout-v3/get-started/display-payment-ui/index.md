---
title: Display Payment UI
hide_from_sidebar: false
description: |
  How to display the checkout payment UI.
menu_order: 6
---

## Display Payment UI

There are a couple of decisions to be made when presenting your payment UI. You
have the choice between a payment menu with all payment methods you want to
offer, or with a single available payment method using instrument mode.

Regardless of the number of payment methods available to the payer, you also
need to choose between `Redirect` and `Seamless View`.

With `Redirect`, the payer is sent to a Swedbank Pay page where we handle the
purchase process. The payer is redirected back to you when the purchase is
completed or if the payer aborts the purchase. The page will be styled by
Swedbank Pay.

With `Seamless View`, the payer stays at your site and you initiate the
Swedbank Pay purchase module in an iframe. The purchase component will be styled
by Swedbank Pay.

Read about how you integrate them in the corresponding sections.

{% include iterator.html next_href="redirect"
                         next_title="Redirect" %}
{% include iterator.html next_href="seamless-view"
                         next_title="Seamless View" %}
