---
title: Swedbank Pay Payments Vipps
sidebar:
  navigation:
  - title: Vipps Payments
    items:
    - url: /payments/vipps
      title: Introduction
    - url: /payments/vipps/redirect
      title: Redirect
    - url: /payments/vipps/seamless-view
      title: Seamless View
    - url: /payments/vipps/after-payment
      title: After Payment
    - url: /payments/vipps/other-features
      title: Other Features
---

{% include alert-development-section.md %}

{% include jumbotron.html body="  Enter your phone number,
get the push message, press the pay button... and you're done!  " %}

Vipps is the main Norwegian payment app for mobile phones supported by the major
Norwegian banks, making it one of the essential payment instruments for
merchants operating in Norway. We offer it on our redirect and seamless view
platforms. 

## Purchase flow

After the payment is created, the consumer pushes the payment button on Swedbank Pay's
payment page (redirect) or in the iFrame (seamless view).

![screenshot of the first Vipps redirect page][vipps-redirect]{:height="500px" width="425px"}

He or she is then redirected to Vipps' own payment
page where the phone number is entered, and a push message is sent to the phone.

![screenshot of the Vipps number input page][vipps-number-input]{:height="500px" width="450px"}


The payment request will appear in the app and can be confirmed by the consumer.
If you are using the redirect option, the consumer will be redirected back to
the merchant's site. 

## Good To Know

### Payment Type

Vipps is one of the instruments using two-phase payments. The `authorization` is
done when the consumer successfully confirms in the app, and the `abort`,
`cancel`, `capture` or `reversal` is done by the merchant at a later time. Read
more about the different operations [here][after-payment] and the payment
resource [here][payment-resource].

### Settlement

Vipps transactions are handled, processed and settled as card transactions in
our system. They are, however, tagged as Vipps transactions and have their own
acquirer agreement, so the two payment instruments are settled separately.

### 3D Secure

As Vipps transactions are processed as card transactions, you will also need a
3D Secure agreement. If you already have a 3D Secure agreement used in the card
contract setup, this can be re-used.

### Demoshop

Vipps is unfortunately not available in our demoshop at the moment, but it will
be shortly. The demoshop will use a fakeservice which enables you to test a
successful purchase without using the test app.

{% include iterator.html  next_href="redirect" next_title="Next: Redirect" %}


[payment-resource]: /payments/vipps/other-features#payment-resource
[after-payment]: /payments/vipps/after-payment
[vipps-redirect]: /assets/img/payments/vipps-redirect-en.png
[vipps-number-input]: /assets/img/payments/vipps-number-input-en.png
