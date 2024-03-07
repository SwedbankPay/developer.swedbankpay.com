---
section: Get Started
sidebar_icon: description
title: Introduction
description: |
  Everything you need to set up a basic payment integration
permalink: /:path/
menu_order: 2
---

## Foundation

To start integrating Swedbank Pay Digital Payments, you need the following:

*   [HTTPS][https] enabled web server.
*   Agreement that includes Swedbank Pay Checkout.
*   Obtained credentials (merchant Access Token) from Swedbank Pay through
    the Merchant Portal.

The **basic payment integration** consists of 4 main steps. **Creating** the
payment, **displaying** the payment UI, **verifying** the payment status and
**capturing** the funds. Don't hesitate with contacting us for further
integration support.

FANCY STEP ILLUSTRATION NEEDED!

{:.table .table-striped}
| ----------: | ----------: |
| Initiate a payment | The first step is to initiate a payment. You have a selection of setups and use cases depending on your business model, like recurring and one-click payments - but for now we'll stick to the basic payment. |
| Display UI         | Present a UI for your end user and customize for your needs. The main choice you have to make is between the seamless view or redirect integration. There are pros and cons to both. |
| Validate status    | Validate the status of the purchase in order to take the right action before acting on the payment response. |
| Capture            |  Capture the funds from a successful payment. |

## Get Ready To Go Live

A few more steps remain before your integration is ready to run in a production
environment. Our technical onboarding managers are ready to assist you.

*   Acceptance tests

*   Contract details

*   Settlement and reconciliation

No need to worry about these steps just yet. We will walk you through everything
when we get there.

[https]: /checkout-v3/resources/fundamental-principles#connection-and-protocol
[json]: https://www.json.org/
[rest]: https://en.wikipedia.org/wiki/Representational_state_transfer
