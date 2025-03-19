---
permalink: /:path/nexoimplementation/
title: Implementation of nexo
description: The nexo implementation for a business app is just a few messages.
menu_order: 180
---

## Implementing nexo When On Device

Implementing nexo for On Device is probably the simplest implementation since it is the `client only` mode and just a few messages. Refer to the documentation on this site for [`nexo Retailer`][nexoretailer] but ignore the HTTP part since the nexo messages are passed in intents.

### [LoginRequest][login]

The LoginRequest is needed to be able to start communicating with the payment app. Once login is successful several payments can be done until the terminal reboots or software restarts. An attempt to make a `PaymentRequest` before successful login will give a failure response with `ErrorCondition` set to `NotAllowed`.

### [PaymentRequest][payment]

PaymentRequest is used for both purchase and refund. The PaymentResponse contains the receipt information.
The sad part is that according to branding regulations less secure, purchases that need to be signed by cardholder need to be implemented although they rarely occur. Please read about [CVM signature][cvmsign].

### [ReversalRequest][reversal]

ReversalRequest can only be made on the very last transaction if it was successful. There is a big difference in reversals versus refunds, where reversal will clear the booked money latest the next day while refund may take business days before the money is back on the customer's account. Reversal is a must for the cvm signature test case in if the cardholder is unable to identify himself or the signature is rejected.

### [PrintRequest][print]

PrintRequest is used for printing receipts via the payment app.

### [TransactionStatusRequest][transactionstatus]

TransactionStatusRequest is used for retreiving a copy of a result for a transaction. This may be useful if out of paper or any other malfunction causing the original result to be lost.

### [LogoutRequest][logout].

LogoutRequest is the least important to implement since a reboot of the terminal will cause the same thing.

{% include iterator.html next_href="/pax-terminal/OnDevice" next_title="Back" %}

[login]: /pax-terminal/Nexo-Retailer/Quick-guide/first-message
[payment]: /pax-terminal/Nexo-Retailer/Quick-guide/make-payment
[reversal]: /pax-terminal/Nexo-Retailer/Quick-guide/reversal
[print]: /pax-terminal/Nexo-Retailer/use-a920-printer
[transactionstatus]: /pax-terminal/Nexo-Retailer/Quick-guide/transactionstatus
[logout]: /pax-terminal/Nexo-Retailer/Quick-guide/logout
[nexoretailer]: /pax-terminal/Nexo-Retailer
[cvmsign]: /pax-terminal/Nexo-Retailer/Quick-guide/payment-response/#for-cvm-method-signature-client-only-mode
