---
title: Set Payment Instrument
permalink: /:path/setpaymentinstrument/
description: |
    SetPaymentInstrument starts a payment for supplied paymentInstrument.
---
### Method Signature

*   bool SetPaymentInstrument(string paymentInstrument)

### Description

SetPaymentInstrument starts a payment for supplied paymentInstrument. This method has to be called before PaymentAsync or RefundAsync and cannot be combined with GetPaymentInstrument.

Using [`TransactionSetup.PaymentInstrument`][transactionsetup] when starting a [Payment][payment] or [Refund][refund] is an other way to accomplish the same thing.

Prefix and supplied PAN must be registred in the terminal setup and may not be a PCI regulated card. The normal usage is for giftcards or card numbers that are created on site such as financing.

### Parameter

`string` PaymentInstrument - format is pan and expiry date separated by an equal sign. "PAN=MMYY"

{% include alert.html type="informative" icon="info" header="There is an alternative"
body="It is also possible to pass the payment instrument in a `TransactionSetup` object when calling Payment" %}

[transactionsetup]: /pax-terminal/NET/includes/transactionsetup
[payment]: /pax-terminal/NET/SwpTrmLib/Methods/essential/paymentasync
[refund]: /pax-terminal/NET/SwpTrmLib/Methods/essential/refundasync
