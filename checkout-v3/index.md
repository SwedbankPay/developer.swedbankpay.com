---
section: Digital Payments
sidebar_icon: shopping_cart
title: Introduction
description: |
  **A brief introduction to implementing Digital Payments.**
menu_order: 1
---

<section class="panel panel-brand">
 <header>
 <h3 class="panel-title">Why Swedbank Pay?</h3>
 <p class="panel-sub-title"></p>
 </header>
 <div class="panel-body">
 <ul>
 <li>Get all your payment needs from one provider</li>
 <li>Manage all digital sales channels through one platform</li>
 <li>Customize your payment menu</li>
 <li>Ensure ease of use for everyone with the latest accessibility standards (WCAG)</li>
 <li>Simplify your financial management with one payout and one report</li>
 <li>Enjoy uninterrupted service</li>
 <li>Get started quickly</li>
 </ul>
 </div>
</section>

There are three ways of implementing our digital payments, depending on what
suits you best. The native implementation, which goes directly towards our APIs,
modules (WooCommerce) or SDKs (.NET or Java).

The modules and SDKs have their [own section][modules-sdks], which is where you
need to go if you are planning on using them. A bit less flexible than the
native API option, but a lower threshold to get going.

If you are looking for the native implementation, we have everything you need in
this section. We recommend [getting started here][get-started].

### API Platform Use Cases

<div class="row mt-4">
    <div class="col-xl-6 col-lg-6 d-flex">
       <a href="/checkout-v3/get-started/" class="cards cards-primary">
         <span class="cards-icon">
            <i class="material-icons-outlined">
                storefront
            </i>
         </span>
         <span class="cards-content">
            <span class="h4">One-Time Payments</span>
            <span><p>Get things started with our basic implementation.</p>
            </span>
         </span>
         <i class="material-icons">arrow_forward</i>
      </a>
    </div>
<div class="row mt-4">
    <div class="col-xl-6 col-lg-6 d-flex">
       <a href="/checkout-v3/get-started/recurring" class="cards cards-primary">
         <span class="cards-icon">
            <i class="material-icons-outlined">
                storefront
            </i>
         </span>
         <span class="cards-content">
            <span class="h4">Recurring Payments</span>
            <span><p>Start getting that steady cash flow with our subscription services.</p>
            </span>
         </span>
         <i class="material-icons">arrow_forward</i>
      </a>
    </div>
    <div class="col-xl-6 col-lg-6 d-flex">
       <a href="/checkout-v3/get-started/one-click" class="cards cards-primary">
         <span class="cards-icon">
            <i class="material-icons-outlined">
                storefront
            </i>
         </span>
         <span class="cards-content">
            <span class="h4">One-Click Payments</span>
            <span><p>Save your customer's details and make their checkout faster.</p>
            </span>
         </span>
         <i class="material-icons">arrow_forward</i>
      </a>
    </div>
</div>

### Availability

This implementation is available in Danish `da-DK`, English (US) `en-US`,
Finnish `fi-FI`, Norwegian `nb-NO`, and Swedish `sv-SE`. You can choose the
contents of your payment UI from the following payment instruments, somewhat
depending on which countries you are operating in.

{% include alert.html type="informative" icon="info" header="Digital Wallets"
body="Some of the digital wallets we offer require you to take additional steps
before we can activate them for you. Please follow the link(s) in the table
below to read more." %}

{:.table .table-plain}
|        | Payment Instrument | Region                                    |
| :--------------------------: | :--------------: | :---------------------------------------- |
| ![Apple Pay][apple-pay-logo]     | [Apple Pay][apple-pay]           |  ![EarthIcon][earth-icon]    |
| ![Card][card-icon]               | Card                             |  ![EarthIcon][earth-icon]    |
| ![Click to Pay][c2p-logo]        | [Click to Pay][click-to-pay]     |  ![EarthIcon][earth-icon]    |
| ![Google Pay][google-pay-logo]   | [Google Pay][google-pay]&trade;  |  ![EarthIcon][earth-icon]    |
| ![MobilePay][mobilepay-logo]     | MobilePay                        | {% flag dk %} {% flag fi %}  |
| ![Swedbank Pay][swp-logo]        | Swedbank Pay Installment Account | {% flag se %} {% flag no %}  |
| ![Swedbank Pay][swp-logo]        | Swedbank Pay Invoice             | {% flag no %} {% flag se %}  |
| ![Swedbank Pay][swp-logo]        | Swedbank Pay Monthly Payments    | {% flag se %}                |
| ![Swish][swish-logo]             | Swish                            | {% flag se %}                |
| ![Trustly][trustly-logo]         | [Trustly][trustly]               | {% flag se %} {% flag fi %}  |
| ![Vipps][vipps-logo]             | Vipps                            | {% flag no %}                |

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
[wcag-presentation]: https://www.swedbankpay.com/information/wcag
[paid]: /checkout-v3/features/technical-reference/resource-sub-models#paid
[trustly]: /checkout-v3/payment-presentations#trustly
[get-started]: /checkout-v3/get-started/
[modules-sdks]: /checkout-v3/modules-sdks/
