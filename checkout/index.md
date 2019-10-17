---
title: Swedbank Pay Checkout – Introduction
opengraph:
    description: Introduction to Swedbank Pay Checkout
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
    - url: /checkout/3DS2-documentation
      title: 3DS2 Documentation
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/test-data
      title: Test Data
    - url: /resources/demoshop
      title: Demoshop
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
  both the **`consumer`** and **`paymentmenu`** scope.

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

            Payer ->> Merchant: Start Checkin
            activate Merchant
                Merchant ->> SwedbankPay: POST /psp/consumers
                activate SwedbankPay
                    SwedbankPay -->> Merchant: rel:view-consumer-identification
                deactivate SwedbankPay
                Merchant -->> Payer: Show Checkin (Consumer Hosted View)

            deactivate Merchant
            Payer ->> Payer: Initiate Consumer Hosted View (open iframe)
            Payer ->> SwedbankPay: Show Consumer UI page in iframe
            activate SwedbankPay
                SwedbankPay ->> Payer: Consumer identification process
                SwedbankPay -->> Payer: show consumer completed iframe
            deactivate SwedbankPay
            Payer ->> Payer: onConsumerIdentified (consumerProfileRef)
        end

        rect rgba(138,205,195,0.1)
            note left of Payer: Payment Menu
            Payer ->> Merchant: Prepare Payment Menu
            activate Merchant
                Merchant ->> SwedbankPay: POST /psp/paymentorders (paymentUrl, consumerProfileRef)
                activate SwedbankPay
                    SwedbankPay -->> Merchant: rel:view-paymentorder
                deactivate SwedbankPay
                Merchant -->> Payer: Display Payment Menu
            deactivate Merchant
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
                    Payer ->> Merchant: Redirect to Payment Complete URL
                    activate Merchant
                        Merchant ->> SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
                        activate SwedbankPay
                            SwedbankPay -->> Merchant: Payment Order status
                        deactivate SwedbankPay
                    deactivate Merchant
                end
                opt consumer performes payment within iframe
                    SwedbankPay ->> Merchant: POST Payment Callback
                    SwedbankPay -->> Payer: Payment status
                    Payer ->> Merchant: Redirect to Payment Complete URL
                    activate Merchant
                        Merchant ->> SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
                        activate SwedbankPay
                            SwedbankPay -->> Merchant: Payment Order status
                        deactivate SwedbankPay
                    deactivate Merchant
                end
            deactivate SwedbankPay
        end
    deactivate Payer

    rect rgba(81,43,43,0.1)
        note left of Payer: Capture
        activate Merchant
            Merchant ->> SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
            activate SwedbankPay
                SwedbankPay -->> Merchant: rel:create-paymentorder-capture
            deactivate SwedbankPay
            Merchant ->> SwedbankPay: POST /psp/paymentorders/<paymentOrderId>/captures
            activate SwedbankPay
                SwedbankPay -->> Merchant: Capture status
            deactivate SwedbankPay
            note right of Merchant: Capture here only if the purchased goods don't require shipping. If shipping is required, perform capture after the goods have shipped.
        deactivate Merchant
    end
```

### Payment Url

For our hosted views solution in Checkout (using
[Payment Order][payment-order]), we have a URL property called `paymentUrl`
that will be used if the consumer is redirected out of the hosted view
(the `iframe`). The consumer is redirected out of `iframe` when selecting
payment methods Vipps or in the 3D secure verification for credit card
payments.

The URL should represent the page of where the payment hosted view was hosted
originally, such as the checkout page, shopping cart page, or similar.
Basically, `paymentUrl` should be set to the same URL as that of the page
where the JavaScript for the hosted payment view was added to in order to
initiate the payment. Please note that the `paymentUrl` must be able to invoke
the same JavaScript URL from the same Payment or Payment Order as the one that
initiated the payment originally, so it should include some sort of state
identifier in the URL. The state identifier is the ID of the order, shopping
cart or similar that has the URL of the Payment or Payment Order stored.

If `paymentUrl` is not supplied, retry of payments will not be possible in
[Payment Order][payment-order], which makes it more tedious to retry payment
as the whole process including the creation of the payment order needs to
be performed again.

With `paymentUrl` in place, the retry process becomes much more convenient for
both the integration and the payer.

  [https]: /#connection-and-protocol
  [payment-order]: #
  [initiate-consumer-session]: #
  [view-consumer-identification]: #
  [msisdn]: https://en.wikipedia.org/wiki/MSISDN
  [payee-reference]: #
  [consumer-events]: #
  [payment-menu-styling]: #
  [payment-order-operations]: #
  [transactions]: #
  [guest-payments]: #
  [callback]: #
