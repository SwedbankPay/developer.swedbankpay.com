---
title: Swedbank Pay Payments Credit Account
sidebar:
  navigation:
  - title: Payments
    items:
    - url: /payments/
      title: Introduction
    - url: /payments/credit-account
      title: Credit Account
    - url: /payments/credit-account/redirect
      title: Credit Account Redirect
    - url: /payments/credit-account/seamless-view
      title: Credit Account Seamless View
    - url: /payments/credit-account/after-payment
      title: Credit Account After Payment
    - url: /payments/credit-account/optional-features
      title: Credit Account Optional Features
    - url: /payments/credit-card
      title: Credit Card Payments
    - url: /payments/invoice
      title: Invoice Payments
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


{% include payment-menu-styling.md %}

{% include settlement-reconciliation.md %}

{% include payment-link.md %}

{% include subsite.md %}

## Problem messages

When performing unsuccessful operations, the eCommerce API will respond with a problem message. We generally use the problem message type and status code to identify the nature of the problem. The problem name and description will often help narrow down the specifics of the problem.

For general information about problem messages and error handling, visit error handling and problem details.


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