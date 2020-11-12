---
section: Checkout
title: Introduction
estimated_read: 3
description: |
  **Swedbank Pay Checkout** is a complete reimagination
  of the checkout experience, integrating seamlessly into the merchant website
  through highly customizable and flexible components.
  Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
  and try out Swedbank Pay Checkout for yourself!
menu_order: 100
---

Swedbank Pay Checkout allows your customers to be identified with Swedbank Pay,
enabling existing Swedbank Pay Checkout users to pay with their favorite payment
methods in just a few simple steps.

## Prerequisites

To start integrating Swedbank Pay Checkout, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes Swedbank Pay Checkout.
*   Obtained credentials (merchant Access Token) from Swedbank Pay through
    Swedbank Pay Admin. Please observe that Swedbank Pay Checkout encompass
    both the **`consumer`** and **`paymentmenu`** scope.

## Introduction

To get started with Swedbank Pay Checkout, you should learn about its different
components and how they work together. Swedbank Pay Checkout consists of two
related, but disconnected concepts: **Checkin** and **Payment Menu**. Checkin
identifies the consumer in our Consumer API and Payment Menu authorizes the
payment with our Payment Menu API.

The next step is to **Capture** the payment. You can either capture the total
amount, or do a part-capture (as described under
[After Payment][after-payment-capture]). Connect these steps and you have
Swedbank Pay Checkout.

While Checkin is a necessary component to store personal information and access
features like storing cards, it is not a mandatory step for the Checkout process
to work. If the payer is from a country where we currently don't support
Checkin, or if he or she opts not to store their data, that's fine. The Payment
Menu can still be used as a **guest**.

Below, you will see a sequence diagram showing the sequence of a Swedbank Pay
checkout.

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```mermaid
sequenceDiagram
    participant Consumer
    participant Merchant
    participant SwedbankPay as Swedbank Pay
    participant 3rdParty

        rect rgba(238, 112, 35, 0.05)
            note left of Consumer: Checkin

    Consumer ->>+ Merchant: Start Checkin
    Merchant ->>+ SwedbankPay: POST /psp/consumers
    deactivate Merchant
    SwedbankPay -->>+ Merchant: rel:view-consumer-identification ①
    deactivate SwedbankPay
    Merchant -->>- Consumer: Show Checkin on Merchant Page

    Consumer ->>+ Consumer: Initiate Consumer Hosted View (open iframe) ②
    Consumer ->>+ SwedbankPay: Show Consumer UI page in iframe ③
    deactivate Consumer
    SwedbankPay ->>- Consumer: Consumer identification process
    activate Consumer
    Consumer ->>+ SwedbankPay: Consumer identification process
    deactivate Consumer
    SwedbankPay -->>- Consumer: show consumer completed iframe
    activate Consumer
    Consumer ->> Consumer: EVENT: onConsumerIdentified (consumerProfileRef) ④
    deactivate Consumer
    end
        rect rgba(138, 205, 195, 0.1)
            activate Consumer
            note left of Consumer: Payment Menu
            Consumer ->>+ Merchant: Initiate Purchase
            deactivate Consumer
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders (paymentUrl, consumerProfileRef)
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel:view-paymentorder
            deactivate SwedbankPay
            Merchant -->>- Consumer: Display Payment Menu on Merchant Page
            activate Consumer
            Consumer ->> Consumer: Initiate Payment Menu Hosted View (open iframe)
            Consumer -->>+ SwedbankPay: Show Payment UI page in iframe
            deactivate Consumer
            SwedbankPay ->>+ Consumer: Do payment logic
            deactivate SwedbankPay
            Consumer ->> SwedbankPay: Do payment logic
            deactivate Consumer

                opt Consumer perform payment out of iFrame
                    activate Consumer
                    Consumer ->> Consumer: Redirect to 3rd party
                    Consumer ->>+ 3rdParty: Redirect to 3rdPartyUrl URL
                    deactivate Consumer
                    3rdParty -->>+ Consumer: Redirect back to paymentUrl (merchant)
                    deactivate 3rdParty
                    Consumer ->> Consumer: Initiate Payment Menu Hosted View (open iframe)
                    Consumer ->>+ SwedbankPay: Show Payment UI page in iframe
                    deactivate Consumer
                end

        SwedbankPay -->> Payer: Payment status

            alt If payment is completed
            activate Consumer
            Consumer ->> Consumer: Event: onPaymentCompleted
            Consumer ->>+ Merchant: Check payment status
            deactivate Consumer
            Merchant ->>+ SwedbankPay: GET <paymentorder.id>
            deactivate Merchant
            SwedbankPay ->>+ Merchant: rel: paid-paymentorder
            deactivate SwedbankPay
            opt Get PaymentOrder Details (if paid-paymentorder operation exist)
            activate Consumer
            deactivate Consumer
            Merchant ->>+ SwedbankPay: GET rel: paid-paymentorder
            deactivate Merchant
            SwedbankPay -->> Merchant: Payment Details
            deactivate SwedbankPay
            end
            end

                opt If payment is failed
                activate Consumer
                Consumer ->> Consumer: Event: OnPaymentFailed
                Consumer ->>+ Merchant: Check payment status
                deactivate Consumer
                Merchant ->>+ SwedbankPay: GET {paymentorder.id}
                deactivate Merchant
                SwedbankPay -->>+ Merchant: rel: failed-paymentorder
                deactivate SwedbankPay
                opt Get PaymentOrder Details (if failed-paymentorder operation exist)
                activate Consumer
                deactivate Consumer
                Merchant ->>+ SwedbankPay: GET rel: failed-paymentorder
                deactivate Merchant
                SwedbankPay -->> Merchant: Payment Details
                deactivate SwedbankPay
                end
                end
        activate Merchant
        Merchant -->>- Consumer: Show Purchase complete
            opt PaymentOrder Callback (if callbackUrls is set)
            activate Consumer
            deactivate Consumer
                SwedbankPay ->> Merchant: POST Payment Callback
            end
            end

    rect rgba(81,43,43,0.1)
        activate Merchant
        note left of Consumer: Capture
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

*   ① `rel: view-consumer-identification` is a value in one of the operations,
    sent as a response from Swedbank Pay to the Merchant.
*   ② `Initiate Consumer Hosted View (open iframe)` creates the iframe.
*   ③ `Show Consumer UI page in iframe` displays the checkin form as content inside
    of the iframe.
*   ④ `onConsumerIdentified (consumerProfileRef)` is an event that triggers when
    the consumer has been identified, and delivers a field
    `consumerProfileRef` as a reference to be used in the payment menu.

#### Payment Menu

*   ⑤ `Authorize Payment` is when the payer has accepted the payment.

{% include languages.md api_resource="paymentorders" %}

{% include iterator.html next_href="checkin"
                         next_title="Implement Checkin" %}

[after-payment-capture]: /checkout/capture
[https]: /home/technical-information#connection-and-protocol
[payment-order]: /checkout/other-features#payment-orders
