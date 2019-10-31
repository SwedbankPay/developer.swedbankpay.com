---
title: Swedbank Pay Payments Swish Other Features
sidebar:
  navigation:
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
  - title: Payments
    items:
    - url: /payments/
      title: Introduction
    - url: /payments/credit-card
      title: Credit Card Payments
    - url: /payments/credit-card/redirect
      title: Credit Card Redirect
    - url: /payments/credit-card/seamless-view
      title: Credit Card Seamless View
    - url: /payments/credit-card/after-payment
      title: Credit Card After Payments
    - url: /payments/credit-card/other-features
      title: Credit Card Other Features
    - url: /payments/invoice
      title: Invoice Payments
    - url: /payments/invoice/redirect
      title: Invoice Redirect
    - url: /payments/invoice/seamless-view
      title: Invoice Seamless View
    - url: /payments/invoice/after-payment
      title: Invoice After Payment
    - url: /payments/invoice/other-features
      title: Invoice Other Features
    - url: /payments/mobile-pay
      title: Mobile Pay Payments
    - url: /payments/mobile-pay/redirect
      title: Mobile Pay Redirect
    - url: /payments/mobile-pay/seamless-view
      title: Mobile Pay Seamless View
    - url: /payments/mobile-pay/after-payment
      title: Mobile Pay After Payment
    - url: /payments/mobile-pay/other-features
      title: Mobile Pay Other Features
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/swish/redirect
      title: Swish Redirect
    - url: /payments/swish/seamless-view
      title: Swish Seamless View
    - url: /payments/swish/after-payment
      title: Swish After Payment
    - url: /payments/swish/other-features
      title: Swish Other Features
    - url: /payments/vipps
      title: Vipps Payments
    - url: /payments/vipps/redirect
      title: Vipps Redirect
    - url: /payments/vipps/seamless-view
      title: Vipps Seamless View
    - url: /payments/vipps/after-payment
      title: Vipps After After Payment
    - url: /payments/vipps/other-features    
      title: Vipps Other Features
    - url: /payments/direct-debit
      title: Direct Debit Payments
    - url: /payments/direct-debit/redirect
      title: Direct Debit Redirect
    - url: /payments/direct-debit/seamless-view
      title: Direct Debit Seamless View
    - url: /payments/direct-debit/after-payment
      title: Direct Debit After Payments
    - url: /payments/direct-debit/other-features
      title: Direct Debit Other Features
    - url: /payments/credit-account
      title: Credit Account
    - url: /payments/credit-account/after-payment
      title: Credit Account After Payment
    - url: /payments/credit-account/other-features
      title: Credit Account Other Features
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/test-data
      title: Test Data
    - url: /resources/demoshop
      title: Demoshop
---

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

#### Error types from Swish and third parties 

All Swish error types will have the following URI in front of type: `https://api.payex.com/psp/<errordetail>/swish`

{:.table .table-striped}
| **Type** | **Status** | **Error code** | **Details**
| *externalerror* | 500 | No error code| 
| *inputerror* | 400 | FF08 | Input validation failed (PayeeReference) 
| *inputerror* | 400 | BE18 | Input validation failed (Msisdn) 
| *inputerror* | 400 | PA02 | Input validation failed (Amount) 
| *inputerror* | 400 | AM06 | Input validation failed (Amount) 
| *inputerror* | 400 | AM02 | Input validation failed (Amount)
| *inputerror* | 400 | AM03 | Input validation failed (Currency) 
| *inputerror* | 500 | RP02 | Input validation failed (Description)
| *configurationerror* | 403 | RP01 | Configuration of contract is not correct, or missing settings
| *configurationerror* | 403 | ACMT07 | Configuration of contract is not correct, or missing settings 
| *systemerror* | 500 | RP03 | Unable to complete operation (Invalid callback url) 
| *swishdeclined* | 403 | RP06 | Third party returned error (Duplicate swish payment request) 
| *swishdeclined* | 403 | ACMT03 | Third party returned error (Swish msisdn not enrolled)
| *swishdeclined* | 403 | ACMT01 | Third party returned error (Swish msisdn not enrolled)
| *swishdeclined* | 403 | RF02 | Third party returned error (Reversal declined due to Sale transaction being over 13 months old)
| *swishdeclined* | 403 | RF04 | Third party returned error (Msisdn has changed owner (organization) between sale and reversal)
| *swishdeclined* | 403 | RF06 | Third party returned error (Msisdn has changed owener (SSN) between sale and reversal)
| *swishdeclined* | 403 | RF07 | Third party returned error (Swish rejected transaction)
| *swishdeclined* | 403 | FF10 | Third party returned error (Bank rejected transaction)
| *usercancelled* | 403 | BANKIDCL | Cancelled by user 
| *swishdeclined* | 403 | TM01 | Payment timed out (User din't confirm payment in app)
| *swishdeclined* | 403 | DS24 |  Payment timed out (Bank didn't respond).
| *systemerror* | 500 | Any other error code|  

[technical-reference-problems]: #