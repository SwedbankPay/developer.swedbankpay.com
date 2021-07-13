---
title: toStyleBundle -
---
//[sdk](../../index)/[com.swedbankpay.mobilesdk](index)/[toStyleBundle](to-style-bundle)



# toStyleBundle  
[androidJvm]  
Content  
fun [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html)<*, *>.[toStyleBundle](to-style-bundle)(): [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html)  
More info  


Convert a [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html) containing styling parameters to a [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html).



Styling parameters must be [passed](-payment-fragment/-companion/-a-r-g_-s-t-y-l-e) to [PaymentFragment](-payment-fragment/index) as a [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html), but it may be more convenient to build the parameters as a [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html) and convert them to a [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html) with this function.



It may be simpler to use [PaymentFragment.ArgumentsBuilder](-payment-fragment/-arguments-builder/index) and [style](-payment-fragment/-arguments-builder/style) instead.



E.g:

    arguments.putBundle(ARG_STYLE, mapOf(
        "thisElement" to mapOf(
            "thisAttribute" to "x",
            "thatAttribute" to "y"
        ),
        "thatElement" to mapOf(
            "yonAttribute" to "z"
        )
    ).toStyleBundle())  



