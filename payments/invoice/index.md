---
title: Swedbank Pay Invoice Payments
sidebar:
  navigation:
  - title: Invoice Payments
    items:
    - url: /payments/invoice
      title: Introduction
    - url: /payments/invoice/redirect
      title: Redirect
    - url: /payments/invoice/seamless-view
      title: Seamless View
    - url: /payments/invoice/direct
      title: Direct
    - url: /payments/invoice/capture
      title: Capture
    - url: /payments/invoice/after-payment
      title: After Payment
    - url: /payments/invoice/other-features
      title: Other Features
---

{% include jumbotron.html body="**Invoice Payments** is one of the easiest
                                payment service where Swedbank Pay helps improve
                                cashflow by purchasing merchant invoices. Choose
                                between our **Direct**, **Redirect** and
                                **Seamless view** integration options." %}

{% include alert.html type="neutral"
                      icon="open_in_browser"
                      body="The **Direct** integration puts the control in your
                      hands. You control the collection of the purchase
                      information and personal information before sending them
                      to us. Swedbank Pay receives invoice data, which is used
                      to produce and distribute invoices to the
                      consumer/end-user." %}

{% include alert.html type="neutral"
                      icon="cached"
                      body="**Redirect** is the easiest way to implement Invoice
                      Payments. Redirect will take your consumer to a Swedbank
                      Pay hosted payment page where they can perform a secure
                      transaction. The consumer will be redirected back to your
                      website after the completion of the payment." %}

{% include alert.html type="neutral"
                      icon="branding_watermark"
                      body="**Seamless View** is our solution for a payment
                      experience that is integrated directly on your website.
                      The payment process will be executed in an `iframe` on
                      your page." %}

### Important steps before you launch Swedbank Pay Invoice Payments at your website

Prior to launching Swedbank Pay Invoice Payments at your site, make sure that
you have done the following:  

1. Sent a merchant logo in .JPG format to the [Swedish
   setup][setup-mail-sweden], [Norwegian setup][setup-mail-norway] or [Finnish
   setup][setup-mail-finland], depending on your country. The logo will be
   displayed on all your invoices. Minimum accepted size is 600x200 pixels, and
   at least 300 DPI.
2. Included a link to "Terms and Conditions" for Invoice.

## API Requests

The API requests are displayed in the purchase flow below.
You can create an invoice payment with the following `operation`
options:

* [Financing Consumer][financing-consumer]
* [Recur][recur]
* [Verify][verify]

Our `payment` example uses the [`FinancingConsumer`][financing-consumer]
operation.

## Invoice flow

This is an example of the Redirect scenario. For other integrations, take a
look at the respective sections. The sequence diagram below shows the two
requests you have to send to Swedbank Pay to make a purchase. The diagram also
shows the steps in a [purchase][purchase] process.

```mermaid
sequenceDiagram
    Consumer->>Merchant: Start purchase
    activate Merchant
    note left of Merchant: First API request
    Merchant->>-Swedbank Pay: POST <Invoice Payment> (operation=FinancingConsumer)
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Consumer: authorization page
    activate Consumer
    note left of Consumer: redirect to Swedbank Pay
    Consumer->>-Swedbank Pay: enter consumer details
    activate Swedbank Pay
    Swedbank Pay-->>-Consumer: redirect to merchant
    activate Consumer
    note left of Consumer: redirect back to Merchant
    Consumer->>Merchant: access merchant page
    activate Merchant
    note left of Merchant: Second API request
    Merchant->>+Swedbank Pay: GET <Invoice payment>
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Consumer: display purchase result
```

{% include iterator.html next_href="redirect" next_title="Next: Redirect" %}

[after-payment]: /payments/invoice/after-payment
[callback-api]: /payments/invoice/other-features#callback
[financing-consumer]: /payments/invoice/other-features#financing-consumer
[no-png]: /assets/img/no.png
[optional-features]: /payments/invoice/optional-features
[recur]: /payments/invoice/other-features#recur
[redirect]: /payments/invoice/redirect
[purchase]: /payments/invoice/other-features#purchase
[se-png]: /assets/img/se.png
[setup-mail-finland]: verkkokauppa.setup@swedbankpay.fi
[setup-mail-norway]: mailto:ehandelsetup@swedbankpay.no
[setup-mail-sweden]: mailto:ehandelsetup@swedbankpay.se
[verify]: /payments/invoice/other-features#verify
