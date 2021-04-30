## Payment Orders

The SDK works in terms of Payment Orders as used in [Checkout][checkout]
and [Payment Menu][payment-menu]. Therefore, all [features][checkout-features]
of payment orders are available in the SDK by using a suitable custom
configuration.

The rest of the page illustrates how to use certain Payment Order features
with the SDK-provided Merchant Backend Configuration. Detailed descriptions
of the features will not be repeated here; please refer to the
[Checkout documentation][checkout-features] instead.

### URLs

A Payment Order created for the SDK must have [`urls`][checkout-urls] the same
way a Payment Order to be used on a web page would. The SDK context places some
requirement on these urls.

{:.table .table-striped}
| Field               | SDK Requirements                                                                                                                                                |
| :------------------ | :------- | :--------------------------------------------------------------------------------------------------------------------------------------------------- |
| `hostUrls`          | Should match the value your Configuration returns in the `webViewBaseURL` of `ViewPaymentOrderInfo`.                                                            |
| `completeUrl`       | No special requirements. However, the SDK will intercept the navigation, so `completeUrl` will not actually be opened in the SDK Web View.                      |
| `termsOfServiceUrl` | No special requirements.                                                                                                                                        |
| `cancelUrl`         | No special requirements. However, the SDK will intercept the navigation, so `cancelUrl` will not actually be opened in the SDK Web View.                        |
| `paymentUrl`        | If opened in a browser, must eventually be delivered to the SDK, bringing the containing app to the foreground. See the Android and iOS specific documentation. |
| `callbackUrl`       | No special requirements. This is a server-to-server affair.                                                                                                     |

#### Merchant Backend Configuration

The SDK-provided Merchant Backend Configuration allows creating a set of `urls`
that fulfill the above when used with a backend implementing the Merchant
Backend API.

{:.code-view-header}
**Android**

```kotlin
// backendUrl is the the backendUrl of your MerchantBackendConfiguration
val urls = PaymentOrderUrls(
    context = context,
    backendUrl = backendUrl
    callbackUrl = callbackUrl,
    termsOfServiceUrl = termsOfServiceUrl
)
```

{:.code-view-header}
**iOS**

```kotlin
// On iOS, the `paymentUrl` has a nonnegligible chance of actually being shown in Safari,
// so we want to localize it. This is why we need the language parameter here.
let urls = SwedbankPaySDK.PaymentOrderUrls(
    configuration: configuration,
    language: language,
    callbackUrl: callbackUrl,
    termsOfServiceUrl: termsOfServiceUrl
)
```

### Order Items

You may want to populate the `orderItems` field of the `paymentOrder` for e.g.
printing invoices. The SDK offers facilities for working with `orderItems`,
allowing you to discover the fields of an Order Item in your IDE.

Please refer to the [Checkout documentation][checkout-orderitems] and/or the
class documentation for the meaning of the fields.

On Android, `OrderItem` is a data class, so its instances are immutable,
but you can easily create copies with modified fields.

{:.code-view-header}
**Android**

```kotlin
val orderItem = OrderItem(
    reference = "123abc",
    name = "Thing",
    // ItemType is a enum, allowing you to discover the options in your IDE
    type = ItemType.PRODUCT,
    `class` = "Things",
    // Optional Order Item fields are optional in the kotlin OrderItem class as well.
    // The optional fields default to null, so you do not need to specify them if
    // you do not use them.
    itemUrl = null,
    quantity = 1,
    quantityUnit = "pcs",
    unitPrice = 1000,
    vatPercent = 2500 // 25%,
    amount = 1000,
    vatAmount = 200
)

// OrderItem is immutable, but easy to create partially modified copies of
val otherItem = orderItem.copy(
    reference = "456def",
    name = "Other Thing"
)
```

On iOS `SwedbankPaySDK.OrderItem` is a struct, allowing you to store and modify
them like any other Swift values.

{:.code-view-header}
**iOS**

```swift
var orderItem = SwedbankPaySDK.OrderItem(
    reference: "123abc",
    name: "Thing",
    // SwedbankPaySDK.ItemType is a enum, allowing you to discover the options in your IDE
    type: .Product,
    class: "Things",
    quantity: 1,
    quantityUnit: "pcs",
    unitPrice: 1000,
    vatPercent: 2500 // 25%,
    amount: 1000,
    vatAmount: 200
)

// a SwedbankPaySDK.OrderItem var is mutable like any var
orderItem.reference = "456def"
orderItem.name = "Other Thing"
```

[checkout]: /checkout/
[payment-menu]: /payment-menu/
[checkout-features]: /checkout/v2/features
[checkout-urls]: /checkout/v2/features/technical-reference/urls
[checkout-orderitems]: /checkout/v2/features/technical-reference/order-items
