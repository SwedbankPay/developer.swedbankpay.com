---
title: Display Payment UI
hide_from_sidebar: false
description: |
  How to display the checkout payment UI.
menu_order: 3
---

## Step 2: Display Payment UI

There are a couple of decisions to be made when you are presenting your payment
UI. You have the choice between a payment menu with all the payment instruments
you want to offer, or to present the `paymentOrder` with a single available
payment instrument using instrument mode.

Regardless of the number of instruments available to the payer, you also need to
choose between the display options `Redirect` and `Seamless View`. Read more
about these by following the corresponding link.

{% include iterator.html next_href="redirect"
                         next_title="Integrate Redirect" %}
{% include iterator.html next_href="seamless-view"
                         next_title="Integrate Seamless View" %}
