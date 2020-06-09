---
title: Swedbank Pay MobilePay Online Payments
sidebar:
  navigation:
  - title: MobilePay Online Payments
    items:
    - url: /payments/mobile-pay
      title: Introduction
    - url: /payments/mobile-pay/redirect
      title: Redirect
    - url: /payments/mobile-pay/after-payment
      title: After Payment
    - url: /payments/mobile-pay/other-features
      title: Other Features
---

{% include jumbotron.html body="  MobilePay is the fast and simple way of
paying with your mobile phone, reaching more than 4 million Danish end-users." %}

MobilePay is the main Danish payment app for mobile phones, making it one of the
essential payment instruments for merchants operating in Denmark. More than 4
million Danes are users of the app, and more than 100,000 merchants are
accepting payments. We offer it on our redirect and seamless view platforms.

## Purchase flow

After the payment is created, the consumer is redirected to MobilePay's
own payment page where the phone number is entered, and a push message is sent
to the phone.

![screenshot of the MobilePay number input page][mobilepay-number-input]{:height="600px" width="425px"}

A countdown is shown in the browser and the payment request will appear in the
app, waiting to be confirmed by the consumer. If you are using the redirect
option, the consumer will be redirected back to the merchant's site.

## Good To Know

### Intent

**`Authorization` (two-phase)**: The intent of a MobilePay Online purchase is
always `Authorization`. The amount will be reserved but not charged. You will
later (i.e. if a physical product, when you are ready to ship the purchased
products) have to make a [`Capture`][mobilepay-capture] or
[`Cancel`][mobilepay-cancel] request.

### Payment Type

MobilePay Online is one of the instruments using two-phase payments. The
`authorization` is done when the consumer successfully confirms in the app, and
the `abort`, `cancel`, `capture` or `reversal` is done by the merchant at a
later time. Read more about the [different operations][other-features] and the
[payment resource][payment-resource].

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

{% include languages.md api_resource="mobilepay" %}

## Payment availability

Even though MobilePay supports several currencies, the payment instrument itself
is only available for consumers in Denmark and Finland. This allows a shop in
Norway to take payments in NOK from a Danish payer if the shop supports
shipping to Denmark, for instance.

{% include iterator.html
                         next_href="redirect"
                         next_title="Next: Redirect" %}

[mobilepay-number-input]: /assets/img/payments/mobilepay-redirect-en.png
[mobilepay-cancel]: /payments/mobile-pay/after-payment#cancellations
[mobilepay-capture]: /payments/mobile-pay/after-payment#capture
[payment-resource]: /payments/mobile-pay/other-features#payment-resource
[other-features]: /payments/mobile-pay/other-features#operations
