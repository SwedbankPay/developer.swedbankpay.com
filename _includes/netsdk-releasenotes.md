
## 30 April 2025

### .Net SDK 1.3.25120.1

*   New boolean flag in SaleApplInfo ForceAcquisitionReference, that when set to true always requires a cardAquisition before PaymentRequest.

## 1 April 2024

### .Net SDK 1.3.24170

*   Add specific data from fuel app to the receiptBlob

## 15 April 2024

### .Net SDK 1.3.24163

*   If installed POS language is not supported by terminal as operator language,
    use english.
*   Only send continue_processing if Continue is called. Don't send
    continue_processing automatically on Payment.

## 15 April 2024

### .Net SDK 1.3.24129

*   PaymentRequetsResult now with new properties, MerchantReceiptBlob,
    MerchantReceiptBlobNoHeader and SignatureBlock.

## 15 April 2024

### .Net SDK 1.3.24075

*   Fixed bug for fuel that caused SaleItems to be missed when starting with
    GetPaymentInstrument.

## 18 March 2024

### .Net SDK 1.3.24066

*   New package ID. SwedbankPay.Pax.Sdk. Still the same namespaces and dll name.
*   Fix for display messages from fuel app that lacks text id.
*   Added support for AdminRequest with service identification OM02, OM03 and
    OM04, regarding the Store-And-Forward.
*   Fixed bug for PrintRequest with DocumentQualifier other other than
    CashierReceipt or CustomerReceipt.
*   Possibility for Net Framework 4.0. Now supports Netstandard2.0, net
    framework 4.5 and 4.0.

## 5 February 2024

### .Net SDK 1.3.24047

*   PaymentRequestResult now populates ProductName and PAN even if
    PaymentInstrumentData is missing.
*   Possibility to use OpenEx or OpenExAsync to set OperatorID and ShiftNumber
    that will be forwarded and seen in reports.
*   Possibility to attach purchase order Id by setting in in TransactionSetup
    when starting a payment.
*   Setting up the logfile will only be made once even if new instances is
    created. Filter is removed when calling Stop.
*   Calling Stop will stop and remove the listener.
*   SplitPayment may be indicated in TranactionSetup and is sent to terminal to
    be forwarded to host.
*   Property type of TransactionSetup is always overridden and set to Refund if
    Refund or RefundAsync is called.
*   Default currency fixed when using TransactionSetup.

## 25 January 2024

### .Net SDK 1.3.24025

*   RequestToDisplay and UpdateTerminal have now corrected results.
*   ReverseLast now automatically makes retries if the terminal responds busy.
*   OnTerminalAddressObtainedEventCallback now with correct access modifier to
    be able to access Ipv4 and Port properties.

## 16 January 2024

### .Net SDK 1.3.24016

*   CardAcquisitionReference is now a copy of POITransactionID. Earlier time was
    converted to local time and caused problem when an other timezone was used.
*   [PaymentRequetsResult][paymentrequestresult] has now a lot of properties to
    make values easily available.

## 16 January 2024

### .Net SDK version 1.3.23348

*   CVM signature transaction works just the same for Client Only mode as for
    default Client and Server mode.
*   [`ConfirmationHandler`][confirmationhandler] callback is a must even for
    Client Only mode.
*   [`EventCallback`][eventcallback] for `PrintRequestEventCallback` is a must
    even for Client Only mode.
*   [Code Examples][codeexamples] updated.

## 15 December 2023

### .Net SDK Version 1.3

*   Extended interface with function [RequestToPrint][requesttoprint].
*   Extended [TransactionSetup][transactionsetup] with a list of SaleItem to be
    used with fuel functionality.
*   ReceiptBlob and ReceiptBlobNoHeader has been shortened and compressed.

## 7 November 2023

### .Net SDK Version 1.2

*   SDK for .Net has extended its interface with new methods for
[GetPaymentInstrument][getpaymentinstrument], [Payment][payment] and
[Refund][refund] for which an object with parameters is passed. This was made to
be able set a transaction id from the sale system.
*   ReceiptBlobNoHeader has been added to PaymentRequestResult.

[getpaymentinstrument]:/pax-terminal/NET/SwpTrmLib/Methods/handy/getpaymentinstrumentasync
[payment]: /pax-terminal/NET/SwpTrmLib/Methods/essential/paymentasync
[refund]: /pax-terminal/NET/SwpTrmLib/Methods/essential/refundasync
[requesttoprint]: /pax-terminal/NET/SwpTrmLib/Methods/handy/requesttoprint
[transactionsetup]: /pax-terminal/NET/includes/transactionsetup
[confirmationhandler]: /pax-terminal/NET/SwpTrmLib/ISwpTrmCallbackInterface
[eventcallback]: /pax-terminal/NET/SwpTrmLib/ISwpTrmCallbackInterface/
[codeexamples]: /pax-terminal/NET/CodeExamples
[paymentrequestresult]: /pax-terminal/NET/includes/paymentrequestresult
