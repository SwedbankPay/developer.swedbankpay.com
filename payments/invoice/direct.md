---
title: Swedbank Pay Payments Invoice Direct
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

{% include jumbotron.html body="**Direct**
Direct is a payment service where Swedbank Pay helps improve cashflow by
purchasing merchant invoices. Swedbank Pay receives invoice data, which is used
to produce and distribute invoices to the consumer/end-use" %}

## Introduction

1. Collect all purchase information and send it in a `POST` request to
Swedbank Pay.
1. Include personal information (SSN and postal code) and send it to Swedbank Pay.
1. Make a new `POST` request towards Swedbank Pay to retrieve the name and
address of the customer.
1. Create an authorization transaction by calculating the final price / amount.
1. Make a third `POST` request with consumer data as input.
1. Send a  `GET` request with the `paymentID` to get the authorization result
1. Make a Capture by creating a `POST` request

  **By making a Capture, Swedbank Pay will generate
  the invoice to the consumer and the order is ready for shipping.**

## Options before posting a payment

All valid options when posting a payment with operation equal to
`FinancingConsumer`, are described in
[other features][other-features-financing-consumer].

{:.table .table-striped}
| | **Sweden** ![Swedish flag][se-png]| **Norway** ![Norwegian flag][no-png] | **Finland** ![Finish flag][fi-png] |
| `operation` | `FinancingConsumer` | `FinancingConsumer` | `FinancingConsumer` |
| `intent` | `Authorization` | `Authorization` | `Authorization` |
| `currency` | SEK | NOK | EUR |
|`invoiceType` | `PayExFinancingSE` | `PayExFinancingNO` | `PayExFinancingFI` |

* An invoice payment is always two-phased based - you create an Authorize
  transaction, that is followed by a `Capture` or `Cancel` request.
* **Defining CallbackURL**: When implementing a scenario, it is optional to
  set a [CallbackURL][callback-api] in the `POST` request. If `callbackURL`
  is set Swedbank Pay will send a postback request to this URL when the consumer
  has fulfilled the payment.

{% include alert.html type="neutral" icon="info" body="
Note that the invoice will not be created/distributed before you have
made a `capture` request." %}.

The `Capture` , `Cancel`, `Reversal` opions are
described in [optional features][optional-features].
The links will take you directly to the API description for the specific request.

The sequence diagram below shows a high level description of the invoice
process, including the four requests you have to send to Swedbank Pay to create
an authorize transaction for Sweden (SE) and Norway (NO). Note that for Finland
(FI) the process is different as the Merchant needs to send a `POST` request
with the `approvedLegalAddress` (SNN and postal number).

## Invoice flow (SE and NO)

```mermaid
sequenceDiagram
  Consumer->>Merchant: Start purchase (collect SSN and postal number)
  Activate Merchant
  note left of Merchant: First API request
  Merchant->>Swedbank Pay: POST <Invoice Payments> (operation=FinancingConsumer)
  Activate Swedbank Pay

  Swedbank Pay-->>Merchant: payment resource
  note left of Merchant: Second API request
  Merchant-->>Swedbank Pay: POST <approvedLegalAddress> (SNN and postal number)
  Swedbank Pay-->>Swedbank Pay: Update payment with consumer delivery address
  Swedbank Pay-->>Merchant: Approved legaladdress information
  Deactivate Swedbank Pay

  Merchant-->>Consumer: Display all details and final price
  Consumer->>Consumer: Input email and mobile number
  Deactivate Merchant
  Consumer->>Merchant: Confirm purchase
  Activate Merchant

  note left of Merchant: Third API request
  Merchant->>+Swedbank Pay: POST <invoice authorizations> (Transaction Activity=FinancingConsumer)
  Swedbank Pay-->>-Merchant: Transaction result
  note left of Merchant: Fourth API request
  Merchant->>+Swedbank Pay: GET <invoice payments>
  Swedbank Pay-->>-Merchant: payment resource
  Merchant-->>Consumer: Display result
  Deactivate Merchant
```

## Invoice Flow (FI)

```mermaid
sequenceDiagram
  Consumer->>+Merchant: start purchase
  note left of Merchant: First API request
  Merchant->>+Swedbank Pay: POST <Invoice Payments> (operation=FinancingConsumer)
  Swedbank Pay-->>-Merchant: payment resource
  Merchant-->>-Consumer: Display All detail and final price
  Consumer-->>Consumer: Input consumer data
  Consumer->>Merchant: Confirm purchase

  Activate Merchant
  note left of Merchant: Second API request
  Merchant->>+Swedbank Pay: POST <Invoice autorizations> (Transaction Activity=FinancingConsumer)
  Swedbank Pay->>-Merchant: Transaction result
  note left of Merchant: Third API request
  Merchant->>+Swedbank Pay: GET <Invoice payments>
  Swedbank Pay-->>-Merchant: payment resource
  Merchant-->>Consumer: Display result
  Deactivate Merchant
```

[capture]: /payments/credit-card/after-payment#Capture
[fi-png]: /assets/img/fi.png
[financing-invoice-1-png]: /assets/img/checkout/test-purchase.png
[financing-invoice-2-png]: /assets/screenshots/invoice/redirect-view/iframe-verify-data.png
[no-png]: /assets/img/no.png
[se-png]: /assets/img/se.png
[callback-api]: /payments/invoice/other-features#callback
[hosted-view]: /payments/#hosted-view-implementation
[optional-features]: /payments/invoice/optional-features
[other-features-financing-consumer]: /payments/invoice/other-features
[redirect]: /payments/invoice/redirect
[setup-mail]: mailto:setup.ecom@PayEx.com
