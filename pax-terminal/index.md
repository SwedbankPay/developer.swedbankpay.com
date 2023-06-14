---
section: Pax Terminal
sidebar_icon: point_of_sale
title: Introduction
redirect_from: /checkout-v3/resources/ecom
permalink: /:path/
menu_order: 300
---

Swedbank Pay have designed the Swedbank Pay Payment Application solution using
the nexo Retailer protocol for its API interface to integrated parties. The
Swedbank Pay Payment Application implementation of nexo Retailer allows the
integrated application to initiate the relevant functions within Swedbank Pay
Payment Application.

The Swedbank Pay SDK contains one implementation for using PAX A30 terminal but
makes it possible to vary the style of use by configuration. There are two major
styles that is decided by the SalesCapabilities string sent in as a
LoginRequest:

-   Act as both server and client
-   Act as client only

The intended default style requires the consumer of the SwpTrmLib to act as both
a server and a client. The server handles requests from the terminal, such as
display information, events, and possible input request from the terminal, such
as a request to confirm that a receipt has been signed if needed. The second
style is to act as a client only and then lose information from terminal such as
events informing that a card has been inserted or removed or display information
helping the operator to see what is going on. Transactions that need signing is
not possible. Such transactions regard cards from outside EU for which PIN may
not be required.

## Configure the terminal

In order for the terminal to communicate with the ECR the IP address need to be
set in the admin menu. To enter the admin menu tap 6 times on the Swedbank Pay
logo located at the top of the screen. Then enter the pin-code. Set the ECR IP
address and then press the save button.
