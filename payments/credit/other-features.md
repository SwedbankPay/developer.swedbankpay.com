---
title: Swedbank Pay Credit Payments – Other Features
sidebar:
  navigation:
  - title: Credit Payments
    items:
    - url: /payments/credit/
      title: Introduction
    - url: /payments/credit/after-payment
      title: After Payment
    - url: /payments/credit/other-features
      title: Other Features
---

{% include alert-review-section.md %}

{% include jumbotron.html body="Welcome to Other Features - a subsection of
Credit Account Payments. This section has extented code examples and features
that were not covered by the previous subsections." %}

## Payment resource

{% include payment-resource.md  payment-instrument="creditaccount" %}

{% include transactions-reference.md payment-instrument="creditaccount" %}

{% include callback-reference.md  payment-instrument="creditaccount" %}

## PayeeInfo

{% include payee-info.md %}

{% include settlement-reconciliation.md %}

## Problem messages

When performing unsuccessful operations, the eCommerce API will respond with
a problem message. We generally use the problem message type and status code to
identify the nature of the problem. The problem name and description will often
help narrow down the specifics of the problem.

### Error types

All error types will have the following URI in front of type:
`https://api.payex.com/psp/errordetail/careditaccount/<error-type>`

{:.table .table-striped}
| Type            | Status | Description                   |
| :-------------- | :----- | :---------------------------- |
| `externalerror` | `500`  | No error code                 |
| `inputerror`    | `400`  | 10 - ValidationWarning        |
| `inputerror`    | `400`  | 30 - ValidationError          |
| `inputerror`    | `400`  | 3010 - ClientRequestInvalid   |
| `externalerror` | `502`  | 40 - Error                    |
| `externalerror` | `502`  | 60 - SystemError              |
| `externalerror` | `502`  | 50 - SystemConfigurationError |
| `externalerror` | `502`  | 9999 - ServerOtherServer      |
| `forbidden`     | `403`  | Any other error code          |

{% include iterator.html
        prev_href="after-payment"
        prev_title="Back: After Payment"%}
