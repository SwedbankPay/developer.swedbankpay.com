---
title: SwedbankPaySDKConfiguration
---
# SwedbankPaySDKConfiguration

A SwedbankPaySDKConfiguration is responsible for
creating and manipulating Consumer Identification Sessions
and Payment Orders as required by the SwedbankPaySDKController.

``` swift
public protocol SwedbankPaySDKConfiguration 
```

See SwedbankPaySDK.MerchantBackendConfiguration for
a configuration that integrates with a backend implementing
the Merchant Backend API.

## Default Implementations

### `updatePaymentOrder(paymentOrder:userData:viewPaymentOrderInfo:updateInfo:completion:)`

``` swift
func updatePaymentOrder(
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?,
        viewPaymentOrderInfo: SwedbankPaySDK.ViewPaymentOrderInfo,
        updateInfo: Any,
        completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void
    ) -> SwedbankPaySDKRequest? 
```

### `urlMatchesListOfGoodRedirects(_:completion:)`

Check if the given url matches the built-in list of known-good
payment menu redirects. The completion callback is always called
on the main thread.

``` swift
func urlMatchesListOfGoodRedirects(_ url: URL, completion: @escaping (Bool) -> Void) 
```

#### Parameters

  - url: the URL to check
  - completion: called with `true` if url matches the list, called with `false` otherwise

### `decidePolicyForPaymentMenuRedirect(navigationAction:completion:)`

``` swift
func decidePolicyForPaymentMenuRedirect(
        navigationAction: WKNavigationAction,
        completion: @escaping (SwedbankPaySDK.PaymentMenuRedirectPolicy) -> Void
    ) 
```

### `url(_:matchesPaymentUrl:)`

``` swift
func url(_ url: URL, matchesPaymentUrl paymentUrl: URL) -> Bool 
```

## Requirements

### postConsumers(consumer:​userData:​completion:​)

Called by SwedbankPaySDKController when it needs to start a consumer identification
session. Your implementation must ultimately make the call to Swedbank Pay API
and call completion with a SwedbankPaySDK.ViewConsumerIdentificationInfo describing the result.

``` swift
func postConsumers(
        consumer: SwedbankPaySDK.Consumer?,
        userData: Any?,
        completion: @escaping (Result<SwedbankPaySDK.ViewConsumerIdentificationInfo, Error>) -> Void
    )
```

#### Parameters

  - consumer: he SwedbankPaySDK.Consumer the SwedbankPaySDKController was created with
  - userData: the user data the SwedbankPaySDKController was created with
  - completion: callback you must invoke to supply the result

### postPaymentorders(paymentOrder:​userData:​consumerProfileRef:​completion:​)

Called by SwedbankPaySDKController when it needs to create a payment order.
Your implementation must ultimately make the call to Swedbank Pay API
and call completion with a SwedbankPaySDK.ViewPaymentOrderInfo describing the result.

``` swift
func postPaymentorders(
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?,
        consumerProfileRef: String?,
        completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void
    )
```

#### Parameters

  - paymentOrder: the SwedbankPaySDK.PaymentOrder the SwedbankPaySDKController was created with
  - userData: the user data the SwedbankPaySDKController was created with
  - consumerProfileRef: if a checkin was performed first, the `consumerProfileRef` from checkin
  - completion: callback you must invoke to supply the result

### updatePaymentOrder(paymentOrder:​userData:​viewPaymentOrderInfo:​updateInfo:​completion:​)

Called by SwedbankPaySDKController when it needs to update the
ongoing payment order.

``` swift
func updatePaymentOrder(
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?,
        viewPaymentOrderInfo: SwedbankPaySDK.ViewPaymentOrderInfo,
        updateInfo: Any,
        completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void
    ) -> SwedbankPaySDKRequest?
```

As the update could be cancelled, you must also return a request handle
that allows the request to cancelled.

#### Parameters

  - paymentOrder: the SwedbankPaySDK.PaymentOrder the SwedbankPaySDKController was created with
  - userData: the user data the SwedbankPaySDKController was created with
  - viewPaymentOrderInfo: the current ViewPaymentOrderInfo as returned from a call to this or postPaymentorders
  - updateInfo: the updateInfo value from the `updatePaymentOrder` call As you are in control of both the configuration and the update call, you can coordinate the actual type used here.
  - completion: callback you must invoke to supply the result

#### Returns

a cancellation handle to the request started by this call

### decidePolicyForPaymentMenuRedirect(navigationAction:​completion:​)

Called by SwedbankPaySDKController when the payment menu is about to navigate
to a different page. Testing has shown that some pages are incompatible with
WKWebView. The SDK contains a list of redirects tested to be working, but you
can customize the behaviour by providing a custom implementation of this method.

``` swift
func decidePolicyForPaymentMenuRedirect(
        navigationAction: WKNavigationAction,
        completion: @escaping (SwedbankPaySDK.PaymentMenuRedirectPolicy) -> Void
    )
```

The default implementation returns .openInWebView if the url of the navigation
matches the built-in list, and .openInBrowser otherwise.
If you override this method, but wish to access the built-in list of known-good
redirects, call urlMatchesListOfGoodRedirects.

#### Parameters

  - navigationAction: the navigation that is about to happen
  - completion: callback you must invoke to supply the result

### url(\_:​matchesPaymentUrl:​)

Called by SwedbankPaySDKController when it needs to check if a given url
is equivalent to a `paymentUrl` of a payment order.
This method has a default implementation. In advanced scenarios you
may wish to provide your own implementation instead.

``` swift
func url(_ url: URL, matchesPaymentUrl paymentUrl: URL) -> Bool
```

The default implementation from allows for the scheme to change,
and for extra query parameters to be added to the paymentUrl.
I.e. if the paymentUrl is https://example.com/?a=1,
then all of the following match:

  - https://example.com/?a=1

  - https://example.com/?a=1\&b=2

  - com.example.my.app://example.com/?a=1

  - com.example.my.app://example.com/?a=1\&b=2

The need for this method merits some discussion.
When a 3D-Secure flow starts an external application, such as
BankID, that application will in turn continue the flow by opening
some url. Usually that url will be a url of the card issuer, and therefore
not routed back to our app. Instead, it will be opened in Safari. Of course,
ultimately that page will navigate to the paymentUrl of the payment order
in progress. Assuming both your backend and your app are configured correctly,
the paymentUrl should be a Universal Link to your app, and you should
receive the url your
`UIApplicationDelegate.application(_:continue:restorationHandler:)`.
You will then forward the url to the SDK by calling
`SwedbankPaySDK.continue(userActivity:)`. The url there is then equal
to the payment order's paymentUrl (which you reported to the SDK in the
`ViewPaymentOrderInfo`), the SDK recognizes this, and the payment menu is reloaded.

However, the mechanics of Universal Links make them unreliable. To work around
their limitations, we must allow for alternate urls to also match the paymentUrl.
To see why, consider the following flow of events:

1.  The card issuer page navigates to `paymentUrl`. This is our first opportunity;
    Here the url is equal to `paymentUrl`.
2.  Assume `paymentUrl` is opened in Safari. We must show some html content to the user.
    Show them a page with a "continue" button, which links back to the `paymentUrl`,
    but with an extra parameter (this is needed for the next step).
    This is our second opportunity; here the url is `paymentUrl` with an extra query
    parameter.
3.  Assume the `paymentUrl` with extra parameter is *also* opened in Safari.
    (N.B\! This should not happen with if all parts of your system are configured
    correctly, but in principle it is possible that iOS has not yet successfully
    retrieved your apple-app-site-association file. Also this scenario is prone to
    occuring during development, so it is nice not to get stuck here.) We show the same
    html content, except the "continue" button now links to `paymentUrl` with the scheme
    changed to a scheme unique to your app.
4.  There is nowhere else for the custom-scheme link to go except your app, so
    here is our final possibility of getting the url. Now the url is `paymentUrl`
    but with a different scheme. (In our Merchant Backend example implementation,
    it is actually `paymentUrl` with both an extra query parameter and a different
    scheme, to simplify the implementation.) Note that in this case we get the url
    in our `UIApplicationDelegate.application(_:open:options:)` method instead.
