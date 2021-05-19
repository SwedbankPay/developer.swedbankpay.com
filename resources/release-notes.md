---
title: Release Notes
estimated_read: 10
description: |
  The latest updates about our releases will be
  published on this page.
---

{% include alert.html type="informative" icon="info" header="Version numbers"
body="The version numbers used in headers on this page refers to the version of
this very documentation, not to a version of any APIs described by it." %}

## 19 May 2021

### Version 2.2.1

*   Added payment link option for [Trustly][trustly-payment-link]
*   Added information about invoice capture in [Checkout v2][checkout-invoice-capture] and [Payment Menu][payment-menu-invoice-capture]
*   Added MobilePay `shoplogoUrl` in the [Checkout v2][checkout-items] and [Payment Menu][payment-menu-items] items section
*   Added [Delete Token section][card-delete-token] in Card's technical reference
*   Fixed minor typos and bugs

## 30 Apr 2021

### Version 2.2.0

*   Restructured Features sections for all implementations into [core features][core-features], [optional features][optional-features] and [technical reference][technical-reference]
*   Renamed Checkout to [Checkout v2][Checkout-v2]
*   Added [TRA exemption][tra-exemption] section
*   Fixed a handful of typos and bugs

## 28 Jan 2021

### Version 2.1.2

*   Updated Theme version to 1.9.9
*   Updated Design Guide Version to 5.0.1

## 26 Jan 2021

### Version 2.1.0

*   Updated theme with visual fixes
*   Search icon is now clickable
*   Various bug fixes
*   Various corrections and typo fixes
*   Re-worded [split settlement][split-settlement]
*   Clarified that [callback][callback] is a fail-safe
*   Updated tables and code examples with payerReference in various places, like [card purchase][card-purchase]
*   Updated Mobile SDK configurations for both [iOS][ios-configuration] and [Android][android-configuration] to include integration with custom backends
*   Updated GitHub references for Mobile SDK
*   Re-wrote [Prices][prices] section

## 01 Dec 2020

### Version 2.0.2

*   Various bug fixes
*   Various corrections and typo fixes
*   Corrected information about [3D-Secure][card-3ds-info]
*   Added paragraphs about different consumer flows in [Checkin][Checkin]
*   Added link to gift card on the [front page][frontpage]

## 12 Nov 2020

### Version 2.0.1

*   Added section for [MobilePay Seamless View][mobilepay-seamless-view]
*   Split [MobilePay Capture][mobilepay-capture] to a separate page
*   Code examples for digital products added in [Checkin][Checkin]

## 11 Nov 2020

### Version 2.0.0

Launched new developer portal theme:

*   New design
*   New menu structure
*   Reading time

Other changes:

*   Added GDPR disclaimer.
*   Added custom 404 page.
*   Added section about [Transaction On File][transaction-on-file]
*   Added Seamless View for [Trustly][trustly-payments].
*   Added documentation about payment and transaction states. See [Card Other Features][card-transaction-states] for example.
*   Added event override warning for Seamless View Events, see [Card Seamless View Events][card-seamless-view] for example.
*   Added section regarding [MOTO][moto-payment-card] in Card Other Features.
*   Deleted Merchant Identified Payer in [Checkout][checkout].
*   Renamed Merchant Authenticated Consumer to
    [Delegated Strong Consumer Authentication][dsca].
*   Updated `payer`/`consumer`/`end-user` naming for most sections.
*   Updated expiry date for test cards in [test data][test-data].
*   Updated [callback][checkout-callback] documentation.
*   Updated regex pattern for `orderItems.class`.

## 04 Sep 2020

### Version 1.13.3

*   Added documentation on deprecated operations in [Checkout][checkout-payment-order-purchase].
*   Updated `instrument` description in [Checkout][checkout].
*   Updated `payeeReference` description.
*   Clarified `msisdn` and `shoplogoUrl` in [MobilePay Online Payments][mobile-pay].
*   Updated [Test data][test-data] in [Resources][resources].
*   Documented problems in [Trustly Payments][trustly-payments].
*   Added an alert for two-phase payments in Capture pages.

## 28 Aug 2020

### Version 1.13.2

*   Added description on `metadata` for all payment instruments.
*   Updated files in [Settlement & Reconciliation][settlement-reconcilitation].
*   Added information on token deletion in [Card Payments][card] and [Invoice Payments][invoice].
*   Updated the documentation on `paymentRestrictedToAgeLimit` and
    `paymentRestrictedToSocialSecurityNumber` in [Swish Payments][swish].
*   Added documentation on guest checkout in [Checkout][checkout].
*   Updated information about `logourl` in [Checkout][checkout].
*   Added a list of accepted banks in [Trustly Payments][trustly-payments].
*   Updated the `UpdateOrder` description in [Checkout][checkout].

## 21 Aug 2020

### Version 1.13.1

*   Removed documentation for [Trustly Payments][trustly-payments] Seamless View.
*   Updated `reOrderPurchaseIndicator` description.
*   Updated [Other Features][trustly-features] in [Trustly Payments][trustly-payments].
*   Updated [Test Data][test-data] for Vipps Payments.
*   Added updated documentation on the `transaction` operation.

## 17 Jul 2020

### Version 1.13.0

*   Added documentation on Mobile SDK in [Modules & SDKs][modules-sdks] section.
*   Added tables for mapping API fields to settlement files in
    [Settlement and Reconciliation][settlement-reconcilitation].

## 10 Jul 2020

### Version 1.12.1

*   Corrected the documentation by removing `generatePaymentToken` and
    `paymentToken` from [Checkout][checkout].

## 07 Jul 2020

### Version 1.12.0

*   Added information on 3-D Secure 2 for [Checkout][checkout-3ds2] and
    [Card Payments][card-3ds2].
*   Updated reconciliation files in [Settlement &
    Reconciliation][settlement-reconcilitation].
*   Added test card for Forbrugsforeningen in [Test data][test-data].
*   Documented `paid`, `failed` and `aborted` across all resources.
*   Added additional information on `payerReference`, `generateRecurrenceToken`,
    `paymentToken`, `generatePaymentToken`, `recurrenceToken` and
    `instrument` for the `paymentorder` resource in [Checkout][checkout].
*   Corrected and updated `view-` operations for all resources.
*   Updated [Seamless View Events][seamless-view-events-card] for all resources.
*   Described `nonPaymentToken` and `externalNonPaymentToken` in
    [Card Payments][card].
*   Small corrections to [Swish Payments][swish] documentation.
*   Clarified the [`updateOrder`][update-order-checkout] documentation.

## 04 Jun 2020

### Version 1.11.1

*   Added additional information on the settlement files in [Settlement &
    Reconciliation][settlement-reconcilitation] for all Payments.
*   Corrected [Card Payments Redirect][card-redirect] and [Card Payments
    Seamless View][card-seamless-view] sequence diagrams.
*   Added [Abort][swish-abort] in [Swish Payments][swish].

## 29 May 2020

### Version 1.11.0

*   Added a new [Trustly Payments][trustly-payments] section.
*   Added information about [Storing URIs][storing-uri] in the [Technical
    Information][home-technical-information] section.

## 22 May 2020

### Version 1.10.1

*   Updated [Swish Redirect][swish-redirect] requests.
*   Added `orderReference` information in Payment Order Callback in [Checkout Other features][checkout-callback].

## 14 May 2020

### Version 1.10.0

*   Added a new [Gift Cards][gift-cards] section with descriptions of our Gift Cards API.
*   Added a new section [Co-badge Card Choice for Dankort][co-badge-card] in
    [Card Payments][card-payment-url].

## 07 May 2020

### Version 1.9.2

*   Corrected table in [payments page][payments].

### Version 1.9.1

*   Corrected sequence diagrams in [Swish Payments][swish] and
    [Vipps Payments][vipps].
*   The `description` field is now more thoroughly described for all requests it's
    present in.
*   The `language` field is now better described for all requests it's present in.
*   All broken links should now be unbroken.

## 22 Apr 2020

### Version 1.9.0

*   Added a new section [SDKs and Modules][sdk-modules] in Resources.
*   Corrected problem `type` URIs for [Card Payments][card], [Checkout][checkout]
    and [Swish Payments][swish].
*   Required checkmarks have a new, fresh look: {% icon check %}
*   Flags now also sport a new look: {% flag no %} {% flag se %} {% flag dk %}
    {% flag fi %} {% flag lt %} {% flag lv %} {% flag ee %}

## 15 Apr 2020

### Version 1.8.3

*   Bug fixes to Mermaid diagram and alert styling, plus improvements to code
    block styling after the update to [Swedbank Pay Design Guide][design-guide]
    4.5.0.
*   Added examples with screenshots of the effects of [Delegated Strong Consumer
    Authentication][dsca-checkout].

### Version 1.8.2

*   Added a more thorough description on `paymentUrl` and `completeUrl` in all
    relevant payments.
*   Updated `orderItems` to be required in all requests and responses.
*   Clean up of [Swish Payments][swish]
*   Removed `pageStripDown` in [Vipps Redirect][vipps].
*   Updated [Card Payments Direct][card-direct] to have a correct integration
    flow.
*   Updated the [main page][frontpage] to be more welcoming.
*   Updated information on [Delegated Strong Consumer Authentication][dsca-checkout].

## 31 Mar 2020

### Version 1.8.1

*   Documented allowed characters in `orderItem.class`.
*   Added `receiptReference` in [Invoice Payments][invoice] and
    [Payment Order][payment-orders] in capture and reversal.
*   Callback is now moved to Other features in all payments intruments.
*   Clean up of [MobilePay][mobile-pay].
*   Corrected the address of Leia Ahlström in [Test Data][test-data].
*   Updated the documentation in [Card Payments][card-payment-url]
    to recommend using `shippingAddress`.
*   Updated `payeeReference` to have an unique description for Payment Order and
    every Payment Instrument.

## 18 Mar 2020

### Version 1.8.0

*   Updated [Invoice Payments Direct][invoice-direct] where
    `approvedLegalAddress` should now be use for all countries.
*   Small text changes and clarifications.
*   Restructured [Invoice Payments][invoice] and [Card Payments][card].

### Version 1.7.7

This change contains build updates for the page. :octocat:

## 04 Mar 2020

### Version 1.7.6

*   Several links has been corrected. The chance of 404 is now much lower.
*   Other small text changes and clarifications.

## 03 Mar 2020

### Version 1.7.5

*   New page! Technical reference into has been moved from the front page
    to [technical information][home-technical-information].
*   Front page got a slimmer look. :swimmer:
*   Abort reference is back in [credit card reference][credit-card-abort].
*   Swish error code reference got a face lift, check it out
    [here][swish-api-errors] :candy:.

### Version 1.7.4

*   Described the M-Commerce flow for [Swish Direct][swish-direct-mcom].
*   Alphabetize the terms in [Terminology][terminology].

## 27 Feb 2020

### Version 1.7.3

*   Expanded information about the field `restrictedToInstruments`.
*   Added information about the field `receiptReference`.
*   Added information about [direct integration in Credit card][card-direct].
*   Added and fixed several missing headings in template files.
*   Expanded information about `verify`.
*   Created new page for [Checkout Capture][checkout-capture].
*   Mobile Pay Online was previously only refered to as Mobile Pay, this has been
    corrected.

## 7 Feb 2020

### Version 1.7.2

*   Removed several duplicate headers in features pages.
*   Added unscheduled purchase information in
    [card payments][card-unscheduled-purchase].
*   We have added card logos when selecting card in payment menu.
    See [updated screenshot of payment menu][checkout-payment-menu-frontend].

## 6 Feb 2020

### Version 1.7.1

All sections have been released. :trophy:

### Version 1.7.0

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

## 29 Jan 2020

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
    `payer` object in [Payment Order requests][payment-orders].
*   `cardholder` added to [Card Payments Purchase requests][card-purchase].
*   Various improvements and fixes.

## 27 Jan 2020

### Version 1.6.0

*   [Credit Payments][credit] (née "Credit Account") sections have been deleted
    from the Swedbank Pay Developer Portal.
*   The [Swish Payments][swish] and [Vipps Payments][vipps] have received a few
    updates and are now ready for another round of review.
*   [MobilePay Online Payments][mobile-pay] is now ready for review.
*   `paymentAgeLimit` is now added in [Swish Payments][swish].
*   The [Terminology page][terminology] is updated and _3-D Secure 2.0 (3DS2)_   ,
    _PSD2_   and _SCA_   explanations are added.
*   Added descriptions for Payment States And Transaction States everywhere appropriate.
*   Google Analytics has been added to Developer Portal.

## 16 Jan 2020

### Version 1.5

*   The review of [Invoice Payments][invoice] is complete and as such the section
    is now released and ready for use.
*   The [Card Payments][card] section has received an overhaul, inching it closer
    to release.
*   The [Swish Payments][swish] and [Vipps Payments][vipps] sections are ready for
    review.
*   The Direct Debit, [MobilePay Online Payments][mobile-pay] and
    [Credit Payments][credit] (née "Credit Account") sections have received a few
    updates, inching them all closer to review.

## 09 Jan 2020

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

## 22 Dec 2019

### Update in checkin module

We have added support for specifying language as input in checkin module,
`language`. Supported languages are Norwegian, Swedish and English. Consumers
outside Sweden and Norway can now purchase in our Checkout service. You can
specify supported countries for shipment in a new input parameter,
`shippingAddressRestrictedToCountryCodes`, in our checkin module.
Updated API specification can be found [here][initiate-consumer-session].
The parameters `language` and `shippingAddressRestrictedToCountryCodes` have replaced the former `consumerCountryCode`.

The parameters `msisdn` and `email` have been made obsolete due to GDPR rules. This information cannot be sent in without the explicit consent of the payer.

{% comment %}
TODO: Release this when the Swish Redirect section is released with the correct screenshot. Change the link below when this is ready.

### Improved purchase experience in Swish

We now show the flag connected to the origin of the phone number the payer
uses in Swish during payment. See updated screenshot of payment pages in [[Swish
ecom
redirect>>doc:Main.ecommerce.payex-payment-instruments.swish-payments.swish-e-commerce-redirect.WebHome]]
model.
{% endcomment %}

## 01 Nov 2019

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

If you use our seamless view-solution we have added the URL field called
paymentUrl (previously added for CreditCard, Vipps and Payment Order), that will
be used when the user is returned from the Swish application. See further
information regarding paymentUrl at: [[PaymentUrl in
CreditCard>>doc:Main.ecommerce.release-information.WebHome||anchor="HPaymentUrlCreditCard"]]
{% endcomment %}

### Support international phone numbers in Swish

We have added support for sending in international phone numbers in the request.
Check our Swish documentation [here][swish-features].
This is supported in API, and when payer's enter their phone number on the
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

## 01 Oct 2019

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
invoked after return of the payer, he or she will either be redirected to
the `completeUrl` (event onPaymentCompleted) or if payment has failed, see an
error-message and get the option to retry the payment.

## 01 Aug 2019

### Order Items in payment orders

On [Payment Orders][payment-orders],
`itemDescriptions` and `vatSummary` has been replaced with the more
versatile and powerful `orderItems`. While `itemDescriptions` will continue
to work, it is recommended that all integrations switch over to `orderItems`
as soon as possible. When `orderItems` is used, `itemDescriptions` must be
removed from all requests as the two cannot be used simultaneously.

### Payment Url

For our Seamless Views (currently [Vipps][vipps-payment-url] or in
[Checkout][checkout-payment-url]), we have added a new URL field called
`paymentUrl` that will be used when user is returned from 3rd party. The URL
should represent the page of where the payment seamless view was hosted
originally, such as the checkout page, shopping cart page, or similar.
Basically, `paymentUrl` should be set to the same URL as that of the page where
the JavaScript for the hosted payment view was added to in order to initiate the
payment. Please note that the `paymentUrl` must be able to invoke the same
JavaScript URL from the same Payment or Payment Order as the one that initiated
the payment originally, so it should include some sort of state identifier in
the URL. The state identifier is the ID of the order, shopping cart or similar
that has the URL of the Payment or Payment Order stored. When the JavaScript is
invoked after return of the payer, he or she will either be redirected to the
`completeUrl`, or, if payment failed, see an error message and get the option
to retry the payment.

If `paymentUrl` is not implemented, retry of payments will not be possible in
either individual payment instruments such as
[Vipps][vipps-payment-resource]
or in [Checkout][payment-orders].
It makes it more tedious to retry payment as the whole process including the
creation of the payment or payment order needs to be performed again. With
paymentUrl in place, the retry process becomes much more convenient for both the
integration and the payer.

[android-configuration]: /modules-sdks/mobile-sdk/configuration#android
[callback]: /payment-instruments/card/features/technical-reference/callback
[card-delete-token]: /payment-instruments/card/features/technical-reference/delete-token
[card-direct]: /payment-instruments/card/direct
[card-payment-url]: /payment-instruments/card/features/technical-reference/payment-url
[card-purchase]: /payment-instruments/card/redirect#step-1-create-a-purchase
[card-unscheduled-purchase]: /payment-instruments/card/features/optional/unscheduled-purchase
[card-transaction-states]: /payment-instruments/card/features/technical-reference/payment-transaction-states
[card]: /payment-instruments/card
[card-3ds-info]: /payment-instruments/card#purchase-flow
[card-3ds2]: /payment-instruments/card/features/core/3d-secure-2
[card-redirect]: /payment-instruments/card/redirect
[card-seamless-view]: /payment-instruments/card/seamless-view
[checkin]: /checkout/v2/checkin
[checkout-capture]: /checkout/v2/capture
[checkout-invoice-capture]: /checkout/v2/capture#invoice
[checkout-checkin-front-end]:/checkout/v2/checkin#step-1-initiate-session-for-consumer-identification
[checkout-payment-menu-frontend]: /checkout/v2/checkin#step-2-display-swedbank-pay-checkin-module
[checkout-payment-order-purchase]: /checkout/v2/payment-menu#request
[checkout-payment-url]: /checkout/v2/features/technical-reference/payment-url
[checkout]: /checkout
[checkout-v2]: /checkout/v2/
[checkout-items]: /checkout/v2/features/technical-reference/items
[checkout-3ds2]: /checkout/v2/features/core/3d-secure-2
[checkout-callback]: /checkout/v2/features/technical-reference/callback
[co-badge-card]: /payment-instruments/card/features/optional/cobadge-dankort#co-badge-card-choice-for-dankort
[core-features]: /checkout/v2/features/core/
[credit-card-abort]: /payment-instruments/card/after-payment#abort
[credit]: /payment-instruments/card
[data-protection]: /resources/data-protection
[design-guide]: https://design.swedbankpay.com/
[dsca]: /checkout/v2/features/optional/dsca
[frontpage]: https://developer.swedbankpay.com/
[gift-cards]: /gift-cards
[home-technical-information]: /introduction
[initiate-consumer-session]: /checkout/v2/checkin#step-1-initiate-session-for-consumer-identification
[invoice-direct]: /payment-instruments/invoice/direct
[invoice]: /payment-instruments/invoice
[ios-configuration]: /modules-sdks/mobile-sdk/configuration#ios
[dsca-checkout]: /checkout/v2/features/optional/dsca
[mobile-pay]: /payment-instruments/mobile-pay
[mobilepay-seamless-view]: /payment-instruments/mobile-pay/seamless-view
[mobilepay-capture]: /payment-instruments/mobile-pay/capture
[modules-sdks]: /modules-sdks
[moto-payment-card]: /payment-instruments/card/features/optional/moto
[one-click]: /payment-instruments/card/features/optional/one-click-payments
[optional-features]: /checkout/v2/features/optional/
[payment-orders]: /checkout/v2/payment-menu#step-3-create-payment-order
[payment-menu-invoice-capture]:/payment-menu/capture#invoice
[payment-menu-items]: /payment-menu/features/technical-reference/items
[payments]: /payment-instruments
[prices]: /checkout/v2/features/technical-reference/prices
[update-order-checkout]: /checkout/v2/features#update-order
[resources]: /resources/
[settlement-reconcilitation]: /payment-instruments/card/features/core/settlement-reconciliation
[sdk-modules]: /modules-sdks
[split-settlement]: /payment-instruments/card/features/core/settlement-reconciliation#split-settlement
[storing-uri]: /introduction#storing-uris
[swish-api-errors]: /payment-instruments/swish/features/technical-reference/problems
[swish-direct-mcom]: /payment-instruments/swish/direct#step-2b-create-m-commerce-sale-transaction
[swish-direct]: /payment-instruments/swish/direct
[swish-features]: /payment-instruments/swish/features
[swish-redirect]: /payment-instruments/swish/redirect
[swish-seamless-view]: /payment-instruments/swish/seamless-view
[seamless-view-events-card]: /payment-instruments/card/features/technical-reference/seamless-view-events
[swish]: /payment-instruments/swish
[swish-abort]: /payment-instruments/swish/after-payment#abort
[technical-reference]: /checkout/v2/features/technical-reference/
[terminology]: /resources/terminology
[test-data]: /resources/test-data
[transaction-on-file]: /payment-instruments/card/features/optional/transaction-on-file
[tra-exemption]: /checkout/v2/features/optional/tra
[trustly-payments]: /payment-instruments/trustly
[trustly-payment-link]: /payment-instruments/trustly/features/optional/payment-link
[trustly-features]: /payment-instruments/trustly/features
[vipps-payment-resource]: /payment-instruments/vipps/features/technical-reference/payment-resource
[vipps-payment-url]: /payment-instruments/vipps/features/technical-reference/payment-url
[vipps]: /payment-instruments/vipps
