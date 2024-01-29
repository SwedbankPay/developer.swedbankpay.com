---
section: NET
title: Introduction and Overview
permalink: /:path/
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

The SwpTrmLib only contains one implementation for using a PAX terminal from Swedbank Pay at the moment, but makes it possible to vary the style of use by configuration. There are two major styles that is decided by the `SalesCapabilities` string sent in a `LoginRequest`:

*   Act as both server and client - [see code example for default style][default-style]
*   Act as client only - [see code example for client only][client-style]

The intended default style requires the consumer of the SwpTrmLib to act as both a server and a client. The server
handles requests from the terminal, such as display information, events, and possible input request from the terminal,
such as a request to confirm that a receipt has been signed if needed.

The second style is to act as a client only and then loose information from terminal such as events informing that a card has been inserted or removed or display information helping the operator to see what is going on. Transaction that need customer signing the receipt are under the hood done a bit differently, but have the exact same behavior as when using the default integration style.

### Synchronous methods

Most available methods have an asynchronous and a synchronous version. Note that the synchronous versions internally renders a call to the asynchronous version. All results genereated due to synchronous calls are received in one callback method, [SyncRequestResult][syncrequestresult], which parameter is the same result as described for the asynchronous version.

{% include alert.html type="warning" icon="warning" header="Warning"
body= "Do not wrap the synchronous calls in async await since the methods themselves call async methods."
%}

{% include card-list.html %}

[default-style]: /pax-terminal/NET/codeexamples/#as-client-and-server
[client-style]: /pax-terminal/NET/codeexamples/#as-client-only
[syncrequestresult]: /pax-terminal/NET/swptrmlib/iswptrmcallbackinterface/#syncrequestresult
