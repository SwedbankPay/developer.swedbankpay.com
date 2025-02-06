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
moment: v3.0 and v3.1. Collectively we refer to them as **v3.x**. If we use v3.x
instead of a specific version number, this means that the text paragraph,
feature section or code example applies to all Digital Payments versions. Unless
stated otherwise by the presence of a separate v3.1 section, there are no
differences between the two alternatives.

If youre a new merchant currently getting started, you should implement v3.1.
[If you are an existing merchant we recommend migrating to v3.1][migrate], but
you are still able to use v3.0. Reach out to your technical contact person for
guidance regarding this.

## The Basic Implementation

The **basic payment integration** consists of 4 main steps. **Creating** the
payment, **displaying** the payment UI, **verifying** the payment status and
**post-purchase actions**. Don't hesitate with contacting us for further
integration support.

Depending on the payment method used, the payments are either **one-phase** or
**two-phase** transactions. **Swish** and **Trustly** have one-phase payments,
the rest of the payment methods are two-phased. One-phase payments are completed
and the funds are transferred in one operation. They will be tagged as `Sale`
transactions. Two-phase payments need two operations (`Authorization` and
`Capture`) before funds are transferred. Read more about differences in handling
when you get to the [post-purchase section][post-purchase].

![Implementation steps][basic-implementation]{:class="mt-4 mb-5"}

{:.table .table-plain}
| ----------: | ----------: |
| Initiate a Payment | The first step is to initiate a payment. You have a selection of setups and use cases depending on your business model, like recurring and one-click payments - for now we'll stick to the basic payment. |
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
*   If you intend to use [unscheduled] or [recur] purchases,
  you need to be able to send requests for [deleting tokens][delete-token].
*   Make sure that you can handle [network tokens][nwt] by using our
  [test cards][test-cards] for that specific case.
*   If you expose any transactional data or information such as masked PANs - an
example could be a "My page" with content regarding stored details or
subscriptions - make sure you display the correct information, and take into
account that details can be changed by the issuer if the card is enrolled for
[network tokenization][nwt].

#### Contract details

If you are unsure if the contract is ready, you can check the status with our
setup team by [sending them an e-mail with your organization number included][e-mail].

#### Test in production

We recommend you to test the integration and do transactions in a **closed**
**production environment** before you go live.

#### Settlement and reconciliation

To see how your reports will look, you can check out our sample reports.
[You'll find them in the Settlement & Reconciliation section][set-rec].

No need to worry about these steps just yet. We will walk you through everything
when we get there.

[basic-implementation]: /assets/img/checkout/devp-get-started.png
[delete-token]: /checkout-v3/features/optional/delete-token/
[e-mail]: mailto:support.psp@swedbankpay.se
[https]: /checkout-v3/get-started/fundamental-principles#connection-and-protocol
[json]: https://www.json.org/
[migrate]: /checkout-v3/migrate
[modules-sdks]: /checkout-v3/modules-sdks/
[nwt]: /checkout-v3/features/customize-payments/network-tokenization/
[post-purchase]: /checkout-v3/get-started/post-purchase-3-1/
[rest]: https://en.wikipedia.org/wiki/Representational_state_transfer
[set-rec]: /checkout-v3/features/balancing-the-books/settlement-reconciliation/#report-samples
[test-cards]: /checkout-v3/test-data/#network-tokenization
[unscheduled]: /checkout-v3/features/optional/unscheduled/
[recur]: /checkout-v3/features/optional/recur/
