---
section: Get Started
sidebar_icon: description
title: The Basics
description: |
  Everything you need to set up a basic payment integration
permalink: /:path/
menu_order: 2
---

Get Started is a guide for the native API implementation of Digital Payments.
[Modules and SDKs have their own section][modules-sdks].

## Foundation

To start integrating Swedbank Pay Digital Payments, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes Swedbank Pay Checkout.
*   Obtained credentials (Merchant Access Token) from Swedbank Pay through
    the Merchant Portal.

There are two versions of Digital Payments available in production at the
moment. If you are a new merchant, you should implement v3.1. If you are an
existing merchant, we recommend migrating to v3.1, but you are still able to use
v3.0. Reach out to your technical contact person for guidance regarding this.
Unless stated otherwise by the presence of a separate v3.1 page, there are no
differences between the two alternatives.

## The Basic Implementation

The **basic payment integration** consists of 4 main steps. **Creating** the
payment, **displaying** the payment UI, **verifying** the payment status and
**capturing** the funds. Don't hesitate with contacting us for further
integration support.

![Implementation steps][basic-implementation]{:class="mt-4 mb-5"}

{:.table .table-plain}
| ----------: | ----------: |
| Initiate a Payment | The first step is to initiate a payment. You have a selection of setups and use cases depending on your business model, like recurring and one-click payments - but for now we'll stick to the basic payment. |
| Display UI         | Present a UI for your end user and customize for your needs. The main choice you have to make is between the seamless view or redirect integration. There are pros and cons to both. |
| Validate Status    | Validate the status of the purchase in order to take the right action before acting on the payment response. |
| Capture            |  Capture the funds from a successful payment. |

## Get Ready To Go Live

A few more steps remain before your integration is ready to run in a production
environment. Our teams are ready to assist you.

*   Acceptance tests

*   Contract details

*   Settlement and reconciliation

No need to worry about these steps just yet. We will walk you through everything
when we get there.

[basic-implementation]: /assets/img/basic-implementation.svg
[https]: /checkout-v3/get-started/fundamental-principles#connection-and-protocol
[json]: https://www.json.org/
[modules-sdks]: /checkout-v3/modules-sdks/
[rest]: https://en.wikipedia.org/wiki/Representational_state_transfer
