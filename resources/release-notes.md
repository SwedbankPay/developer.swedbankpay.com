---
title: Release Notes
description: |
  The latest updates about our releases will be
  published on this page.
menu_order: 800
---

{% include alert.html type="informative" icon="info" header="Version numbers"
body="The version numbers used in headers on this page refers to the version of
this very documentation, not to a version of any APIs described by it." %}

## 10 March 2023

### Version 4.1.0

A lot of changes are happening these days. We've made the decision to focus the
Checkout v3 offering, so our Starter and Business implementations are no more.
This means that we can do what we do best: giving you a payment experience
packed with options. The [Payments Only][checkout-v3-payments-only]
implementation is still here, and for those of you with a Strong Consumer
Authentication who want access to our safely stored card data,
[Enterprise][checkout-v3-enterprise] is still available too.

## 03 March 2023

### Version 4.0.0

We promised you something big, and here it is. [Click to Pay][click-to-pay] and
[Google Pay&trade;][google-pay] have been added to our arsenal of payment
instruments. Click on your instrument of choice to see what is needed for you to
activate in your integration. We have also added information on how to activate
[Apple Pay][apple-pay], which we recommend reading up on.

As you've probably already seen, our new sidebar is finally live too! We have
given it a facelift and different levels which we hope make it easier for you to
navigate. All the content is where it used to be. Check it out (and let us know
what you think)! You might also wonder where the tables following our code
examples have gone. We have made them expandable, and given them a facelift as
well.

We have also added [3DS2 test data][3ds2-test], along with smaller maintenance
tasks and bug fixes.

## 31 January 2023

### Version 3.1.8

Bigger things are coming up around the bend, so we are stopping by with some
smaller fixes and a [Checkout v3 matrix][checkout-v3-matrix] giving you a better
overview over which payment instruments v3 has to offer, and the countries they
are available.

We'll be back soon!

## 17 January 2023

### Version 3.1.7

We kick off the new year with a new field in our payment order request. Your
Checkout v3 implementation of choice is now added in the request.
Version 2 of the balance report and transaction list is our second newcomer this
release. Head over to [Settlement & Reconciliation][settlement-balance-report]
to learn more.

We have added a [paid status model][status-model-paid-v2] to Checkout v2 and
Payment Menu v2, and the [update payment order section][payment-order-update] is
added to Checkout v3.

## 15 December 2022

### Version 3.1.6

Our last update in 2022 mainly consists of clean-ups and fixes, but the most
important changes are `bin` and `msidn` fields added (where they are relevant)
to [Paid resource model][resource-model-paid-swish]
and [Paid status model][status-model-paid], plus a small rework of
[Age restrictions][age-restrictions].

Happy holidays, everyone! We look forward to seeing you in 2023!

## 29 November 2022

### Version 3.1.5

Our penultimate release of the year has a few things up its sleeve. The most
exciting being the new capabilities
[Cross Channel Payments][cross-channel-payments],
[Automated Fuel Dispenser Payments][afd-payments], [SSN][ssn-restrictions] and
[Age][age-restrictions] restrictions. We've also added some new fields in the
[Paid][resource-model-paid] and [Cancelled][resource-model-cancelled] models, a
new [Payer][resource-model-payer] resource model. Please note the
[organization number][v3-setup] added to the essential information for Checkout
v3 set ups. Apart from that, there are no releases without typo corrections and
bug fixes.

## 20 September 2022

### Version 3.1.3

Another small one. We've added Checkout v3 paid responses for all instruments in
both [status][status-models] and [resource-models][resource-models], finished up
the headers which was missing, added MobilePay to
[Request Delivery Information][request-delivery-information] and done away with
some more bugs and typos.

## 02 September 2022

### Version 3.1.2

We have been picking up steam since our summer break, hitting full throttle as
September arrived. A smaller release this time around, but there are some
important additions nonetheless. We have added a
[siteID][checkout-v3-payments-only-redirect-request] field to checkout v3
implementations, re-worked nearly all
[headers][checkout-v3-payments-only-seamless] across the portal to make
navigation easier, added a section on
[deleting payment tokens][delete-payment-tokens], along with the usual batch of
assorted bug fixes and typos.

## 01 July 2022

### Version 3.1.1

A release filled with leftovers before we clock out for summer. Mostly small
fixes in code examples and tables, but the most important additions are the new
fields added in the [paid resource model][resource-model-paid]. Have a great
summer!

## 22 June 2022

### Version 3.1.0

Summer has finally arrived, and we have quite a treat waiting in our final
release before the vacation pulse kicks in. Without further ado: We now proudly
offer **Apple Pay**! It is available in all our Checkout v3 implementations and
integrations. There are a couple of other new additions as well:

*   Our [SDKs][sdk-modules] have been updated to support Checkout v3
*   You can now [request delivery information][request-delivery-information] for
  selected instruments
*   An eligibility check [eligibility check][eligibility-check] for wallets has
  been added to instrument mode
*   Fixed typos, minor bugs and code examples

## 04 April 2022

### Version 3.0.3

*   Added a new [card error code][card-error-codes] and restructured the tables.
*   Fleshed out the [Unscheduled Purchase][unscheduled-mit] section.
*   Fleshed out the [Recur][recur] section.
*   Moved the [callback][callback] section to core features.
*   Typos and minor bug fixes in code examples and tables.

## 16 March 2022

### Version 3.0.2

*   Typos and minor bug fixes in code examples and tables.
*   Re-wrote [Payer Aware Payment Menu][payer-aware-payment-menu]
*   Clarified [`OnAborted` Seamless View event][seamless-view-events-onaborted]
*   Elaborated user agent fields in requests.
*   Added links to resource models in [Checkout v3 response tables][checkout-create-starter-paymentorder]

## 24 February 2022

### Version 3.0.1

*   Added descriptive card icons
*   Added [Payer Aware Payment Menu][payer-aware-payment-menu]
*   Added new screenshots for Checkout v3 implementations
*   Rewrote instrument mode section
*   Reorganized features in the sidebar
*   Fixed internal links

## 18 February 2022

### Version 3.0.0

It's been a minute, but the day is finally here. We can proudly present Checkout
version 3.0! The same range of payment instruments, checkin options and features
as always, but since different merchants have different needs, we've made it
easier for you to get the checkout experience which fits you best. So, what's
new?

*   Two Checkout implementations tailor-made for different needs and wishes:
    Enterprise or Payments Only. We've summed them up to help
    you find the right fit and [get started][get-started].
*   Each implementation starts off with a guide to set up your test account
    quickly.
*   Want to see the new implementations in action? Head over to the
    [demoshop][demoshop].
*   We've put the [sequence diagrams][sequence-diagrams] in a separate section.
*   The [Seamless View events][seamless-view-events] have been re-worked to make
    the integration smoother for you.
*   Renamed and gathered the Post Purchase options on one page. The rest of the
    features are still where they used to be.
*   We've given the [front page][frontpage] a touch up, and given the new
    sections a slightly different look to distinguish them.
*   Already up on Checkout version 2.0? No worries. All the documentation is
    still available in the sidebar and [here][checkout-v2].

## 15 October 2021

### Version 2.2.3

*   Updated [Android SDK documentation][android-sdk-documentation]
*   Added info about [consumerProfileRef expiration][checkin]
*   Added important information about WebView integrations for [mobile card payments][mobile-card-payments]
*   Updated [iOS SDK documentation][ios-sdk-documentation]
*   Added information about [authorization timeouts][authorization-timeouts] (bottom of page)
*   Added important info about [MobilePay shoplogoUrl][mobilepay-seamless-view]
*   Fixed minor bugs and code examples

## 03 August 2021

### Version 2.2.2

*   Added payment link for [Payment Menu v2][payment-menu-payment-link]
*   Renamed [Merchant Authenticated Consumer][mac-checkout] section (previously Delegated Strong Authenticated Consumer)
*   Updated [Unscheduled Merchant Initiated Transaction][unscheduled-mit]
*   Fixed typos, minor bugs and code examples

## 19 May 2021

### Version 2.2.1

*   Added payment link option for [Trustly][trustly-payment-link]
*   Added information about invoice capture in [Checkout v2][checkout-invoice-capture] and [Payment Menu][payment-menu-invoice-capture]
*   Added MobilePay `shoplogoUrl` in the [Checkout v2][checkout-items] and [Payment Menu v2][payment-menu-items] items section
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
    [Delegated Strong Customer Authentication][mac].
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
*   Added information about [Storing URLs][storing-uri] in the [Technical
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
*   Corrected problem `type` URLs for [Card Payments][card], [Checkout][checkout]
    and [Swish Payments][swish].
*   Required checkmarks have a new, fresh look: {% icon check %}
*   Flags now also sport a new look: {% flag no %} {% flag se %} {% flag dk %}
    {% flag fi %} {% flag lt %} {% flag lv %} {% flag ee %}

## 15 Apr 2020

### Version 1.8.3

*   Bug fixes to Mermaid diagram and alert styling, plus improvements to code
    block styling after the update to [Swedbank Pay Design Guide][design-guide]
    4.5.0.
*   Added examples with screenshots of the effects of [Delegated Strong Customer
    Authentication][mac-checkout].

### Version 1.8.2

*   Added a more thorough description on `paymentUrl` and `completeUrl` in all
    relevant payments.
*   Updated `orderItems` to be required in all requests and responses.
*   Clean up of [Swish Payments][swish]
*   Removed `pageStripDown` in [Vipps Redirect][vipps].
*   Updated the [main page][frontpage] to be more welcoming.
*   Updated information on [Delegated Strong Customer Authentication][mac-checkout].

## 31 Mar 2020

### Version 1.8.1

*   Documented allowed characters in `orderItem.class`.
*   Added `receiptReference` in [Invoice Payments][invoice] and
    [Payment Order][payment-orders] in capture and reversal.
*   Callback is now moved to Other features in all payments instruments.
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
*   Added and fixed several missing headings in template files.
*   Expanded information about `verify`.
*   Created new page for [Checkout Capture][checkout-capture].
*   Mobile Pay Online was previously only referred to as Mobile Pay, this has been
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

The input parameter `quantity` in the `orderItems` field is now updated to decimal.
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
invoked after return of the payer, they will either be redirected to
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
invoked after return of the payer, they will either be redirected to the
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

[3ds2-test]: /resources/test-data#otp-3ds2
[afd-payments]: /checkout-v3/payments-only/features/optional/afd
[age-restrictions]: /checkout-v3/payments-only/features/optional/age-restrictions
[android-configuration]: /modules-sdks/mobile-sdk/configuration#android
[android-sdk-documentation]: /modules-sdks/mobile-sdk/android
[apple-pay]: /checkout-v3/payment-presentations#apple-pay
[authorization-timeouts]: /old-implementations/checkout-v2/capture
[callback]: /checkout-v3/payments-only/features/core/callback
[card-delete-token]: /old-implementations/payment-instruments-v1/card/features/optional/delete-token
[card-error-codes]: /old-implementations/payment-instruments-v1/card/features/technical-reference/problems
[card-payment-url]: /old-implementations/payment-instruments-v1/card/features/technical-reference/payment-url
[card-purchase]: /old-implementations/payment-instruments-v1/card/redirect#step-1-create-a-purchase
[card-unscheduled-purchase]: /old-implementations/payment-instruments-v1/card/features/optional/unscheduled
[card-transaction-states]: /old-implementations/payment-instruments-v1/card/features/technical-reference/payment-transaction-states
[card]: /old-implementations/payment-instruments-v1/card
[card-3ds-info]: /old-implementations/payment-instruments-v1/card#sequence-diagram
[card-3ds2]: /old-implementations/payment-instruments-v1/card/features/core/3d-secure-2
[card-redirect]: /old-implementations/payment-instruments-v1/card/redirect
[card-seamless-view]: /old-implementations/payment-instruments-v1/card/seamless-view
[checkin]: /old-implementations/checkout-v2/checkin
[checkout-capture]: /old-implementations/checkout-v2/capture
[checkout-invoice-capture]: /old-implementations/checkout-v2/capture
[checkout-checkin-front-end]:/old-implementations/checkout-v2/checkin#step-1-initiate-session-for-consumer-identification
[checkout-payment-menu-frontend]: /old-implementations/checkout-v2/checkin#step-2-display-swedbank-pay-checkin-module
[checkout-payment-order-purchase]: /old-implementations/checkout-v2/payment-menu#step-3-create-payment-order
[checkout-payment-url]: /old-implementations/checkout-v2/features/technical-reference/payment-url
[checkout-create-starter-paymentorder]: /checkout-v3/enterprise/seamless-view#step-1-create-payment-order
[checkout]: /old-implementations/checkout-v2/
[checkout-v2]: /old-implementations/checkout-v2/
[checkout-items]: /old-implementations/checkout-v2/features/technical-reference/items
[checkout-3ds2]: /old-implementations/checkout-v2/features/core/3d-secure-2
[checkout-callback]: /old-implementations/checkout-v2/features/core/callback
[checkout-v3-matrix]: /checkout-v3/#choose-the-right-implementation-for-your-business
[checkout-v3-enterprise]: /checkout-v3/enterprise
[checkout-v3-payments-only]: /checkout-v3/payments-only
[checkout-v3-payments-only-redirect-request]: /checkout-v3/payments-only/redirect#payment-order-request
[checkout-v3-payments-only-seamless]: /checkout-v3/payments-only/seamless-view
[click-to-pay]: /checkout-v3/payment-presentations#click-to-pay
[co-badge-card]: /old-implementations/payment-instruments-v1/card/features/optional/cobadge-dankort#co-badge-card-choice-for-dankort
[core-features]: /old-implementations/checkout-v2/features/core/
[credit-card-abort]: /old-implementations/payment-instruments-v1/card/after-payment#abort
[credit]: /old-implementations/payment-instruments-v1/card
[cross-channel-payments]: /checkout-v3/payments-only/features/optional/cross-channel-payments
[data-protection]: /resources/data-protection
[delete-payment-tokens]: /checkout-v3/payments-only/features/optional/delete-token#delete-paymenttoken-request
[demoshop]: https://ecom.externalintegration.payex.com/pspdemoshop
[design-guide]: https://design.swedbankpay.com/
[eligibility-check]: /checkout-v3/payments-only/features/optional/instrument-mode#eligibility-check
[mac]: /old-implementations/checkout-v2/features/optional/mac
[frontpage]: https://developer.swedbankpay.com/
[get-started]: /checkout-v3/
[gift-cards]: /gift-cards
[google-pay]: /checkout-v3/payment-presentations#google-pay
[home-technical-information]: /introduction
[initiate-consumer-session]: /old-implementations/checkout-v2/checkin#step-1-initiate-session-for-consumer-identification
[invoice-direct]: /old-implementations/payment-instruments-v1/invoice/direct
[invoice]: /old-implementations/payment-instruments-v1/invoice
[ios-configuration]: /modules-sdks/mobile-sdk/configuration#ios
[ios-sdk-documentation]: /modules-sdks/mobile-sdk/ios
[mac-checkout]: /old-implementations/checkout-v2/features/optional/mac
[mobile-card-payments]: /old-implementations/payment-instruments-v1/card/mobile-card-payments
[mobile-pay]: /old-implementations/payment-instruments-v1/mobile-pay
[mobilepay-seamless-view]: /old-implementations/payment-instruments-v1/mobile-pay/seamless-view
[mobilepay-capture]: /old-implementations/payment-instruments-v1/mobile-pay/capture
[modules-sdks]: /modules-sdks
[moto-payment-card]: /old-implementations/payment-instruments-v1/card/features/optional/moto
[one-click]: /old-implementations/payment-instruments-v1/card/features/optional/one-click-payments
[optional-features]: /old-implementations/checkout-v2/features/optional/
[payment-orders]: /old-implementations/checkout-v2/payment-menu#step-3-create-payment-order
[payment-order-update]: /checkout-v3/payments-only/features/optional/update
[payment-menu-invoice-capture]:/old-implementations/payment-menu-v2/capture
[payment-menu-items]: /old-implementations/payment-menu-v2/features/technical-reference/items
[payment-menu-payment-link]: /old-implementations/payment-menu-v2/features/optional/payment-link
[payments]: /old-implementations/payment-instruments-v1/
[payer-aware-payment-menu]: /checkout-v3/payments-only/features/optional/payer-aware-payment-menu
[prices]: /old-implementations/checkout-v2/features/technical-reference/prices
[update-order-checkout]: /old-implementations/checkout-v2/features/optional/update
[recur]: /checkout-v3/payments-only/features/optional/recur
[resource-model-cancelled]: /checkout-v3/payments-only/features/technical-reference/resource-sub-models#cancelled
[resource-model-paid]: /checkout-v3/payments-only/features/technical-reference/resource-sub-models#paid
[resource-model-paid-swish]: /checkout-v3/payments-only/features/technical-reference/resource-sub-models#swish-paid-resource
[resource-model-payer]: /checkout-v3/payments-only/features/technical-reference/resource-sub-models#payer
[resource-models]: /checkout-v3/payments-only/features/technical-reference/resource-sub-models
[request-delivery-information]: /checkout-v3/payments-only/features/optional/request-delivery-info
[resources]: /resources/
[settlement-balance-report]: /old-implementations/payment-instruments-v1/card/features/core/settlement-reconciliation#balance-report
[settlement-reconcilitation]: /old-implementations/payment-instruments-v1/card/features/core/settlement-reconciliation
[sdk-modules]: /modules-sdks
[split-settlement]: /old-implementations/payment-instruments-v1/card/features/core/settlement-reconciliation#split-settlement
[ssn-restrictions]: /checkout-v3/payments-only/features/optional/payer-restrictions
[status-models]: /checkout-v3/payments-only/features/technical-reference/status-models
[status-model-paid]: /checkout-v3/payments-only/features/technical-reference/status-models#paid
[status-model-paid-v2]: /old-implementations/checkout-v2/features/technical-reference/status-models#paid
[storing-uri]: /introduction#storing-urls
[swish-api-errors]: /old-implementations/payment-instruments-v1/swish/features/technical-reference/problems
[swish-direct-mcom]: /old-implementations/payment-instruments-v1/swish/direct#step-2b-create-m-commerce-sale-transaction
[swish-direct]: /old-implementations/payment-instruments-v1/swish/direct
[swish-features]: /old-implementations/payment-instruments-v1/swish/features
[swish-redirect]: /old-implementations/payment-instruments-v1/swish/redirect
[swish-seamless-view]: /old-implementations/payment-instruments-v1/swish/seamless-view
[seamless-view-events]: /checkout-v3/payments-only/features/technical-reference/seamless-view-events
[seamless-view-events-onaborted]: /checkout-v3/payments-only/features/technical-reference/seamless-view-events#onaborted
[seamless-view-events-card]: /old-implementations/payment-instruments-v1/card/features/technical-reference/seamless-view-events
[sequence-diagrams]: /checkout-v3/sequence-diagrams
[swish]: /old-implementations/payment-instruments-v1/swish
[swish-abort]: /old-implementations/payment-instruments-v1/swish/after-payment#abort
[technical-reference]: /old-implementations/checkout-v2/features/technical-reference/
[terminology]: /resources/terminology
[test-data]: /resources/test-data
[transaction-on-file]: /old-implementations/payment-instruments-v1/card/features/optional/transaction-on-file
[tra-exemption]: /old-implementations/checkout-v2/features/optional/tra
[trustly-payments]: /old-implementations/payment-instruments-v1/trustly
[trustly-payment-link]: /old-implementations/payment-instruments-v1/trustly/features/optional/payment-link
[trustly-features]: /old-implementations/payment-instruments-v1/trustly/features
[unscheduled-mit]: /checkout-v3/payments-only/features/optional/unscheduled
[v3-setup]: /checkout-v3/payments-only/#step-1-sign-up-for-a-test-account
[vipps-payment-resource]: /old-implementations/payment-instruments-v1/vipps/features/technical-reference/payment-resource
[vipps-payment-url]: /old-implementations/payment-instruments-v1/vipps/features/technical-reference/payment-url
[vipps]: /old-implementations/payment-instruments-v1/vipps
