---
title: Swedbank Pay Credit Payments
sidebar:
  navigation:
  - title: Credit Payments
    items:
    - url: /payments/credit/
      title: Introduction
    - url: /payments/credit/redirect
      title: Redirect
    - url: /payments/credit/after-payment
      title: After Payment
    - url: /payments/credit/other-features
      title: Other Features
---

{% include alert-review-section.md %}

{% include jumbotron.html body="**Credit Payments** is an online payment
                                instrument allowing payers to split a purchase
                                into several payments. Choose **Redirect**
                                to get started on the integration." %}

{% include alert.html type="neutral"
                      icon="cached"
                      body="**Redirect** is the way to implement Credit Payments.
                      Redirect will take your consumer to a Swedbank
                      Pay hosted payment page where they can perform a secure
                      transaction. The consumer will be redirected back to your
                      website after the completion of the payment." %}

{% include alert.html type="info"
                      icon="info"
                      body="Swedbank Pay Credit Account is only available for
                      swedish merchants at the moment." %}

## Introduction

* When properly set up in your merchant/webshop site and the payer starts the
  purchase process, you need to make a `POST` request towards Swedbank Pay with
  your Purchase information. This will generate a payment object with a unique
  `paymentID`. You will receive a **redirect URL** to a Swedbank Pay payment
  page.
* You need to redirect the payer's browser to that specified URL so that the
  payer can enter the payment details in a secure Swedbank Pay environment.
* Swedbank Pay will redirect the payer's browser to - one of two specified URLs,
  depending on whether the payment session is followed through completely or
  cancelled beforehand. Please note that both a successful and rejected payment
  reach completion, in contrast to a cancelled payment.
* When you detect that the payer reach your `completeUrl` , you need to do a
  `GET` request to receive the state of the transaction, containing the
  `paymentID` generated in the first step, to receive the state of the
  transaction.

## Credit Payments flow

This is an example of the Credit Payments flow in the Redirect scenario.
For other integrations, take a look at the respective sections.
The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase. The diagram also
shows the steps in a [purchase][purchase] process.

```mermaid
sequenceDiagram
    Consumer->>Merchant: Start purchase
    activate Merchant
    note left of Merchant: First API request
    Merchant->>-Swedbank Pay: POST <Credit Payments>
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
    Merchant->>+Swedbank Pay: GET <Credit payment>
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Consumer: display purchase result
```

{% include iterator.html
        prev_href="../"
        prev_title="Back: Payments"
        next_href="after-payment"
        next_title="Next: After Payment" %}
