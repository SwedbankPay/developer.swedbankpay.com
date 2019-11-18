---
title: Swedbank Pay Checkout – Summary
sidebar:
  navigation:
  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/checkin
      title: Checkin
    - url: /checkout/payment-menu
      title: Payment Menu
    - url: /checkout/after-payment
      title: After Payment
    - url: /checkout/summary
      title: Summary
    - url: /checkout/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

{% include jumbotron.html body="If you have read this far, you should now be
done with the basic integration of Swedbank Pay Checkout. Congratulations!
Read on to check items on the check list to ensure that your integration
complies with our **Best Practices**." %}

## Best Practices

A completed integration against Swedbank Pay Checkout should adhere to a set of
best practice criteria in order to successfully go through Swedbank Pay's
integration validation procedure.

### Must Haves

* The Checkin and Payment Menu components (the two `<iframe>` elements) must be
  separate (one must not replace the other).
* The Checkin must be completed before any shipping details are finalized, as
  the Checkin component provides shipping address via the
  `onShippingDetailsAvailable` event.
* If a browser refresh is performed after the payer has checked in, the payment
  menu must be shown even though `onConsumerIdentified` is not invoked.
* The `consumerProfileRef` returned in the response from the `POST` request to
  the `consumers` resource must be included in the `POST` request to the
  `paymentorders` resource.
* The `paymentUrl` is an URL property that redirect the consumer from the payment page and back to the Merchant

For our Seamless View, the URL property called `paymentUrl` will be used when the
consumer is redirected out of the Seamless View frame through our
[Vipps API][vipps-payments].
The consumer is redirected out of frame when selecting Vipps as payment method.
The URL should represent the page of where the payment Seamless View was hosted
originally,
such as the checkout page, shopping cart page, or similar. Basically,
`paymentUrl` should be set to the same URL as that of the page where the
JavaScript for the hosted payment view was added to in order to initiate the
payment.
Please note that the `paymentUrl` must be able to invoke the same JavaScript
URL from the same Payment as the one that initiated the payment originally,
so it should include some sort of state identifier in the URL.
The state identifier is the ID of the order, shopping cart or similar that has
the URL of the Payment stored.

With `paymentUrl` in place, the retry process becomes much more convenient for
both the integration and the payer.

* When the contents of the shopping cart changes or anything else that affects
  the amount occurs, the `paymentorder` must be updated and the Payment Menu
  must be `refresh`ed.
* Features not described on this page must not be used, although they are
  available in the API. Flags that can be turned to `true` must be kept
  `false` as described in this standard setup documentation.
* When the payer is checked in, he or she must be identified appropriately in
  the Payment Menu (stored credit cards must be visible for the credit card
  payment instrument, for instance).
* `orderReference` must be sent as a part of the `POST` request to
  `paymentorders` and must represent the order ID of the webshop or merchant
  website.
* The integration needs to handle both one and two phase purchases correctly.
* All of the operations `Cancel`, `Capture` and `Reversal` must be implemented.
* The [transaction callback][callback] must be handled appropriately.
* [Problems][problems] that may occur in Swedbank Pay' API must be handled
  appropriately.
* Your integration must be resilient to change. Properties, operations,
  headers, etc., that aren't understood in any response **must be ignored**.
  Failing due to a something occurring in a response that your implementation
  haven't seen before is a major malfunction of your integration and must be
  fixed.
* The `paymentUrl` must be placed on a page where it can invoke the same 
  `JavaScript` URL from the same _Payment_ or _Payment Order_ as the initiated
  payment page, so a identifier of some sort should be stored either on the page
  or in the `URL` of the `paymentUrl` so the same original payment view can 
  be initiated. The state identifier is the ID of the order, shopping
  cart or similar that has the URL of the Payment or Payment Order stored.

{% include iterator.html prev_href="after-payment"
                         prev_title="Back: After Payment"
                         next_href="other-features"
                         next_title="Next: Other Features" %}

[problems]: /checkout/other-features#problems
[callback]: /checkout/other-features#callback
