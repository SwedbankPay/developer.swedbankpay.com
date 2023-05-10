---
section: Checkout v3
sidebar_icon: shopping_cart
title: Get Started
description: |
  **A brief introduction to implementing Checkout v3.**
menu_order: 1
---

With Checkout v3, you need to be able to collect, verify and store the payer
data, including delivery address, and build your own checkout flow. We'll store
the card data for you, but you own it. This means that you have to remove data
in compliance with GDPR, but you won't have to worry about handling sensitive
card info.

Our PSP lets you choose whether to offer a single payment instrument or a
payment menu consisting of all the instruments you wish to include.

We offer a variety of payment instruments and features designed to meet your
business needs. You can choose from the following payment instruments, somewhat
depending on which countries you are operating in.

{% include alert.html type="informative" icon="info" header="Digital Wallets"
body="Some of the digital wallets we offer in Checkout v3 require you to take
additional steps before we can activate them for you. Please follow the link(s)
in the table below to read more." %}

{% include alert.html type="informative" icon="info" header="Credit Account"
body="Swedbank Pay Credit Account will be renamed Swedbank Pay Installment
Account during Q2 2023. The renaming will not have any technical
consequences, so you do not have to change anything in you integration." %}

{:.table .table-plain}
|        | Payment Instrument | Enterprise   |  Payments Only | Region                                    |
| :--------------------------: | :--------------: | :--------------: | :--------------: | :---------------------------------------- |
|   ![Apple Pay][apple-pay-logo]   | [Apple Pay][apple-pay]          | {% icon check %} | {% icon check %} |  ![EarthIcon][earth-icon]             |
|    ![Card][card-icon]    | Card         | {% icon check %} | {% icon check %} | ![EarthIcon][earth-icon]                  |
|   ![Click to Pay][c2p-logo]   | [Click to Pay][click-to-pay]            | {% icon check %} | {% icon check %} |  ![EarthIcon][earth-icon]             |
|   ![Google Pay][google-pay-logo]   | [Google Pay][google-pay]&trade;          | {% icon check %} | {% icon check %} |  ![EarthIcon][earth-icon]             |
| ![MobilePay][mobilepay-logo] | MobilePay       | {% icon check %} | {% icon check %} | {% flag dk %} {% flag fi %}               |
| ![Swedbank Pay][swp-logo] | Swedbank Pay Credit Account | {% icon check %} | {% icon check %} | {% flag se %} |
| ![Swedbank Pay][swp-logo] | Swedbank Pay Invoice | {% icon check %} | {% icon check %} | {% flag no %} {% flag se %} |
| ![Swedbank Pay][swp-logo] | Swedbank Pay Monthly Payments | {% icon check %} | {% icon check %} | {% flag se %} |
| ![Swish][swish-logo]     | Swish                 | {% icon check %} | {% icon check %} | {% flag se %}                             |
|   ![Trustly][trustly-logo]   | Trustly            |{% icon check %} | {% icon check %} | {% flag se %} {% flag fi %}               |
| ![Vipps][vipps-logo]     | Vipps                | {% icon check %} | {% icon check %} | {% flag no %}                             |

{% include iterator.html next_href="/checkout-v3/payments-only"
                         next_title="Set Up & Integration" %}

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
