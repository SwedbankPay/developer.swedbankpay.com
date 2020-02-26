---
title: Swedbank Pay Payments
sidebar:
  navigation:
  - title: Payments
    items:
    - url: /payments/
      title: Introduction
    - url: /payments/card
      title: Card Payments
    - url: /payments/invoice
      title: Invoice Payments
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/vipps
      title: Vipps Payments
    - url: /payments/mobile-pay
      title: MobilePay Payments
---

{% include jumbotron.html body="Payments is our off-the-rack assortment of
payment instruments. You can pick and choose among them to tailor the instrument
package best suited for your business." %}

Is Card the only payment instrument you need? Go for Card only. Do you want Card
and Invoice? Implement Card and Invoice. Want them all? Have them all. Each
payment instrument is set up with a separate contract and integration.

With a couple of exceptions, our payment instruments are available on three
platforms. Choose between our easy-to-use PCI compliant platforms Redirect
and Seamless View – or use Swedbank Pay Direct API to integrate directly. Our
payment instruments and their platform availability are listed in the table
below.

{:.table .table-striped}
|                              | Payment instrument              | Seamless View | Redirect | Direct API | Region                                             |
| :--------------------------: | :------------------------------ | :-----------: | :------: | :--------: | :------------------------------------------------- |
|    ![CardIcon][card-icon]    | [Credit card][card]             |    ✔︎︎︎︎︎     |  ✔︎︎︎︎︎  |   ✔︎︎︎︎︎   | ![EarthIcon][earth-icon]                           |
| ![InvoiceIcon][invoice-icon] | [Swedbank Pay Invoice][invoice] |    ✔︎︎︎︎︎     |  ✔︎︎︎︎︎  |            | ![nor][nor-flag] ![swe][swe-flag] ![fin][fin-flag] |
|     ![Vipps][vipps-logo]     | [Vipps][vipps]                  |    ✔︎︎︎︎︎     |  ✔︎︎︎︎︎  |            | ![nor][nor-flag]                                   |
|     ![Swish][swish-logo]     | [Swish][swish]                  |    ✔︎︎︎︎︎     |  ✔︎︎︎︎︎  | ✔︎︎︎︎︎  ︎  | ![swe][swe-flag]                                   |
| ![MobilePay][mobilepay-logo] | [Mobile Pay][mobile-pay]        |               |  ✔︎︎︎︎︎  |            | ![dan][dan-flag] ![fin][fin-flag]                  |

## Prerequisites

To start integrating Swedbank Pay Payments, you need the following:

* An [HTTPS][https] enabled web server.
* An agreement which includes Swedbank Pay Payments.
* Credentials (Merchant Access Token) from Swedbank Pay retrieved from
  Swedbank Pay Admin.

## Platform options

Here are our three platform options at a glance. You can read more about the
integration process by visiting the sections for each payment instrument.

### Seamless View

With [Seamless Views][seamless-view] you can initiate the payment process
directly in an `iframe` on your site. If you prefer that the consumer isn't
redirected away from you, this option enables you to embed our payment page
seamlessly into your shopping experience.

### Redirect

The [Redirect][redirect] platform redirects the consumers to a Swedbank Pay
hosted payment page. The consumer will be redirected back to your page when the
payment is completed.

### Direct

[Direct][direct] is the option where you integrate directly using our Direct
API. This is an integration with the most flexibility and opportunities. If you
want to offer Card Payments and choose this option, you have to be PCI-DSS
compliant.

## The Fundamentals

{% include alert.html type="neutral"
                      icon="info"
                      body="All Payments APIs in the Swedbank Pay API Platform
                      share a common foundation with a similar payment process
                      for all payment instruments, reducing complexity and
                      enabling a more straightforward integration." %}

There are two main payment types, **two-phase** and **one-phase** payments. The
two seem very similar from a consumer's point of view, but there are key
differences you should know about.

### Two-Phase Payments

A two-phase payment is performed in two steps – an `authorization` which
reserves the consumer's funds, and a `capture` of the funds at a later time,
usually when the goods are shipped.

This is the most common payment type, and it is used by Card Payments, Vipps
Payments, MobilePay payments and Invoice Payments. A
capture of an invoice will *not* capture any funds, but trigger the invoice
distribution and send it to the consumer.

The payment instruments that support two-phase payments are:

* [Card][card]
* [Invoice][invoice]
* [MobilePay][invoice]
* [Vipps][vipps]

### One-Phase Payments

There are two types of one-phase payments – `sale` and `autoCapture`.

`sale` is used by payment instruments such as [Swish][swish].
These payments will have a `sale` transaction instead of the `authorization` and
`capture`. The funds will be captured from the consumer straight away.

`autoCapture` is only available for Card Payments. The mechanics work the same
way as a two-phase payment, with two separate transactions – one for the
`authorization` and one for the `capture`.

As the name implies, the capture transaction is performed automatically when the
authorization is successful. Because of this, `autoCapture` should only be used
when dealing with digital products, since they are shipped instantly.

As the funds are captured instantly, `cancel` is not available for either of the
one-phase payments. `abort` and `reversal` can be performed the same way as with
two-phase payments.

The payment instruments that support one-phase payments are:

* [Swish][swish]
* [Card][card]

## The Payment Object

The payment is the container object that holds all transactions
created during the payment process. When Swedbank Pay receives the payment
request body (in JSON format), a payment is created and you will be given a
unique payment ID in return. The response also includes (in a true RESTful way)
the URIs and operations for further actions, given the state of the payment.

After creating a payment, you can:

* `Authorize` funds. An authorization transaction reserves the funds. It is
  possible to `abort` a payment before the end user has completed the payment
  process. And either:
* `Capture` funds. Before delivering the merchandise you need to create a capture
  transaction to ensure that the money is charged from the consumer credit card
  or properly billed by invoice. One-phase payments will combine these two in a
  `sale` or `autoCapture` transaction as described in the section above.

  Or:
* `Cancel` the authorized amount. Funds that are authorized but not yet captured,
  can be released back to the consumer. This is done by creating a cancel
  transaction. This is not available for one-phase payments.
* `Reverse` captured funds. In some cases you may need to make a reversal of
  captured funds. This is achieved by creating a reversal transaction.

All actions after creating the payment can be done by using our APIs, or from
our admin tool. `abort` is only available when using APIs.

Please visit our [demoshop][demoshop] to see our Payment Menu and Redirect
implementation in action.

[demoshop]: {{ page.front_end_url }}/pspdemoshop
[card-icon]: /assets/img/card-icon.png
[https]: /#connection-and-protocol
[invoice-icon]: /assets/img/invoice-icon.png
[envelope-icon]: /assets/img/envelope-icon.png
[keypad-icon]: /assets/img/keypad-icon.png
[vipps-logo]: /assets/img/vipps-icon.png
[swish-logo]: /assets/img/swish-icon.png
[mobilepay-logo]: /assets/img/mobilepay-icon.png
[earth-icon]: /assets/img/globe-icon.png
[nor-flag]: /assets/img/no.png
[swe-flag]: /assets/img/se.png
[fin-flag]: /assets/img/fi.png
[lat-flag]: /assets/img/latvia-flag.png
[lit-flag]: /assets/img/lithuania-flag.png
[est-flag]: /assets/img/estonia-flag.png
[dan-flag]: /assets/img/danish-flag.png
[card]: /payments/card
[invoice]: /payments/invoice
[direct-debit]: /payments/direct-debit
[vipps]: /payments/vipps
[swish]: /payments/swish
[mobile-pay]: /payments/mobile-pay
[seamless-view]: /payments/card/seamless-view
[redirect]: /payments/card/redirect
[direct]: /payments/card/direct
