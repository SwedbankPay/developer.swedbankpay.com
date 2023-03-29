---
section: Methods
redirect_from: /modules-sdks/pax-terminal/instore-solution/NET/Methods
permalink: /:path/
title: ISwpTrmIf_1 Methods
---
### Create

The [Create method][create-method] is the first method to be called.

### Start

The [Start method][start-method] initializes the created instance

### OpenAsync

The [OpenAsync method][openasync] call is the first method call that actually communicates with the terminal.

### CloseAsync

The [CloseAsync][closeasync] call is used to terminate a login session and allow for maintenance. Terminal will show closed.

### PaymentAsync

Call [PaymentAsync][paymentasync] to make a purchase transaction when the amount is known. To read card before the amount is known use [GetPaymentInstrumentAsync][getpaymentinstrumentasync] instead.

### RefundAsync

Call [RefundAsync][refundasync] to make a refund transaction when the amount is known. To read card before the amount is known use [GetPaymentInstrumentAsync][getpaymentinstrumentasync] instead. RefundAsync has the exact same results as PaymentAsync.

### AbortAsync

A call to [AbortAsync][abortasync] aborts an ongoing request. The AbortRequest itself is not responded to by the terminal and the response of the aborted request ends up as a result of the aborted request.

### ReverseLastAsync

Call [ReverseLastAsync][reverselastasync] to reverse the last transaction. The reversal is only possible for the last transaction made and ofcource if it was successful.

### GetPaymentInstrumentAsync

Call [GetPaymentInstrumentAsync][getpaymentinstrumentasync] to initiate a purchase before amount is known.

### SetPaymentInstrument

With [SetPaymentInstrument][setpaymentinstrument] it is possible to send a NON PCI regulated card number or similar to the terminal.

[create-method]: ./create
[start-method]: ./start
[openasync]: ./openasync
[paymentasync]: paymentasync
[getpaymentinstrumentasync]: ./getpaymentinstrumentasync
[abortasync]: ./abortasync
[refundasync]: ./refundasync
[closeasync]: ./closeasync
[setpaymentinstrument]: ./setpaymentinstrument
[reverselastasync]: ./reverselastasync
