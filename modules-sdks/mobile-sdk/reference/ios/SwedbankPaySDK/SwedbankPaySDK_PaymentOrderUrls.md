---
title: SwedbankPaySDK.PaymentOrderUrls
---
# SwedbankPaySDK.PaymentOrderUrls

A set of URLs relevant to a payment order.

``` swift
struct PaymentOrderUrls : Codable, Equatable 
```

The Mobile SDK places some requirements on these URLs,  different to the web-page case.
See individual properties for discussion.

## Inheritance

`Codable`, `Equatable`

## Initializers

### `init(hostUrls:completeUrl:cancelUrl:paymentUrl:callbackUrl:termsOfServiceUrl:)`

``` swift
public init(
            hostUrls: [URL],
            completeUrl: URL,
            cancelUrl: URL? = nil,
            paymentUrl: URL? = nil,
            callbackUrl: URL? = nil,
            termsOfServiceUrl: URL? = nil
        ) 
```

## Properties

### `hostUrls`

Array of URLs that are valid for embedding this payment order.

``` swift
public var hostUrls: [URL]
```

The SDK generates the web page that embeds the payment order internally, so it is not really
hosted anywhere. However, the WebView will use the value returned in
`ViewPaymentOrderInfo.webViewBaseUrl` as the url of that generated page. Therefore,
the `webViewBaseUrl` you use should match `hostUrls` here.

### `completeUrl`

The URL that the payment menu will redirect to when the payment is complete.

``` swift
public var completeUrl: URL
```

The SDK will capture the navigation before it happens; the `completeUrl` will never be
actually loaded in the WebView. Thus, the only requirement for this URL is that is is
formally valid.

### `cancelUrl`

The URL that the payment menu will redirect to when the payment is canceled.

``` swift
public var cancelUrl: URL?
```

The SDK will capture the navigation before it happens; i.e. this works similarly to how
`completeUrl` does.

### `paymentUrl`

A URL that will be navigated to when the payment menu needs to be reloaded.

``` swift
public var paymentUrl: URL?
```

The `paymentUrl` is used to get back to the payment menu after some third-party process
related to the payment is completed. As long as the process stays within the SDK controlled
WebView, we can intercept the navigation, like `completeUrl` , and reload the payment menu.
However, because those processes may involve opening other applications, we must also be
prepared for `paymentUrl` being opened from those third-party applications. In particular,
we must be prepared for `paymentUrl` being opened in Safari.

The have `paymentUrl` handed over to the SDK, it must be a Universal Link registered to your
application. With Univeral Links correctly configured, the `paymentUrl` should be routed
to your application, and you will receive it in your
`UIApplicationDelegate.application(_:continue:restorationHandler:)` method. From there,
you must forward it to the SDK by calling `SwedbankPaySDK.continue(userActivity:)`.

In some cases the `paymentUrl` will be opened in Safari instead, despite correct
Universal Links configuration. To handle this situation you have the option of
attempting to retrigger the Univeral Links routing by redirecting the from `paymentUrl`
to a different domain, with a link back to `paymentUrl`. Please refer to the documentation
in the Swedbank Pay Developer Portal for further discussion of the mechanics involved.
To facilitate the backend part of this system, the SDK will also accept URLs that
have additional query parameters added to the original `paymentUrl`.

As a final fallback, you may invoke a URL with a custom scheme registered to your
application. In addition to changing the scheme, that URL may also add query parameters,
but should be otherwise equal to the original `paymentUrl`. When you receive such a URL
in your `UIApplicationDelegate.application(_:open:options:)` method, forward it to
the SDK by calling `SwedbankPaySDK.open(url:)`.

For advanced use-cases, you can customize the URL-matching behaviour described above
in your `SwedbankPayConfiguration.`

Each `paymentUrl` you create should be unique inside your application.

### `callbackUrl`

A URL on your server that receives status callbacks related to the payment.

``` swift
public var callbackUrl: URL?
```

The SDK does not interact with this server-to-server URL and as such places no
requirements on it.

### `termsOfServiceUrl`

A URL to your Terms of Service.

``` swift
public var termsOfServiceUrl: URL?
```

By default, pressing the Terms of Service link present a view controller that
loads this URL in a `WKWebView`. You can override this behaviour through
`SwedbankPaySDKDelegate.overrideTermsOfServiceTapped(url:)`.
