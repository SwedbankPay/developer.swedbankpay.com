---
section: Digital Payments
sidebar_icon: shopping_cart
title: Introduction
description: |
  **A brief introduction to implementing Digital Payments.**
menu_order: 1
---

With Digital Payments, you need to be able to collect, verify and store the
payer data, including delivery address, and build your own checkout flow. We'll
store the card data for you, but you own it. This means that you have to remove
data in compliance with GDPR, but you won't have to worry about handling
sensitive card info.

Our PSP lets you choose whether to offer a single payment instrument or a
payment menu consisting of all the instruments you wish to include.

We offer a variety of payment instruments and features designed to meet your
business needs. You can choose from the following payment instruments, somewhat
depending on which countries you are operating in.

The Checkout is available in Danish `da-DK`, English (US) `en-US`, Finnish
`fi-FI`, Norwegian `nb-NO`, and Swedish `sv-SE`.

{% include alert.html type="informative" icon="info" header="Digital Wallets"
body="Some of the digital wallets we offer require you to take additional steps
before we can activate them for you. Please follow the link(s) in the table
below to read more." %}

{:.table .table-plain}
|        | Payment Instrument | Region                                    |
| :--------------------------: | :--------------: | :---------------------------------------- |
|   ![Apple Pay][apple-pay-logo]   | [Apple Pay][apple-pay]          |  ![EarthIcon][earth-icon]             |
|    ![Card][card-icon]    | Card         | ![EarthIcon][earth-icon]                  |
|   ![Click to Pay][c2p-logo]   | [Click to Pay][click-to-pay]            |  ![EarthIcon][earth-icon]             |
|   ![Google Pay][google-pay-logo]   | [Google Pay][google-pay]&trade;          |  ![EarthIcon][earth-icon]             |
| ![MobilePay][mobilepay-logo] | MobilePay       | {% flag dk %} {% flag fi %}               |
| ![Swedbank Pay][swp-logo] | Swedbank Pay Installment Account | {% flag se %} |
| ![Swedbank Pay][swp-logo] | Swedbank Pay Invoice | {% flag no %} {% flag se %} |
| ![Swedbank Pay][swp-logo] | Swedbank Pay Monthly Payments | {% flag se %} |
| ![Swish][swish-logo]     | Swish                 | {% flag se %}                             |
|   ![Trustly][trustly-logo]   | Trustly            | {% flag se %} {% flag fi %}               |
| ![Vipps][vipps-logo]     | Vipps                | {% flag no %}                             |

{% include iterator.html next_href="/checkout-v3/payment-request"
                         next_title="Start Integrating" %}
{% include iterator.html next_href="/checkout-v3/setup"
                         next_title="Set Up A Test Account" %}

[apple-pay]: /checkout-v3/payment-presentations#apple-pay
[apple-pay-logo]:/assets/img/applepay-logo.svg
[click-to-pay]: /checkout-v3/payment-presentations#click-to-pay
[c2p-logo]:/assets/img/clicktopay-logo.svg
[card-icon]: /assets/img/new-card-icon.svg
[earth-icon]: /assets/img/globe-icon.png
[google-pay]: /checkout-v3/payment-presentations#google-pay
[google-pay-logo]: /assets/img/googlepay-logo.svg
[mobilepay-logo]: /assets/img/icon-mobilepay-simple.svg
[vipps-logo]: /assets/img/icon-vipps-simple.svg
[swp-logo]: /assets/img/swedbank-pay-vertical-black.svg
[swish-logo]: /assets/img/icon-swish-simple.svg
[trustly-logo]: /assets/img/icon-trustly-simple.svg
