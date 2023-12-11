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

## 11 December 2023

### .Net SDK Version 1.3

Extended interface with function [RequestToPrint][requesttoprint].

Extended [TransactionSetup][transactionsetup] with a list of SaleItem to be used with fuel functionality.

ReceiptBlob and ReceiptBlobNoHeader has been shortened and compressed.

[getpaymentinstrument]:/pax-terminal/NET/Methods/getpaymentinstrumentasync
[payment]: /pax-terminal/NET/Methods/paymentasync
[refund]: /pax-terminal/NET/Methods/refundasync
[requesttoprint]: /pax-terminal/NET/Methods/requesttoprint
[transactionsetup]: /pax-terminal/NET/transactionsetup
