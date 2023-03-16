---
section: Methods
redirect_from: /modules-sdks/pax-terminal/instore-solution/NET/Methods
title: ISwpTrmIf_1 Methods
---
## Create

The [Create method][create-method] is the first method to be called.

## Start

The [Start method][start-method] initializes the created instance

## OpenAsync

The [OpenAsync method][openasync] call is the first method call that actually communicates with the terminal.

## CloseAsync

## PaymentAsync

Call [PaymentAsync][paymentasync] to make a purchase transaction when the amount is known. To read card before the amount is known use [GetPaymentInstrumentAsync][getpaymentinstrumentasync] instead.

## RefundAsync

Call [RefundAsync][paymentasync] to make a refund transaction when the amount is known. To read card before the amount is known use [GetPaymentInstrumentAsync][getpaymentinstrumentasync] instead. RefundAsync has the exact same results as PaymentAsync.

## AbortAsync

A call to [AbortAsync][abortasync] aborts an ongoing request. The AbortRequest itself is not responded to by the terminal and the response of the aborted request ends up as a result of the aborted request.

## GetPaymentInstrumentAsync

Call [GetPaymentInstrumentAsync][getpaymentinstrumentasync] to initiate a purchase before amount is known.

[create-method]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/create
[start-method]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/start
[openasync]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/openasync
[paymentasync]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/paymentasync
[getpaymentinstrumentasync]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/getpaymentinstrumentasync
[abortasync]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/abortasync
