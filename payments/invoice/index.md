---
title: Swedbank Pay Invoice Payments
sidebar:
  navigation:
  - title: Invoice Payments
    items:
    - url: /payments/invoice
      title: Introduction
    - url: /payments/invoice/direct
      title: Direct
    - url: /payments/invoice/redirect
      title: Redirect
    - url: /payments/invoice/seamless-view
      title: Seamless View
    - url: /payments/invoice/after-payment
      title: After Payment
    - url: /payments/invoice/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="This section of the Developer Portal is under construction and
                      should not be used to integrate against
                      Swedbank Pay's APIs yet." %}

{% include jumbotron.html body="**Invoice Payments** is one of the most easiest
and safest payment service where Swedbank Pay helps improve cashflow by
purchasing merchant invoices.
Choose between our **Direct**, **Redirect** and **Seamless view**
integration options." %}

{% include alert.html type="neutral"
                      icon="open_in_browser"
                      body="**Direct** is a payment service where Swedbank Pay
                      helps improve cashflow by purchasing merchant invoices.
                      Swedbank Pay receives invoice data, which is used to
                      produce and distribute invoices to the consumer/end-use." %}

{% include alert.html type="neutral"
                      icon="cached"
                      body="**Redirect** is the easiest way to implement Invoice
                      Payments. Redirect will take the consumer to a Swedbank
                      Pay hosted payment page where they can perform a safe
                      transaction. The consumer will be redirected back to your
                      website after the completion of the payment." %}

{% include alert.html type="neutral"
                      icon="branding_watermark"
                      body="**Seamless View** is our solution for a payment
                      experience that is integrated directly on your website.
                      The payment process will be executed in an `iframe` on
                      your page." %}

### Important steps before you launch Swedbank Pay Faktura at your website

Prior to launching Swedbank Pay Faktura at your site, make sure that you
have done the following:  

1. Sent a merchant logo in .JPG format to [setup.ecom@payex.com][setup-mail].
    The logo will be displayed on all your invoices. Minimum accepted size is
    600x200 pixels, and at least 300 DPI.
2. Included a link to "Terms and Conditions" for Swedbank Pay Faktura.

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).
You can create an invoice payment with the following `operation`
options:

* [Financing Consumer][other-features-financing-consumer]
* [Recur][recur]
* [Verify][verify]

Our `payment` example uses the [`FinancingConsumer`]
[other-features-financing-consumer] value.

## Invoice flow

The sequence diagram below shows the two requests you have to send to Swedbank
Pay to make a purchase.
The diagram also shows in high level,
the sequence of the process of a complete purchase.

```mermaid
sequenceDiagram
    Consumer->>Merchant: Start purchase
    activate Merchant
    note left of Merchant: First API request
    Merchant->>+Swedbank Pay: POST <Invoice Payment> (operation=FinancingConsumer)
    Swedbank Pay-->>-Merchant: payment resource
    Merchant-->>-Consumer: authorization page
    note left of Consumer: redirect to Swedbank Pay
    Consumer->>+Swedbank Pay: enter consumer details
    Swedbank Pay-->>-Consumer: redirect to merchant
    note left of Consumer: redirect back to Merchant
    Consumer->>Merchant: access merchant page
    activate Merchant
    note left of Merchant: Second API request
    Merchant->>+Swedbank Pay: GET <Invoice payment>
    Swedbank Pay-->>-Merchant: payment resource
    Merchant-->>Consumer: display purchase result
    deactivate Merchant
```

[after-payment]: /payments/invoice/after-payment
[no-png]: /assets/img/no.png
[se-png]: /assets/img/se.png
[fi-png]: /assets/img/fi.png
[callback]: /payments/invoice/other-features#callback
[cancel]: /payments/invoice/after-payment#cancellations
[capture]: /payments/invoice/after-payment#captures
[other-features-financing-consumer]:/payments/invoice/other-features#create-authorization-transaction
[payout]: /payments/card/other-features/#payout
[purchase]: /payments/card/other-features/#purchase
[verify]: /payments/card/other-features/#verify
[recur]: /payments/card/other-features/#recur
[user-agent-def]: https://en.wikipedia.org/wiki/User_agent
[payee-reference]: /payments/invoice/other-features#payee-info
