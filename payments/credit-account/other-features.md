---
title: Swedbank Pay Payments Credit Account Other Features
sidebar:
  navigation:
  - title: Credit Account Payments
    items:
    - url: /payments/credit-account/
      title: Introduction
    - url: /payments/credit-account/after-payment
      title: After Payment
    - url: /payments/credit-account/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

{% include settlement-reconciliation.md %}

{% include payment-link.md %}

{% include subsite.md %}

## Problem messages

When performing unsuccessful operations, the eCommerce API will respond with a problem message. We generally use the problem message type and status code to identify the nature of the problem. The problem name and description will often help narrow down the specifics of the problem.

For general information about problem messages and error handling, visit error handling and problem details[technical-reference-problem-details].


## Error types from PayEx Invoice and third parties

All invoice error types will have the following URI in front of type: https://api.payex.com/psp/errordetail/invoice/<errorType>

| Type |	Status	| 
| externalerror |	500 |	No error code |
| inputerror |	400 |	10 - ValidationWarning |
| inputerror |	400 |	30 - ValidationError | 
| inputerror | 400 |	3010 - ClientRequestInvalid |
| externalerror |	502 |	40 - Error |
| externalerror |	502 |	60 - SystemError |
| externalerror |	502 |	50 - SystemConfigurationError |
| externalerror |	502 |	9999 - ServerOtherServer |
| forbidden |	403 |	Any other error code |

[technical-reference-problem-details]: #