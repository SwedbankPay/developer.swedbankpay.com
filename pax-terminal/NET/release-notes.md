---
title: What's new
description: |
  The latest updates about the .Net SDK and documentation will be
  published on this page.
permalink: /:path/release-notes/
menu_order: 1
icon:
    content: feed
    outlined: true

---

## January 25 2024

*   RequestToDisplay and UpdateTerminal have now correced results.
*   ReverseLast now automatically makes retries if the terminal responds busy.
*   OnTerminalAddressObtainedEventCallback now with correct access modifier to be able to access Ipv4 and Port properties.

## January 16 2024

*   CardAcquisitionReference is now a copy of POITransactionID. Earlier time was converted to local time and caused problem when an other timezone was used.
*   [PaymentRequetsResult][paymentrequestresult] has now a lot of properties to make values easily available.

## December 15 2023

### .Net SDK version 1.3.23348

*   CVM signature transaction works just the same for Client Only mode as for default Client and Server mode.
*   [`ConfirmationHandler`][confirmationhandler] callback is a must even for Client Only mode.
*   [`EventCallback`][eventcallback] for `PrintRequestEventCallback` is a must even for Client Only mode.
*   [Code Examples][codeexamples] updated.

## December 11 2023

### .Net SDK Version 1.3

Extended interface with function [RequestToPrint][requesttoprint].

Extended [TransactionSetup][transactionsetup] with a list of SaleItem to be used with fuel functionality.

ReceiptBlob and ReceiptBlobNoHeader has been shortened and compressed.

## 03 November 2023

### .Net SDK Version 1.2

SDK for .Net has extended its interface with new methods for [GetPaymentInstrument][getpaymentinstrument],
[Payment][payment] and [Refund][refund] for which an object with parameters is passed. This was made to be able set a transaction id from the sale system.

ReceiptBlobNoHeader has been added to PaymentRequestResult.

[getpaymentinstrument]:/pax-terminal/NET/Methods/getpaymentinstrumentasync
[payment]: /pax-terminal/NET/Methods/paymentasync
[refund]: /pax-terminal/NET/Methods/refundasync
[requesttoprint]: /pax-terminal/NET/Methods/requesttoprint
[transactionsetup]: /pax-terminal/NET/transactionsetup
[confirmationhandler]: /pax-terminal/NET/ISwpTrmCallbackInterface
[eventcallback]: /pax-terminal/NET/ISwpTrmCallbackInterface/
[codeexamples]: /pax-terminal/NET/CodeExamples
[paymentrequestresult]: /pax-terminal/NET/includes/paymentrequestresult
