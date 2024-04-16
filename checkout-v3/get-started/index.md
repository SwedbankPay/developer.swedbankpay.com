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
**post-purchase actions**. Don't hesitate with contacting us for further
integration support.

![Implementation steps][basic-implementation]{:class="mt-4 mb-5"}

{:.table .table-plain}
| ----------: | ----------: |
| Initiate a Payment | The first step is to initiate a payment. You have a selection of setups and use cases depending on your business model, like recurring and one-click payments - but for now we'll stick to the basic payment. |
| Display UI         | Present a UI for your end user and customize for your needs. The main choice you have to make is between the seamless view or redirect integration. There are pros and cons to both. |
| Validate Status    | Validate the status of the purchase in order to take the right action before acting on the payment response. |
| Post-Purchase actions |  After a successful purchase, you can perform actions like capturing the funds (Trustly and Swish do not require this), cancelling the transaction or do reversals. |

## Get Ready To Go Live

When you feel ready and have made transactions with all of your selected payment
methods, there are a few more steps that remain before your integration is
cleared to run in a production environment. Our teams are ready to assist you.

#### Acceptance tests

We need access to your test environment in order to perform transactions.
Before we do acceptance tests you need to make sure the following is in place:

*   That you receive order confirmations/receipts by e-mail that contain order
number, transaction number, price and the merchant/store's contact information.
*   If you intend to use unscheduled[unscheduled] or recurring[recur] purchases,
  you need to be able to send requests for [deleting tokens][delete-token].
*   Make sure that you can handle [network tokens][nwt] by using our
  [test cards][test-cards] for that specific case.
*   If you expose any transactional data or information such as masked PANs - an
example could be a "My page" with content regarding stored details or
subscriptions - make sure you display the correct information, and take into
account that details can be changed by the issuer if the card is enrolled for
[network tokenization][nwt].

#### Contract details

If you are unsure if the contract is ready, you can check the status with the
setup team by [sending them an e-mail with your organization number included][e-mail].

#### Test in production

We recommend you to first test the integration and do transactions in a closed
production environment before you go live.

#### Settlement and reconciliation

To see how your values might look in the reports you can have a look at our
reports samples. [You find them in our Settlement & Reconciliation section][set-rec].

No need to worry about these steps just yet. We will walk you through everything
when we get there.

[basic-implementation]: /assets/img/checkout/devp-get-started.svg
[delete-token]: /checkout-v3/features/optional/delete-token/
[e-mail]: mailto:support.psp@swedbankpay.se
[https]: /checkout-v3/get-started/fundamental-principles#connection-and-protocol
[json]: https://www.json.org/
[modules-sdks]: /checkout-v3/modules-sdks/
[nwt]: /checkout-v3/features/optional/network-tokenization/
[rest]: https://en.wikipedia.org/wiki/Representational_state_transfer
[set-rec]: /checkout-v3/features/core/settlement-reconciliation/#report-samples
[test-cards]: /checkout-v3/test-data/#network-tokenization
[unscheduled]: /checkout-v3/features/optional/unscheduled/
[recur]: /checkout-v3/features/optional/recur/
