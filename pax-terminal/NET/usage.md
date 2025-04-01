---
title: Basic Information
description: Things to know before you start
permalink: /:path/usage/
menu_order: 10
---
## Usage

The SwpTrmLib only contains one implementation for using a PAX terminal from Swedbank Pay at the moment, but makes it possible to vary the style of use by configuration. There are two major styles that is decided by the `SalesCapabilities` string sent in a `LoginRequest` which happens on call to `Open/OpenAsync`:

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

[default-style]: /pax-terminal/NET/CodeExamples/#as-client-and-server
[client-style]: /pax-terminal/NET/CodeExamples/#as-client-only
[syncrequestresult]: /pax-terminal/NET/SwpTrmLib/ISwpTrmCallbackInterface/#syncrequestresult
