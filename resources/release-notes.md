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
---

{% include alert-review-section.md %}

{% include jumbotron.html body="" %}

## December 2019

### Update in checkin module

We have added support for specifying language as input in checkin module,
language. Supported languages are Norwegian, Swedish and English. Consumers
outside Sweden and Norway can now purchase in our Checkout service. You can
specify supported countries for shipment in a new input parameter,
shippingAddressRestrictedToCountryCodes, in our checkin module.
Updated api specification can be found [here][initiate-consumer-session]

{% comment %}
TODO: Release this when the Swish Redirect section is released with the correct screenshot.

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

### Payment order

We have added support for restricting payment instruments available in payment
menu. The input parameter is ##restrictedToInstruments## in Payment order. See
updated documentation
[[here>>doc:Main.ecommerce.technical-reference.payment-orders-resource.WebHome]]

## October 2019

### Payment Url Credit Card

We have added the URL property called ##paymentUrl## for [[Credit
Card>>doc:Main.ecommerce.technical-reference.core-payment-resources.card-payments.WebHome]]
hosted view (previously added for Vipps and Payment Order), that will be used
when the user is returned from 3rd party. The URL should represent the page in
where the payment hosted view was hosted originally, such as the checkout page,
shopping cart page, or similar. Basically, ##paymentUrl## should be set to the
same URL as that of the page where the JavaScript for the hosted payment view
was added, in order to initiate the payment. Please note that the ##paymentUrl##
must be able to invoke the same JavaScript URL from the same Payment as the one
that initiated the payment originally, so it should include some sort of state
identifier in the URL. The state identifier is the ID of the order, shopping
cart or similar that has the URL of the Payment stored. When the JavaScript is
invoked after return of the consumer, the consumer will either be redirected to
the completeUrl (event onPaymentCompleted) or if payment has failed, see an
error-message and get the option to retry the payment.

## August 2019

### Order Items

On [[Payment
Order>>doc:Main.ecommerce.technical-reference.payment-orders-resource.WebHome]],
##itemDescriptions## and ##vatSummary## has been replaced with the more
versatile and powerful ##orderItems##. While ##itemDescriptions## will continue
to work, it is recommended that all integrations switch over to ##orderItems##
as soon as possible. When ##orderItems## is used, ##itemDescriptions## must be
removed from all requests as the two cannot be used simultaneously.

### Payment Url

For our hosted views (currently
[[Vipps>>doc:Main.ecommerce.technical-reference.core-payment-resources.vipps-payments.WebHome]]
or in [[Payment
Order>>doc:Main.ecommerce.technical-reference.payment-orders-resource.WebHome]]),
we have added a new URL property called ##paymentUrl## that will be used when
user is returned from 3rd party. The URL should represent the page of where the
payment hosted view was hosted originally, such as the checkout page, shopping
cart page, or similar. Basically, ##paymentUrl## should be set to the same URL
as that of the page where the JavaScript for the hosted payment view was added
to in order to initiate the payment. Please note that the ##paymentUrl## must be
able to invoke the same JavaScript URL from the same Payment or Payment Order as
the one that initiated the payment originally, so it should include some sort of
state identifier in the URL. The state identifier is the ID of the order,
shopping cart or similar that has the URL of the Payment or Payment Order
stored. When the JavaScript is invoked after return of the consumer, the
consumer will either be redirected to the completeUrl, or, if payment failed,
see an error-message, and get the option to retry the payment.

If paymentUrl is not implemented, retry of payments will not be possible in
either individual payment instruments such as
[[Vipps>>doc:Main.ecommerce.technical-reference.core-payment-resources.vipps-payments.WebHome]]
or in [[Payment
Order>>doc:Main.ecommerce.technical-reference.payment-orders-resource.WebHome]].
It makes it more tedious to retry payment as the whole process including the
creation of the payment or payment order needs to be performed again. With
paymentUrl in place, the retry process becomes much more convenient for both the
integration and the payer.

[checkout]: /checkout
[initiate-consumer-session]: /checkout/checkin#checkin-back-end
[payment-orders]: /checkout/other-features#payment-orders
[swish-other-features]: /payments/swish/other-features