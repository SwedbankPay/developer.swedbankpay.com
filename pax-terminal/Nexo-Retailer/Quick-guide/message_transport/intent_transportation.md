---
title: Message Transport On Device
permalink: /:path/intent_transportation/
hide_from_sidebar: false
description: |
    Messages sent internallay in the terminal to and from the Swedbank Pay Payment App are sent
     using broadcast intents.
icon:
    content: tap_and_play
    outlined: true
menu_order: 25
---

Messages sent to and from the Swedbank Pay Payment App are sent using broadcast intents.

Messages sent to the payment app are sent using the intent **"com.swedbankpay.payment.intent.TERMINAL_NEXO_MESSAGE"** and messages sent from the payment app to another app is using **"com.swedbankpay.payment.intent.ECR_NEXO_MESSAGE"**.

The complete nexo `SaleToPOIResponse` or `SaleToPOIRequest` is placed as a byte array in the property **Extra** of the intent.

```kotlin
private fun sendMessageIntent(data: ByteArray) {
    Intent().also { intent: Intent ->
        intent.setAction("com.swedbankpay.payment.intent.TERMINAL_NEXO_MESSAGE")
        intent.putExtra(Intent.EXTRA_TEXT, data)
        sendBroadcast(intent)
    }
}
```

{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/first-message" next_title="Next" %}
