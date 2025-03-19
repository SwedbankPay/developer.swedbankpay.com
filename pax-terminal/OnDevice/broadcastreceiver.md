---
permalink: /:path/broadcastreceiver/
title: Broadcast Receiver
description: Broadcast Receiver Needed For ECR On Device App
menu_order: 170
---

## Broadcast Receiver

The business app needs to implement a broadcast receiver that filters the following actions

*   `com.swedbankpay.payment.intent.ECR_NEXO_MESSAGE`
*   `com.swedbankpay.payment.intent.ECR_ADMIN`

Whenever these are received the business app should place itself on top. For `ECR_NEXO_MESSAGE` the actual `SaleToPOIResponse\Request` is placed in the property `extras` of the intent.

{:.code-view-header}
**what it could look like if using kotlin**

```kotlin
{
    @Inject
    lateinit var nexoHandler: NexoHandler

    override fun onReceive(
        context: Context,
        intent: Intent,
    ) {
        AndroidInjection.inject(this, context)

        moveToForground(context);

        val nexoMessage = requireNotNull(intent.extras?.getByteArray(Intent.EXTRA_TEXT))
        nexoHandler.handle(nexoMessage)
    }

    private fun moveToForeground(context: Context) {
        Intent(context, MainActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT)
        }.also { context.startActivity(it) }
    }

}
```

{% include iterator.html next_href="/pax-terminal/OnDevice/nexoimplementation" prev_title="Next" %}
{% include iterator.html next_href="/pax-terminal/OnDevice" next_title="Back" %}
