---
Section: ECR On Device
permalink: /:path/
title: ECR On Device
description: Place A POS Application On Terminal
menu_order: 2250
---

## ECR on Device

ECR on device means that you may have your own POS app running on the terminal using our payment app for payments. We will facilitate the download and installation of the POS app, or Business App as we call it, by adding it to our TMS for distribution. The business app is never manually started from a launch screen but is automatically started by our payment app. In the event that the business application is not running, there is a menu choice in the Payment app for starting the Business App.

There are two types of On Device solutions. One where the communication with our payment app occurs on the terminal using broadcast intent, and one where the app is totally unaware of the payment app and only communicates with its backend which in turn uses the cloud connection to our payment app. In the latter case our app will send an explicit intent to your app's main activity, to place it on top before sending a response back on the cloud connection. In the first case your app is responsible to place itself on top when an answer is received. For the cloud connected solution, please contiue reading about the [cloud connection][cloudconnection] and [nexo Retailer][nexoretailer].

The message protocol is [nexo Retailer][nexoretailer] but instead of sending messages using HTTP over a network as with integrations with external devices, android [broadcast intents][broadcastintent] will be used insted. The nexo Retailer for Swedbank Pay may be implemented using default mode receiving requests from the payment app, but for simplicity we recommend implementation as client-only, which makes it really simple. Once a LoginRequest is successful keep sending payment request. Abort is made from the payment app.

{% include card-list.html %}

[nexoretailer]: /pax-terminal/Nexo-Retailer/
[broadcastintent]: /pax-terminal/Nexo-Retailer/Quick-guide/message_transport/intent-transportation
[cloudconnection]: /pax-terminal/cloud/
