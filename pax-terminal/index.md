---
section: Instore Payments
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

There are three options for integrating the Swedbank Pay terminals to a sale
system.

*   [nexo Retailer][nexoretailer] - As implemented by Swedbank Pay.
*   [.Net SDK][dotnetsdk] - abstract interface implementing the nexo Retailer.
*   [Java SDK][javasdk] - abstract interface implementing the nexo Retailer.

The Swedbank Pay SDK contains one implementation for using a PAX A30, A35 or
A920 PRO terminal, but makes it possible to vary the style of use by
configuration. There are two major styles that is decided by the
SalesCapabilities string sent in as a LoginRequest:

*   Act as both server and client
*   Act as client only

The intended default style requires the consumer of the SwpTrmLib to act as both
a server and a client. The server handles requests from the terminal, such as
display information, events, and possible input request from the terminal, such
as a request to confirm that a receipt has been signed if needed. The second
style is to act as a client only and then lose information from terminal such as
events informing that a card has been inserted or removed or display information
helping the operator to see what is going on.

## Configure the terminal

In order for the terminal to communicate with the ECR the IP address need to be
set in the admin menu. To enter the admin menu, tap the three dots in the
footer. Then enter the code. Set the ECR IP address and then press the save
button.

[nexoretailer]: /pax-terminal/Nexo-Retailer/
[dotnetsdk]: /pax-terminal/NET/
[javasdk]: /pax-terminal/java
