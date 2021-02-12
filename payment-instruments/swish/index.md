---
section: Swish
title: Introduction
redirect_from: /payments/swish/
estimated_read: 4
description: |
  Swish is Sweden's main payment app and the
  preferred online payment method with the highest convertion rates.
menu_order: 500
---

Swish is the main Swedish payment app for mobile phones supported by all Swedish
banks, making it one of the essential payment instruments for merchants
operating in Sweden. According to Kantar Sifo, it is the preferred online
payment method in the age group 18-40, and the payment method with the best
convertion rates.

We offer both desktop and mobile phone payment flows in our Redirect and
Seamless View integrations, in addition to Direct API and Payment Link.
Three flexible ways of integrating, two conversion optimized payment flows.
Using the Direct API integration will put you in charge of
determining which device is being used, and whether the e- or m-commerce flow is
the most suitable. We will do this for you in Redirect and Seamless view.

## Payment Flow

The following is a quick presentation of the purchase flow when using the
Redirect or Seamless view. You can find in-depth descriptions of the separate
flows in the corresponding sections.

In the desktop intended e-commerce flow, the payer enters a Swish connected mobile
phone number on Swedbank Pay's payment page (Redirect) or in the `iframe` (Seamless
View) after the payment is created.

{:.text-center}
![screenshot of the Swish redirect payment page with number input][swish-payment]{:height="400px" width="475px"}

After pushing the pay button, the payer needs to open the Swish app and confirm
the payment. If you are using the Redirect option, the payer will be
Redirected back to the merchant's site.

In the mobile phone intended m-commerce flow, the payment page or `iframe` will
only have a pay button, and no mobile phone number input is needed.
The Swish app will be launched automatically when you push the pay button.

## Good To Know

{% include intent.md sale=true show_authorization=false %}

### Payment Type

Swish is one of the instruments using one-phase payments. The `sale` is done
when the payer successfully confirms in the app, capturing the funds
instantly. The `abort` operation is still available, but the `cancel` and
`capture` operations are not. The `reversal`, if needed, is done by the
merchant at a later time. Read more about the [different
operations][after-payment] and the [payment resource][payment-resource].

### Certificate

We recommend that you apply for Swish as part of our Settlement Service and
utilize our Technical Supplier Certificate. A Swedbank Pay sales representative
can assist you with this. The Settlement Service will provide you with
aggregated and reconciled reports and payments. The Technical Supplier
Certificate means setup will be quicker and you will not have to assign a point
of contact to monitor and renew a certificate.

You could also contact one of the following banks offering Swish Handel:
[Danske Bank][danske-bank], [SEB][SEB-swish],
[Länsförsäkringar][Länsförsäkringar],
[Sparbanken Syd][sparbanken-syd], [Sparbanken Öresund][sparbanken-oresund],
[Nordea][nordea], [Handelsbanken][handelsbanken], in order to get an acquiring
agreement, a Swish alias and access to Swish Certificate Management
system (several banks do however support Technical Supplier Certificate setups
so you can ask them for that).

### Demoshop

You can give Swish a go in our demoshop if you like. For Redirect payments, you
need to toggle `paymentUrl` off, if you want to try Seamless View, `paymentUrl`
must be toggled on. The external integration demoshop used for testing is set up
with the Merchant Swish Simulator, which enables you to test without using the
Swish App.

{% include languages.md %}

{% include iterator.html next_href="direct" next_title="Direct" %}

[after-payment]: /payment-instruments/swish/after-payment
[danske-bank]: https://danskebank.se/sv-se/foretag/medelstora-foretag/onlinetjanster/pages/swish-handel.aspx
[handelsbanken]: https://www.handelsbanken.se/sv/foretag/konton-betalningar/ta-betalt/swish-for-foretag
[Länsförsäkringar]: https://www.lansforsakringar.se/stockholm/foretag/bank/lopande-ekonomi/betalningstjanster/swish-handel/
[nordea]: https://www.nordea.se/foretag/produkter/betala/swish-handel.html
[payment-resource]: /payment-instruments/swish/other-features#payment-resource
[SEB-swish]: https://seb.se/foretag/digitala-tjanster/swish-handel
[sparbanken-oresund]: https://www.sparbankenskane.se/foretag/digitala-tjanster/swish/swish-handel.html
[sparbanken-syd]: https://www.sparbankensyd.se/vardagstjanster/betala/swish-foretag/
[swish-payment]: /assets/img/payments/swish-redirect-number-input-en.png
