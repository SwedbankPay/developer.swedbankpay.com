---
title: Swedbank Pay Payment Menu– Introduction
sidebar:
  navigation:
  - title: Payment Menu
    items:
    - url: /payment-menu/
      title: Introduction
    - url: /payment-menu/payment-order
      title: Payment Order
    - url: /payment-menu/capture
      title: Capture
    - url: /payment-menu/after-payment
      title: After Payment
    - url: /payment-menu/other-features
      title: Other Features
---

{% include jumbotron.html body="**Swedbank Pay Payment Menu** integrates
seamlessly into the merchant website through highly customizable and flexible
components."%}

Swedbank Pay Payment Menu allows your customers to pay with their favorite payment
methods in just a few simple steps.

## Prerequisites

To start integrating Swedbank Pay Payment Menu, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes Swedbank Pay Payment Menu.
*   Obtained credentials (merchant Access Token) from Swedbank Pay through
  Swedbank Pay Admin.

## Introduction

To get started with Swedbank Pay Payment Menu, you should learn about its different
components and how they work together. **Payment Menu** authorizes the
payment with our Payment Menu API. The next step is to **Capture** the payment.
You can either capture the total amount, or do a part-capture (as described
under [After Payment][after-payment-capture]). Connect these steps and you have
Swedbank Pay Payment Menu.

Under, you will see a sequence diagram showing the sequence of a Swedbank Pay
Payment Menu.

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay
    participant 3rdParty
    rect rgba(138, 205, 195, 0.1)
            activate Payer
            note left of Payer: Payment Menu
            Payer ->>+ Merchant: Initiate Purchase
            deactivate Payer
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders (paymentUrl, consumerProfileRef)
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel:view-paymentorder
            deactivate SwedbankPay
            Merchant -->>- Payer: Display Payment Menu on Merchant Page
            activate Payer
            Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
            Payer -->>+ SwedbankPay: Show Payment UI page in iframe
            deactivate Payer
            SwedbankPay ->>+ Payer: Do payment logic
            deactivate SwedbankPay
            Payer ->> SwedbankPay: Do payment logic
            deactivate Payer

                opt Consumer perform payment out of iFrame
                    activate Payer
                    Payer ->> Payer: Redirect to 3rd party
                    Payer ->>+ 3rdParty: Redirect to 3rdPartyUrl URL
                    deactivate Payer
                    3rdParty -->>+ Payer: Redirect back to paymentUrl (merchant)
                    deactivate 3rdParty
                    Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
                    Payer ->>+ SwedbankPay: Show Payment UI page in iframe
                    deactivate Payer
                end

        SwedbankPay -->> Payer: Payment status

            alt If payment is completed
            activate Payer
            Payer ->> Payer: Event: onPaymentCompleted
            Payer ->>+ Merchant: Check payment status
            deactivate Payer
            Merchant ->>+ SwedbankPay: GET <paymentorder.id>
            deactivate Merchant
            SwedbankPay ->>+ Merchant: rel: paid-paymentorder
            deactivate SwedbankPay
            opt Get PaymentOrder Details (if paid-paymentorder operation exist)
            activate Payer
            deactivate Payer
            Merchant ->>+ SwedbankPay: GET rel: paid-paymentorder
            deactivate Merchant
            SwedbankPay -->> Merchant: Payment Details
            deactivate SwedbankPay
            end
            end

                opt If payment is failed
                activate Payer
                Payer ->> Payer: Event: OnPaymentFailed
                Payer ->>+ Merchant: Check payment status
                deactivate Payer
                Merchant ->>+ SwedbankPay: GET {paymentorder.id}
                deactivate Merchant
                SwedbankPay -->>+ Merchant: rel: failed-paymentorder
                deactivate SwedbankPay
                opt Get PaymentOrder Details (if failed-paymentorder operation exist)
                activate Payer
                deactivate Payer
                Merchant ->>+ SwedbankPay: GET rel: failed-paymentorder
                deactivate Merchant
                SwedbankPay -->> Merchant: Payment Details
                deactivate SwedbankPay
                end
                end
```

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

{% include iterator.html next_href="payment-order"
                         next_title="Next: Payment Order" %}

[after-payment-capture]: /payment-menu/capture
[https]: /home/technical-information#connection-and-protocol
[payment-order]: /payment-menu/other-features#payment-orders
