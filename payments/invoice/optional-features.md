---
title: Swedbank Pay Payments Invoice After Payments
sidebar:
  navigation:
  - title: Payments
    items:
    - url: /payments/
      title: Introduction
    - url: /payments/credit-account
      title: Credit Account Payments
    - url: /payments/credit-card
      title: Credit Card Payments
    - url: /payments/invoice
      title: Invoice Payments
    - url: /payments/invoice/redirect
      title: Invoice Payments Redirect
    - url: /payments/invoice/seamless-view
      title: Invoice Payments Seamless View
    - url: /payments/invoice/after-payment
      title: Invoice Payments After Payment
    - url: /payments/invoice/optional-features
      title: Invoice Payments Optional Features
    - url: /payments/direct-debit
      title: Direct Debit Payments
    - url: /payments/mobile-pay
      title: Mobile Pay Payments
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/vipps
      title: Vipps Payments
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

## API requests

The API requests are displayed in the [invoice flow][invoice-flow]. The options you can choose from when creating a payment with key operation set to Value FinancingConsumer are listed below. The general REST based API model is described in the [technical reference][technical-reference].

### Options before posting a payment

{:.table .table-striped}
| **POST Request** |	Finland ![Finish flag][fi-png]  |
| **Operation** |	FinancingConsumer |
| **Intent** | Authorization |
| **Currency** | EUR |
| **InvoiceType** |	PayExFinancingFI |

*   An invoice payment is always two-phased based -  you create an Authorize transaction, that is followed by a Capture or Cancel request.
*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL][callback-url] in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.][callback-api]


### Problem messages

When performing unsuccessful operations, the eCommerce API will respond with a problem message. We generally use the problem message type and status code to identify the nature of the problem. The problem name and description will often help narrow down the specifics of the problem.

For general information about problem messages and error handling,[visit error handling and problem details][technical-reference-problem-details].

#### Error types from PayEx Invoice and third parties 

All invoice error types will have the following URI in front of type: `https://api.payex.com/psp/errordetail/invoice/<errorType>`

{:.table .table-striped}
| **Type** | **Status** | 
| `externalerror` | 500 | No error code
| `inputerror` | 400 | 10 - ValidationWarning
| `inputerror` | 400 | 30 - ValidationError
| `inputerror` | 400 | 3010 - ClientRequestInvalid
| `externalerror` | 502 | 40 - Error
| `externalerror` | 502 | 60 - SystemError
| `externalerror` | 502 | 50 - SystemConfigurationError
| `externalerror` | 502 | 9999 - ServerOtherServer
| `forbidden` | 403 | Any other error code

{% include payment-menu-styling.md %}

{% include settlement-reconciliation.md %}

{% include payment-link.md %}

[fi-png]: /assets/img/fi.png
[invoice-flow]: /payments/invoice/index/#invoice-flow
[technical-reference]: #
[callback-url]: #
[callback-api]: #
[technical-reference-problem-details]: #
