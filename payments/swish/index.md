---
title: Swedbank Pay Payments Swish
sidebar:
  navigation:
  - title: Swish Payments
    items:
    - url: /payments/swish
      title: Introduction
    - url: /payments/swish/direct
      title: Direct
    - url: /payments/swish/redirect
      title: Redirect
    - url: /payments/swish/seamless-view
      title: Seamless View
    - url: /payments/swish/after-payment
      title: After Payment
    - url: /payments/swish/other-features
      title: Other Features
---

{% include alert-review-section.md %}

{% include jumbotron.html body="Enter your phone number, get the push message,
push the pay button... and you're done!" %}

Swish is the main Swedish payment app for mobile phones supported by all Swedish
banks, making it one of the essential payment instruments for merchants
operating in Sweden. We offer both mobile and browser based purchase flows on
our redirect and seamless view platforms, in addition to direct API integration
and Payment Link.


## Purchase Flow

If you are using the browser based flow, the consumer enters his or hers phone
on Swedbank Pay's payment page (redirect) or in the `iframe` (seamless view)
after the payment is created.

![screenshot of the Swish redirect payment page with number input][swish-payment]{:height="500px" width="425px"}

After pushing the pay button, a push message is sent to the phone, asking the
consumer to confirm the purchase in the Swish app. If you are using the redirect
option, the consumer will be redirected back to the merchant's site.

In the mobile purchase flow, the payment page or `iframe` will only have a pay
button, and no number input. The Swish app will be launched automatically when
you push the pay button.

## Good To Know

### Payment Type

Swish is one of the instruments using one-phase payments. The `sale` is done
when the consumer successfully confirms in the app, capturing the funds
instantly. The `abort` operation is still available, but the `cancel` and
`capture` operations are not. The `reversal`, if needed, is done by the
merchant at a later time. Read more about the [different
operations][after-payment] and the [payment resource][payment-resource].

### Certificate

As a part of the setup, you will need a Swish certificate. As a Swedbank
costumer you can apply for Swish as part of [Swedbank Pay Settlement
Service][settlement-service]), and utilize the Swedbank Pay Technical Supplier
Certificate. A [Swedbank Pay sales representative][payex-mailto] can assist you
with this.

Otherwise, you can contact one of the following banks
offering Swish Handel: [Danske Bank][danske-bank],
[SEB][SEB-swish], [Länsförsäkringar], [Sparbanken Syd][sparbanken-syd],
[Sparbanken Öresund][sparbanken-oresund], [Nordea][nordea],
[Handelsbanken][handelsbanken], in order to get an acquiring agreement, a
Swish alias and access to [Swish Certificate Management
system][swish-certificate-management-system].


### Demoshop

You can give Swish a go in our demoshop if you like. For redirect payments, you
need to toggle `paymentUrl` off, if you want to try seamless view, `paymentUrl` must
be toggled on. The demoshop uses the Merchant Swish Simulator, which enables you
to test without using the Swish App.


{% include iterator.html  next_href="redirect" next_title="Next: Redirect" %}


[danske-bank]: https://danskebank.se/sv-se/foretag/medelstora-foretag/onlinetjanster/pages/swish-handel.aspx
[handelsbanken]: https://www.handelsbanken.se/sv/foretag/konton-betalningar/ta-betalt/swish-for-foretag
[Länsförsäkringar]: https://www.lansforsakringar.se/stockholm/foretag/bank/lopande-ekonomi/betalningstjanster/swish-handel/
[MSS]: https://developer.getswish.se/faq/which-test-tools-are-available/
[nordea]: https://www.nordea.se/foretag/produkter/betala/swish-handel.html
[payex-admin-portal]: https://admin.payex.com/psp/login/
[payex-mailto]: mailto:sales@payex.com
[SEB-swish]: https://seb.se/foretag/digitala-tjanster/swish-handel
[sparbanken-oresund]: https://www.sparbankenskane.se/foretag/digitala-tjanster/swish/swish-for-handel/index.htm
[sparbanken-syd]: https://www.sparbankensyd.se/vardagstjanster/betala/swish-foretag/
[support-mailto]: mailto:support.ecom@swedbankpay.se
[swedbank-swish]: https://www.swedbank.se/foretag/betala-och-ta-betalt/ta-betalt/swish/swish-handel/index.htm
[swish-certificate-management-system]: https://comcert.getswish.net/cert-mgmt-web/authentication.html
[swish-payment]: /assets/img/payments/swish-redirect-number-input-en.png
[payment-resource]: /payments/swish/other-features#payment-resource
[after-payment]: /payments/swish/after-payment
