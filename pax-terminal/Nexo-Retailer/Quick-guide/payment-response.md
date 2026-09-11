---
title: PaymentResponse
permalink: /:path/payment-response/
description: |
 Payment response holds the receipt data
menu_order: 45
---
A payment is approved if the `Result` attribute of the `/PaymentResponse/Response` element is `Success`.
For all unapproved payments the same attribute is `Failure` and the actual response code is found in the receipt data if wanted.
Depending on why a payment is unapproved the response may not contain a receipt. However, make sure to always make a payment terminal receipt available if a card has been used.

The payment response carries both a merchant receipt and a customer receipt. The customer receipt should always be used. The merchant receipt is used if the receipt needs to be signed by the customer.
The receiptdata is a Base64 encoded JSON structure.

If the merchant is set up for loyalty handling via the SwedbankPay host, the payment response may contain a `LoyaltyResult` as well like shown below.

{% include pax-payment-response.md %}

Please read about responses for [signature approval][cvmsignature].

{% include iterator.html prev_href="/pax-terminal/Nexo-Retailer/Quick-guide/make-payment" prev_title="Back to PaymentRequest" %}
{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/reversal" next_title="Reverse successful transaction" %}
[cvmsignature]: /pax-terminal/Nexo-Retailer/Quick-guide/cvm_signature