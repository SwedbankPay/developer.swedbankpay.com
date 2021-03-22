## Problems

When using the Merchant Backend Configuration, most errors in the payment
process will result in [Problem][problems] responses from the backend.
The SDK contains utilities for processing these in your application.

On Android, if any operation fails due to a Problem, the resulting exception
will be of the type `RequestProblemException`, which allows access to the
`Problem` object. `Problem` is a JVM representation of the Problem JSON
response, allowing for easy access to standard fields. You are free to use
`Problem` as-is for modeling your own problem types. The Merchant Backend
Configuration further defines a subclass of `Problem`,
`MerchantBackendProblem`, which is a sealed class containg all the problem
types expected to occur with a Merchant Backend server. All problems reported
by the Merchant Backenc Configuration are of this type, allowing you to use
kotlin's powerful `when` expression to handle the different errors:

{:.code-view-header}
**Android**

```kotlin
when (problem) {
    is MerchantBackendProblem.Client.MobileSDK.Unauthorized ->
        handleUnauthorized()
    is MerchantBackendProblem.Client ->
        handleOtherClientError()
    is MerchantBackendProblem.Server.MobileSDK ->
        handleMerchantBackendError()
    is MerchantBackendProblem.Server.SwedbankPay.ConfigurationError ->
        handleConfigurationError()
    is MerchantBackendProblem.Server.SwedbankPay ->
        handleSwedbankPayError()
    else ->
        handleUnknownError()

}
```

On iOS, if any operation fails due to a Problem, the resultig error will be
`SwedbankPaySDK.MerchantBackendError.problem`, and it will have the problem
as an associated value, of type `SwedbankPaySDK.Problem`.
`SwedbankPaySDK.Problem` is a enum with a similar structure to the Android
`MerchantBackendProblem`, allowing for idiomatic error handling.

{:.code-view-header}
**iOS**

```swift
if case SwedbankPaySDK.MerchantBackendError.problem(let problem) = error {
    switch problem {
    case .client(.mobileSDK(.unauthorized)):
        handleUnauthorized()
    case .client:
        handleOtherClientError()
    case .server(.mobileSDK):
        handleMerchantBackendError()
    case .server(.swedbankPay):
        handleSwedbankPayError()
    default:
        handleUnknownError()
    }
}
```

[problems]: /payment-menu/features/technical-reference/problems
