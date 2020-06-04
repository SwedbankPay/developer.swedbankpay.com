---
title: Release Notes
sidebar:
  navigation:
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/sdk-modules
      title: SDKs and Modules
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
    - url: /resources/public-migration-key
      title: Public Migration Key
---

{% include jumbotron.html body="The latest updates about our releases will be
published on this page." %}

{% include alert.html type="informative" icon="info" header="Version numbers"
body="The version numbers used in headers on this page refers to the version of
this very documentation, not to a version of any APIs described by it." %}

## May 2020

### Version 1.11.1

*   Added additional information on the settlement files in [Settlement &
    Reconciliation][settlement-reconcilitation] for all Payments.
*   Corrected [Card Payments Redirect][card-redirect] and [Card Payments
  Seamless View][card-seamless-view] sequence diagrams.
*   Added [Abort][swish-abort] in [Swish Payments][swish].

### Version 1.11.0

*   Added a new [Trustly Payments][trustly-payments] section.
*   Added information about [Storing URIs][storing-uri] in the [Technical
  Information][home-technical-information] section.

### Version 1.10.1

*   Updated [Swish Redirect][swish-redirect] requests.
*   Added `orderReference` information in Payment Order Callback in [Checkout Other features][checkout-callback].

### Version 1.10.0

*   Added a new [Gift Cards][gift-cards] section with descriptions of our Gift Cards API.
*   Added a new section [Co-badge Card Choice for Dankort][co-badge-card] in
  [Card Payments][card-payment-url].

### Version 1.9.2

*   Corrected table in [payments page][payments]

### Version 1.9.1

*   Corrected sequence diagrams in [Swish Payments][swish] and
  [Vipps Payments][vipps].
*   The `description` field is now more thoroughly described for all requests it's
  present in.
*   The `language` field is now better described for all requests it's present in.
*   All broken links should now be unbroken.

## April 2020

### Version 1.9.0

*   Added a new section [SDKs and Modules][sdk-modules] in Resources.
*   Corrected problem `type` URIs for [Card Payments][card], [Checkout][checkout]
  and [Swish Payments][swish].
*   Required checkmarks have a new, fresh look: {% icon check %}
*   Flags now also sport a new look: {% flag no %} {% flag se %} {% flag dk %}
    {% flag fi %} {% flag lt %} {% flag lv %} {% flag ee %}

### Version 1.8.3

*   Bug fixes to Mermaid diagram and alert styling, plus improvements to code
  block styling after the update to [Swedbank Pay Design Guide][design-guide]
  4.5.0.
*   Added examples with screenshots of the effects of [Merchant Authenticated
  Consumer][mac-checkout].

### Version 1.8.2

*   Added a more thorough description on `paymentUrl` and `completeUrl` in all
  relevant payments.
*   Updated `orderItems` to be required in all requests and responses.
*   Clean up of [Swish Payments][swish]
*   Removed `pageStripDown` in [Vipps Redirect][vipps].
*   Updated [Card Payments Direct][card-direct] to have a correct integration
  flow.
*   Updated the [main page][frontpage] to be more welcoming.
*   Updated information on [Merchant Authenticated Consumer][mac-checkout].

## March 2020

### Version 1.8.1

*   Documented allowed characters in `orderItem.class`.
*   Added `receiptReference` in [Invoice Payments][invoice] and
  [Payment Order][checkout-payment-orders] in capture and reversal.
*   Callback is now moved to Other features in all payments intruments.
*   Clean up of [MobilePay][mobile-pay].
*   Corrected the address of Leia Ahlström in [Test Data][test-data].
*   Updated the documentation in [Card Payments][card-payment-url]
  to recommend using `shippingAddress`.
*   Updated `payeeReference` to have an unique description for Payment Order and
  every Payment Instrument.

### Version 1.8.0

*   Updated [Invoice Payments Direct][invoice-direct] where
  `approvedLegalAddress` should now be use for all countries.
*   Small text changes and clarifications.
*   Restructured [Invoice Payments][invoice] and [Card Payments][card].

### Version 1.7.7

This change contains build updates for the page. :octocat:

### Version 1.7.6

*   Several links has been corrected. The chance of 404 is now much lower.
*   Other small text changes and clarifications.

### Version 1.7.5

*   New page! Technical reference into has been moved from the front page
  to [technical information][home-technical-information].
*   Front page got a slimmer look. :swimmer:
*   Abort reference is back in [credit card reference][credit-card-abort].
*   Swish error code reference got a face lift, check it out
  [here][swish-api-errors] :candy:.

## February 2020

### Version 1.7.4

*   Described the M-Commerce flow for [Swish Direct][swish-direct-mcom].
*   Alphabetize the terms in [Terminology][terminology].

### Version 1.7.3

*   Expanded information about the field `restrictedToInstruments`.
*   Added information about the field `receiptReference`.
*   Added information about [direct integration in Credit card][card-direct].
*   Added and fixed several missing headings in template files.
*   Expanded information about `verify`.
*   Created new page for [Checkout Capture][checkout-capture].
*   Mobile Pay Online was previously only refered to as Mobile Pay, this has been
  corrected.

### Version 1.7.2

*   Removed several duplicate headers in other-features pages.
*   Added unscheduled purchase information in
  [card payments][card-unscheduled-purchase].
*   We have added card logos when selecting card in payment menu.
  See [updated screenshot of payment menu][checkout-payment-menu-frontend].

### Version 1.7.1

All sections have been released. :trophy:

### Version 1.7

*   README is updated with info about includes.
*   Added  several includes.
*   Updated payeeReference description in Checkout and Invoice section.
*   Using snake case consistently.
*   Added section for unscheduled purchase in Card section.
*   Fixed JavaScript example in Checkin section.
*   Added info about mobile verification in Swish Other Features.
*   Added section about Authenticated Merchants in Checkout section.
*   Cleanup in `Vipps` Other Features.
*   `paymentRestrictedToAgeLimit` and `paymentRestrictedToSocialSecurityNumber`
  added to `swish` object in [Swish Redirect][swish-redirect]. `paymentAgeLimit`
  , `socialSecurityNumber` added to the new `payerInfo` object in
  [Swish Seamless View][swish-seamless-view]. Properties added in `Swish`.
*   Added section about migration key in Resources section.

## January 2020

### Version 1.6.3

*   `restrictedToInstruments` added back to [Payment Order purchase
  requests][checkout-payment-order-purchase].
*   `Direct Debit` section and mentions in various includes removed.
*   Various improvements and fixes.

### Version 1.6.2

*   The [Payments][payments] and [Card Payments][card] sections are reviewed and
  released.

### Version 1.6.1

*   `email`, `msisdn`, `workPhoneNumber` and `homePhoneNumber` added to the
  `payer` object in [Payment Order requests][checkout-payment-orders].
*   `cardholder` added to [Card Payments Purchase requests][card-purchase].
*   Various improvements and fixes.

### Version 1.6

*   [Credit Payments][credit] (née "Credit Account") sections have been deleted
  from the Swedbank Pay Developer Portal.
*   The [Swish Payments][swish] and [Vipps Payments][vipps] have received a few
  updates and are now ready for another round of review.
*   [MobilePay Payments][mobile-pay] is now ready for review.
*   `paymentAgeLimit` is now added in [Swish Payments][swish].
*   The [Terminology page][terminology] is updated and *3-D Secure 2.0 (3DS2)*   ,
  *PSD2*   and *SCA*   explanations are added.
*   Added descriptions for Payment States And Transaction States everywhere appropriate.
*   Google Analytics has been added to Developer Portal.

### Version 1.5

*   The review of [Invoice Payments][invoice] is complete and as such the section
  is now released and ready for use.
*   The [Card Payments][card] section has received an overhaul, inching it closer
  to release.
*   The [Swish Payments][swish] and [Vipps Payments][vipps] sections are ready for
  review.
*   The Direct Debit, [MobilePay Payments][mobile-pay] and
  [Credit Payments][credit] (née "Credit Account") sections have received a few
  updates, inching them all closer to review.

### Version 1.4

*   Updated [Swish Redirect][swish-direct] and [Swish Direct][swish-direct]
  sections in preparations for review and the transition from PayEx Developer
  Portal.
*   Added [Data Protection][data-protection] section.
*   Payment Orders now support `orderItems` in all operations.
*   Added [Terminology page][terminology].
*   Clarified what the `awaitingActivity` state means for different payment
  instruments.
*   Removed erroneous `noCVC` in examples for [One-Click Card Payments][one-click]
  section.
*   Added description for the `onBillingDetailsAvailable` event in the
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

PayEx' Commerce offerings are being rebranded to **Swedbank Pay**   and as a
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

If you use our hosted view-solution we have added the URL field called
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

We have added the URL field called `paymentUrl` for [Card
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

### Order Items in payment orders

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
we have added a new URL field called `paymentUrl` that will be used when
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

[card-direct]: /payments/card/direct
[card-payment-url]: /payments/card/other-features#payment-url
[card-purchase]: /payments/card/redirect#step-1-create-a-purchase
[card-unscheduled-purchase]: /payments/card/other-features#unscheduled-purchase
[card]: /payments/card
[card-redirect]: /payments/card/redirect
[card-seamless-view]: /payments/card/seamless-view
[checkout-capture]: /checkout/capture
[checkout-checkin-front-end]: /checkout/checkin#step-1-initiate-session-for-consumer-identification
[checkout-payment-menu-frontend]: /checkout/checkin#step-2-display-swedbank-pay-checkin-module
[checkout-payment-order-purchase]: /checkout/payment-menu#request
[checkout-payment-orders]: /checkout/other-features#payment-orders
[checkout-payment-url]: /checkout/other-features#payment-url
[checkout]: /checkout
[checkout-callback]: /checkout/other-features#callback
[co-badge-card]: /payments/card/other-features#co-badge-card-choice-for-dankort
[credit-card-abort]: /payments/card/after-payment#abort
[credit]: /payments/card
[data-protection]: /resources/data-protection
[design-guide]: https://design.swedbankpay.com/
[frontpage]: https://developer.swedbankpay.com/
[gift-cards]: /gift-cards
[home-technical-information]: /home/technical-information
[initiate-consumer-session]: /checkout/checkin#step-1-initiate-session-for-consumer-identification
[invoice-direct]: /payments/invoice/direct
[invoice]: /payments/invoice
[mac-checkout]: /checkout/other-features#merchant-authenticated-consumer
[mobile-pay]: /payments/mobile-pay
[one-click]: /payments/card/other-features#one-click-payments
[payment-orders]: /checkout/other-features#creating-a-payment-order
[payments]: /payments
[settlement-reconcilitation]: /payments/card/other-features#settlement-and-reconciliation
[sdk-modules]: /resources/sdk-modules
[storing-uri]: /home/technical-information#storing-uris
[swish-api-errors]: /payments/swish/other-features#swish-api-errors
[swish-direct-mcom]: /payments/swish/direct#step-2b-create-m-commerce-sale-transaction
[swish-direct]: /payments/swish/direct
[swish-other-features]: /payments/swish/other-features
[swish-redirect]: /payments/swish/redirect
[swish-seamless-view]: /payments/swish/seamless-view
[swish]: /payments/swish
[swish-abort]: /payments/swish/after-payment#abort
[terminology]: /resources/terminology
[test-data]: /resources/test-data
[trustly-payments]: /payments/trustly
[vipps-payment-resource]: /payments/vipps/other-features#payment-resource
[vipps-payment-url]: /payments/vipps/other-features#payment-url
[vipps]: /payments/vipps
