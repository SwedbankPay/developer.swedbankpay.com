---
title: Plain Webview
sidebar:
  navigation:
  - title: Mobile SDK
    items:
    - url: /modules-sdks/mobile-sdk/
      title: Introduction
    - url: /modules-sdks/mobile-sdk/merchant-backend
      title: Merchant Backend
    - url: /modules-sdks/mobile-sdk/merchant-backend-sample-code
      title: Merchant Backend Sample Code
    - url: /modules-sdks/mobile-sdk/android
      title: Android
    - url: /modules-sdks/mobile-sdk/ios
      title: iOS
    - url: /modules-sdks/mobile-sdk/process-diagrams
      title: Process Diagrams
    - url: /modules-sdks/mobile-sdk/plain-webview
      title: Plain Webview
---

{% capture disclaimer %}
This page is prodived for informational purposes only,
and is not part of the Mobile SDK documentation proper.
{% endcapture %}

{% include alert.html type="warning" icon="warning" header="Unsupported"
body=disclaimer %}

{% include jumbotron.html body="The **Swedbank Pay Mobile SDK** aims to provide an easy way of integrating Swedbank Pay Checkout into a mobile application. It is, however, an opinionated library, and in particular is has no support for Swedbank Pay Payments at this point. Experience from developing the SDK may still be valuable for integrators wishing to show Payments pages in a Web View inside a mobile application. This page serves as a repository of that experience." %}

## The Mobile SDK And You

A major goal for the Mobile SDK is to provide a platform where you can start developing your mobile e-commerce application rapidly, in a regular, native mobile application development workflow. Hence, it is designed to be a fairly self-contained whole, with a prescribed interface between the mobile client side and the backend server side. This, of course, means that to use the SDK, your backend must implement the API used by the SDK. If you already have a working solution for web pages, this may not be ideal; indeed, you may wish to reuse your existing web page using Checkout or Payments, and expect to embed it inside your mobile application using a web view.

Indeed, on a high level this is what the SDK mobile client components do, in addition to providing native Swift and Kotlin APIs to the servie. The SDK internally generates a web page that shows the Checkout payment menu, so the developer need not concern themselves with html or other web-specific technologies. An exisiting web implementation would not really benefit from the extra discoverability and quality-of-life improvements of a mobile-native API, so the SDK's value proposition seems to be little benefit for substantial reimplementation work.

That said, there are important considerations in embedding a Swedbank-Pay-enabled web page in a web view; considerations, which have been taken into account in the development of the SDK. There are currently no plans to offer any first-party components to help with embedding an existing Swedbank Pay web page, but this page shall serve as best-effort documentation for anyone attempting such.

## Basics

Let us assume that the urls of the payment are as follows:

*   `https://example.com/perform-payment` is the page containing the Payment Menu or Payment Seamless View, i.e. the `paymentUrl`
*   `https://example.com/payment-completed` is the `completeUrl`
*   `https://example.com/payment-canceled` is the `cancelUrl`

Swedbank Pay payments use JavaScript, so that needs to be enabled:

{:.code-header}
**iOS**
```swift
    // WKPreferences.javaScriptEnabled is true by default,
    // so usually there is no need to to do this.
    // Other properties of WKWebViewConfiguration will be
    // needed for later steps, though, so it is good to have
    // it from the beginning.
    let configuration = WKWebViewConfiguration()
    configuration.preferences.javaScriptEnabled = true

    // Note: You can only set a configuration by using this initializer.
    // You cannot set a configuration in Interface Builder.
    let webView = WKWebView(frame: .zero, configuration: configuration)
```

{:.code-header}
**Android**
```kotlin
    val webView = WebView(context) // or get it from a layout

    // WebSettings.javaScriptEnabled is false by default,
    // so failing to do this will result in the payment page not working.
    // Setting javaScriptEnabled to true causes a linter warning,
    // which can be suppressed with an annotation.
    webView.settings.javaScriptEnabled = true
```

Some pages use the DOM Storage API, which must be enabled separately on Android:

{:.code-header}
**Android**
```kotlin
    webView.settings.domStorageEnabled = true
```

With this setup, you can load to the web view the page that shows the Payment Menu or the Payment Seamless View, and see what happens. You should be able to see the Swedbank Pay payment interface, and in many cases also complete a payment. It is not unlikely, though, that some payment methods will not work as expected. Also, you will be more or less stuck after the payment is complete.

{:.code-header}
**iOS**
```swift
    let paymentUrl = URL(string: "https://example.com/perform-payment")!
    webView.load(URLRequest(url: paymentUrl))
```

{:.code-header}
**Android**
```kotlin
    webView.loadUrl("https://example.com/perform-payment")
```

## Completion

There are two ways of being notified of payment completion: listening for navigations, or using JavaScript hooks. Which one you want to use is partly a matter of taste, but if your existing system does some processing in the `completeUrl` page, it may be easier to use JavaScript hooks.

### Listening for Navigations

The iOS `WKNavigationDelegate` protocol and Android `WebViewClient` class can be used to listen for navigations, and change their behaviour.

{:.code-header}
**iOS**
```swift
    // This example uses Self as the delegate.
    // It could be a separate object also.
    webView.navigationDelegate = self
```
```swift
    extension MyClass : WKNavigationDelegate {
        // WKNavigationDelegate methods
    }
```

{:.code-header}
**Android**
```kotlin
    webView.webViewClient = object : WebViewClient() {
        // WebViewClient methods
    }
```

In the simplest case you could listen for a navigation to the `completeUrl` or `cancelUrl`, and intercept it.

{:.code-header}
**iOS**
```swift
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        switch navigationAction.request.url?.absoluteString {
        case "https://example.com/payment-completed":
            decisionHandler(.cancel)
            // Handle payment completion (success/failure)

        case "https://example.com/payment-canceled":
            decisionHandler(.cancel)
            // Handle payment cancellation

        default:
            decisionHandler(.allow)
        }
    }
```

{:.code-header}
**Android**
```kotlin
    override fun shouldOverrideUrlLoading(
        view: WebView?,
        url: String?
    ): Boolean {
        return when (url) {
            "https://example.com/payment-completed" -> {
                // Handle payment completion (success/failure)
                true
            }

            "https://example.com/payment-canceled" -> {
                // Handle payment cancellation
                true
            }

            else -> false
        }
    }
```

If your `completeUrl`, or `cancelUrl` for that matter, do some processing and redirect further, you can adapt these patterns to listen to your custom urls instead.

### Adding JavaScript Hooks

On both iOS and Android, it is possible to add custom JavaScript interfaces to a web view. These interfaces then result in callbacks to native (Swift/Kotlin/ObjC/Java) methods, where you can execute your application specific actions. To observe payment completion and cancellation this way, you need to modify your `completeUrl` and `cancelUrl` pages to call these mobile-app-specific JavaScript interfaces. How you do this is beyond our scope here.

#### JavaScript Hooks: iOS

On iOS, JavaScript interfaces are added through the `WKUserContentController` of the `WKWebView`. The `WKUserContentController` is set by the `WKWebViewConfiguration` used when creating the `WKWebView`; you cannot change the `WKUserContentController` of a `WKWebView`. You can, however, modify the `WKUserContentController` of a live `WKWebView`, if you want more fine-grained control on which interfaces are exposed at what time.

{:.code-header}
**iOS**
```swift
    let userContentController = webView
        .configuration
        .userContentController
    // Alternatively, add the script message handler(s)
    // to configuration.userContentController
    // before creating the WKWebView.

    // This example uses Self as the handler.
    // It could be a separate object also.
    userContentController.add(self, name: "completed")
    userContentController.add(self, name: "canceled")
```
```swift
    extension MyClass : WKScriptMessageHandler {
        func userContentController(
            _ userContentController: WKUserContentController,
            didReceive message: WKScriptMessage
        ) {
            switch message.name {
            case "completed":
                // Handle payment completion (success/failure)

            case "canceled":
                // Handle payment cancellation
            }

            // the argument of the call is available at message.body
        }
    }
```

On iOS, the interfaces added by `WKUserContentController.add(_:name:)` are exposed in JavaScript as `window.webkit.messageHandlers.<name>.postMessage(body)`, so your `completeUrl` and `cancelUrl` pages would need to eventually execute code like

```js
    window.webkit.messageHandlers.completed.postMessage("success")
```
```js
    window.webkit.messageHandlers.canceled.postMessage()
```

#### JavaScript Hooks: Android

{% include alert.html type="warning" icon="warning" header="Security Warning" body="Never use `WebView.addJavascriptInterface` on Android versions earlier than 4.2 (`Build.VERSION_CODES.JELLY_BEAN_MR1`)!" %}

On Android, JavaScript interfaces are added by the `WebView.addJavascriptInterface` method. Any public methods with the `@JavascriptInterface` annotation of the passed-in object are exposed in JavaScript.

{:.code-header}
**Android**
```kotlin
    webView.addJavascriptInterface(
        MyJsInterface(),
        "callbacks"
    )
```
```kotlin
    class MyJsInterface {
        // IMPORTANT!
        // Methods annotated with @JavascriptInterface are
        // NOT called on the main thread. They are called on
        // a private, background, WebView thread.
        // Make sure to only call methods that are safe
        // to call in a background thread, or move execution to
        // the main thread, e.g. by ViewModel.viewModelScope
        // or LifecycleOwner.lifecycleScope (remember that
        // FragmentActivity and Fragment implement LifecycleOwner).

        @JavascriptInterface
        fun completed(status: String) {
            // Handle payment completion (success/failure)
        }

        @JavascriptInterface
        fun canceled() {
            // Handle payment cancellation
        }
    }
```

On Android, the objects added by `WebView.addJavascriptInterface` are exposed as globals with the specified name, and their `@JavascriptInterface public` methods with their JVM names (N.B! Be careful not to break the JVM names with Proguard or similar). Thus, your `completeUrl` and `cancelUrl` pages would need to eventually execute code like

```js
    callbacks.completed("success")
```
```js
    callbacks.canceled()
```

## External Applications

Before starting to implement lauching external applications, you should try to get at least one card payment working. With completion observing in place, you should be able to complete a payment flow, at least using the External Integration environment and its test cards.

Sometimes, a payment flow calls for launching an external application, like BankID or Swish. A web page does this by opening a url that is handled by the app in question. To accommodate for this, we extend the "Listening for Navigations" approach above. If you opted for JavaScript hooks for completion, you will now need to add a navigation listener for external apps.

Determining whether a url should launch an external app is straightforward, though on Android it involves a bit of a judgement call. Let us take a look at the arguably simpler iOS case first.

### External Applications: iOS

You cannot query the system for an arbitrary url to see if it can be opened – this is a deliberate privacy measure. What can be done, and what also happens to be exactly what we want to do, is to attempt to open a url and receive a callback telling us whether it succeeded. Nowadays, the recommended way of opening external applications is to use Universal Links, anyway, which are, on the surface, indistiguishable from web links.

{:.code-header}
**iOS**
```swift
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        // Check for completeUrl and cancelUrl here, if applicable.

        if let url = navigationAction.request.url {
            openInExternalApp(
                url: url,
                decisionHandler: decisionHandler
            )
        } else {
            // N.B. This should never happen.
            decisionHandler(.allow)
        }
    }

    private func openInExternalApp(
        url: URL,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        // First, check for universal link
        UIApplication.shared.open(
            url,
            options: [.universalLinksOnly: true]
        ) { universalLinkOpened in
            if universalLinkOpened {
                // Url was opened in external app, so do not open it in WKWebView.
                decisionHandler(.cancel)
            } else {
                // Url was not opened in external app, see if WKWebView can handle it.
                if let scheme = url.scheme,
                    WKWebView.handlesURLScheme(scheme) {
                    // Regular http(s) url, proceed.
                    decisionHandler(.allow)
                } else {
                    // Custom-scheme url. Try to open it.
                    UIApplication.shared.open(url)
                    // Cancel the navigation regardless of the result,
                    // as WKWebView does not know what to do with the url anyway.
                    decisionHandler(.cancel)
                }
            }
        }
    }
```

### External Applications: Android

On Android, web pages attempting to launch external apps happens in one of three ways:

*   Custom-scheme links
*   Http(s) links matching a pattern
*   Intent-scheme links

Each of these maps into an `Intent`. For custom-scheme and patterned http(s) links, that `Intent` has the original url as its `uri`, an `action` of `android.intent.action.VIEW`, and the categories `android.intent.category.BROWSABLE` and `android.intent.category.DEFAULT`. An `Intent` created from an intent-scheme url can have any `action` and categories, although they too should have an implicit `android.intent.category.BROWSABLE` category. Their `uri` is parsed from the intent-scheme url, but we need not trouble ourselves with the specifics here.

On Android we can, and indeed should, query the system whether it can launch Activities from arbitrary Intents. We should note, however, that an Android system is likely to have an app that accepts all http(s) url, namely the browser. Hence, we should exercise a bit of discretion when choosing to launch activities in place of web view navigations.

{:.code-header}
**Android**
```kotlin
    override fun shouldOverrideUrlLoading(
        view: WebView?,
        url: String?
    ): Boolean {
        // Check for completeUrl and cancelUrl here, if applicable.

        if (url == null) return false // should never happen

        val uri = Uri.parse(url)
        if (openInExternalApp(uri)) {
            return true
        } else {
            // uri was not opened in a external app.
            // Let WebView take care of it, if it is
            // a normal http(s) url.
            return when (uri.scheme) {
                "http", "https" -> false
                else -> true
            }
        }
    }

    private fun openInExternalApp(uri: Uri): Boolean {
        when (uri.scheme) {
            "intent" -> {
                openIntentUri(uri)
                // intent uris are always intercepted,
                // as WebView cannot handle them anyway
                return true
            }
            else -> {
                return openRegularUri(uri)
            }
        }
    }

    private fun openIntentUri(uri: Uri) {
        val intent = try {
            Intent.parseUri(
                uri.toString(),
                Intent.URI_INTENT_SCHEME
            )
        } catch (_: URISyntaxException) {
            return
        }
        // Web pages should only be allowed to start activities
        // with CATEGORY_BROWSABLE.
        intent.addCategory(Intent.CATEGORY_BROWSABLE)
        if (canStartActivity(intent)) {
            try {
                startActivity(intent)
            } catch (_: Exception) {
                // Could not start activity.
                // There is little we can do here.
            }
        } else {
            openIntentUriFallbackUrl(intent)
        }
    }

    private fun openIntentUriFallbackUrl(intent: Intent) {
        val fallbackUrl = intent.getStringExtra("browser_fallback_url")
        if (fallbackUrl != null) {
            val fallbackIntent = Intent(
                Intent.ACTION_VIEW,
                Uri.parse(fallbackUrl)
            ).addCategory(Intent.CATEGORY_BROWSABLE)
            if (canStartActivity(fallbackIntent)) {
                try {
                    startActivity(fallbackIntent)
                } catch (_: Exception) {}
            }
        }
    }


    private fun openRegularUri(uri: Uri): Boolean {
        val intent = Intent(Intent.ACTION_VIEW, uri)
            .addCategory(Intent.CATEGORY_BROWSABLE)
        val resolveInfo = resolveActivity(intent)
        val shouldStartActivity = resolveInfo != null && when (uri.scheme) {
            "http", "https" -> shouldStartActivityForHttpUri(uri, resolveInfo)
            else -> true
        }
        if (shouldStartActivity) {
            try {
                startActivity(intent)
                return true
            } catch (_: Exception) {}
        }
        return false
    }

    private fun resolveActivity(intent: Intent): ResolveInfo? {
        return packageManager.resolveActivity(
            intent,
            PackageManager.MATCH_DEFAULT_ONLY
        )
    }

    private fun canStartActivity(intent: Intent): Boolean {
        return resolveActivity(intent) != null
    }

    private fun shouldStartActivityForHttpUri(
        resolveInfo: ResolveInfo
    ): Boolean {
        // Only open http(s) links in external apps
        // if the intent filter is a "good" match.
        // Requiring a matching host in the intent filter
        // is the most reasonable generic choice, but
        // you can exercise more fine-grained control here
        // if you wish.
        val matchCategory = resolveInfo.match and IntentFilter.MATCH_CATEGORY_MASK
        return matchCategory >= IntentFilter.MATCH_CATEGORY_HOST
    }
```

## Getting Back from External Applications

In some cases on Android, getting back from the external application requires no further setup. In particular, this is the case with BankID, if the web page launches it in the recommended manner. In other cases, including any scenario on iOS, the external app will attempt to return to the payment by opening the `paymentUrl`. Assuming the `paymentUrl` is an https url, it would normally be opened in the browser application (usually Safari or Chrome), so we need to build a system that gets it back to the application where the payment is being processed in a web view.

### Using a Custom-Scheme paymentUrl

Perhaps the simplest way of making `paymentUrl` open in the application is to make it a custom-scheme url rather than an https url. This does come with a few disadvantages, though:

*   On iOS, the system will show a confirmation popup, which cannot be customized, before opening a custom-scheme url
*   Related to the above, there is no way of making sure your application is the only one installed that handles the scheme
*   `paymentUrl` is passed to systems outside Swedbank Pay; systems that may only be compatible with http(s) urls

It is somewhat of a Quick and Dirty solution. We do not recommend this approach.

### iOS: Make paymentUrl a Universal Link

On iOS, the recommended way of assigning urls to apps is to use [Universal Links][ios-universal-links]. This fits our use-case quite well, and indeed it is what the SDK is designed to do too. When an external app executes the `UIApplication.shared.open("https://example.com/perform-payment")`, then, assuming Universal Links are configured correctly, that url will not be opened in Safari, but will instead be opened in the application. You must then examine the url, determine that it is a `paymentUrl` from your app, and reload the `paymentUrl` in your web view. The payment process should then continue normally. Make sure that any navigation listeners and JavaScript hooks are in place before loading the `paymentUrl`.

Now, Universal Links depend on correct configuration, and during development you may find yourself with a broken configuration from time to time. But perhaps even more importantly, Universal Links cannot really be 100% guaranteed to work every time. Please see the iOS SDK documentation for some discussion, but also note that even with correct configuration, the system could fail to retrieve your apple-app-site-association file for any given installation, which could render your universal links temporarily inoperable on that device. This means that your `paymentUrl` needs to show some sensible content in case it is opened in Safari. There are a few ways of going at this, but one possibility, assuming you have a working implementation for web in place, is to show your regular payment page, allow the payment to complete there, and then try to launch your application, perhaps by a custom-scheme url, or a universal link to a separate domain. Take a look at [what the SDK does][sdk-paymenturl] to not be trapped by unhappy circumstances.

Note that the Universal Links documentation is not explicit on which `UIApplicationDelegate` method is called when an application opens a universal link with `UIApplication.open(_:options:completionHandler:)` (i.e. `application(_:open:options:)` or `application(_:continue:restorationHandler:)`). It is probably best to implement both. Universal Links opened from Safari will callback to `application(_:continue:restorationHandler:)`.

### Android: Add an Intent Filter for paymentUrl

Android has always supported apps handling urls matching a pattern. Therefore, it seems sensible to just create an intent filter matching any `paymentUrl` you might create. As `paymentUrl`s are entirely under your control, you can design a system where they fit a pattern that can be realized as an intent filter. You then receive the url in the relevant app component in the normal manner, and proceed to reload the `paymentUrl` in your web view. The payment process will then continue normally.

The downsides of this are:

*   You are restricted in how you can change the way you form `paymentUrl`s
*   There are other apps that can also handle the `paymentUrl`, namely the browser

Because of the latter, when an external application opens `paymentUrl`, there are three things that can happen:

*   `paymentUrl` is opened in your app
*   `paymentUrl` is opened in another app, e.g. Chrome
*   an app chooser is shown

The second one is obviously undesirable. The last one is also not great. The user is not expecting to "open a url", and may well make the "wrong" choice here, and it is anyway a bad user experience.

#### Autoverify to the Rescue?

Since Android 6.0 it has been possible to use a [mechanism][android-autoverify] very similar to Apple's Universal Links to "strongly" assing http(s) urls to applications. This works by adding an `android:autoVerify="true"` attribute to the intent filter, plus a `.well-known/assetlinks.json` file to the server. This could solve the problems above, but it has its own issues, namely:

*   Requires Android 6.0
*   Is really quite cumbersome to setup

The SDK does not use this method.

### Android: Have paymentUrl Redirect to an Intent Url

Another option on Android is to allow the https `paymentUrl` to be opened in Chrome normally, but have that url redirect to an [intent url][android-intent-scheme]. That intent url can be made specific to your application, making it so that unless the user has installed an application with the same package id (from a non-Google-Play source, presumably), it will always be opened in your app. This is what the SDK does.

The SDK does this by having `paymentUrl` return an http redirect response. This appears to work in all cases, though the documentation is not explicit on this. Now, as here we seem to want to have `paymentUrl` be the url loaded in the WebView, this does not work out-of-the-box. One option is to override `shouldInterceptRequest` in your `WebViewClient`, and special-case the loading of `paymentUrl`. Another solution could be loading `paymentUrl` normally, but adding a script to the page that checks for a JavaScript interface you provide in the WebView, and it is not there, then it would issue the redirect to the intent url. The documentation does state that Chrome will not launch an app "When the Intent URI is initiated without user gesture." As this is not what has been done in the SDK, we have not first-hand knowledge on best practices here. A redirect that happens during the page load may be allowed here. If it is not, then a button or some other way of issuing the redirect from user interaction is needed.

For reference, the way the SDK handles `paymentUrl`s on Android looks like this from the perspective of the backend:

{:.code-header}
**Request**
```http
    GET /perform-payment
    Host: example.com
```

{:.code-header}
**Response**
```http
    HTTP/1.1 301 Moved Permanently
    Location: intent://example.com/perform-payment#Intent;scheme=https;action=com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER;package=com.example.app;end;`;
```

It uses an action defined by the SDK, and the package name of the containing application, making sure the intent is routed to the correct application, and to the correct SDK component. Note that the uri of the resulting intent is the `paymentUrl`.

## Dealing with Picky Web Pages

Testing has shown, that on iOS some 3D-Secure pages do not like being opened in a web view. It does seem that this is mostly related to BankID integrations. We believe the problem stems from a configuration that sets a cookie in the browser, launches BankID, then BankID opens a different web page (not the `paymentUrl`), which expects to find that cookie. Now, if the first page was opened in a web view, the cookie is in that web view, but as the second page will be opened in Safari, the cookie will be nowhere to be found. Furthermore, at least in one instance, the original page in the web view will not receive any notification on the BankID process, despite being launched from there. We have not encountered this on Android, but it is quite possible for a similar situation to happen there also.

Now, all of the above is speculation, and not really worth getting too deep into. The end result, however, is that some 3DS pages must be opened in Safari on iOS. The jury is still out if the same is true on Android. Fortunately, with the `paymentUrl` handling in place, this is straightforward to do: simply treat any urls not known to be working as "external app urls", i.e. open them with `UIApplication.shared.open(url)` and call the `decisionHandler` with `.cancel`. The payment will eventually navigate to `paymentUrl` in Safari, and should return to the app. It should be noted, though, that in many cases the initial navigation to `paymentUrl` will be opened in Safari instead of the app in these cases. This acerbates the need for fallback mechanisms.

The iOS (and possibly Android) SDKs will contain a list of known-good 3DS pages. Feel free to use this as a resource in your own implementation.

{% include iterator.html prev_href="process-diagrams"
                         prev_title="Back: Process Diagrams" %}

[ios-universal-links]: https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content
[sdk-paymenturl]: /modules-sdks/mobile-sdk/ios#payment-url-and-external-applications
[android-autoverify]: https://developer.android.com/training/app-links/verify-site-associations
[android-intent-scheme]: https://developer.chrome.com/multidevice/android/intents
