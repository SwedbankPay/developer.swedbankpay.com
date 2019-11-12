---
title: Swedbank Pay Checkout – Introduction
sidebar:
  navigation:
  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/payment
      title: Payment
    - url: /checkout/after-payment
      title: After Payment
    - url: /checkout/summary
      title: Summary
    - url: /checkout/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

{% include jumbotron.html body="**Swedbank Pay Checkout** is a complete reimagination
of the checkout experience, integrating seamlessly into the merchant website
through highly customizable and flexible components.

Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
and try out Swedbank Pay Checkout for yourself!" %}

Swedbank Pay Checkout allows your customers to be identified with Swedbank Pay,
enabling existing Swedbank Pay Checkout users to pay with their favorite payment
methods in just a few simple steps.

## Prerequisites

To start integrating Swedbank Pay Checkout, you need the following:

* [HTTPS][https] enabled web server
* Agreement that includes Swedbank Pay Checkout
* Obtained credentials (merchant Access Token) from Swedbank Pay through
  Swedbank Pay Admin. Please observe that Swedbank Pay Checkout encompass
  both the **`consumer`** and **`paymentmenu`** scope

## Introduction

To get started with Swedbank Pay Checkout, you should learn about its different
components and how they work together. Swedbank Pay Checkout consists of two related,
but disconnected concepts: **Checkin** and **Payment Menu**. Checkin identifies
the consumer in our Consumer API and Payment Menu completes the payment with
our Payment Menu API. Connect the two concepts and you have Swedbank Pay Checkout.

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    activate Payer
        rect rgba(238, 112, 35, 0.05)
            note left of Payer: Checkin

            Payer ->>+ Merchant: Start Checkin
                Merchant ->>+ SwedbankPay: POST /psp/consumers
                    SwedbankPay -->>- Merchant: rel:view-consumer-identification
                Merchant -->>- Payer: Show Checkin (Consumer Hosted View)

            Payer ->> Payer: Initiate Consumer Hosted View (open iframe)
            Payer ->>+ SwedbankPay: Show Consumer UI page in iframe
                SwedbankPay ->> Payer: Consumer identification process
                SwedbankPay -->>- Payer: show consumer completed iframe
            Payer ->> Payer: onConsumerIdentified (consumerProfileRef)
        end
    deactivate Payer

        rect rgba(138,205,195,0.1)
    activate Payer
            note left of Payer: Payment Menu
            Payer ->>+ Merchant: Prepare Payment Menu
                Merchant ->>+ SwedbankPay: POST /psp/paymentorders (paymentUrl, consumerProfileRef)
                    SwedbankPay -->>- Merchant: rel:view-paymentorder
                Merchant -->>- Payer: Display Payment Menu
            Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
            SwedbankPay -->> Payer: Show Payment UI page in iframe
            activate SwedbankPay
                Payer ->> SwedbankPay: Pay
                opt consumer perform payment out of iframe
                    SwedbankPay ->> Merchant: POST Payment Callback
                    SwedbankPay -->> Payer: Redirect to Payment URL
                    Payer ->> Merchant: Prepare payment Menu
                    Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
                    Payer ->> SwedbankPay: Show Payment UI page in iframe
                    SwedbankPay -->> Payer: Payment status
                    Payer ->>+ Merchant: Redirect to Payment Complete URL
                        Merchant ->>+ SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
                            SwedbankPay -->>- Merchant: Payment Order status
                    deactivate Merchant
                end
                opt consumer performes payment within iframe
                    SwedbankPay ->> Merchant: POST Payment Callback
                    SwedbankPay -->> Payer: Payment status
                    Payer ->>+ Merchant: Redirect to Payment Complete URL
                        Merchant ->>+ SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
                            SwedbankPay -->>- Merchant: Payment Order status
                    deactivate Merchant
                end
            deactivate SwedbankPay
        end
    deactivate Payer

    rect rgba(81,43,43,0.1)
        note left of Payer: Capture
        activate Merchant
            Merchant ->>+ SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
                SwedbankPay -->>- Merchant: rel:create-paymentorder-capture
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders/<paymentOrderId>/captures
                SwedbankPay -->>- Merchant: Capture status
            note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.
        deactivate Merchant
    end
```

{% include iterator.html next_href="payment"
                         next_title="Next: Implement Payment" %}

[https]: /#connection-and-protocol
[payment-order]: /checkout/payment#payment-orders
