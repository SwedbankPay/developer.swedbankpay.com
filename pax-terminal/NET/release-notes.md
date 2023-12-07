---
title: What's new
permalink: /:path/release-notes/
description: |
  The latest updates about the .Net SDK and documentation will be
  published on this page.
menu_order: 1
---

## 03 November 2023

### .Net SDK Version 1.2

SDK for .Net has extended its interface with new methods for [GetPaymentInstrument][getpaymentinstrument],
[Payment][payment] and [Refund][refund] for which an object with parameters is passed. This was made to be able set a transaction id from the sale system.

ReceiptBlobNoHeader has been added to PaymentRequestResult.

[getpaymentinstrument]:/pax-terminal/NET/Methods/getpaymentinstrumentasync
[payment]: /pax-terminal/NET/Methods/paymentasync
[refund]: /pax-terminal/NET/Methods/refundasync
