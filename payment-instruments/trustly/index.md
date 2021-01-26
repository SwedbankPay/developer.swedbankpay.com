---
section: Trustly
title: Introduction
redirect_from: /payments/trustly/
estimated_read: 2
description: |
  **Trustly** is the simplest way to
  provide **Direct Bank** payments on your website. Choose between our
  **Redirect** and **Seamless View** integration options.
menu_order: 800
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


### Important steps before you launch Swedbank Pay Trustly Payments at your website

Prior to launching Trustly Payments at your site, make sure that
the payment option is displayed with a Trustly logo, corresponding
to [Trustly's guidelines][trustly-guidelines].

## Payment Type

Trustly is one of the instruments using one-phase payments. The `sale` is done
when the payer successfully confirms in the app, capturing the funds
instantly. The `abort` operation is still available, but the `cancel` and
`capture` operations are not. The `reversal`, if needed, is done by the
merchant at a later time. Read more about the [different
operations][after-payment] and the [payment resource][payment-resource].

## Languages

The displayed languages that we currently support is English (`en-us`), Norwegian (`nb-no`), Swedish (`sv-se`), and Finish (`fi-fi`).

## Banks

Trustly is supported by the following Finnish and Swedish banks as of August 14.
2020.

### Finland {% flag fi %}

{:.table .table-striped}
|        Bank         | Supported in eCom as of August 2020 | Instant Credit Notification |
| :-----------------: | :---------------------------------: | :-------------------------: |
|       Nordea        |          {% icon check %}           |      {% icon check %}       |
|        Aktia        |          {% icon check %}           |      {% icon check %}       |
|     OP-Pohjola      |          {% icon check %}           |      {% icon check %}       |
|    Säästöpankki     |          {% icon check %}           |      {% icon check %}       |
|     POP Pankki      |          {% icon check %}           |      {% icon check %}       |
|    Handelsbanken    |          {% icon check %}           |      {% icon check %}       |
|    Ålandsbanken     |          {% icon check %}           |      {% icon check %}       |
|      S-Pankki       |          {% icon check %}           |      {% icon check %}       |
| Danske Bank (Sampo) |          {% icon check %}           |      {% icon check %}       |
|  Oma Säästöpankki   |          {% icon check %}           |      {% icon check %}       |

### Sweden {% flag se %}

{:.table .table-striped}
| Bank             | Supported in eCom as of August 2020 | Instant Credit Notification |
| :--------------- | :---------------------------------: | :-------------------------: |
| Swedbank         |          {% icon check %}           |      {% icon check %}       |
| Nordea           |          {% icon check %}           |      {% icon check %}       |
| Handelsbanken    |          {% icon check %}           |      {% icon check %}       |
| SEB              |          {% icon check %}           |      {% icon check %}       |
| Danske Bank      |                                     |      {% icon check %}*      |
| Skandiabanken    |          {% icon check %}           |      {% icon check %}       |
| Länsforsäkringar |          {% icon check %}           |      {% icon check %}       |
| ICA Banken       |                                     |                             |
| Forex            |                                     |                             |
| Sparbanken Syd   |          {% icon check %}           |      {% icon check %}       |
| Marginalen Bank  |          {% icon check %}           |      {% icon check %}       |

*Danske Bank in Sweden offers instant credit notifications up to SEK 2500.


{% include iterator.html next_href="redirect" next_title="Redirect" %}

[after-payment]: /payment-instruments/trustly/after-payment
[callback-api]: /payment-instruments/trustly/other-features#callback
[optional]: /payment-instruments/trustly/optional
[payment-resource]: /payment-instruments/swish/other-features#payment-resource
[recur]: /payment-instruments/trustly/other-features#recur
[redirect]: /payment-instruments/trustly/redirect
[purchase]: /payment-instruments/trustly/other-features#create-payment
[trustly-guidelines]: https://trustly.com/en/developer/documents
