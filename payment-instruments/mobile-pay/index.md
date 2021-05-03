---
section: MobilePay Online
title: Introduction
redirect_from: /payments/mobile-pay/
estimated_read: 3
description: |
  MobilePay Online is the fast and simple way of paying with your mobile phone,
  reaching more than 4 million users in Denmark and Finland.
permalink: /:path/
menu_order: 500
---

MobilePay is the main payment app in Denmark and one of the leading apps in
Finland, making it one of the essential payment instruments for merchants
operating in these Nordic countries. More than 4.2 million Danes and Finns use
the app and 140,000 stores are accepting payments. We offer it on
our redirect and seamless view platforms.

## Purchase flow

When the payment is created, the payer is redirected to a Swedbank Pay landing
page where he or she can proceed with the payment by pressing the pay button.

{:.text-center}
![screenshot of the Swedbank Pay landing page][swedbankpay-landing-page]{:height="425px" width="475px"}

This takes the payer to MobilePay's own payment page where the phone number is
entered, and a push message is sent to the phone.

{:.text-center}
![screenshot of the MobilePay Online number input page][mobilepay-number-input]{:height="700px" width="475px"}

A countdown is shown in the browser and the payment request will appear in the
app, waiting to be confirmed by the payer. If you are using the redirect
option, the payer will be redirected back to the merchant's site.

## Good To Know

### Intent

**`Authorization` (two-phase)**: The intent of a MobilePay Online purchase is
always `Authorization`. The amount will be reserved but not charged. You will
later (i.e. if a physical product, when you are ready to ship the purchased
products) have to make a [`Capture`][mobilepay-capture] or
[`Cancel`][mobilepay-cancel] request.

### Payment Type

MobilePay Online is one of the instruments using two-phase payments. The
`authorization` is done when the payer successfully confirms in the app, and
the `abort`, `cancel`, `capture` or `reversal` is done by the merchant at a
later time. Read more about the [different operations][features] and the
[payment resource][payment-resource].

{% include alert-two-phase-payments.md %}

### Settlement

MobilePay Online transactions are handled, processed and settled as card
transactions in our system. They are, however, tagged as MobilePay Online
transactions and have their own acquirer agreement, so the two payment
instruments are settled separately.

### 3-D Secure

As MobilePay Online transactions are processed as card transactions, a 3-D
Secure agreement is needed to complete the payment instrument setup. This
information is provided to you by your acquirer when you set up your agreement
with them. If you offer both Card Payments and MobilePay Online, you will need
two separate 3-D Secure agreements, one for each payment instrument. Apart from
the agreement with the acquirer, no further 3-D Secure compliance is required
from you as a merchant in this regard.

### Demoshop

MobilePay Online is unfortunately not available in our demoshop at the moment,
but it will be in the future. The demoshop in the test environments will use a
fakeservice which enables you to test a successful purchase without using the
MobilePay app.

{% include languages.md %}

## Payment availability

Even though MobilePay Online supports several currencies, the payment instrument
itself is only available for payers in Denmark and Finland. This allows a shop
in Norway to receive payments in NOK from a Danish payer if the shop supports
shipping to Denmark, for instance.

{% include iterator.html next_href="redirect" next_title="Redirect" %}

[mobilepay-number-input]: /assets/img/payments/mobilepay-redirect-en.png
[mobilepay-cancel]: /payment-instruments/mobile-pay/after-payment#cancellations
[mobilepay-capture]: /payment-instruments/mobile-pay/after-payment#capture
[payment-resource]: /payment-instruments/mobile-pay/features/technical-reference/payment-resource
[features]: /payment-instruments/mobile-pay/features/technical-reference/operations
[swedbankpay-landing-page]: /assets/img/payments/sbp-mobilepaylandingpage-en.png
