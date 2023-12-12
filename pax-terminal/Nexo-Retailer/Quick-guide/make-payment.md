---
title: Make a Payment
permalink: /:path/make-payment/
description: |
 Once there is a Login Session it is possible to make a Payment transaction. The PaymentRequest is used for purchase as well as refund.
menu_order: 40
---
## PaymentRequest

Send a PaymentRequest to make a payment or refund when there is a `LoginSession`.
Make sure to save the `MessageHeader` since that is needed if abort is needed.

{% include pax-payment-request.md %}

## Following a PaymentRequest

{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/payment-response" next_title="Payment response is received" %}
{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/abortpayment" next_title="Abort payment with an AbortRequest" %}
{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/transactionstatus" next_title="Transaction status is asked for"%}
{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/first-message" next_title="LoginRequest if all else fail" %}
