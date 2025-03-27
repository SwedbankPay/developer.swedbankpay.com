---
Section: ECR On Device
permalink: /:path/
title: ECR On Device
description: Place A POS Application On Terminal
menu_order: 2250
---

## ECR on Device

ECR on device means that you may have your own POS app running on the terminal using our payment app for payments. We will facilitate the download and installation of the POS app, or Business App as we call it, by adding it to our TMS for distribution. The business app is never manually started from a launch screen but is automatically started by our payment app. In the event that the business application is not running, there is a menu choice in the Payment app for starting the Business App.

The message protocol is [nexo Retailer][nexoretailer] but instead of sending messages using HTTP over a network as with integrations with external devices, android [broadcast intents][broadcastintent] will be used insted. The nexo Retailer for Swedbank Pay may be implemented using default mode receiving requests from the payment app, but for simplicity we recommend implementation as client-only, which makes it really simple. Once a LoginRequest is successful keep sending payment request. Abort is made from the payment app.

{% include card-list.html %}

[nexoretailer]: /pax-terminal/Nexo-Retailer/
[broadcastintent]: /pax-terminal/Nexo-Retailer/Quick-guide/message_transport/intent_transportation
