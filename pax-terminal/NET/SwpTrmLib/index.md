---
title: Content of SwpTrmLib
permalink: /:path/
description:
menu_order: 30
---
## Essential Methods

Making a transaction from scratch only takes a few method calls.

*   [Create][create-method] - Creates an instance and returns an interface
*   [Start][start-method] - Initializes the instance and starts a listener for terminal if that mode is chosen
*   [Open/OpenAsync][openasync] - Starts a Login Session with the terminal. The session is valid until Close or a new Open call
*   [Payment/PaymentAsync][paymentasync] - Starts a payment transaction for supplied amount.
*   [Refund/RefundAsync][refundasync] - Starts a refund transaction for supplied amount.
*   [GetLastTranactionResult/GetLastTransactionResultAsync][getlasttransactionresult] - Requests a copy of the result for the last transaction
*   [Close/CloseAsync][closeasync] - Finishes the terminal session and allows for terminal maintenance. At least once a day.

## Handy Methods

To get more than just payments and refunds

*   [GetPaymentInstrument/GetPaymentInstrumentAsync][getpaymentinstrumentasync] - Opens card readers to read card before amount is known
*   [SetPaymentInstrument][setpaymentinstrument] - Sends a payment instrument (card number) to the terminal. Note! Only non PCI regulated cards.
*   [RequestToDisplay/RequestToDisplayAsync][requesttodisplayasync] - Sends a message to be displayed on terminal
*   [RequestCustomerConfirmation/RequestCustomerConfirmationAsync][requestcustomerconfirmation] - Displays a yes/no question on the terminal and receive the result.
*   [RequestCustomerDigitString/RequestCustomerDigitStringAsync][requestcustomerdigitstring] - Displays a message and ask customer to enter a digit string.
*   [RequestToPrint/RequestToPrintAsync][requesttoprint] - (A920pro only) Possibility to use the terminal's printer.

## Other Available Methods

*   [Abort/AbortAsync][abortasync] - Aborts something ongoing
*   [Continue][continue] - May be used after `GetPaymentInstrument` to make terminal proceed with PIN dialog before amount is known
*   [ReverseLast/ReverseLastAsync][reverselastasync] - Reverses the last transaction if it was approved
*   [UpdateTerminal/UpdateTerminalAsync][updateterminal] - Ask terminal to see if is any parameter update pending

## Callbacks

### ISwpTrmCallbackInterface

Callbacks need to be implemented at all times. The use of them depends on the implementation mode, but two of them are a **must**.

*   [ConfirmationHandler][confirmationhandler] - **Must be implemented**. When the terminal requests a  Yes/No from operator (Verify signed receipt)
*   [EventCallback][eventcallback] - replaces the subscribing to events. **Must be implemented** for the `PrintRequestEventCallback`.
*   [EventNotificationHandler][eventnotificationhandler] - Reception of EventNotification messages from the terminal
*   [SyncRequestResult][syncrequestresult] - Results from various synchrounous methods

## Events

The events are only used if running as a server. Consider to use the EventCallback instead.

*   [OnTerminalDisplay][onterminaldisplay]
*   [OnNewStatus][onnewstatus]
*   [OnTerminalAddressObtained][onterminaladdressobtained]

[create-method]: ./Methods/create
[start-method]: ./Methods/start
[openasync]: ./Methods/openasync
[paymentasync]: ./Methods/paymentasync
[getpaymentinstrumentasync]: ./Methods/getpaymentinstrumentasync
[abortasync]: ./Methods/abortasync
[refundasync]: ./Methods/refundasync
[closeasync]: ./Methods/closeasync
[setpaymentinstrument]: ./Methods/setpaymentinstrument
[reverselastasync]: ./Methods/reverselastasync
[requesttodisplayasync]: ./Methods/requesttodisplayasync
[requestcustomerconfirmation]: ./Methods/requestcustomerconfirmation
[onterminaldisplay]: ./Events/#onterminaldisplay
[onnewstatus]: ./Events/#onnewstatus
[onterminaladdressobtained]: ./Events/#onterminaladdressobtained
[confirmationhandler]: ./ISwpTrmCallbackInterface/#confirmationhandler
[eventnotificationhandler]: ./ISwpTrmCallbackInterface/#eventnotificationhandler
[syncrequestresult]: ./ISwpTrmCallbackInterface/#syncrequestresult
[continue]: ./Methods/continue
[getlasttransactionresult]: ./Methods/getlasttransactionresult
[requestcustomerdigitstring]: ./Methods/requestcustomerdigitstring
[eventcallback]: ./ISwpTrmCallbackInterface
[updateterminal]: ./Methods/updateterminalasync
[requesttoprint]: ./Methods/requesttoprint
