---
Section: ECR On Device
permalink: /:path/
title: ECR On Device
description: Place A POS Application On Terminal
menu_order: 2250
---

## ECR on Device

ECR on device means that you may have your own POS app running on the terminal using our payment app for payments.
The POS app or `business app` as we call it, has to be downloaded from our TMS and is automatically started by our payment app. The app is never started from a launch screen. There is however a menu choice in the payment app for starting the business app in case it is not running.

The message protocol is [nexo Retailer][nexoretailer] but instead of sending messages using HTTP over a network, android [broadcast intents][broadcastintent] will be used insted. The nexo Retailer for Swedbank Pay should be implemented as client-only, which makes it really simple. Once a LoginRequest is successful keep sending payment request. Abort is made from the payment app.

{% include card-list.html %}

[nexoretailer]: /pax-terminal/Nexo-Retailer/
[broadcastintent]: /pax-terminal/Nexo-Retailer/Quick-guide/message_transport/intent_transportation
