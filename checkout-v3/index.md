---
section: Checkout v3
title: Get Started
description: |
  **To give you a hint of how to implement our checkout in a matter that will
  make the most sense for your business, this page aims to give you a brief
  introduction to our four implementation options.**
menu_order: 200
checkout_v3: true

header:
  - table_header: Data Ownership
  - table_header: Swedbank Pay
    badge_type: default
  - table_header: Merchant Side
    badge_type: inactive
table_content:
  - icon: lock
    label: Authentication
    swedbankPay: true
  - icon: local_shipping
    label: Delivery Info
    swedbankPay: true
  - icon: assignment_ind
    label: Payer Info
    swedbankPay: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

table_content_business:
  - icon: lock
    label: Authentication
    swedbankPay: true
  - icon: local_shipping
    label: Delivery Info
    merchantSide: true
  - icon: assignment_ind
    label: Payer Info
    swedbankPay: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

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

The customer journey varies a lot depending on your business vertical. For
example, if you're selling physical goods - like clothes, shoes or computers,
you need to collect a delivery address. Unlike if you are selling digital goods,
where that isn't needed. But this is also a matter of which data you can and/or
wish to collect and manage yourself.

Here, you can choose between two main paths. Either you let us provide you with
a **Full Checkout** solution (including both payer identification and payment
menu) - meaning the payer themselves can choose how they'd like to pay, or you
can decide to use the **Payments Only** option. This means that you are in
charge of collecting and storing the payer data and the payment instruments to
be presented.

Regardless of whether you choose to go with the full checkout or payments only,
we will supply you with a variety of payment instruments and features which
cater to your business needs.

-   **Authentication:** The process of verifying the payer's identity.

-   **Delivery Info:** Information about where the goods should be delivered.

-   **Payer Info:** The payer’s personal data e.g. name, address, card number
    etc.

-   **PSP:** The service of providing payment instruments in the checkout.

## What Are You Looking For?

{% capture tab1_intro %}

## Full Checkout

With the **Full Checkout**, you will get access to a number of payment
instruments. selected to support the needs of the local market. We help you
collect and safely store the payer's data. If the payer agrees, we will store
their information to have it prefilled the next time they shop.
{:.heading-line}
{% endcapture %}

{% capture tab1_content %}

{% include card-table.html
  title='Starter'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text="The ultimate implementation pack for anyone new to this, who needs support
  with all parts covering the checkout. We collect and verify the payer's
  identity, billing and shipping address, and store the payer data.
  Everything needed to get started with online payments."
  table_content=page.table_content
  header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout-v3/starter/'
  %}

{% include card-table.html
  title='Business'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text="On the next level on your growth journey, looking for someone to
  authenticate and store the payer data you collected? We've got you covered, so the
payer won't have to fill out their information twice. Simply
  everything needed for growing your business."
  table_content=page.table_content_business
  header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout-v3/business/'
%}

{% include card-table.html
  title='Enterprise'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text="If you only need support with data storage and payment instruments - this is
  the most suitable option for you. You collect and verify the consumer data,
  and we sort out the rest. Everything you need for scaling your business."
  table_content=page.table_content_enterprise header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout-v3/enterprise/'
%}
{% endcapture %}

{% capture tab2_intro %}

## Payments Only

With our payments only package, you collect the payer data and have the
flexibility to build your own checkout flow. This implementation supports our
full range of payment instruments.
{:.heading-line}
{% endcapture %}

{% capture tab2_content %}

{% include card-table.html
  title='Payments Only'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text="If you can collect, verify and store your payer data*, and if needed -
  the delivery address - this is the option for you. With our PSP you can decide
  if you want to offer a single payment instrument or the full payment offering.

  *We will store the **card** data for you, but you will keep the ownership.
   This means that you will have to facilitate removal of data in accordance
   with GDPR requirements, but won't have to worry about handling sensitive card
   data."
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
