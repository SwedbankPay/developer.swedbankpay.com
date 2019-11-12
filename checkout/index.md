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
the consumer in our Consumer API and Payment Menu authorizes the payment with
our Payment Menu API. The next step is to **Capture** the payment. You can either
capture the total amount, or do a part-capture (as described under 'After Payment'). Connect these steps and you have
Swedbank Pay Checkout.

Under, you will see a sequence diagram showing the sequence of a Swedbank Pay checkout.
Note that in this diagram, the Payer refers to the merchant front-end (website)
while Merchant refers to the merchant back-end.

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    activate Payer
        rect rgba(238, 112, 35, 0.05)
            note left of Payer: Checkin

            Payer ->> Merchant: Start Checkin
            activate Merchant
                Merchant ->> SwedbankPay: POST /psp/consumers
                activate SwedbankPay
                    SwedbankPay -->> Merchant: rel:view-consumer-identification [1]
                deactivate SwedbankPay
                Merchant -->> Payer: Show Checkin (Consumer Hosted View)

            deactivate Merchant
            Payer ->> Payer: Initiate Consumer Hosted View (open iframe) [2]
            Payer ->> SwedbankPay: Show Consumer UI page in iframe [3]
            activate SwedbankPay
                SwedbankPay ->> Payer: Consumer identification process
                SwedbankPay -->> Payer: Show Consumer completed iframe
            deactivate SwedbankPay
            Payer ->> Payer: onConsumerIdentified (consumerProfileRef) [4]
        end

        rect rgba(138,205,195,0.1)
            note left of Payer: Payment Menu
            Payer ->>+ Merchant: Prepare Payment Menu
                Merchant ->>+ SwedbankPay: POST /psp/paymentorders (paymentUrl, consumerProfileRef)
                    SwedbankPay -->>- Merchant: rel:view-paymentorder
                Merchant -->>- Payer: Display Payment Menu
            Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
            SwedbankPay -->> Payer: Show Payment UI page in iframe
            activate SwedbankPay
                Payer ->> SwedbankPay: Authorize Payment [5]
                opt consumer perform payment out of iframe
                    SwedbankPay ->> Merchant: POST Payment Callback
                    SwedbankPay -->> Payer: Redirect to Payment URL
                    Payer ->> Merchant: Prepare Payment Menu
                    Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
                    Payer ->> SwedbankPay: Show Payment UI page in iframe
                    SwedbankPay -->> Payer: Payment status
                    Payer ->>+ Merchant: Redirect to Payment Complete URL
                        Merchant ->>+ SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
                            SwedbankPay -->>- Merchant: Payment Order status
                    deactivate Merchant
                end
                opt consumer perform payment within iframe
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

### Explanations

Under, you see a list of notes that explains some of the sequences in the diagram. 

#### Checkin

[1] 'rel: view-consumer-identification' is a value in one of the operations,
sent as a response from Swedbank Pay to the Merchant. <br>
[2] 'Initiate Consumer Hosted View (open iframe)' creates the iframe. <br>
[3] 'Show Consumer UI page in iframe' displays the checkin form as content inside
of the iframe. <br>
[4] 'onConsumerIdentified (consumerProfileRef)' is an event that triggers when the
consumer has been identified, and delivers<br> a property 'consumerProfileRef' as a
reference to be used in the payment menu.

#### Payment Menu

[5] 'Authorize Payment' is when the payer has accepted the payment.

{% include iterator.html next_href="payment"
                         next_title="Next: Implement Payment" %}

[https]: /#connection-and-protocol
[payment-order]: /checkout/payment#payment-orders
