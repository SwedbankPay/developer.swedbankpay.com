---
title: SetPaymentInstrument
description: |
    SetPaymentInstrument starts a payment for supplied paymentInstrument.
---
### Method Signature

*   bool SetPaymentInstrument(string paymentInstrument)

### Description

SetPaymentInstrument starts a payment for supplied paymentInstrument. This method has to be called before PaymentAsync or RefundAsync and cannot be combined with GetPaymentInstrument.

Prefix and supplied PAN must be registred in the terminal setup and may not be a PCI regulated card. The normal usage is for giftcards or card numbers that are created on site such as financing.

### Parameter

`string` PaymentInstrument - format is pan and expiry date separated by an equal sign. "PAN=MMYY"
