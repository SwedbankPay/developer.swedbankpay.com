---
section: Checkout v2
sidebar_icon: shopping_cart
title: Introduction
description: |
  **Swedbank Pay Checkout** is a complete reimagination
  of the checkout experience, integrating seamlessly into the merchant website
  through highly customizable and flexible components.
  Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
  and try out Swedbank Pay Checkout for yourself!
menu_order: 4
---

Swedbank Pay Checkout allows your customers to be identified by Swedbank Pay,
enabling existing Swedbank Pay Checkout users to pay with their favorite payment
methods in just a few simple steps.

## Prerequisites

To start integrating Swedbank Pay Checkout, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes Swedbank Pay Checkout.
*   Obtained credentials (merchant Access Token) from Swedbank Pay through
    the Merchant Portal. Please observe that Swedbank Pay Checkout encompass
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
Checkin, or if they opt not to store their data, that's fine. The Payment
Menu can still be used as a **guest**.

## Sequence

Below, you will find sequence diagrams visualizing the sequence of Swedbank Pay
Checkout. The parties involved in the sequences are:

*   **Payer** refers to the front-end code that runs in the web browser
   (JavaScript events as well as user interaction).
*   **Merchant** refers to the merchant back-end server.
*   **Swedbank Pay** refers to the Swedbank Pay API.

### Checkin

The first operation in the Checkout process is to identify the payer. This step
is called **Checkin** and is visualized in the below diagram.

```plantuml
@startuml "Checkin"
    $participant("payer", "Payer") as Payer
    $participant("merchant", "Merchant") as Merchant
    $participant("server", "Swedbank Pay") as SwedbankPay

    Payer -> Merchant: Start Checkin
    activate Payer
        activate SwedbankPay
            Merchant -> SwedbankPay: $code("POST /psp/consumers")
            activate Merchant
                SwedbankPay --> Merchant: $code("rel:view-consumer-identification") <b>①</b>
                Merchant --> Payer: $code("rel:view-consumer-identification") <b>②</b>
            deactivate Merchant
            Payer <-> SwedbankPay: $code("<script src=rel:view-consumer-identification.href />")
        deactivate SwedbankPay
    deactivate Payer

    Payer -> Payer: $code("payex.hostedView.consumer()")

    activate Payer
        Payer -> SwedbankPay: Consumer identification <b>③</b>
        activate SwedbankPay
            SwedbankPay --> Payer: $code("onConsumerIdentified(consumerProfileRef)") <b>④</b>
        deactivate SwedbankPay

        Payer -> Merchant: $code("POST { consumerProfileRef }") <b>⑤</b>
    deactivate Payer

    activate Merchant
        Merchant -> Merchant: Store $code("consumerProfileRef")
    deactivate Merchant
@enduml
```

1.  `rel:view-consumer-identification` is a value in one of the operations,
    sent as a response from Swedbank Pay to the Merchant.
2.  **Show Checkin** creates and displays the Checkin Seamless View.
3.  **Consumer identification** is a simplified view of what happens inside the
    Checkin Seamless View in order to identify the payer.
4.  `onConsumerIdentified(consumerProfileRef)` is an event that triggers when
    the consumer has been identified, and delivers the field
    `consumerProfileRef` as a reference to be used when creating the Payment
    Order that will be used to display the Payment Menu.
5.  `POST { consumerProfileRef }` ensures that the `consumerProfileRef` is
    persisted in storage (a database, for example).

### Payment Menu

When **Checkin** is completed successfully and the `consumerProfileRef` is
secured, the next operation is to display the **Payment Menu** and have the
payer complete a payment, which is visualized in the sequence diagram below.

```plantuml
@startuml "Payment Menu"
    $participant("payer", "Payer") as Payer
    $participant("merchant", "Merchant") as Merchant
    $participant("server", "Swedbank Pay") as SwedbankPay

    ' TODO: Remove scale once https://github.com/plantuml/plantuml/discussions/793 is solved.
    scale 0.81

    Payer -> Merchant: Pay
    activate Payer
        activate Merchant
            Merchant -> SwedbankPay: $code("POST /psp/paymentorders { consumerProfileRef }")
            activate SwedbankPay
                SwedbankPay --> Merchant: $code("rel:view-paymentorder")
            deactivate SwedbankPay
            Merchant --> Payer: $code("rel:view-paymentorder")
        deactivate Merchant

        Payer <-> SwedbankPay: $code("<script src=rel:view-paymentorder.href />")

        activate SwedbankPay
            Payer -> Payer: $code("payex.hostedView.paymentMenu()")
            SwedbankPay <-> Payer: Perform payment
        deactivate SwedbankPay
    deactivate Payer

    alt#fff #ebf8f2 completed payment
        SwedbankPay -> Payer: $code("onPaymentCompleted(paymentorder)")
        activate SwedbankPay
            activate Payer
                Payer -> Merchant: Check payment status
                activate Merchant
                    Merchant -> SwedbankPay: $code("GET paymentorder.id")
                    SwedbankPay --> Merchant: $code("rel:paid-paymentorder")
                    Merchant -> SwedbankPay: $code("GET rel:paid-paymentorder.href")
                    SwedbankPay --> Merchant: Completed Payment Order
                    Merchant --> Payer: Show receipt
                deactivate Merchant
            deactivate Payer
        deactivate SwedbankPay
    else failed payment
        SwedbankPay -> Payer: $code("onPaymentFailed(paymentorder)")
        activate SwedbankPay
            activate Payer
                Payer -> Merchant: Check payment status
                activate Merchant
                    Merchant -> SwedbankPay: $code("GET paymentorder.id")
                    SwedbankPay --> Merchant: $code("rel:failed-paymentorder")
                    Merchant -> SwedbankPay: $code("GET rel:failed-paymentorder.href")
                    SwedbankPay --> Merchant: Failed Payment Order
                    Merchant --> Payer: Show failure page
                deactivate Merchant
            deactivate Payer
        deactivate SwedbankPay
    end
@enduml
```

{% comment %}
TODO: Number each important step in the above diagram and create a numbered list
      that explains each step.
{% endcomment %}

### Callback

For every change to the Payment Order after its creation, a [callback] will be
made from Swedbank Pay towards the `callbackUrl` specified in the Payment Order.
It is important to listen to these callbacks so in the event that the payer
closes the browser window, there are network problems or anything else
unexpected happens during the payment process, the status is updated in the
merchant system.

```plantuml
@startuml "Callback"
    $participant("merchant", "Merchant") as Merchant
    $participant("server", "Swedbank Pay") as SwedbankPay

    SwedbankPay -> Merchant: $code("POST { payment activity }")
    activate Merchant
        activate SwedbankPay
            Merchant -> SwedbankPay: $code("GET paymentorder.id")
            SwedbankPay --> Merchant: Payment Order
        deactivate SwedbankPay

        Merchant -> Merchant: Update order status
    deactivate Merchant
@enduml
```

{% comment %}
TODO: Number each important step in the above diagram and create a numbered list
      that explains each step.
{% endcomment %}

### Capture

After the payment is completed, you can **Capture** the payment. Capture should
be done after the goods are shipped or if the purchased goods don't require
shipping. Only payment instruments that support authorizations will expose the
`create-paymentorder-capture` operation when they can be captured.

```plantuml
@startuml "Capture"
    $participant("merchant", "Merchant") as Merchant
    $participant("server", "Swedbank Pay") as SwedbankPay

    Merchant -> Merchant: Capture
    activate Merchant
        Merchant -> SwedbankPay: $code("GET paymentorder.id")
        activate SwedbankPay
            SwedbankPay --> Merchant: $code("rel:create-paymentorder-capture")
            Merchant -> SwedbankPay: $code("POST rel:create-paymentorder-capture.href")
            SwedbankPay --> Merchant: Capture status
        deactivate SwedbankPay

        Merchant -> Merchant: Update order status
    deactivate Merchant
@enduml
```

{% comment %}
TODO: Number each important step in the above diagram and create a numbered list
      that explains each step.
{% endcomment %}

This product supports Danish `da-DK`, English (US) `en-US`, Finnish `fi-FI`,
Norwegian `nb-NO` and Swedish `sv-SE`.

{% include iterator.html next_href="checkin"
                         next_title="Implement Checkin" %}

[after-payment-capture]: /old-implementations/checkout-v2/capture
[callback]: /old-implementations/checkout-v2/features/core/callback
[https]: /introduction#connection-and-protocol
