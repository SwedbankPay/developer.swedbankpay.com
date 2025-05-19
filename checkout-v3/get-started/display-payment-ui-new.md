---
title: Display Payment UI - NEW
hide_from_sidebar: false
description: |
  How to display the payment UI.
menu_order: 5
tab_list:
- title: Redirect
  content_src: redirect-payment-ui.md
- title: Seamless View
  content_src: seamless-view-payment-ui.md
---

{: .h2 }
### Display Payment UI

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

{% include tabs.html tab_list=page.tab_list default_tab_index=1 %}
