---
section: Checkout v3
title: Get Started
description: |
  **Before moving on we would like to give you a brief introduction to what you need
  to consider before composing your checkout page, along with some prerequisites.**
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
    label: Consumer Info
    swedbankPay: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

table_content_authenticated:
  - icon: lock
    label: Authentication
    merchantSide: true
  - icon: local_shipping
    label: Delivery Info
    swedbankPay: true
  - icon: assignment_ind
    label: Consumer Info
    swedbankPay: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

table_content_mac:
  - icon: lock
    label: Authentication
    merchantSide: true
  - icon: local_shipping
    label: Delivery Info
    merchantSide: true
  - icon: assignment_ind
    label: Consumer Info
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
    label: Consumer Info
    merchantSide: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

---

## Choose The Right Implementation For Your Business

Truth is, the customer journey varies a lot depending on your business
vertical. For example, if you're selling physical goods like clothes, shoes or
computers, you need to collect the address of the consumer for shipping
purposes. Unlike if you were selling digital goods, where that's simply not
necessary. But it also comes down to what you are able and wish to manage
yourself.

When building your checkout page you have two main paths. Either you let us
provide you with the entire checkout solution. This includes consumer
identification and payment menu, where your customer themselves can choose how
to pay. Or, you can choose to only use our payment option (also called the
payment menu), where you are in charge of collecting and storing the customer
data.

Regardless if you choose our checkout or payments only option, you will always
be able to decide which payment options are available for the consumer. Hence
you can show all available payment options for that specific market, or just one
or two if that makes more sense for your business.

-   **Consumer Info:** The consumer's personal data e.g. name, address, phone
    number etc.

-   **Authentication:** The process for verifying the consumer's identity via
    Strong Consumer Authentication (e.g. BankID).

-   **Delivery Info:** Information about where the goods should be delivered.

-   **PSP:** The service of providing payment methods in the checkout or payment
    menu.

## What Are You Looking For?

{% capture tab1_intro %}

## Full Checkout

By using the **Full Checkout**, we help you collect and safely store consumer
data. We can also prefill consumer info in the checkout if they have agreed to
let us store their info. All of our implementations support both single payment
options and the full payment offering.
{:.heading-line}
{% endcapture %}

{% capture tab1_content %}

{% include card-extended.html
  title='Standard'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text='We collect and verify the identity of your consumer. We also collect the billing and shipping address, and we store the consumer information. With our PSP you are always able to choose one or more payment methods.'
  table_content=page.table_content
  header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout-v3/standard/'
  %}

{% include card-extended.html
  title='Authenticated'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text="The consumer data you have collected, is shared with us for verification and
  storage. If you have a login, your consumer won't need to fill out their
  information twice. With our PSP you are always able to choose one or more
  payment methods."
  table_content=page.table_content_authenticated
  header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout-v3/authenticated/'
%}

{% include card-extended.html
  title='Merchant Authenticated Consumer'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text="In order to implement this solution, you need to be able to both collect and
  verify your consumer's data using SCA. We store the consumer information, and
  with our PSP you are always able to choose one or more payment methods."
  table_content=page.table_content_mac
  header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout-v3/mac/'
%}
{% endcapture %}

{% capture tab2_intro %}

## Payments Only

If you are looking for our payments package, you will have the flexibility to
build your own checkout flow. You collect the consumer data and own the entire
checkout process. The **Payments Only** implementation supports both single
payment options and the full payment offering.
{:.heading-line}
{% endcapture %}

{% capture tab2_content %}

{% include card-extended.html
  title='Payments'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text="In order to implement this solution, you need to be able to both collect and
  verify your consumer's data using SCA. You also store the consumer information.
  With our PSP you are always able to choose one or more payment methods."
  table_content=page.table_content_payments
  header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout-v3/payments/'
%}
{% endcapture %}

{% include tabs.html
  tab1_intro=tab1_intro
  tab1_content=tab1_content
  tab2_intro=tab2_intro
  tab2_content=tab2_content
  %}
