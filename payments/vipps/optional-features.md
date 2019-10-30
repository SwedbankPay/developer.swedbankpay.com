---
title: Swedbank Pay Payments Vipps Optional Features
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
    - url: /payments/direct-debit
      title: Direct Debit Payments
    - url: /payments/mobile-pay
      title: Mobile Pay Payments
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/swish/redirect
      title: Swish Redirect
    - url: /payments/swish/seamless-view
      title: Swish Seamless View
    - url: /payments/swish/after-payment
      title: Swish After After Payment
    - url: /payments/swish/optional-features
      title: Swish Optional Features
    - url: /payments/vipps
      title: Vipps Payments
    - url: /payments/vipps/redirect
      title: Vipps Redirect
    - url: /payments/vipps/seamless-view
      title: Vipps Seamless View
    - url: /payments/vipps/after-payment
      title: Vipps After After Payment
    - url: /payments/vipps/optional-features    
      title: Vipps Optional Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}


{% include payment-menu-styling.md %}

{% include settlement-reconciliation.md %}

{% include one-click-payments.md %}

{% include payment-link.md %}

{% include recurring-card-payments.md %}

{% include subsite.md %}

## Problem messages

When performing unsuccessful operations, the eCommerce API will respond with a problem message. We generally use the problem message type and status code to identify the nature of the problem. The problem name and description will often help narrow down the specifics of the problem.

For general information about problem messages and error handling, [visit error handling and problem details][technical-reference-problems].  

### Error types from Vipps (Init-call)

All Vipps error types will have the following URI in front of type: `https://api.payex.com/psp/errordetail/vipps/<errorType>`

{:.table .table-striped}
| **Type** | **Status** | Note 
| *VIPPS_ERROR* | 403 | All errors

### Error types from Vipps (Callback)

All Vipps error types will have the following URI in front of type: `https://api.payex.com/psp/errordetail/vipps/<errorType>`

{:.table .table-striped}
| **Type** | **Status** | Note 
| *VIPPS_DECLINED* | 400 | Any status that is not YES

### Error types from Acquirer

All Vipps error types will have the following URI in front of type: `https://api.payex.com/psp/errordetail/vipps/<errorType>`

{:.table .table-striped}
| **Type** | **Status** | Note 
| *CARD_BLACKLISTED* | 400 | 
| *PAYMENT_TOKEN_ERROR* | 403 | 
| *CARD_DECLINED* | 403 | 
| *ACQUIRER_ERROR* | 403 | 
| *ACQUIRER_CARD_BLACKLISTED* | 403 | 
| *ACQUIRER_CARD_EXPIRED* | 403 | 
| *ACQUIRER_CARD_STOLEN* | 403 | 
| *ACQUIRER_INSUFFICIENT_FUNDS* | 403 | 
| *ACQUIRER_INVALID_AMOUNT* | 403 | 
| *ACQUIRER_POSSIBLE_FRAUD* | 403 | 
| *FRAUD_DETECTED* | 403 | 
| *BAD_REQUEST* | 500 | 
| *INTERNAL_SERVER_ERROR* | 500 | 
| *BAD_GATEWAY* | 502 | 
| *ACQUIRER_GATEWAY_ERROR* | 502 | 
| *ACQUIRER_GATEWAY_TIMEOUT* | 504 | 
| *UNKNOWN_ERROR* | 500 | 

[technical-reference-problems]: #