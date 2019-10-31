---
title: Swedbank Pay Payments Vipps Other Features
sidebar:
  navigation:
  - title: Vipps Payments
    items:
    - url: /payments/vipps
      title: Introduction
    - url: /payments/vipps/redirect
      title: Redirect
    - url: /payments/vipps/seamless-view
      title: Seamless View
    - url: /payments/vipps/after-payment
      title: After After Payment
    - url: /payments/vipps/other-features    
      title: Other Features
---


  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/payment
      title: Checkout Payment
    - url: /checkout/after-payment
      title: Checkout After Payment
    - url: /checkout/other-features
      title: Checkout Other Features

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

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