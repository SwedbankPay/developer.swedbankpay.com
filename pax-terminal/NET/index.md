---
section: NET
title: Introduction and Overview
permalink: /:path/
redirect_from: /checkout-v3/modules-sdks/pax-terminal/instore-solution/NET
description: |
    Use the .NET SDK to quickly and easy integrate with the terminal from your POS solution. The aim of the SDK is to minimize the work effort for both users and Swedbank Pay.
menu_order: 1500
---

## Introduction

SwpTrmLib is a Net Standard 2.0 nuget package that may be used when integrating Swedbank Pay terminal to a sale system. The
package makes it simple and easy to get started.
It has high abstraction and even if the actual protocol to the terminal changes this interface can stay the same.

It offers both synchronous and asynchronous methods and for the [simplest form of implementation][client-style] it just takes a few calls to make a transaction.

As of now the terminal is not prepared for a cloud connection, but by using this SDK it is possible to quickly make a small proxy service that makes whichever cloud connection that is desired.

In the future there may be other variants of the interface and usage within the SDK, but this version will stay the same and once an implementation has been made, it should not have to be changed unless new requirements or new functionality is desired.

The aim of the SDK is to minimize the total work effort for both users and Swedbank Pay.

## Usage

The SwpTrmLib only contains one implementation for using a PAX terminal from Swedbank Pay at the moment, but makes it possible to vary the style of use
by configuration. There are two major styles that is decided by the `SalesCapabilities` string sent in a `LoginRequest`:

*   Act as both server and client - [see code example for default style][default-style]
*   Act as client only - [see code example for client only][client-style]

The intended default style requires the consumer of the SwpTrmLib to act as both a server and a client. The server
handles requests from the terminal, such as display information, events, and possible input request from the terminal,
such as a request to confirm that a receipt has been signed if needed.

The second style is to act as a client only and then loose information from terminal such as events informing that a card has been inserted or removed or display
information helping the operator to see what is going on. Transactions that need signing is not possible but will be in a later terminal version. Such
transactions regard cards from outside EU for which PIN may not be required.

### Synchronous methods

Most available methods have an asynchronous and a synchronous version. Note that the synchronous versions internally renders a call to the asynchronous version. All results genereated due to synchronous calls are received in one callback method, [SyncRequestResult][syncrequestresult], which parameter is the same result as described for the asynchronous version.

{% include alert.html type="warning" icon="warning" header="Warning"
body= "Do not wrap the synchronous calls in async await since the methods themselves call async methods."
%}

## Essential Methods

Making a transaction from scratch only takes a few method calls.

*   [Create][create-method] - Creates an instance and returns an interface
*   [Start][start-method] - Initializes the instance and starts a listener for terminal if that mode is chosen
*   [Open/OpenAsync][openasync] - Starts a Login Session with the terminal. The session is valid until Close or a new Open call
*   [Payment/PaymentAsync][paymentasync] - Starts a payment transaction for supplied amount.
*   [Refund/RefundAsync][refundasync] - Starts a refund transaction for supplied amount.
*   [Close/CloseAsync][closeasync] - Finishes the terminal session and allows for terminal maintenance. At least once a day.

## Handy Methods

To get more than just payments and refunds

*   [GetPaymentInstrument/GetPaymentInstrumentAsync][getpaymentinstrumentasync] - Opens card readers to read card before amount is known
*   [SetPaymentInstrument][setpaymentinstrument] - Sends a payment instrument (card number) to the terminal. Note! Only non PCI regulated cards.
*   [RequestToDisplay/RequestToDisplayAsync][requesttodisplayasync] - Sends a message to be displayed on terminal
*   [RequestCustomerConfirmation/RequestCustomerConfirmationAsync][requestcustomerconfirmation] - Displays a yes/no question on the terminal and receive the result.

## Other Available Methods

*   [Abort/AbortAsync][abortasync] - Aborts something ongoing
*   [ReverseLast/ReverseLastAsync][reverselastasync] - Reverses the last transaction if it was approved
*   AdminAsync - Ask terminal to see if is any parameter update pending

## Events

The events are only used if running as a server.

*   [OnTerminalDisplay][onterminaldisplay]
*   [OnNewStatus][onnewstatus]
*   [OnTerminalAddressObtained][onterminaladdressobtained]

## Callbacks

### ISwpTrmCallbackInterface

The callbacks needed if running as a server or using the synchronous method calls.

*   [ConfirmationHandler][confirmationhandler]
*   [EventNotificationHandler][eventnotificationhandler]
*   [SyncRequestResult][syncrequestresult]

[create-method]: ./Methods/create
[start-method]: ./Methods/start
[openasync]: ./Methods/openasync
[paymentasync]: ./Methods/paymentasync
[getpaymentinstrumentasync]: ./Methods/getpaymentinstrumentasync
[abortasync]: ./Methods/abortasync
[default-style]: ./CodeExamples/#as-client-and-server
[client-style]: ./CodeExamples/#as-client-only
[refundasync]: ./Methods/refundasync
[closeasync]: ./Methods/closeasync
[setpaymentinstrument]: ./Methods/setpaymentinstrument
[reverselastasync]: ./Methods/reverselastasync
[requesttodisplayasync]: ./Methods/requesttodisplayasync
[requestcustomerconfirmation]: ./Methods/requestcustomerconfirmation
[onterminaldisplay]: Events/#onterminaldisplay
[onnewstatus]: Events/#onnewstatus
[onterminaladdressobtained]: Events/#onterminaladdressobtained
[confirmationhandler]: ISwpTrmCallbackInterface/#confirmationhandler
[eventnotificationhandler]: ISwpTrmCallbackInterface/#eventnotificationhandler
[syncrequestresult]: ISwpTrmCallbackInterface/#syncrequestresult
