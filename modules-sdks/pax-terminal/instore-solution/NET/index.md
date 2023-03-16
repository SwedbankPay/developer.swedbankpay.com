---
section: NET
title: Introduction and Overview
redirect_from: /modules-sdks/pax-terminal/instore-solution/NET
permlink: /:path/
description: |
    Use the .NET SDK to quickly and easy integrate with the terminal from your POS solution. The aim of the SDK is to minimize the work effort for both users and Swedbank Pay.
menu_order: 1500
---

## Introduction

SwpTrmLib is a Net Standard 2.0 nuget package that may be used when integrating Swedbank Pay terminal to a sale system. The
package makes it simple and easy to get started.
It has high abstraction and even if the actual protocol to the terminal changes this interface can stay the same.

It offers asynchronous methods and for the [simplest form of implementation][client-style] it just takes a few calls to make a transaction.

As of now the terminal is not prepared for a cloud connection, but by using this SDK it is possible to quickly make a small proxy service that makes whichever cloud connection that is desired.

In the future there may be other variants of the interface and usage within the SDK, but this version will stay the same and once an implementation has been made it should not have to be changed unless new requirements or new functionallity is desired.

The aim of the SDK is to minimize the total work effort for both users and Swedbank Pay.

## Usage

The SwpTrmLib contains at the moment one implementation for using a PAX terminal from Swedbank Pay, but makes it possible to vary the style of use
by configuration. There are to major styles that is decided by the `SalesCapabilities` string sent in a `LoginRequest`:

* Act as both server and client - [see code example for default style][default-style]
* Act as client only - [see code example for client only][client-style]

The intended default style requires the consumer of the SwpTrmLib to act as both a server and a client. The server
handles requests from the terminal, such as display information, events, and possible input request from the terminal,
such as a request to confirm that a receipt has been signed if needed.

The second style is to act as a client only and then loose information from terminal such as events informing that a card has been inserted or removed or display
information helping the operator to see what is going on. Transactions that need signing is not possible. Such
transactions regard cards from outside EU for which PIN may not be required.

## Essential Methods

To make a transaction from scratch it takes only a few method calls.

* [Create][create-method] - Creates an instance and returns an interface
* [Start][start-method] - Initialises the instance and starts a listener for terminal if that mode is chosen
* [OpenAsync][openasync] - Starts a Login Session with the terminal. The session remains until Close or a new Open call
* [PaymentAsync][paymentasync] - Starts a payment transaction for supplied amount.
* RefundAsync - Starts a refund transaction for supplied amount.
* Close - Finnish the terminal session and allows for terminal maintenance. At least once a day

## Handy Methods

To get more than just payments and refunds

* [GetPaymentInstrumentAsync][getpaymentinstrumentasync] - Opens card readers to read card befor amount is known
* SetPaymentInstrument - Send a payment instrument (card number) to the terminal. Note! Only non PCI regulated cards.
* RequestToDisplayAsync - Send message to be displayed on terminal
* RequestCustomerConfirmationAsync - Display a yes/no question on the terminal and receive the result.

## Other Available Methods

* [AbortAsync][abortasync] - Abort something ongoing
* ReverseLastAsync - Reverse last transaction if it was approved
* AdminAsync - Ask terminal to see if is any parameter update pending

[create-method]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/create
[start-method]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/start
[openasync]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/openasync
[paymentasync]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/paymentasync
[getpaymentinstrumentasync]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/getpaymentinstrumentasync
[abortasync]: /modules-sdks/pax-terminal/instore-solution/NET/Methods/abortasync
[default-style]: /modules-sdks/pax-terminal/instore-solution/NET/CodeExamples/#as-client-and-server
[client-style]: /modules-sdks/pax-terminal/instore-solution/NET/CodeExamples/#as-client-only
