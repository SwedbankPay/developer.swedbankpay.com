---
section: Checkout v3
title: Get Started
estimated_read: 5
description: |
  Before moving on we would like to give you a brief introduction to what you need
  to consider before composing your checkout page, along with some prerequisites.
menu_order: 300
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

**Consumer Info:**  The consumer's personal data e.g. name, address, phone
number etc.

**Authendication:** The process for verifying the consumer's identity via
Strong Consumer Authentication (e.g. BankID).

**Delivery Info:** Information about where the goods should be delivered.

**PSP:** The service of providing payment methods in the checkout or payment
menu.

## What Are You Looking For?

**Full Checkout**
**Payments Only**

## Full Checkout

By using the Full Checkout, we help you collect and safely store consumer data.
We can also prefill consumer info in the checkout if they have agreed to let us
store their info. All of our implementations support both single payment options
and the full payment offering.

### Standard

We collect and verify the identity of your consumer. We also collect the billing
and shipping address, and we store the consumer information. With our PSP you
are always able to choose one or more payment methods.

Data Ownership          Swedbank Pay                  Merchant side

Authentication          v
Delivery Info           v
Consumer Info           v
PSP                     v

{% include iterator.html next_href="/checkout/v3/standard/setup"
                         next_title="Proceed" %}

### Authenticated

The consumer data you have collected, is shared with us for verification and
storage. If you have a login, your consumer won't need to fill out their
information twice. With our PSP you are always able to choose one or more
payment methods.

Data Ownership          Swedbank Pay                  Merchant side

Authentication          v
Delivery Info           v
Consumer Info                                         v
PSP                     v

{% include iterator.html next_href="/checkout/v3/authenticated/setup"
                         next_title="Proceed" %}

### Merchant Authenticated Consumer

In order to implement this solution, you need to be able to both collect and
verify your consumer's data using SCA. We store the consumer information, and
with our PSP you are always able to choose one or more payment methods.

Data Ownership          Swedbank Pay                  Merchant side

Authentication                                        v
Delivery Info                                         v
Consumer Info           v
PSP                     v

{% include iterator.html next_href="/checkout/v3/mac/setup"
                         next_title="Proceed" %}

## Payments Only

If you are looking for our payments package, you will have the flexibility to
build your own checkout flow. You collect the consumer data and own the entire
checkout process. The **Payments Only** implementation supports both single
payment options and the full payment offering.

### Payments

In order to implement this solution, you need to be able to both collect and
verify your consumer's data using SCA. You also store the consumer information.
With our PSP you are always able to choose one or more payment methods.

Data Ownership          Swedbank Pay                  Merchant side

Authentication                                        v
Delivery Info                                         v
Consumer Info                                         v
PSP                     v

{% include iterator.html next_href="/checkout/v3/payments/setup"
                         next_title="Proceed" %}
