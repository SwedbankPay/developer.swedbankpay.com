---
title: .NET
description: |
    Use the .NET SDK to quickly and easy integrate with the terminal from your POS solution.
menu_order: 1000
---

## Introduction

SwpTrmLib is a Net Standard 2.0 nuget package that may be used when integrating Swedbank Pay terminal to a sale system. The
package makes it simple and easy to get started.

## Usage

The SwpTrmLib contains one implementation for using PAX A30 terminal but makes it possible to vary the style of use
by configuration. There are to major styles that is decided by the SalesCapabilities string sent in a LoginRequest:

- Act as both server and client
- Act as clinent only

The intended default style requires the consumer of the SwpTrmLib to act as both a server and a client. The server
handles requests from the terminal, such as display information, events, and possible input request from the terminal,
such as a request to confirm that a receipt has been signed if needed. The second style is to act as a client only and then
loose information from terminal such as events informing that a card has been inserted or removed or display
information helping the operator to see what is going on. Transactions that need signing is not possible. Such
transactions regard cards from outside EU for which PIN may not be required.

## Create Instance

Start by calling the static create method of SwpTrmLib.PAXTrmImp_1

```java

this is the code.

```
