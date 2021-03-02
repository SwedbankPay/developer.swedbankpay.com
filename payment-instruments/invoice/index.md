---
section: Invoice
title: Introduction
redirect_from: /payments/invoice/
estimated_read: 2
description: |
  **Invoice** is one of the easiest
  payment services where Swedbank Pay helps improve cashflow by purchasing
  merchant invoices. Choose between our **Direct**, **Redirect** and
  **Seamless view** integration options.
permalink: /:path/
menu_order: 400
---

{% include alert.html type="informative"
                      icon="open_in_browser"
                      body="The **Direct** integration puts the control in your
                      hands. You control the collection of the purchase
                      information and personal information before sending them
                      to us. Swedbank Pay receives invoice data, which is used
                      to produce and distribute invoices to the
                      payer." %}

{% include alert.html type="informative"
                      icon="cached"
                      body="**Redirect** is the easiest way to implement Invoice
                      Payments. Redirect will take your payer to a Swedbank
                      Pay hosted payment page where they can perform a secure
                      transaction. The payer will be redirected back to your
                      website after the completion of the payment." %}

{% include alert.html type="informative"
                      icon="branding_watermark"
                      body="**Seamless View** is our solution for a payment
                      experience that is integrated directly on your website.
                      The payment process will be executed in an `iframe` on
                      your page." %}

### Important steps before you launch Swedbank Pay Invoice Payments at your website

Prior to launching Swedbank Pay Invoice Payments at your site, make sure that
you have done the following:

1.  Sent a merchant logo in .JPG format to the [Swedish
    setup][setup-mail-sweden], [Norwegian setup][setup-mail-norway] or [Finnish
    setup][setup-mail-finland], depending on your country. The logo will be
    displayed on all your invoices. Minimum accepted size is 600x200 pixels, and
    at least 300 DPI.
2.  Included a link to "Terms and Conditions" for Invoice.

## API Requests

The API requests are displayed in the purchase flow below.
You can create an invoice payment with the following `operation`
options:

*   [Financing Consumer][financing-consumer]
*   [Recur][recur]
*   [Verify][verify]

Our `payment` example uses the [`FinancingConsumer`][financing-consumer]
operation.

{:.text-center}
![screenshot of the first Invoice redirect page][fincon-invoice-redirect]{:height="725px" width="475px"}

{% include languages.md %}

## Invoice flow

This is an example of the Redirect scenario. For other integrations, take a
look at the respective sections. The sequence diagram below shows the two
requests you have to send to Swedbank Pay to make a purchase. The diagram also
shows the steps in a [purchase][purchase] process.

```mermaid
sequenceDiagram
    Payer->>Merchant: Start purchase
    activate Merchant
    note left of Merchant: First API request
    Merchant->>-Swedbank Pay: POST <Invoice Payment> (operation=FinancingConsumer)
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Payer: authorization page
    activate Payer
    note left of Payer: redirect to Swedbank Pay
    Payer->>-Swedbank Pay: enter payer details
    activate Swedbank Pay
    Swedbank Pay-->>-Payer: redirect to merchant
    activate Payer
    note left of Payer: redirect back to Merchant
    Payer->>Merchant: access merchant page
    activate Merchant
    note left of Merchant: Second API request
    Merchant->>+Swedbank Pay: GET <Invoice payment>
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Payer: display purchase result
```

{% include iterator.html next_href="redirect" next_title="Redirect" %}

[after-payment]: /payment-instruments/invoice/after-payment
[callback-api]: /payment-instruments/invoice/features/technical-reference/callback
[financing-consumer]: /payment-instruments/invoice/other-features#financing-consumer
[optional]: /payment-instruments/invoice/optional
[fincon-invoice-redirect]: /assets/img/payments/fincon-invoice-redirect-first-en.png
[recur]: /payment-instruments/invoice/features/optional/recur
[redirect]: /payment-instruments/invoice/redirect
[purchase]: /payment-instruments/invoice/features/technical-reference/create-payment
[setup-mail-finland]: mailto:verkkokauppa.setup@swedbankpay.fi
[setup-mail-norway]: mailto:ehandelsetup@swedbankpay.no
[setup-mail-sweden]: mailto:ehandelsetup@swedbankpay.se
[verify]: /payment-instruments/invoice/features/optional/verify
