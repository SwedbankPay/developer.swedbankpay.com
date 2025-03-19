---
permalink: /:path/messaging/
title: Messaging To and From ECR On Device App
description: Broadcast Intents are used for messaging
menu_order: 165
---

## Intent Actions Used

When the payment app is broadcasting messages to business apps it uses the following two actions:

*   `com.swedbankpay.payment.intent.ECR_NEXO_MESSAGE`
*   `com.swedbankpay.payment.intent.ECR_ADMIN`

When a business app is broadcasting messages to the business app it uses the following:

*   `com.swedbankpay.payment.intent.TERMINAL_NEXO_MESSAGE`
*   `com.swedbankpay.payment.intent.TERMINAL_ADMIN`

The business app should use `TEMINAL_ADMIN` with `Intent.extras` set to the admin action `OPEN_ADMIN_MENU` to access the configuration menu of the payment app. The other available admin actions are not really used, since whenever any of these intents are received the receiver is supposed to move itself to front.

{:.code-view-header}
**Available admin actions**

```kotlin
enum class AdminAction {
    MOVE_TO_BACK,
    MOVE_TO_FRONT,
    OPEN_ADMIN_MENU
}
```

{% include alert.html type="warning" icon="warning" header="Note"
body="The payment app sends ECR_ADMIN action with nothing in intent.extras. Just move the business app to front."
%}

{% include iterator.html next_href="/pax-terminal/OnDevice/broadcastreceiver" next_title="Next" %}
{% include iterator.html next_href="/pax-terminal/OnDevice" next_title="Back" %}
