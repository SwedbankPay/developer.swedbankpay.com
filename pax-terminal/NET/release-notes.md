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

## February 6 2024

*   Documentation updated to reflect SDK release.
*   Text updated for [`TransactionSetup`][transactionsetup]
*   Use case section, apm transaction, apm refund, cvm signtature and fuel card transaction and auto configuration of terminal IP in the POS.

## January 25 2024

### .Net SDK 1.3.24025

*   RequestToDisplay and UpdateTerminal have now corrected results.
*   ReverseLast now automatically makes retries if the terminal responds busy.
*   OnTerminalAddressObtainedEventCallback now with correct access modifier to be able to access Ipv4 and Port properties.

## January 16 2024

### .Net SDK 1.3.24016

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

[getpaymentinstrument]:/pax-terminal/NET/SwpTrmLib/Methods/handy/getpaymentinstrumentasync
[payment]: /pax-terminal/NET/SwpTrmLib/Methods/essential/paymentasync
[refund]: /pax-terminal/NET/SwpTrmLib/Methods/essential/refundasync
[requesttoprint]: /pax-terminal/NET/SwpTrmLib/Methods/handy/requesttoprint
[transactionsetup]: /pax-terminal/NET/includes/transactionsetup
[confirmationhandler]: /pax-terminal/NET/SwpTrmLib/ISwpTrmCallbackInterface
[eventcallback]: /pax-terminal/NET/SwpTrmLib/ISwpTrmCallbackInterface/
[codeexamples]: /pax-terminal/NET/CodeExamples
[paymentrequestresult]: /pax-terminal/NET/includes/paymentrequestresult
