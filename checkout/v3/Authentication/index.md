---
section: Checkout Authentication
title: Introduction
estimated_read: 5
description: |
  **Swedbank Pay Checkout** is a complete reimagination
  of the checkout experience, integrating seamlessly into the merchant website
  through highly customizable and flexible components.
  Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
  and try out Swedbank Pay Checkout for yourself!
menu_order: 100
---


## Introduction

You should choose our Checkout Authentication integration model if: 
- you collect your own consumer information in order to complete an order.
- you do not need consumer information from Swedbank Pay to calculate shipping costs.
- you do not have an consumer authentication login.
- want your consumers to access stored payment information in Swedbank Pay Checkout for easier payment process.


You can choose two different ways of integrating the Authentication-model. 
Either by Redirect mode, where you send the consumer to Swedbank Pay page and we 
will handle the entire authentication and paymentprocess. The consumer will be 
redirected back to you when the purchase is completed or consumer has chosen to abort payment.
The payment page will be styled by Swedbank Pay.

The other alternative is by Seamless view. This is where the consumer stays at your 
site, and you initiate the SwedbankPay authentication and payment module in an iframe.
The checkin and payment-compontent will be styled by Swedbank Pay.

Go to the next step in order to read more about our two integration alternatives.

{% include languages.md %}

{% include iterator.html next_href="redirect"
                         next_title="Implement Redirect" %}

{% include iterator.html next_href="samless-view"
                         next_title="Implement Seamless View" %}

[after-payment-capture]: /checkout/v3/capture
[https]: /introduction#connection-and-protocol

