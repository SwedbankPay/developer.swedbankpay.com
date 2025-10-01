---
section: Trustly
title: Introduction
redirect_from: /payments/trustly/
description: |
  **Trustly** is the simplest way to
  provide **Direct Bank** payments on your website. Choose between our
  **Redirect** and **Seamless View** integration options.
permalink: /:path/
menu_order: 700
---

{% include alert.html type="informative"
                      icon="cached"
                      body="**Redirect** is the easiest way to do **Direct
                      Bank** payments. Redirect will take the payer to a
                      Swedbank Pay hosted payment page where they can perform a
                      secure transaction. The payer will be redirected back
                      to your website after the completion of the payment." %}

{% include alert.html type="informative" icon="branding_watermark"
                      body="**Seamless View** is our solution for a payment
                      experience that is integrated directly on your website.
                      The payment process will be executed in an `iframe` on
                      your page." %}

## Important Steps Before You Launch Trustly At Your Website

Prior to launching Trustly Payments at your site, make sure that
the payment option is displayed with a Trustly logo, corresponding
to [Trustly's guidelines][trustly-guidelines].

## Payment Type

Trustly is one of the payment methods using one-phase payments. The `sale` is
done when the payer successfully confirms in the app, capturing the funds
instantly. The `abort` operation is still available, but the `cancel` and
`capture` operations are not. The `reversal`, if needed, is done by the merchant
at a later time. Read more about the [different operations][after-payment] and
the [payment resource][payment-resource].

## Languages

The languages we currently support are English (`en-us`), Norwegian (`nb-no`),
Swedish (`sv-se`), and Finish (`fi-fi`).

{% include iterator.html next_href="redirect" next_title="Redirect" %}

[after-payment]: /old-implementations/payment-instruments-v1/trustly/after-payment
[payment-resource]: /old-implementations/payment-instruments-v1/swish/technical-reference/payment-resource
[trustly-guidelines]: https://trustly.com/en/developer/documents
