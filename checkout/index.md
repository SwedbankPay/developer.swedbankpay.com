---
title: Swedbank Pay Checkout – Introduction
sidebar:
  navigation:
  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/checkin
      title: Checkin
    - url: /checkout/payment-menu
      title: Payment Menu
    - url: /checkout/capture
      title: Capture 
    - url: /checkout/after-payment
      title: After Payment
    - url: /checkout/other-features
      title: Other Features
---

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

* [HTTPS][https] enabled web server.
* Agreement that includes Swedbank Pay Checkout.
* Obtained credentials (merchant Access Token) from Swedbank Pay through
  Swedbank Pay Admin. Please observe that Swedbank Pay Checkout encompass
  both the **`consumer`** and **`paymentmenu`** scope.

## Introduction

To get started with Swedbank Pay Checkout, you should learn about its different
components and how they work together. Swedbank Pay Checkout consists of two
related, but disconnected concepts: **Checkin** and **Payment Menu**. Checkin
identifies the consumer in our Consumer API and Payment Menu authorizes the
payment with our Payment Menu API. The next step is to **Capture** the payment.
You can either capture the total amount, or do a part-capture (as described
under [After Payment][after-payment-capture]). Connect these steps and you have
Swedbank Pay Checkout.

Under, you will see a sequence diagram showing the sequence of a Swedbank Pay
checkout.

{% include alert.html type="neutral" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay
    participant 3rdParty

        rect rgba(238, 112, 35, 0.05)
            note left of Payer: Checkin

    Payer ->>+ Merchant: Start Checkin
    Merchant ->>+ SwedbankPay: POST /psp/consumers
    deactivate Merchant
    SwedbankPay -->>+ Merchant: rel:view-consumer-identification ①
    deactivate SwedbankPay
    Merchant -->>- Payer: Show Checkin on Merchant Page

    Payer ->>+ Payer: Initiate Consumer Hosted View (open iframe) ②
    Payer ->>+ SwedbankPay: Show Consumer UI page in iframe ③
    deactivate Payer
    SwedbankPay ->>- Payer: Consumer identification process
    activate Payer
    Payer ->>+ SwedbankPay: Consumer identification process
    deactivate Payer
    SwedbankPay -->>- Payer: show consumer completed iframe
    activate Payer
    Payer ->> Payer: EVENT: onConsumerIdentified (consumerProfileRef) ④
    deactivate Payer
    end
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
        activate Merchant
        Merchant -->>- Payer: Show Purchase complete
            opt PaymentOrder Callback (if callbackUrls is set)
            activate Payer
            deactivate Payer
                SwedbankPay ->> Merchant: POST Payment Callback
            end
            end

    rect rgba(81,43,43,0.1)
        activate Merchant
        note left of Payer: Capture
        Merchant ->>+ SwedbankPay: rel:create-paymentorder-capture
        deactivate Merchant
        SwedbankPay -->>- Merchant: Capture status
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>PaymentInstruments that support <br>Authorizations.
        end
```

### Explanations

Under, you see a list of notes that explains some of the sequences in the
diagram.

#### Checkin

* ① `rel: view-consumer-identification` is a value in one of the operations,
  sent as a response from Swedbank Pay to the Merchant.
* ② `Initiate Consumer Hosted View (open iframe)` creates the iframe.
* ③ `Show Consumer UI page in iframe` displays the checkin form as content inside
  of the iframe.
* ④ `onConsumerIdentified (consumerProfileRef)` is an event that triggers when
  the consumer has been identified, and delivers a field
  `consumerProfileRef` as a reference to be used in the payment menu.

#### Payment Menu

* ⑤ `Authorize Payment` is when the payer has accepted the payment.

{% include iterator.html next_href="checkin"
                         next_title="Next: Implement Checkin" %}

[after-payment-capture]: after-payment#capture
[https]: /#connection-and-protocol
[payment-order]: /checkout/other-features#payment-orders
