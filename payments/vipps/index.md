---
title: Vipps Payments
estimated_read: 30
description: |
  Vipps is the Norwegian way of paying with your mobile phone, fast and simple.
menu_order: 300
---

Vipps is the main Norwegian payment app for mobile phones supported by the major
Norwegian banks, making it one of the essential payment instruments for
merchants operating in Norway. We offer it on our redirect and seamless view
platforms.

## Purchase flow

After the payment is created, the consumer pushes the payment button on Swedbank Pay's
payment page (redirect) or in the `iframe` (seamless view).

{:.text-center}
![screenshot of the first Vipps redirect page][vipps-redirect]{:height="375px" width="475px"}

The payer is then redirected to Vipps' own payment
page where the phone number is entered, and a push message is sent to the phone.

{:.text-center}
![screenshot of the Vipps number input page][vipps-number-input]{:height="500px" width="475px"}

The payment request will appear in the app and can be confirmed by the consumer.
If you are using the redirect option, the consumer will be redirected back to
the merchant's site.

## Good To Know

### Payment Type

Vipps is one of the instruments using two-phase payments. The `authorization` is
done when the consumer successfully confirms in the app, and the `abort`,
`cancel`, `capture` or `reversal` is done by the merchant at a later time. Read
more about the [different operations][after-payment] and the [payment
resource][payment-resource].

{% include alert-two-phase-payments.md %}

### Settlement

Vipps transactions are handled, processed and settled as card transactions in
our system. They are, however, tagged as Vipps transactions and have their own
acquirer agreement, so the two payment instruments are settled separately.

### 3-D Secure

As Vipps transactions are processed as card transactions, a 3-D Secure agreement
is needed to complete the payment instrument setup. This information is provided
to you by your acquirer when you set up your agreement with them. If you offer
both Card Payments and Vipps, you will need two separate 3-D Secure agreements,
one for each payment instrument. Apart from the agreement with the acquirer, no
further 3-D Secure compliance is required from you as a merchant in this regard.

### Demoshop

Vipps is unfortunately not available in our demoshop at the moment, but it will
be shortly. The demoshop will use a fakeservice which enables you to test a
successful purchase without using the Vipps app.

{% include languages.md api_resource="vipps" %}

{% include iterator.html  next_href="redirect" next_title="Next: Redirect" %}

[payment-resource]: /payments/vipps/other-features#payment-resource
[after-payment]: /payments/vipps/after-payment#operations
[capture]: /payments/vipps/after-payment#captures
[cancel]: /payments/vipps/after-payment#cancellations
[vipps-redirect]: /assets/img/payments/vipps-redirect-en.png
[vipps-number-input]: /assets/img/payments/vipps-number-input-en.png
