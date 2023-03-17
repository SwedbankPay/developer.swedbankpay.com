---
section: Checkout v3
sidebar_icon: shopping_cart
title: Get Started
description: |
  **This page aims to provide you with a brief introduction to our two options
  for implementing our checkout in a way that makes sense for your business.**
menu_order: 2

header:
  - table_header: Data Ownership
  - table_header: Swedbank Pay
    badge_type: default
  - table_header: Merchant Side
    badge_type: inactive
table_content_enterprise:
  - icon: lock
    label: Authentication
    merchantSide: true
  - icon: local_shipping
    label: Delivery Info
    merchantSide: true
  - icon: assignment_ind
    label: Payer Info
    swedbankPay: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

table_content_payments:
  - icon: lock
    label: Authentication
    merchantSide: true
  - icon: local_shipping
    label: Delivery Info
    merchantSide: true
  - icon: assignment_ind
    label: Payer Info
    merchantSide: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

---

## Choose The Right Implementation For Your Business

Each business vertical has a different customer journey. If you are selling
physical goods like clothes, shoes, or computers, you need to collect a delivery
address, unlike if you are selling digital goods. There is also the matter of
which data you can and/or wish to collect and manage on your own.

There are two main paths you can take here. If you choose the **Full Checkout**
solution (including payer identification as well as payment options), the payer
chooses the method of payment. You can also choose the **Payments Only** option.
In this case, you will collect and store payer data, along with the payment
instruments you will present to the payer. It is possible to use different
implementations per payment order within the **Full Checkout** options.
This is especially useful if you need different customer journeys based on the
device used.

We offer a variety of payment instruments and features designed to meet your
business' needs, regardless of whether you choose the **Full Checkout** or
**Payments Only**. You can choose from the following payment instruments,
somewhat depending on which countries you are operating in.

{% include alert.html type="informative" icon="info" header="Digital Wallets"
body="Some of the digital wallets we offer in Checkout v3 require you to take
additional steps before we can activate them for you. Please follow the link(s)
in the table below to read more." %}

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

-   **Authentication:** The process of verifying the payer's identity.

-   **Delivery Info:** Information about where the goods should be delivered.

-   **Payer Info:** The payer’s personal data e.g. name, address, card number
    etc.

-   **PSP:** A service that provides payment methods at checkout.

## What Are You Looking For?

{% capture tab1_intro %}

## Full Checkout

The **Full Checkout** allows you to choose from a variety of payment options
specific to your local market, while we help you collect and safely store payer
data. Payment information can be stored so it can be prefilled next time the
payer shops if they agree to do so.
{:.heading-line}
{% endcapture %}

{% capture tab1_content %}

{% include card-table.html
  title='Enterprise'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text="This is the most suitable option if you only need data storage and
  payment instruments. You collect and verify consumer data, and we handle the
  rest. Scaling your business has never been easier."
  table_content=page.table_content_enterprise header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout-v3/enterprise/'
%}

{% endcapture %}

{% capture tab2_intro %}

## Payments Only

With our **Payments Only** package, you collect payer data and build your own
checkout flow. Our full range of payment instruments is supported by this
implementation.
{:.heading-line}
{% endcapture %}

{% capture tab2_content %}

{% include card-table.html
  title='Payments Only'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text="Basically, if you're able to collect, verify and store your payer data*,
  plus the delivery address, this is the option for you. Our PSP lets you choose
  whether to offer a single payment instrument or the whole thing.

  *We'll store the card data for you, but you own it. So you'll have to remove
  data in compliance with GDPR, but you won't have to worry about handling
  sensitive card info."
  table_content=page.table_content_payments
  header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout-v3/payments-only/'
%}
{% endcapture %}

{% include tabs.html
  tab1_intro=tab1_intro
  tab1_content=tab1_content
  tab2_intro=tab2_intro
  tab2_content=tab2_content
  %}

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
