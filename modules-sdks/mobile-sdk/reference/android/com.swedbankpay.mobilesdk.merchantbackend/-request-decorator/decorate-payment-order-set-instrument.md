---
title: decoratePaymentOrderSetInstrument
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[RequestDecorator](index.html)/[decoratePaymentOrderSetInstrument](decorate-payment-order-set-instrument.html)



# decoratePaymentOrderSetInstrument



[androidJvm]\
open suspend fun [decoratePaymentOrderSetInstrument](decorate-payment-order-set-instrument.html)(userHeaders: [UserHeaders](../-user-headers/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))



Override this method to add custom headers to the PATCH {setInstrument} request of a payment order.



The default implementation does nothing.



## Parameters


androidJvm

| | |
|---|---|
| userHeaders | headers added to this will be sent with the request |
| url | the url of the request |
| body | the body of the request |
| instrument | the instrument used to create the request body |




