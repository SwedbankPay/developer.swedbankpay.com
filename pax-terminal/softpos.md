---
title: Pay SoftPos
permalink: /:path/softpos/
description: |
 An introduction to Pay SoftPos
menu_order: 2500
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
set of APIs by contacting a [Norwegian][contact-no] or [Swedish][contact-se]
sales representative respectively.

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

## Minimum Device Requirements

There are a handful of device requirements which must be fulfilled for Pay
SoftPos to work. The device(s):

*   Must have minimum Android 10.0 for consumer devices and minimum Android 8.0
  for enterprise devices.
*   Must have an Android Security patch date that does not exceed 12 months.
*   Must have built-in device hardware NFC (android.hardware.nfc).
*   Must have a 64 bit ARM v8 processor or greater.
*   Must have a stable internet connection.
*   Must be Google Mobile Services certified and enabled.
*   Must be a single screen device.

## Proven Devices

An overview of tested/proven devices and a non-exhaustive list of unsupported
devices.

#### Consumer Devices

{:.table .table-striped}
| Manufacturer             | Models  |
| :----------------------- | :----------- |
| Google                   | Pixel (3, 4, 5, 6, 6 Pro, 7a, 8, 9)          |
| Motorola                 | G31, G54         |
| Nokia                    | 6.2, G20          |
| Nothing Phone            | Nothing Phone 3a Pro          |
| OnePlus                  | 7T Pro, 8 Pro, 9 5G, Pro 5G, 10 Pro 5G          |
| Samsung                  | A15, A21s, A22 (+, 5G), A26, A32 (+, 5G), A33 5G, A34, A35, A36, A40, A51, A52 (+ 5G, s5G), A54, A56, A71, S10 (+, e, 5G, Lite), S20 (+, 5G, +5G, FE, FE 5G, Ultra 5G), S21 (+, 5G, +5G, FE, FE 5G, Ultra 5G) S22 (+, 5G, Ultra), S23, Xcover (+ Pro, Field pro, 4S, 5, 5 Enterprise)        |
| Sony                     | Xperia 10V         |

#### Enterprise Devices

{:.table .table-striped}
| Manufacturer             | Models  |
| :----------------------- | :----------- |
| Bluebird                 | EF501, HF550X |
| Elo                      | M50C, M51, Elo Pay 22-inch |
| Honeywell                | CT40, CT30P, CT37, CT45P, CT70, EDA10A |
| iMin*                    | Swift 2 PRO, Lark1 |
| Landi*                   | M20 (only GMS), M20SE (only GMS), C20DS |
| Memor                    | Memor 17 |
| Mobiwire                 | MobiPrint5, MobiGo2 |
| Oona/AAVA                | Oona 10", Oona 8", Oona1W |
| Orderman                 | 10 |
| Point Mobile             | PM45, PM67, PM75, PM85 |
| RCH                      | APE3, A15 |
| Sunmi*                   | V2s, V2s Plus, L2H, L2s PRO, D3 MINI-Single screen, V3 MIX, V3H, Flex3 |
| Telpo                    | M1K, M8       |
| Unitech                  | EA630, PA768         |
| Urovo                    | CT58, DT50, DT66     |
| Zebra                    | TC21, TC22, TC27, TC52, TC57, TC58, CC6000, EC55, TC53E, KC50        |

*Also available in iMin, Landi and/or Sumni stores respectively.

#### Unsupported Devices (Non-Exhaustive)

Devices not adhering to the full Softpay Mobile Device Policy and PCI/MPoC
requirements are unsupported.

{:.table .table-striped}
| Manufacturer             | Models  |
| :----------------------- | :----------- |
| Huawei                  | All devices        |
| Samsung                  | Samsung Galaxy A-series is (with a few exceptions) not supported from A13 and below. Samsung Galaxy S-series is not supported from S9 and below.        |
| Sunmi                  | V2       |
| Motorola                  | G9 (Power, Plus)        |

[contact-se]: mailto:sales@swedbankpay.se
[contact-no]: mailto:salg@swedbankpay.no
