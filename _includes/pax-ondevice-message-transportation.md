Messages sent to and from the Swedbank Pay Payment App are sent using broadcast intents.

For messages sent to the payment app the intent `com.swedbankpay.payment.intent.TERMINAL_NEXO_MESSAGE` is used, and for messages sent from the payment app to another app the intent `com.swedbankpay.payment.intent.ECR_NEXO_MESSAGE` is used.

The complete nexo `SaleToPOIResponse` or `SaleToPOIRequest` is placed as a byte array in the property `extra` of the intent.

```kotlin
private fun sendMessageIntent(data: ByteArray) {
    Intent().also { intent: Intent ->
        intent.setAction("com.swedbankpay.payment.intent.TERMINAL_NEXO_MESSAGE")
        intent.putExtra(Intent.EXTRA_TEXT, data)
        sendBroadcast(intent)
    }
}
```
