---
section: NET SDK
title: .Net SDK
permalink: /:path/
description: |
    Use the .NET SDK to quickly and easy integrate with the terminal from your POS solution. The aim of the SDK is to minimize the work effort for both users and Swedbank Pay.
menu_order: 1500
---

## Introduction

SwpTrmLib is a Net Standard 2.0 nuget package that may be used when integrating Swedbank Pay terminal to a sale system. The package is available on `nuget.org` with name `SwedbankPay.Pax.Sdk`. The package makes it simple and easy to get started. It has high abstraction and even if the actual protocol to the terminal changes this interface can stay the same.

It offers both synchronous and asynchronous methods and for the [simplest form of implementation][client-style] it just takes a few calls to make a transaction.

As of now the terminal is not prepared for a cloud connection, but by using this SDK it is possible to quickly make a small proxy service that makes whichever cloud connection that is desired.

In the future there may be other variants of the interface and usage within the SDK, but this version will stay the same and once an implementation has been made, it should not have to be changed unless new requirements or new functionality is desired.

The aim of the SDK is to minimize the total work effort for both users and Swedbank Pay.

{% include card-list.html %}

[client-style]: /pax-terminal/NET/CodeExamples/#as-client-only
