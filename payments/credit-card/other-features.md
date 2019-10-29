---
title: Swedbank Pay Payments Credit Card
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
    - url: /payments/credit-card/after-payment
      title: Credit Card After Payments
    - url: /payments/credit-card/other-features
      title: Credit Card Other Features
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



## Recur

A `recur` payment is a payment that references a `recurrenceToken` created through a previous payment in order to charge the same card. Use the [expand][expansion] request parameter to get a response that includes one or more expanded sub-resources inlined.

{:.code-header}
**Request**

```HTTP
POST /psp/creditcard/payments HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
   "payment": {
       "operation": "Recur",
       "intent": "Authorization|AutoCapture",
       "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
       "currency": "NOK",
       "amount": 1500,
       "vatAmount": 0,
       "description": "Test Recurrence",
       "userAgent": "Mozilla/5.0...",
       "language": "nb-NO",
       "urls": {
           "callbackUrl": "http://test-dummy.net/payment-callback"
        },
       "payeeInfo": {
           "payeeId": "12345678-1234-1234-1234-123456789012",
           "payeeReference": "CD1234",
           "payeeName": "Merchant1",
           "productCategory": "A123",
           "orderReference": "or-12456",
           "subsite": "MySubsite"
        }
    }
}
```

{% include one-click-payments.md %}



[expansion]: #

