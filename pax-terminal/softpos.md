---
title: Pay SoftPos
permalink: /:path/softpos/
description: |
 An introduction to Pay SoftPos
menu_order: 1100
---

Pay SoftPos allows a merchant to turn a commercial off-the-shelf mobile phone
into a contactless payment terminal without requiring additional dedicated
hardware. For merchants this offers mobile payment terminals at a different
price point than existing mobile hardware terminals for EMV transactions.

It also allows merchants to utilize other mobile devices they already have and
use, decreasing the number of devices to carry around and offering a standalone
or more integrated experience.

## The User Experience

The merchant installs the Pay SoftPos app on a mobile phone and presents the
device and application to the payer. The payer taps the payment device and
details of the EMV transaction are exchanged between the payment device and the
Pay SoftPos app through the phone's built-in NFC reader.

If a PIN is needed the application presents a PIN pad to the payer, who enters
the PIN and confirms. Shortly after the outcome of the processing is presented.

## Transactional Flow

The details from the transaction are sent to the backend, which in turn
processes the information and relays it to a payment processor or acquirer,
which eventually communicates with the payer's card issuer.

Besides processing payments, the backend also manages the terminals and
continuously attempts to attest that the Pay SoftPos application, or the
platform it runs on, is eligible and not compromised.

## Stand-Alone Or Integrated

The mobile application can run as a standalone application where the merchant
enters an amount and completes a payment. It can also be integrated through APIs
with another Android Point of Sales (POS) application on the same device or a
POS system, that runs on a different platform and/or device, such as a Windows
powered computer. The primary use case is typically to activate the app with a
pre-entered amount.

This will require the AppSwitch SDK, which needs to be embedded in the Point of
Sales (POS) app.

The features available are shown in the table below, and you can access the full
set of APIs by contacting a sales representative.

For both standalone and integrated scenarios, it is only the Pay SoftPos app
that is within the PCI-DSS certification scope. This makes it simpler for
customers to complete the integration.

The Pay SoftPos app is delivered via Google Play Store. Mobile device management
systems can orchestrate the installation on individual devices.

{:.table .table-striped}
| Feature                  | Stand-Alone  | AppSwitch            |
| :----------------------- | :----------- | :------------------- |
| Payment                  | Yes          | Yes                  |
| Payment loyalty / change amount  | No   | Yes                  |
| Refund                   | Yes, in app  | Yes                  |
| Cancellation             | Yes, in app  | Yes                  |
| Store card details for e-commerce | No  | Yes                  |
| Configuration            | No           | Yes                  |
| Get transaction list     | Yes, in app  | Yes                  |
| Get store list           | No           | Yes                  |
| End of Day report        | Yes, in app  | Yes (data)           |
| On device switching      | 1-way        | 2-way                |
| Off device switching, external POS | No          | No          |
| Integration method     | URL link to app | Embedded library in Android POS |
