---
title: SwedbankPaySDK.ViewPaymentOrderInfo
---
# SwedbankPaySDK.ViewPaymentOrderInfo

Data required to show the payment menu.

``` swift
struct ViewPaymentOrderInfo 
```

If you provide a custom SwedbankPayConfiguration
you must get the relevant data from your services
and supply a ViewPaymentOrderInfo
in your SwedbankPayConfiguration.postPaymentorders
completion call.

## Inheritance

`Codable`

## Initializers

### `init(webViewBaseURL:viewPaymentorder:completeUrl:cancelUrl:paymentUrl:termsOfServiceUrl:instrument:availableInstruments:userInfo:)`

``` swift
public init(
            webViewBaseURL: URL?,
            viewPaymentorder: URL,
            completeUrl: URL,
            cancelUrl: URL?,
            paymentUrl: URL?,
            termsOfServiceUrl: URL?,
            instrument: Instrument? = nil,
            availableInstruments: [Instrument]? = nil,
            userInfo: Any? = nil
        ) 
```

### `init(from:)`

``` swift
public init(from decoder: Decoder) throws 
```

## Properties

### `webViewBaseURL`

The url to use as the WKWebView page url
when showing the payment menu.

``` swift
public var webViewBaseURL: URL?
```

This should match your payment order's `hostUrls`.

### `viewPaymentorder`

The `view-paymentorder` link from Swedbank Pay.

``` swift
public var viewPaymentorder: URL
```

### `completeUrl`

The `completeUrl` of the payment order

``` swift
public var completeUrl: URL
```

This url will not be opened in normal operation,
so it need not point to an actual web page,
but it must be a valid url and it must be distinct
form the other urls.

### `cancelUrl`

The `cancelUrl` of the payment order

``` swift
public var cancelUrl: URL?
```

This url will not be opened in normal operation,
so it need not point to an actual web page,
but it must be a valid url and it must be distinct
form the other urls.

### `paymentUrl`

The `paymentUrl` of the payment order

``` swift
public var paymentUrl: URL?
```

The `paymentUrl` you set for your payment order must be a
Universal Link to your app. When your app receives it in the
`UIApplicationDelegate.application(_:continue:restorationHandler:)`
method, you must forward it to the SDK by calling
`SwedbankPaySDK.continue(userActivity:)`. If it is helpful for your
systems, you may add extra query parameters to the `paymentUrl`;
the SDK will ignore these when checking for equality to an ongoing
payment's `paymentUrl` (the Merchant Backend example does this
to work around a scenario where Universal Links are not routed
the way we would wish on iOS 13.3 and below).

Additionally, if your `paymentUrl` is opened in the browser, it must
ultimately open a url that is otherwise equal to the `paymentUrl`, but
it has the `callbackScheme` of your `SwedbankPaySDKConfiguration`.
It may also have additional query parameters, similar to the above.
When you receive this url in your
`UIApplicationDelegate(_:open:options:)` method, you must
forward it to the SDK by calling `SwedbankPaySDK.open(url:)`

### Example

When using the `MerchantBackendConfiguration` and the
related convenience constructors of `SwedbankPaySDK.PaymentOrderUrls`,
the actual `paymentUrl`, i.e. this value, will look like this:

  - https://example.com/sdk-callback/ios-universal-link?scheme=fallback\&language=en-US\&id=1234

Your `UIApplicationDelegate.application(_:continue:restorationHandler:)`
can be called either with that url; or if the page was opened in the browser, the
call will have an extra parameter (this is added by the backend to prevent an infinite loop):

  - https://example.com/sdk-callback/ios-universal-link?scheme=fallback\&language=en-US\&id=1234\&fallback=true

If neither of the above urls is routed to your app (perhaps because of a broken
Universal Link configuration), then the page in the brower will instead open
a url equal to the second one, with the scheme replaced. You will then receive
an url in your `UIApplicationDelegate(_:open:options:)` method
that looks like this:

  - fallback://example.com/sdk-callback/ios-universal-link?scheme=fallback\&language=en-US\&id=1234\&fallback=true

### `termsOfServiceUrl`

The `termsOfServiceUrl` of the payment order

``` swift
public var termsOfServiceUrl: URL?
```

By default, this url will be opened when the user
taps on the Terms of Service link.
You can override that behaviour in your
`SwedbankPaySDKDelegate`.

### `instrument`

If the payment order is in instrument mode, the current instrument

``` swift
public var instrument: Instrument?
```

The SDK does not use this property for anything, so you need not set
a value even if you are using instrument mode. But if you are implementing
instrument mode payments, it is probably helpful if you set
a value here. `MerchantBackendConfiguration` sets this property
and `validInstruments` if the payment order it creates is in instrument mode.

### `availableInstruments`

If the payment order is in instrument mode, all the valid instruments for it

``` swift
public var availableInstruments: [Instrument]?
```

The SDK does not use this property for anything, so you need not set
a value even if you are using instrument mode. But if you are implementing
instrument mode payments, it is probably helpful if you set
a value here. `MerchantBackendConfiguration` sets this property
and `instrument` if the payment order it creates is in instrument mode.

### `userInfo`

Any data you need for the proper functioning of your `SwedbankPaySDKConfiguration`.

``` swift
public var userInfo: Any?
```

## Methods

### `encode(to:)`

``` swift
public func encode(to encoder: Encoder) throws 
```
