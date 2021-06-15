---
title: toStyleBundle
---
//[mobilesdk](../../index.html)/[com.swedbankpay.mobilesdk](index.html)/[toStyleBundle](to-style-bundle.html)



# toStyleBundle



[androidJvm]\
fun [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html)&lt;*, *&gt;.[toStyleBundle](to-style-bundle.html)(): [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html)



Convert a [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html) containing styling parameters to a [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html).



Styling parameters must be [passed](-payment-fragment/-companion/-a-r-g_-s-t-y-l-e.html) to [PaymentFragment](-payment-fragment/index.html) as a [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html), but it may be more convenient to build the parameters as a [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html) and convert them to a [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html) with this function.



It may be simpler to use [PaymentFragment.ArgumentsBuilder](-payment-fragment/-arguments-builder/index.html) and [style](-payment-fragment/-arguments-builder/style.html) instead.



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


