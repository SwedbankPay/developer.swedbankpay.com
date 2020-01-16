---
title: Release Notes
sidebar:
  navigation:
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/test-data
      title: Test Data
    - url: /resources/demoshop
      title: Demoshop
    - url: /resources/development-guidelines
      title: Open Source Development Guidelines
    - url: /resources/release-notes
      title: Release Notes
    - url: /resources/terminology
      title: Terminology
    - url: /resources/data-protection
      title: Data Protection
---

{% include alert-review-section.md %}

{% include jumbotron.html body="The latest updates about our releases will be
published on this page" %}

{% include alert.html type="neutral" icon="info" header="Version numbers listed
on this page refers to the version number of this very documentation, not to a
version of any APIs described by it." %}

## January 2020

### Version 1.5

* The review of [Invoice Payments][invoice] is complete and as such the section
  is now released and ready for use.
* The [Card Payments][card] section has received an overhaul, inching it closer
  to release.
* The [Swish Payments][swish], [Vipps Payments][vipps] and [Credit
  Payments][credit] (née "Credit Account") sections are ready for review.
* The [Direct Debit][direct-debit] and [MobilePay Payments][mobile-pay] sections
  have received a few updates, inching them both closer to review.

### Version 1.4

* Updated [Swish Redirect][swish-direct] and [Swish Direct][swish-direct]
  sections in preparations for review and the transition from PayEx Developer
  Portal.
* Added [Data Protection][data-protection] section.
* Payment Orders now support `orderItems` in all operations.
* Added [Terminology page][terminology].
* Clarified what the `awaitingActivity` state means for different payment
  instruments.
* MobilePay section is ready for review!
* Removed erroneous `noCVC` in examples for [One-Click Card Payments][one-click]
  section.
* Added description for the `onBillingDetailsAvailable` event in the
  [Checkin Front End section][checkout-checkin-front-end].

## December 2019

### Update in checkin module

We have added support for specifying language as input in checkin module,
`language`. Supported languages are Norwegian, Swedish and English. Consumers
outside Sweden and Norway can now purchase in our Checkout service. You can
specify supported countries for shipment in a new input parameter,
`shippingAddressRestrictedToCountryCodes`, in our checkin module.
Updated API specification can be found [here][initiate-consumer-session].
The parameters `language` and `shippingAddressRestrictedToCountryCodes` have replaced the former `consumerCountryCode`.

The parameters `msisdn` and `email` have been made obsolete due to GDPR rules. This information cannot be sent in without an explicit consent from the consumer.

{% comment %}
TODO: Release this when the Swish Redirect section is released with the correct screenshot. Change the link below when this is ready.

### Improved purchase experience in Swish

We now show the flag connected to the origin of the phone number the consumer
uses in Swish during payment. See updated screenshot of payment pages in [[Swish
ecom
redirect>>doc:Main.ecommerce.payex-payment-instruments.swish-payments.swish-e-commerce-redirect.WebHome]]
model.
{% endcomment %}

## November 2019

### Welcome, Swedbank Pay Developer Portal

PayEx' Commerce offerings are being rebranded to **Swedbank Pay** and as a
result of that rebranding, PayEx Checkout is now known as Swedbank Pay Checkout
and its documentation can be found on [here][checkout].

{% comment %}

TODO: Ref discussion about the m-commerce flow. Should we expose this feature
given the challenges we have?

### Support m-com flow for Swish payments

We have added support for m-com flow in
[[Swish>>doc:Main.ecommerce.technical-reference.core-payment-resources.swish-payments.WebHome]].
In redirect flow this is supported without any changes in your integration. But
a configuration on your swish agreement needs to be updated. Contact our support
in order to activate this.

If you use our hosted view-solution we have added the URL property called
paymentUrl (previously added for CreditCard, Vipps and Payment Order), that will
be used when the user is returned from the Swish application. See further
information regarding paymentUrl at: [[PaymentUrl in
CreditCard>>doc:Main.ecommerce.release-information.WebHome||anchor="HPaymentUrlCreditCard"]]
{% endcomment %}

### Support international phone numbers in Swish

We have added support for sending in international phone numbers in the request.
Check our Swish documentation [here][swish-other-features].
This is supported in API, and when consumer enters their phone number on the
payment page.

### Order Items

The input parameter `quantity` in OrderItems-node is now updated to decimal.
You may send up to 4 decimals. See updated documentation
[here][payment-orders]

{% comment %} TODO: This is currently only used by ICA. Should we have the
documentation available? Check Jira-task DX-511.

### Payment order

We have added support for restricting payment instruments available in payment
menu. The input parameter is ##restrictedToInstruments## in Payment order. See
updated documentation
[[here>>doc:Main.ecommerce.technical-reference.payment-orders-resource.WebHome]]
{% endcomment %}

## October 2019

### Payment Url Credit Card

We have added the URL property called `paymentUrl` for [Card
Seamless View][card-payment-url] (previously added for Vipps and Checkout), that will be used
when the user is returned from 3rd party. The URL should represent the page in
where the payment Seamless View was hosted originally, such as the checkout page,
shopping cart page, or similar. Basically, `paymentUrl` should be set to the
same URL as that of the page where the JavaScript for the hosted payment view
was added, in order to initiate the payment. Please note that the `paymentUrl`
must be able to invoke the same JavaScript URL from the same Payment as the one
that initiated the payment originally, so it should include some sort of state
identifier in the URL. The state identifier is the ID of the order, shopping
cart or similar that has the URL of the Payment stored. When the JavaScript is
invoked after return of the consumer, the consumer will either be redirected to
the `completeUrl` (event onPaymentCompleted) or if payment has failed, see an
error-message and get the option to retry the payment.

## August 2019

### Order Items

On [Payment Orders][payment-orders],
`itemDescriptions` and `vatSummary` has been replaced with the more
versatile and powerful `orderItems`. While `itemDescriptions` will continue
to work, it is recommended that all integrations switch over to `orderItems`
as soon as possible. When `orderItems` is used, `itemDescriptions` must be
removed from all requests as the two cannot be used simultaneously.

### Payment Url

For our Seamless Views (currently
[Vipps][vipps-payment-url]
or in [Checkout][checkout-payment-url]),
we have added a new URL property called `paymentUrl` that will be used when
user is returned from 3rd party. The URL should represent the page of where the
payment hosted view was hosted originally, such as the checkout page, shopping
cart page, or similar. Basically, `paymentUrl` should be set to the same URL
as that of the page where the JavaScript for the hosted payment view was added
to in order to initiate the payment. Please note that the `paymentUrl` must be
able to invoke the same JavaScript URL from the same Payment or Payment Order as
the one that initiated the payment originally, so it should include some sort of
state identifier in the URL. The state identifier is the ID of the order,
shopping cart or similar that has the URL of the Payment or Payment Order
stored. When the JavaScript is invoked after return of the consumer, the
consumer will either be redirected to the `completeUrl`, or, if payment failed,
see an error-message, and get the option to retry the payment.

If `paymentUrl` is not implemented, retry of payments will not be possible in
either individual payment instruments such as
[Vipps][vipps-payment-resource]
or in [Checkout][checkout-payment-orders].
It makes it more tedious to retry payment as the whole process including the
creation of the payment or payment order needs to be performed again. With
paymentUrl in place, the retry process becomes much more convenient for both the
integration and the payer.

[card]: /payments/card
[card-payment-url]: /payments/card/other-features#payment-url
[credit]: /payments/credit
[checkout-checkin-front-end]: /checkout/checkin#checkin-front-end
[checkout-payment-orders]: /checkout/other-features#payment-orders
[checkout-payment-url]: /checkout/other-features#payment-url
[checkout]: /checkout
[data-protection]: /resources/data-protection
[direct-debit]: /payments/direct-debit
[initiate-consumer-session]: /checkout/checkin#checkin-back-end
[invoice]: /payments/invoice
[mobile-pay]: /payments/mobile-pay
[one-click]: /payments/card/other-features#one-click-payments
[payment-orders]: /checkout/other-features#creating-a-payment-order
[swish]: /payments/swish
[swish-direct]: /payments/swish/direct
[swish-other-features]: /payments/swish/other-features
[swish-redirect]: /payments/swish/redirect
[terminology]: /resources/terminology
[vipps]: /payments/vipps
[vipps-payment-resource]: /payments/vipps/other-features#payment-resource
[vipps-payment-url]: /payments/vipps/other-features#payment-url
