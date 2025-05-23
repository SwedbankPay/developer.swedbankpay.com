---
section: Payment Methods v1
sidebar_icon: credit_card
title: Introduction
redirect_from: /payments/
description: |
  Payment Methods v1 is our off-the-rack assortment of possibilities. Pick the
  one(s) you like. You can pick and choose among them to tailor a package best
  suited for your business.
permalink: /:path/
menu_order: 5
---

Is Card the only payment method you need? Go for Card only. Do you want Card
and Invoice? Implement Card and Invoice. Want them all? Have them all. Each
payment method is set up with a separate contract and integration.

Choose between our easy-to-use PCI compliant platforms Redirect or Seamless
View. Our payment mehods and their platform availability are listed in the
table below.

{:.table .table-plain}
|                              | Payment Method              |  Seamless View   |     Redirect     |     Direct API     | Region                                    |
| :--------------------------: | :------------------------------ | :--------------: | :--------------: | :----------------: | :---------------------------------------- |
|    {% icon credit_card %}    | [Card Payments][card]           | {% icon check %} | {% icon check %} |  | ![EarthIcon][earth-icon]                  |
| {% icon insert_drive_file %} | [Swedbank Pay Invoice][invoice] | {% icon check %} | {% icon check %} |                    | {% flag no %} |
|     ![Vipps][vipps-logo]     | [Vipps][vipps]                  | {% icon check %} | {% icon check %} |                    | {% flag no %}                             |
|     ![Swish][swish-logo]     | [Swish][swish]                  | {% icon check %} | {% icon check %} | {% icon check %}  ︎ | {% flag se %}                             |
| ![MobilePay][mobilepay-logo] | [Mobile Pay][mobile-pay]        |                  | {% icon check %} |                    | {% flag dk %} {% flag fi %}               |
|   ![Trustly][trustly-logo]   | [Trustly][trustly]              | {% icon check %} | {% icon check %} |                    | {% flag se %} {% flag fi %}               |

## Prerequisites

To start integrating Swedbank Pay Payments, you need the following:

*   An [HTTPS][https] enabled web server.
*   An agreement which includes Swedbank Pay Payments.
*   Credentials (Merchant Access Token) from Swedbank Pay retrieved from
    the Merchant Portal.

## Platform Options

Here are the two platform options at a glance. You can read more about the
integration process by visiting the sections for each payment method.

## Seamless View

With [Seamless Views][seamless-view] you can initiate the payment process
directly in an `iframe` on your site. If you prefer that the payer isn't
redirected away from you, this option enables you to embed our payment page
seamlessly into your shopping experience.

## Redirect

The [Redirect][redirect] platform redirects the payer to a Swedbank Pay hosted
payment page, and back to your page when the payment is completed.

## The Fundamentals

{% include alert.html type="informative"
                      icon="info"
                      body="All Payments APIs in the Swedbank Pay API Platform
                      share a common foundation with a similar payment process
                      for all payment methods, reducing complexity and
                      enabling a more straightforward integration." %}

There are two main payment types, **two-phase** and **one-phase** payments. The
two seem very similar from a payer's point of view, but there are key
differences you should know about.

## Two-Phase Payments

A two-phase payment is performed in two steps – an `authorization` which
reserves the payer's funds, and a `capture` of the funds at a later time,
usually when the goods are shipped.

This is the most common payment type, and it is used by Card Payments, Vipps
Payments, MobilePay payments and Invoice Payments. A
capture of an invoice will *not* capture any funds, but trigger the invoice
distribution and send it to the payer.

The payment methods that support two-phase payments are:

*   [Card][card]
*   [Invoice][invoice]
*   [MobilePay Online][mobile-pay]
*   [Vipps][vipps]

## One-Phase Payments

There are two types of one-phase payments – `sale` and `autoCapture`.

`sale` is used by payment methods such as [Swish][swish].
These payments will have a `sale` transaction instead of the `authorization` and
`capture`. The funds will be captured from the payer straight away.

`autoCapture` is only available for Card Payments. The mechanics work the same
way as a two-phase payment, with two separate transactions – one for the
`authorization` and one for the `capture`.

As the name implies, the capture transaction is performed automatically when the
authorization is successful. Because of this, `autoCapture` should only be used
when dealing with digital products, since they are shipped instantly.

As the funds are captured instantly, `cancel` is not available for either of the
one-phase payments. `abort` and `reversal` can be performed the same way as with
two-phase payments.

The payment methods that support one-phase payments are:

*   [Swish][swish]
*   [Card][card]
*   [Trustly][trustly]

## The Payment Object

The payment is the container object that holds all transactions
created during the payment process. When Swedbank Pay receives the payment
request body (in JSON format), a payment is created and you will be given a
unique payment ID in return. The response also includes (in a true RESTful way)
the URLs and operations for further actions, given the state of the payment.

After creating a payment, you can:

*   `Authorize` funds. An authorization transaction reserves the funds. It is
    possible to `abort` a payment before the payer has completed the payment
    process. And either:
*   `Capture` funds. Before delivering the merchandise you need to create a
    capture transaction to ensure that the money is charged from the payer's
    card or properly billed by invoice. One-phase payments will combine these
    two in a `sale` or `autoCapture` transaction as described in the section
    above.

Or:

*   `Cancel` the authorized amount. Funds that are authorized but not yet captured,
    can be released back to the payer. This is done by creating a cancel
    transaction. This is not available for one-phase payments.
*   `Reverse` captured funds. In some cases you may need to make a reversal of
    captured funds. This is achieved by creating a reversal transaction.

All actions after creating the payment can be done by using our APIs, or from
our Merchant Portal tool. `abort` is only available when using APIs.

[https]: /checkout-v3/get-started/fundamental-principles#connection-and-protocol
[vipps-logo]: /assets/img/icon-vipps-simple.svg
[swish-logo]: /assets/img/icon-swish-simple.svg
[mobilepay-logo]: /assets/img/icon-mobilepay-simple.svg
[trustly-logo]: /assets/img/icon-trustly-new.svg
[earth-icon]: /assets/img/globe-icon.png
[card]: /old-implementations/payment-instruments-v1/card
[invoice]: /old-implementations/payment-instruments-v1/invoice
[vipps]: /old-implementations/payment-instruments-v1/vipps
[swish]: /old-implementations/payment-instruments-v1/swish
[mobile-pay]: /old-implementations/payment-instruments-v1/mobile-pay
[seamless-view]: /old-implementations/payment-instruments-v1/card/seamless-view
[redirect]: /old-implementations/payment-instruments-v1/card/redirect
[trustly]: /old-implementations/payment-instruments-v1/trustly
