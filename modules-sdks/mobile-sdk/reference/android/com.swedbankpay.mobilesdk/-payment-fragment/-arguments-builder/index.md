---
title: ArgumentsBuilder
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentFragment](../index.html)/[ArgumentsBuilder](index.html)



# ArgumentsBuilder



[androidJvm]\
class [ArgumentsBuilder](index.html)

Builder class for the argument [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html) used by PaymentFragment.



## Constructors


| | |
|---|---|
| [ArgumentsBuilder](-arguments-builder.html) | [androidJvm]<br>fun [ArgumentsBuilder](-arguments-builder.html)() |


## Functions


| Name | Summary |
|---|---|
| [build](build.html) | [androidJvm]<br>fun [build](build.html)(): [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html)<br>Convenience for build(Bundle()).<br>[androidJvm]<br>fun [build](build.html)(bundle: [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html)): [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html)<br>Adds the values in this ArgumentsBuilder to a [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html). |
| [consumer](consumer.html) | [androidJvm]<br>fun [consumer](consumer.html)(consumer: [Consumer](../../-consumer/index.html)?): [PaymentFragment.ArgumentsBuilder](index.html)<br>Sets a consumer for this payment. Also enables or disables checkin based on the argument: If consumer is null, disables checkin; if consumer consumer is not null, enables checkin. If you wish to override this, call [useCheckin](use-checkin.html) afterwards. |
| [debugIntentUris](debug-intent-uris.html) | [androidJvm]<br>fun [debugIntentUris](debug-intent-uris.html)(debugIntentUris: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)): [PaymentFragment.ArgumentsBuilder](index.html)<br>Enables or disables verbose error dialogs when Android Intent Uris do not function correctly. |
| [paymentOrder](payment-order.html) | [androidJvm]<br>fun [paymentOrder](payment-order.html)(paymentOrder: [PaymentOrder](../../-payment-order/index.html)?): [PaymentFragment.ArgumentsBuilder](index.html)<br>Sets the payment order to create |
| [setEnabledDefaultUI](set-enabled-default-u-i.html) | [androidJvm]<br>fun [setEnabledDefaultUI](set-enabled-default-u-i.html)(vararg defaultUI: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)): [PaymentFragment.ArgumentsBuilder](index.html)<br>Set the enabled default user interfaces. |
| [style](style.html) | [androidJvm]<br>fun [style](style.html)(style: [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html)): [PaymentFragment.ArgumentsBuilder](index.html)<br>fun [style](style.html)(style: [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html)&lt;*, *&gt;): [PaymentFragment.ArgumentsBuilder](index.html)<br>Sets styling for the payment menu. |
| [useBrowser](use-browser.html) | [androidJvm]<br>fun [useBrowser](use-browser.html)(external: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false): [PaymentFragment.ArgumentsBuilder](index.html)<br>Sets if the payment flow should open an external browser or continue in WebView. |
| [useCheckin](use-checkin.html) | [androidJvm]<br>fun [useCheckin](use-checkin.html)(useCheckin: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)): [PaymentFragment.ArgumentsBuilder](index.html)<br>Enables or disables checkin for this payment. Mostly useful for using [userData](user-data.html) and a custom [Configuration](../../-configuration/index.html). |
| [userData](user-data.html) | [androidJvm]<br>fun [userData](user-data.html)(userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [PaymentFragment.ArgumentsBuilder](index.html)<br>Sets custom data for the payment. |
| [viewModelProviderKey](view-model-provider-key.html) | [androidJvm]<br>fun [viewModelProviderKey](view-model-provider-key.html)(viewModelKey: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?): [PaymentFragment.ArgumentsBuilder](index.html)<br>Sets the key used on the containing [activity's](https://developer.android.com/reference/kotlin/androidx/fragment/app/FragmentActivity.html)[ViewModelProvider](https://developer.android.com/reference/kotlin/androidx/lifecycle/ViewModelProvider.html) for the [PaymentViewModel](../../-payment-view-model/index.html). This is only useful for special scenarios. |

