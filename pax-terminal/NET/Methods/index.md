---
redirect_from: /pax-terminal/NET/Methods
permalink: /:path/
title: ISwpTrmIf_1 Methods
menu_order: 10
---
### Create

The [Create method][create-method] is the first method to be called.

### Start

The [Start method][start-method] initializes the created instance.

### Open/OpenAsync

The [Open method][open] call is the first method call that actually communicates with the terminal.

### Close/CloseAsync

The [Close][close] call is used to terminate a login session and allow for maintenance. The terminal will be shown as closed.

### Payment/PaymentAsync

Call [Payment][payment] to make a purchase transaction when the amount is known. To read the card before the amount is known, use [GetPaymentInstrument][getpaymentinstrument] instead.

### Refund/RefundAsync

Call [Refund][refund] to make a refund transaction when the amount is known. To read the card before the amount is known, use [GetPaymentInstrument][getpaymentinstrument] instead. RefundAsync has the exact same results as PaymentAsync.

### Abort/AbortAsync

A call to [Abort][abort] aborts an ongoing request. The AbortRequest itself is not responded to by the terminal, and the response of the aborted request ends up as a result of the aborted request.

### ReverseLast/ReverseLastAsync

Call [ReverseLast][reverselast] to reverse the last transaction. The reversal is only possible for the last transaction made, given that it was successful.

### GetPaymentInstrument/GetPaymentInstrumentAsync

Call [GetPaymentInstrument][getpaymentinstrument] to initiate a purchase before the amount is known.

### GetLastTransactionResult/GetLastTransactionResultAsync

Call [GetLastTransactionResult][getlasttransactionresult] to retrieve the result of the last

### SetPaymentInstrument

With [SetPaymentInstrument][setpaymentinstrument], it is possible to send a NON PCI regulated card number or similar to the terminal.

### RequestCustomerConfirmation/RequestCustomerConfirmationAsync

Call [RequestCustomerConfirmation][requestcustomerconfirmation] to ask customer a Yes/No question to be answered on the terminal.

### RequestCustomerDigitString/RequetsCustomerDigitStringAsync

Call [RequestCustomerDigitString][requestcustomerdigitstring] to ask the customer to enter a digit string E.g phone number.

### RequestToDisplay/RequestToDisplayAsync

Call [RequestToDisplay][requesttodisplay] to display a message on the terminal.

### RequestToPrint/RequestToPrintAsync

Call [RequestToPrint][requesttoprint] to use the printer on the integrated A920pro terminal.

[create-method]: ./create
[start-method]: ./start
[open]: ./openasync
[payment]: paymentasync
[getpaymentinstrument]: ./getpaymentinstrumentasync
[getlasttransactionresult]: ./getlasttransactionresult
[abort]: ./abortasync
[refund]: ./refundasync
[close]: ./closeasync
[setpaymentinstrument]: ./setpaymentinstrument
[reverselast]: ./reverselastasync
[requestcustomerconfirmation]: ./requestcustomerconfirmation
[requestcustomerdigitstring]: ./requestcustomerdigitstring
[requesttodisplay]: ./requesttodisplayasync
[requesttoprint]: ./requesttoprint
