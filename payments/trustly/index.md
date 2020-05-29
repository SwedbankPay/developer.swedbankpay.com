---
title: Swedbank Pay Trustly Payments
sidebar:
  navigation:
  - title: Trustly Payments
    items:
    - url: /payments/trustly
      title: Introduction
    - url: /payments/trustly/redirect
      title: Redirect
    - url: /payments/trustly/seamless-view
      title: Seamless View
    - url: /payments/trustly/after-payment
      title: After Payment
    - url: /payments/trustly/other-features
      title: Other Features
---

{% include jumbotron.html body="**Trustly Payments** is the simplest way to
provide **Direct Bank** payments on your website. Choose between our
**Redirect** and **Seamless View** integration options." %}

{% include alert.html type="informative"
                      icon="cached"
                      body="**Redirect** is the easiest way to do **Direct
                      Bank** payments. Redirect will take the payer to a
                      Swedbank Pay hosted payment page where they can perform a
                      secure transaction. The consumer will be redirected back
                      to your website after the completion of the payment." %}

{% include alert.html type="informative" icon="branding_watermark"
                      body="**Seamless View** is our solution for a payment
                      experience that is integrated directly on your website.
                      The payment process will be executed in an `iframe` on
                      your page." %}

### Important steps before you launch Swedbank Pay Trustly Payments at your website

Prior to launching Trustly Payments at your site, make sure that
the payment option is displayed with a Trustly logo, corresponding
to [Trustly's guidelines][trustly-guidelines].

## Payment Type

Trustly is one of the instruments using one-phase payments. The `sale` is done
when the consumer successfully confirms in the app, capturing the funds
instantly. The `abort` operation is still available, but the `cancel` and
`capture` operations are not. The `reversal`, if needed, is done by the
merchant at a later time. Read more about the [different
operations][after-payment] and the [payment resource][payment-resource].

## Languages

The displayed languages that we currently support is English (`en-us`), Norwegian (`nb-no`), Swedish (`sv-se`), and Finish (`fi-fi`).

{% include iterator.html next_href="redirect" next_title="Next: Redirect" %}

[after-payment]: /payments/trustly/after-payment
[callback-api]: /payments/trustly/other-features#callback
[optional-features]: /payments/trustly/optional-features
[payment-resource]: /payments/swish/other-features#payment-resource
[recur]: /payments/trustly/other-features#recur
[redirect]: /payments/trustly/redirect
[purchase]: /payments/trustly/other-features#create-payment
[trustly-guidelines]: https://trustly.com/en/developer/documents
