---
section: In-Store Payments
sidebar_icon: point_of_sale
title: Introduction
permalink: /:path/
menu_order: 2
---

Swedbank Pay have designed the Swedbank Pay Payment Application solution using
the nexo Retailer protocol for its API interface to integrated parties. The
Swedbank Pay Payment Application implementation of nexo Retailer allows the
integrated application to initiate the relevant functions within Swedbank Pay
Payment Application.

There are different integration types and different options how to integrate, but all are using the same nexo messages and flow. The difference is how to communicate with the payment application in the terminal. All three works with the available PAX terminals A35, A920Pro and A30.

## Communication Types

*   **Http over Local Network** - The POS need to know the IP address and port the terminal is listening for, and the terminal may need to know the IP address and port of the POS.
*   **Http cloud connection** - using OAuth2 with client credentials grant type. By far the easiest way when installing and connecting to a POS.
*   **Broadcast intents** - on the device, the terminal, when a business app like a POS is placed side by side with our Payment application.

## How To Integrate

There are three ways for integrating the Swedbank Pay terminals to a sale
system.

*   [nexo Retailer][nexoretailer] - Do the job implementing the Swedbank Pay nexo Retailer protocol by building and parsing the messages to handle the different scenarios.
*   [.Net SDK][dotnetsdk] - Use the abstract interface that is implementing the nexo Retailer. Much less time consuming, but does not work for the On Device communication type.
*   [Java SDK][javasdk] - Use the abstract interface implementing the nexo Retailer. Does not work for the On Device or cloud communication types.

## Implementation Modes

The nexo Retailer protocol may be implemented as any of two modes:

*   Act as both server and client
*   Act as client only

The intended default mode requires the POS to act as both a server and a client. The server handles requests from the terminal, such as
display information, events, and possible input request from the terminal, such
as a request to confirm that a receipt has been signed if needed. The second
mode is to act as a client only and then lose information from terminal such as
events informing that a card has been inserted or removed or display information
helping the operator to see what is going on. Which mode that will be used is decided by the LoginRequest from the POS to the terminal.

[nexoretailer]: /pax-terminal/Nexo-Retailer/
[dotnetsdk]: /pax-terminal/NET/
[javasdk]: /pax-terminal/java
