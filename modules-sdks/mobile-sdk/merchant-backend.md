---
title: Merchant Backend
estimated_read: 20
description: |
  To use the **Swedbank Pay Mobile SDK**, you must have a backend server
  that communicates with your Configuration. The fastest way to start
  developing is to use the Merchant Backend API.
menu_order: 800
---

{% capture disclaimer %}
The SDK is at an early stage of development
and is not supported as of yet by Swedbank Pay. It is provided as a
convenience to speed up your development, so please feel free to play around.
However, if you need support, please wait for a future, stable release.
{% endcapture %}

{% include alert.html type="warning" icon="warning" header="Unsupported"
body=disclaimer %}

The Merchant Backend API serves as a simple starting point, and an illustrative example of how to integrate the SDK to your backend systems. The SDK has a Configuration implementation for a backend implementing this API; in addition, there is both a Node.js and a Java sample implementation of this API available.

Even if you plan to integrate the SDK using your own backend API, it is recommended to read through this chapter; especially the section Payment Url Helper Endpoints, which will illustrate how any `paymentUrl` created for the SDK should behave.

The Mobile SDK Merchant Backend API contains a total of six endpoints, three of which have statically defined paths. An OpenAPI specification is [available][swagger]. (It may be easier to view it in the [Swagger Editor][swagger-editor].)

The main part of the API is designed as a transparent wrapper around the Swedbank Pay API, which is the same one used in Checkout. Additionally, two "helper" endpoints are specified, which facilitate the proper routing of the [Payment Url][payment-url] back to the originating app.

## Authentication and Authorization

You should have some authorization and authentication measures in place to prevent misuse of your Merchant Backend API. The sample implementations have a very rudimentary API key header check. This may or may not be sufficient to your purposes. You should adapt the sample implementation or create your own according to your security needs.

The mobile component of the SDK allows adding your own headers to the requests it makes. Therefore you can build your own authentication and authorization measures by adding custom headers in the app, and checking that they have the correct content in the backend.

## The Merchant Backend Configuration

To use a backend implementing the Merchant Backend API, you can use the Merchant Backend Configuration provided with the SDK. This implementation is available as `SwedbankPaySDK.MerchantBackendConfiguration` on iOS and `com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration` on Android; on Android you create the `MerchantBackendConfiguration` object via a `MerchantBackendConfiguration.Builder`.

At a minimum, you must supply the url of the Merchant Backend, i.e. the url of the Root Endpoint. On iOS, you must also have registered a URL type for the SDK: that URL type must have a single scheme, and an additional property with name `com.swedbank.SwedbankPaySDK.callback`, type `Boolean`, and value `YES`. Alternatively you may set the url scheme explicitly in the initializer. Refer to the class documentation for more options.

## Root Endpoint

The root endpoint is used to discover the main API endpoints. The URL of the root endpoint is what is configured as the "Backend URL" in the mobile SDK component. The point of this is to not bind your service to any particular path or even domain. In most cases, however, you can serve a static response for the root endpoint, with the other endpoint urls being relative to the root endpoint. The sample implementations do this.

{:.code-view-header}
**Request**

```http
GET /swedbank-pay-mobile/ HTTP/1.1
Host: example.com
Your-Api-Key: secretish
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "consumers": "/swedbank-pay-mobile/consumers",
    "paymentorders": "/swedbank-pay-mobile/paymentorders"
}
```

{:.table .table-striped}
| Field           | Type     | Description                                                                  |
| :-------------- | :------- | :--------------------------------------------------------------------------- |
| `consumers`     | `string` | URL of the "consumers" endpoint. Resolved against the root endpoint URL.     |
| `paymentorders` | `string` | URL of the "paymentorders" endpoint. Resolved against the root endpoint URL. |

N.B! The API as specified allows assigning endpoints to hosts other that the root endpoint host. However, as this seen to be an uncommon use case, the mobile component of the SDK is, by default, configured to only accept links to the domain of the root endpoint, or its subdomains. If your configuration uses other hosts, you must manually allow them in your mobile app's configuration.

## Consumers Endpoint

The `consumers` endpoint is used to start a consumer identification session. It is specified as a transparent wrapper around the corresponding [Swedbank Pay API][initiate-consumer-session]. The sample implementations do superficial input validation, and forward the request to the Swedbank Pay API without further processing. You are free to override this default behaviour as you see fit in your implementation, but the default should be fine for most use-cases. The expected response is the same as the expected response to the Swedbank Pay API. The default is to pass the response from Swedbank as-is; you should probably not modify this behaviour. Specifically, the response must contain the `view-consumer-identification` operation.

{:.code-view-header}
**Request**

```http
POST /swedbank-pay-mobile/consumers HTTP/1.1
Host: example.com
Your-Api-Key: secretish
Content-Type: application/json

{
    "operation": "initiate-consumer-session",
    "language": "sv-SE",
    "shippingAddressRestrictedToCountryCodes" : ["NO", "SE", "DK"]
}
```

{:.table .table-striped}
|     Required     | Field                                     | Type     | Description                                                                                                                            |
| :--------------: | :---------------------------------------- | :------- | :------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `operation`                               | `string` | `initiate-consumer-session`, the operation to perform.                                                                                 |
| {% icon check %} | `language`                                | `string` | Selected language to be used in Checkin. Supported values are {% include field-description-language.md %} |
| {% icon check %} | `shippingAddressRestrictedToCountryCodes` | `string` | List of supported shipping countries for merchant. Using ISO-3166 standard.                                                            |

At this point, the Merchant Backend will make a corresponding request to the Swedbank Pay API, using its secret access token.

{:.code-view-header}
**Forwarded Request**

```http
POST /psp/consumers HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "operation": "initiate-consumer-session",
    "language": "sv-SE",
    "shippingAddressRestrictedToCountryCodes" : ["NO", "SE", "DK"]
}
```

The Merchant Backend will then forward the response it received back to the calling app.

{:.code-view-header}
**Response &amp; Forwarded Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "token": "7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871",
    "operations": [
        {
            "method": "GET",
            "rel": "redirect-consumer-identification",
            "href": "{{ page.front_end_url }}/consumers/sessions/7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "rel": "view-consumer-identification",
            "href": "{{ page.front_end_url }}/consumers/core/scripts/client/px.consumer.client.js?token={{ page.payment_token }}",
            "contentType": "application/javascript"
        }
    ]
}
```

{:.table .table-striped}
| Field                 | Type     | Description                                                                                                                                       |
| :-------------------- | :------- | :------------------------------------------------------------------------------------------------------------------------------------------------ |
| `token`               | `string` | A session token used to initiate Checkout UI.                                                                                                     |
| `operations`          | `array`  | The array of operation objects to choose from, described in detail in the table below.                                                            |
| └➔&nbsp;`rel`         | `string` | The relational name of the operation, used as a programmatic identifier to find the correct operation given the current state of the application. |
| └➔&nbsp;`method`      | `string` | The HTTP method to use when performing the operation.                                                                                             |
| └➔&nbsp;`contentType` | `string` | The HTTP content type of the target URI. Indicates what sort of resource is to be found at the URI, how it is expected to be used and behave.     |
| └➔&nbsp;`href`        | `string` | The target URI of the operation.                                                                                                                  |

## Payment Orders Endpoint

The `paymentorders` endpoint is used to create a new Payment Order. It is specified as a transparent wrapper around the corresponding [Swedbank Pay API][create-payment-order]. However, it is to be expected that your backend will need to process the payment order both before making the Swedbank Pay API call, and after receiving the response from Swedbank Pay. The sample implementations validate the input, then create an internal unique identitifer for the payment order, and set that as `paymentorder.payeeInfo.payeeReference`, before making the Swedbank Pay call. After receiving the response, the backend stores the `id` of the Payment Order for future use, and forwards the response to the SDK.

Optionally, if your implementation uses [instrument mode payments][instrument-mode], your backend can return the list of valid instruments, along with an endpoint to change the instrument. If you do this, you must also implement the Change Instrument endpoint. The Merchant Backend Configuration on the client side can then use this endpoint to change the instrument of an ongoing payment order.

A production implementation should validate the payment order also from a business logic perspective. This is, naturally, outside the scope of the SDK, as is any other processing you may wish to perform with the payment order. The SDK expects the same form of response as returned from the Swedbank Pay API. Specifically, the response must contain the `view-paymentorder` operation.

{:.code-view-header}
**Request**

```http
POST /swedbank-pay-mobile/paymentorders HTTP/1.1
Host: example.com
Your-Api-Key: secretish
Content-Type: application/json

{
    "paymentorder": { "①": "" }
}
```

{:.table .table-striped}
|     Required     | Field          | Type     | Description                 |
| :--------------: | :------------- | :------- | :-------------------------- |
| {% icon check %} | `paymentorder` | `object` | The payment order to create |

*   ① The contents of `paymentorder` are omitted here. See [Checkout Documentation][create-payment-order] for details.

At this point, the Merchant Backend will preform necessary processing, and make a corresponding request to the Swedbank Pay API, using its secret access token.

{:.code-view-header}
**Forwarded Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": { }
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
    "paymentorder": {
      "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce"
    },
    "operations": [
        {
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=5a17c24e-d459-4567-bbad-aa0f17a76119&culture=sv-SE",
            "rel": "view-paymentorder",
            "method": "GET",
            "contentType": "application/javascript"
        }
    ]
}
```

The Merchant Backend will then forward the response it received back to the calling app.

If instrument mode is used, an you wish to be able to change the instrument, you can provide the list of valid instruments, and an endpoint for changing the instrument. This additional data is placed in an object under the key "mobileSDK".

{:.code-view-header}
**Forwarded Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
    "paymentorder": {
      "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce"
    },
    "operations": [
        {
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=5a17c24e-d459-4567-bbad-aa0f17a76119&culture=sv-SE",
            "rel": "view-paymentorder",
            "method": "GET",
            "contentType": "application/javascript"
        }
    ]
    "mobileSDK": {
        "validInstruments": ["CreditCard", "Invoice-PayExFinancingSe"],
        "setInstrument": "/paymentorders/1234/setInstrument"
    }
}
```

## Set Instrument Endpoint

You only need to implement this endpoint if you are using instrument mode payments. This endpoint is invoked when making a request to the `mobileSDK.setInstrument` url of a payment order created with the Payment Orders endpoint.

This endpoint forwards the PATCH request made to it to the corresponding Swedbank Pay endpoint, as identified by the `update-paymentorder-setinstrument` operation of the payment order. It passes the response to that request back to the SDK. The sample implementation verifies the request body to contain exactly the operation `SetInstrument` and a string `instrument`.

{:.code-view-header}
**Request**

```http
POST /swedbank-pay-mobile/paymentorders HTTP/1.1
Host: example.com
Your-Api-Key: secretish
Content-Type: application/json

{
    "paymentorder": {
        "operation": "SetInstrument",
        "intrument": "CreditCard"
    }
}
```

{:.table .table-striped}
|     Required     | Field                | Type     | Description                               |
| :--------------: | :------------------- | :------- | :---------------------------------------- |
| {% icon check %} | `paymentorder`       | `object` | The changes to make to the payment order  |
| {% icon check %} | └➔&nbsp;`operation`  | `string` | The operation to perform: "SetInstrument" |
| {% icon check %} | └➔&nbsp;`instrument` | `string` | The instrument to set                     |


Merchant Backend will then make a corresponding request to the Swedbank Pay API.

{:.code-view-header}
**Forwarded Request**

```http
PATCH /psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "SetInstrument",
        "intrument": "CreditCard"
    }
}
```

The Merchant Backend will then forward the response it received back to the calling app. If needed, you can append the `mobileSDK` object to this response as well. If it is missing, the SDK will assume the original values are still valid.

{:.code-view-header}
**Response &amp; Forwarded Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
    "paymentorder": {
      "id": "/psp/paymentorders/09ccd29a-7c4f-4752-9396-12100cbfecce"
    },
    "operations": [
        {
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=5a17c24e-d459-4567-bbad-aa0f17a76119&culture=sv-SE",
            "rel": "view-paymentorder",
            "method": "GET",
            "contentType": "application/javascript"
        }
    ]
}
```

## Payment Url Helper Endpoints

The [Payment Url][payment-url] helper endpoints do not interact directly with Swedbank Pay. Instead, they are used to route any navigations to the payment order's payment url to the app using the SDK.

The payment url allows navigations to third-party sites to happen as a part of the payment process. To continue the payment after any third-party processes, navigating to the payment url is expected to load the payment menu again. In the case of an app using the SDK, this means that the payment url must be routed to that app, and the app must react to that url by reloading the payment menu. Furthermore, for maximum compatibility, the payment url should be a regular https url.

Since we want the payment urls to be https urls, they must be hosted somewhere. These helper endpoints facilitate that. Each platform has its own payment url helper, due to the platforms' different requirements for url routing. The endpoints take query arguments to enable apps using the SDK to locally generate unique payment urls for each payment order. The endpoints have no side-effects, and will always return the same response for the same query arguments.

The payment url helper endpoints are specified with static paths relative to the root endpoint url. This is done so that payment urls can be generated locally on the app, without needing to make a network round trip at that point. The SDK has no hard requirement for the helper endpoint urls to have such a relationship to the root endpoint url, but it does contain utility methods for easier integration when that is the case. If you wish to host the payment url helper endpoints elsewhere, or, indeed, replicate the behaviour with some other schema for the payment urls, you must manually set `paymentorder.urls.paymentUrl` to the correct value when creating your payment orders.

Importantly, the payment url helper endpoints must be accessible without any authentication headers. This is because the scenario where they will be used is when a third-party site wishes to navigate back to the payment order. Such a site will necessarily not have any authentication tokens related to your backend. Consequently, it is important to ensure that these endpoints do not inadvertently disclose information.

The sample implementations serve these payment url helper endpoints at the specified static paths.

N.B! The SDK generates unique payment urls by adding unique query arguments to the helper endpoint url. These payment urls only have meaning on the generating device, in the generating app. Opening them on another device will be unable to navigate the user to the originating payment menu.

### Android Payment Url Helper

The Android payment url helper endpoint expects a query parameter named `package`: the package name of the Android application to redirect to. It has no requirements as to the existence or value of other query parameters. As the application using the SDK knows its own package name, it can use this endpoint to generate a payment url that is routed back to itself.

The specified path for the Android payment url helper endpoint is `sdk-callback/android-intent`. The default constructors of the Android SDK form payment urls by appending `sdk-callback/android-intent` to the backend url, i.e. the root endpoint, and adding the `package` query parameter with the containing application's package name, and an `id` query parameter with a random value.

The endpoint responds with an html document that attempts to immediately redirect to an [Intent-scheme Url][android-intent-scheme]. That url is constructed such that it uses the value of the `package` query parameter as the target package of the intent. The action of the intent shall be `com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER`; the SDK has an intent filter for this action. The uri (data) of the intent shall be the full url used in the request. The html document shall also contain a link to that same url. This is needed because in some cases the browser will block the redirect to an Intent-scheme url, and will instead require that the navigation to that url happen from a user interaction.

{:.code-view-header}
**Request**

```http
GET /swedbank-pay-mobile/sdk-callback/android-intent?package=your.ecom.app&id=abb50c53-53c1-4138-923f-59fcf0acd08d HTTP/1.1
Host: example.com
```

{:.table .table-striped}
|     Required     | Field     | Type     | Description                                                |
| :--------------: | :-------- | :------- | :--------------------------------------------------------- |
| {% icon check %} | `package` | `string` | The package name of the Android application to redirect to |

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: text/html

<html>
<head>
<title>Swedbank Pay Payment</title>
<link rel="stylesheet" href="https://design.swedbankpay.com/v/4.3.0/styles/dg-style.css">
<meta name="viewport" content="width=device-width">
<meta http-equiv="refresh" content="0;url=intent://example.com/swedbank-pay-mobile/sdk-callback/android-intent?package=your.ecom.app&id=abb50c53-53c1-4138-923f-59fcf0acd08d#Intent;scheme=https;action=com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER;package=your.ecom.app;end; ①">
</head>
<body>
<div class="text-center">
<img src="https://design.swedbankpay.com/v/4.3.0/img/swedbankpay-logo.svg" alt="Swedbank Pay" height="120">
<p><a class="btn btn-executive" href="intent://example.com/swedbank-pay-mobile/sdk-callback/android-intent?package=your.ecom.app&id=abb50c53-53c1-4138-923f-59fcf0acd08d#Intent;scheme=https;action=com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER;package=your.ecom.app;end;">Back to app</a></p>
</div>
</body>
</html>
```

*   ① The `intent` url is transformed to an Android Intent using the data after the `#Intent;` token. The uri of that intent is the intent url up to that token, with the `intent` scheme replaced according to the `scheme=` parameter – in this case `https`.

Using a payment url crafted this way causes an intent with the payment url to be delivered to the application when a third-party page navigates to the payment url. The SDK receives this intent, recognizes the payment url, and reloads the payment menu.

N.B! It is possible to craft arbitrary `com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER` intents using this endpoint. However, further processing of such intents is dependent on local data, and thus this endpoint leaks no information. Indeed, it is conceptually possible for two different devices to use the same payment url to refer to different payments. Your implementation may restrict the requests it serves; e.g. you may only allow a specific `package`.

### iOS Payment Url Helper

#### Background

The iOS payment url helper endpoint is more involved than the Android one. While a similar mechanism could be used with [custom url schemes][ios-custom-scheme], doing so will not provide optimal user experience: custom schemes will show a confirmation dialog before being routed to the handling application, and the content of that dialog is not under developer control. Instead, the best practice for assigning urls to applications is to use [Universal Links][ios-universal-links].

With the merchant backend host and the iOS application using the SDK configured correctly, the payment url becomes a universal link. Universal links function such that they are given directly to the handling application. This means that if the navigation to the payment url is handled as a unversal link, the actual payment url is never dereferenced before being handled by the application. In this scenario, is does not matter what kind of response would be received by making a `GET` request to the payment url. Unfortunately, this is not guaranteed to happen.

As [documented][ios-universal-links-routing], universal links open the registered application "when [the user] tap[s] links to your website within Safari", but "When a user browses your website in Safari and taps a universal link in the same domain, the system opens that link in Safari -- If the user taps a universal link in a different domain, the system opens the link in your app." This presents two preconditions: the navigation must originate from user interaction, and the domain of the universal link must be different to the domain of the current page. Also, practice has shown that universal links may still sometimes fail to work as intended, so we must have some way of escaping that situation.

In order to have a foolproof system with optimal user experience, we must therefore work correctly in different scenarios:

1.  The initial navigation to the payment url is opened in the application: no requirements for the payment url
2.  The initial navigation to the payment url is opened in Safari: need a way to link back to the payment url such that it is opened in the application instead
    *   2a: The second navigation to the payment url is opened in the application: no further requirements for the payment url
    *   2b: The second navigation to the payment url is also opened in Safari: out of nice-UX options; need to redirect to a custom scheme url

This state of matters necessitates an unintuitive and cumbersome system involving two hosts and a custom url scheme. The usage of two hosts is unavoidable if maximum compatibility combined with optimum user experience is desired. The custom url scheme is unavoidable if an escape hatch in badly behaving scenarios is desired. However, universal links need be configured only to one of the involved hosts, namely the one hosting the payment url. Thus, the page with a link back to the payment url can be on a generic server hosted by Swedbank Pay. \[Development note: the Swedbank Pay server for this purpose is not yet available in the production environment.\]

#### iOS Payment Url System

The iOS payment url helper endpoint expects the following query parameters:

*   `scheme`: The custom scheme for Swedbank Pay SDK payment urls in the application
*   `language`: The language to use in the back-link web page in the case 2 above

The endpoint also accepts two optional query parameters:

*   `app`: The name of the application to show in the back-link web page
*   `fallback`: If `true`, redirects to a custom-scheme url instead of the back-link web page

Like the Android payment url helper endpoint, the iOS payment url helper endpoint imposes no requirements on any other query parameters.

The specified path for the iOS payment url helper endpoint is `sdk-callback/ios-universal-link`. The default constructors of the iOS SDK form payment urls by appending `sdk-callback/ios-universal-link` to the backend url, i.e. the root endpoint, and adding the `scheme` query parameter with the custom scheme registered in the app for handling Swedbank Pay SDK payment urls, the `language` parameter with the chosen language, the `app` parameter with the application name (if available), and an `id` query parameter with a random value. The `fallback` parameter is _not_ set for the payment url.

Let us consider the cases above, when a third-party page wants to navigate back to the payment menu. Case 1 requires no further analysis. The univeral link system works as we intend, the payment url is opened in the app as-is.

Case 2 causes the payment url to be opened in Safari. In this case we want to show a web page with a link back to the payment url, so the user can tap the link and it will be opened in the application, as provided by the conditions outlined above. Since this page must be served from a different domain, the payment url itself must respond with a redirect response.

{:.code-view-header}
**Request**

```http
GET /swedbank-pay-mobile/sdk-callback/ios-universal-link?scheme=yourecomapp&language=en-US&id=abb50c53-53c1-4138-923f-59fcf0acd08d&app=Your%20Ecom%20App HTTP/1.1
Host: example.com
```

{:.table .table-striped}
|     Required     | Field      | Type      | Description                                                         |
| :--------------: | :--------- | :-------- | :------------------------------------------------------------------ |
| {% icon check %} | `scheme`   | `string`  | The custom scheme for handling Swedbank Pay payment urls in the app |
| {% icon check %} | `language` | `string`  | The language to use in the back-link page                           |
|                  | `app`      | `string`  | The application name to display in the back-link page               |
|                  | `fallback` | `boolean` | If `true`, redirect to custom scheme rather than back-link page     |

{:.code-view-header}
**Response**

```http
HTTP/1.1 301 Moved Permanently ①
Location: https://ecom.stage.payex.com/externalresourcehost/trampoline?target=https%3A%2F%2Fexample.com%2Fswedbank-pay-mobile%2Fsdk-callback%2Fios-universal-link%3Fscheme%3Dyourecomapp%26language%3Den-US%26id%3Dabb50c53-53c1-4138-923f-59fcf0acd08d%26app%3DYour%2520Ecom%2520App%26fallback%3Dtrue&language=en-US&app=Your%20Ecom%20App
```

This example uses the public server hosted by Swedbank Pay \[Development note: The public server is not yet available in the production environment. The url will be updated when it is released.\], but you can also host the back-link page yourself if desired.

Safari will immediately follow the redirect:

{:.code-view-header}
**Request**

```http
GET /externalresourcehost/trampoline?target=https%3A%2F%2Fexample.com%2Fswedbank-pay-mobile%2Fsdk-callback%2Fios-universal-link%3Fscheme%3Dyourecomapp%26language%3Den-US%26id%3Dabb50c53-53c1-4138-923f-59fcf0acd08d%26app%3DYour%2520Ecom%2520App%26fallback%3Dtrue&language=en-US&app=Your%20Ecom%20App HTTP/1.1
Host: ecom.stage.payex.com
```

{:.table .table-striped}
|     Required     | Field      | Type     | Description                                            |
| :--------------: | :--------- | :------- | :----------------------------------------------------- |
| {% icon check %} | `target`   | `string` | The link to open when the button on the page is tapped |
| {% icon check %} | `language` | `string` | The language to use in the page                        |
|                  | `app`      | `string` | The application name to display in the page            |

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: text/html

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Swedbank Pay Redirect</title>
    <link rel="icon" type="image/png" href="/externalresourcehost/content/images/favicon.png">
    <link rel="stylesheet" href="/externalresourcehost/content/css/style.css">
</head>
<body>
    <div class="trampoline-container" onclick="redirect()">
    <img alt="Swedbank Pay Logo" src="/externalresourcehost/content/images/swedbank-pay-logo-vertical.png" />
    <span class="trampoline-text">
            <a>Back to Your Ecom App</a>
    </span>
</div>

<script>
    function redirect() { window.location.href = decodeURIComponent("https%3A%2F%2Fexample.com%2Fswedbank-pay-mobile%2Fsdk-callback%2Fios-universal-link%3Fscheme%3Dyourecomapp%26language%3Den-US%26id%3Dabb50c53-53c1-4138-923f-59fcf0acd08d%26app%3DYour%2520Ecom%2520App%26fallback%3Dtrue"); };
</script>

</body>
</html>
```

The back-link page contains a link to the payment url, but with an added with the `fallback=true` parameter. In case 2a the link will be opened in the application, and we are done. In case 2b, however, the link is again opened in Safari. Since the back-link page did not work, it makes no sense to redirect back to it again. Instead we will redirect to a custom scheme url, as those will always be opened in the registered application, albeit only after a confirmation dialog. Of course, this means that we need to know that the payment url is being opened from the back-link page. The `fallback=true` parameter signals to the iOS payment url helper endpoint to alter its behaviour this way.

You may note that in case 2a the application was not opened with the original payment url, but with one with an extra query parameter. The SDK handles this by considering the query part of the payment url separately, allowing additional parameters.

Case 2b continues by making a request to the payment url with the added `fallback=true` parameter. The endpoint responds with a redirect similar to the Android one: the scheme is replaced with the custom scheme, and the rest of the request url is unmodified.

{:.code-view-header}
**Request**

```http
GET /swedbank-pay-mobile/sdk-callback/ios-universal-link?scheme=yourecomapp&language=en-US&id=abb50c53-53c1-4138-923f-59fcf0acd08d&app=Your%20Ecom%20App&fallback=true HTTP/1.1
Host: example.com
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 301 Moved Permanently ①
Location: yourecomapp://example.com/swedbank-pay-mobile/sdk-callback/ios-universal-link?scheme=yourecomapp&language=en-US&id=abb50c53-53c1-4138-923f-59fcf0acd08d&app=Your%20Ecom%20App&fallback=true
```

Note that this custom-scheme link is otherwise equal to the universal link opened in case 2a; accordingly, the SDK handles this by allowing the scheme of the payment url to be either the original scheme, or the custom scheme registered to the application.

*   ① 302 Found is perhaps a more appropriate status. This may be changed in the future, after testing that the routing works correctly with that status.

#### Apple App Site Association

The iOS payment url helper endpoint must be configured as a universal link to the application for it to work correctly. Doing this requires an [Apple app site association][ios-aasa] file on the host of the iOS payment url. This file must be at a path relative to the host root (namely `/.well-known/apple-app-site-association`), and is thus outside the scope of, but linked to, the merchant backend API.

The example implementations assume they are rooted at host root, and serve an Apple app site association using a configurable application ID.

{:.code-view-header}
**Request**

```http
GET /.well-known/apple-app-site-association HTTP/1.1
Host: example.com
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "applinks": {
        "apps": [],
        "details": [
            {
                "appID":"YOURTEAMID.your.ecom.app",
                "paths":["/swedbank-pay-mobile/sdk-callback/*"]
            }
        ]
    }
}
```

## Problems

If there are any errors in servicing a request, they should be reported using [Problem Details for HTTP APIs (RFC 7807)][rfc-7807] messages, like the [Swedbank Pay APIs do][swedbankpay-problems]. In particular, if the Swedbank Pay API response contains a problem, that problem should be forwarded to the client making the original request.

### Merchant Backend Problems

The following problem types are defined for Merchant Backend specific errors. The mobile SDK components contain data types for easy processing of these error types. The sample implementations emit these errors in the specified circumstances; your own implementation is encouraged to do so as well.

All these Merchant Backend problem types will have a URI in the format `https://api.payex.com/psp/errordetail/mobilesdk/<error-type>`.

{:.table .table-striped}
| Type             | Status | Description                                                                     |
| :--------------- | :----: | :------------------------------------------------------------------------------ |
| `gatewaytimeout` | `504`  | The Swedbank Pay API did not respond in time.                                   |
| `badgateway`     | `502`  | The Merchant Backend did not understand the response from the Swedbank Pay API. |
| `unauthorized`   | `401`  | The request did not have proper credentials to perform the operation.           |
| `badrequest`     | `400`  | The Merchant Backend did not undestand the request.                             |

Your implementation is encouraged to define its own problem types for any domain-specific errors; you should namespace those problem types under a domain name under your control – usually the host name of the Merchant Backend.

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="merchant-backend-sample-code"
                         next_title="Merchant Backend Sample Code" %}

[swagger]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/blob/master/documentation/swedbankpaysdk_openapi.yaml
[swagger-editor]: https://editor.swagger.io/?url=https://raw.githubusercontent.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/master/documentation/swedbankpaysdk_openapi.yaml
[payment-url]: /checkout/payment-menu#payment-url
[initiate-consumer-session]: /checkout/checkin#step-1-initiate-session-for-consumer-identification
[create-payment-order]: /checkout/payment-menu#step-3-create-payment-order
[android-intent-scheme]: https://developer.chrome.com/multidevice/android/intents
[ios-custom-scheme]: https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content/defining_a_custom_url_scheme_for_your_app
[ios-universal-links]: https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content
[ios-universal-links-routing]: https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content#3001753
[ios-aasa]: https://developer.apple.com/documentation/safariservices/supporting_associated_domains_in_your_app#3001215
[rfc-7807]: https://tools.ietf.org/html/rfc7807
[swedbankpay-problems]: /introduction#problems
[instrument-mode]: /checkout/payment-menu#payment-url
