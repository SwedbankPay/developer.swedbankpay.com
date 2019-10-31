---
title: Swedbank Pay Resources
sidebar:
  navigation:
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/test-data
      title: Test Data
    - url: /resources/demoshop
      title: Demoshop
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

{% include jumbotron.html body="In this section you find various **resources** for Swedbank Pay's API Platform." %}


## General 

{% include jumbotron.html body=
"PayEx' eCommerce platform is built using the [[REST architectural style>>https://en.wikipedia.org/wiki/Representational_state_transfer]] and the request and responses come in the [[JSON>>http://json.org/]] format. The API has predictable, resource-oriented URIs and use default HTTP features, like HTTP authentication (using OAuth2), HTTP methods and headers. These techniques are widely used and understood by most HTTP client libraries." %}

## Common eCommerce Resources


[Consumers resource][consumers-resource] and [Payment Orders resource][payment-orders-resource] are the two fundamental resources that [Checkin][checkin] and [Payment Menu][payment-menu] build upon. Use Checkin and Payment Menu together to get [PayEx Checkout][checkout].  






## Connection and Protocol 

All requests towards PayEx' REST API platform are made with **HTTP/1.1** over a secure a **TLS 1.1** (or higher) connection. Older HTTP clients running on older operating systems and frameworks might receive connection errors when connecting to PayEx' APIs. This is most likely due to the connection being made from the client with TLS 1.0 or even SSL, which are all insecure and deprecated. If such is the case, ensure that you are able to connect over a TLS 1.1 connection by reading information regarding your programming languages and environments ([Java][java],[ PHP Curl][php-curl], [PHP Zend][php-zend], [Ruby][ruby], [Python][python], [Node.js Request][node]).

You can inspect [PayEx' TLS and cipher suite][tls-and-cipher-suite] support at SSL Labs. Support for HTTP/2 in our APIs is being investigated.

## Headers 

All requests against the eCommerce API should have a few common headers:

{:.code-header}
**Request**

``` HTTP
POST /some/resource HTTP/1.1
Content-Type: application/json; charset=utf-8
Accept: application/json
Authorization: "Bearer 123456781234123412341234567890AB"
Session-Id: 779da454399742248f2942bb064c4707
Forwarded: for=82.115.151.177; host=example.com; proto=https
```

{:.table .table-striped}
| **Header**| **Required** | **Description**
|Content-Type | ✔︎ | The [content type][content-type] of the body of the HTTP request. Usually set to `application/json`.
|Accept|Y|The [content type][content-type] accepted by the client. Usually set to `application/json`.
|Authorization|Y|The OAuth 2 Access Token is generated in [PayEx Admin][payex-admin]. See the [admin guide][admin-guide] on how to get started.
|Session-Id|N|A trace identifier used to trace calls through the PayEx systems (ref [RFC 7329][rfc7329]). Each request must mint a new [GUID/UUID][guid-uuid]. If no `Session-Id` is provided, PayEx will generate one.
|Forwarded|N|The IP address of the consumer as well as the host and protocol of the consumer-facing web page. When the header is present, only the `for` parameter containing the consumer IP address is required, the other parameters are optional. See [RFC 7239][rfc7329] for details.

## URI usage 

The base URIs of the eCommerce APIs are:

* **Test**: [https://api.externalintegration.payex.com][test-uri]
* **Production**: [https://api.payex.com][production-uri]

An important part of REST is its use of hypermedia. Instead of having to perform complex state management and hard coding URIs and operations in the client, this task is moved to the server. The client simply follows links and performs operations provided by the API, given the current state of the resource. The server controls the state and lets the client know through hypermedia what's possible in the current state of the resource. To get an introduction to [hypermedia, please watch this 20 minute video][hypermedia-video-url].


## What to avoid

{% include alert.html type="warning"
                        icon="warning"
                        header="What to avoid"
                        body="It is very important that only the base URIs of PayEx' APIs are stored in your system. All other URIs are returned dynamically in the response. PayEx cannot guarantee that your implementation will remain working if you store any other URIs in your system. When performing requests, please make sure to use the complete URIs that are returned in the response. Do not attempt to parse or build upon the returned data - you should not put any special significance to the information you might glean from an URI. URIs should be treated as identifiers you can use to retrieve the identified resource – nothing more, nothing less. If you don't follow this advice, your integration most assuredly will break when PayEx makes updates in the future." %}



## POST and PATCH requests and responses 

When a `POST` or `PATCH` request is performed the whole target resource representation is returned in the response, as when performing a `GET` request after the initial request. This is an economic approach that limits the number of necessary `GET` requests. 

## Expansion 

The payment resource contain the ID of related sub-resources in its response properties. These sub-resources can be expanded inline by using the request parameter ##expand##. This is an effective way to limit the number of necessary calls to the API, as you return several properties related to a Payment resource in a single request.

Note that the `expand` parameter is available to all API requests but only applies to the request response. This means that you can use the expand parameter on a `POST` or `PATCH` request to get a response containing the target resource including expanded properties.

This example below add the `urls` and `authorizations` property inlines to the response, enabling you to access information from these sub-resources.

{:.code-header}
**Response**

```HTTP
GET /psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c?$expand=urls,authorizations HTTP/1.1
Host: api.payex.com
```

To avoid unnecessary overhead, you should only expand the nodes you need info about.

## Data Types

Some datatypes, like currency, dates and amounts, are managed in a coherent manner across all eCom APIs

### Currency

All currencies are expressed accoring to the [ISO 4217][iso4217] standard, e.g `SEK`, `EUR`, `NOK`. 

### Dates 

All dates are expressed according to the [ISO 8601][iso8601] standard that combine dates, time and timezone, e.g. `2018-09-14T13:21:57.6627579Z`.

### Locale

When defining locale, we use the combination of language ([ISO 639-1][iso639-1]) and country codes ([ISO 3166][iso3166]), e.g. `nb-NO`, `sv-SE`, `en-US`.

### Monetary amounts 

All monetary amounts are entered in the lowest momentary units of the selected currency. The amount of SEK and NOK are in ören/ører, and EUR is in cents.  E.g. 10000 = 100.00 NOK, 5000 = 50.00 SEK, 1000 = 10 EUR.

## Operations 

When a payment resource is created and during its lifetime, it will have a set of operations that can be performed on it. Which operations that are available in a given state varies depending on payment instrument used, what the access token is authorized to do, etc. A subset of possible operations are described below. Visit the technical reference page of a payment instrument for instrument specific operations. 

{:.code-header}
**Request**

```HTTP
{
    "payment": {},
    "operations": [
        {
            "href": "http://api.externalintegration.payex.com/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
            "rel": "update-payment-abort",
            "method": "PATCH"
        },
        {
            "href": "https://ecom.externalintegration.payex.com/creditcard/payments/authorize/123456123412341234123456789012",
            "rel": "redirect-authorization",
            "method": "GET"
        },
        {
            "href": "https://ecom.externalintegration.payex.com/swish/core/scripts/client/px.swish.client.js?token=cfb9e24832d56fec7ab79709f56accc53d79a699756687d39095b517bc5f011b",
            "rel": "view-payment",
            "method": "GET",
            "contentType": "application/javascript"
        },
        {
            "href": "https://api.externalintegration.payex.com/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures",
            "rel": "create-capture",
            "method": "POST"
        }
    ]
}
```



{:.table .table-striped}
|**Property**|**Description**
|href|The target URI to perform the operation against.
|rel|The name of the relation the operation has to the current resource.
|method|The HTTP method to use when performing the operation.

**The operations should be performed as described in each response and not as described here in the documentation**. Always use the `href` and `method` as specified in the response by finding the appropriate operation based on its `rel` value. The only constants is the `rel` and `method` as href composition is the relative identifer of a payment URI.

## PayeeReference 

The `payeeReference` given when creating transactions and payments has some specific processing rules depending on specifications in the contract.

1. It must be **unique** for every operation, used to ensure exactly-once delivery of a transactional operation from the merchant system.
1. Its length and content validation is dependent on whether the `transaction.number` or the `payeeReference` is sent to the acquirer.
11. If you select Option A in the settlement process (PayEx will handle the settlement), PayEx will send the `transaction.number` to the acquirer and the `payeeReference` may have the format of `string(30)`.
11. If you select Option B in the settlement process (you will handle the settlement yourself), PayEx will send the `payeeReference` to the acquirer and it will be limited to the format of `string(12)` and all characters must be digits.



## Abort

To abort a payment, perform the `update-payment-abort` operation that is returned in the payment request. You need to include the following HTTP body:

{:.code-header}
**Request**

```HTTP
PATCH /psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "payment": {
    "operation": "Abort",
    "abortReason": "CancelledByConsumer"
  }
}
```

{:.code-header}
**Response**"

```HTTP
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b",
        "number": 70100130293,
        "created": "2019-01-09T13:11:28.371179Z",
        "updated": "2019-01-09T13:11:46.5949967Z",
        "instrument": "CreditCard",
        "operation": "Purchase",
        "intent": "AutoCapture",
        "state": "Aborted",
        "currency": "DKK",
        "prices": {
            "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b/prices"
        },
        "amount": 0,
        "description": "creditcard Test",
        "payerReference": "100500",
        "initiatingSystemUserAgent": "PostmanRuntime/7.1.1",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b/urls"
        },
        "payeeInfo": {
            "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b/payeeinfo"
        },
        "metadata": {
            "id": "/psp/creditcard/payments/e73da1da-1148-476c-b6bb-08d67623d21b/metadata"
        }
    },
    "operations": []
}
```

The response will be the `payment` resource with its `state` set to `Aborted`.

## Callback 

The Callback  functionality is similar for all payment methods.

* Setting a `callbackUrl` in the HTTP `POST` API is optional, but highly recommended. If a payer closes the browser window, a network error or something else happens that prevents the payer from being redirect from PayEx back to the merchant website, the callback is what ensures that you receive information about what happened with the payment.
* When a change or update from the back-end system are made on a payment or transaction, PayEx will perform a callback to inform the payee (merchant) about this update.
* PayEx will make an HTTP `POST` to the `callbackUrl` that was specified when the payee (merchant) created the payment.
* When the `callbackUrl` receives such a callback, an HTTP `GET` request must be made on the payment or on the transaction. The retrieved payment or transaction resource will give you the necessary information about the recent change/update.
* The callback will be retried if it fails. Below are the retry timings, in milliseconds from the initial transaction time:
*1. 30000 ms
*1. 60000 ms
*1. 360000 ms
*1. 432000 ms
*1. 864000 ms
*1. 1265464 ms
* The callback is sent from the following IP addresses:
** `82.115.146.1`


{:.code-header}
**Payment Instrument Callback**

```HTTP
{
   "payment": {
       "id": "/psp/<payment instrument>/payments/22222222-2222-2222-2222-222222222222",
       "number": 222222222
    },
   "transaction": {
       "id": "/psp/<payment instrument>/payments/22222222-2222-2222-2222-222222222222/<transaction type>/33333333-3333-3333-3333-333333333333",
       "number": 333333333
    }
}
```


{:.code-header}
**Payment Order Callback**

```HTTP
{
    "paymentOrder":{
        "id": "/psp/paymentorders/11111111-1111-1111-1111-111111111111",
        "instrument": "<payment instrument>"
    },
    "payment":{
        "id": "/psp/<payment instrument>/payments/22222222-2222-2222-2222-222222222222",
        "number": 222222222
    },
    "transaction":{
        "id": "/psp/<payment instrument>/payments/22222222-2222-2222-2222-222222222222/<transaction type>/33333333-3333-3333-3333-333333333333",
        "number": 333333333
    }
}
```

{:.table .table-striped}
|**Parameter**|**Description**
|Payment Instrument|CreditCard, Invoice, Swish, Vipps, DirectDebit, MobilePay
|Transaction Type|Authorizations, Captures, Cancellations, Reversals

The sequence diagram below shows the HTTP `POST` you will receive from PayEx, and the two `GET` requests that you make to get the updated status.


```mermaid
sequenceDiagram
    participant Merchant
    participant PayEx
    PayEx->>Merchant: Post <callbackUrl>
    Activate Merchant
    Activate PayEx
    note left of Merchant: Callback by PayEx
    Merchant-->>PayEx: HTTP response
    Deactivate Merchant 
    Deactivate PayEx
    note left of Merchant: First API request
    Merchant->>PayEx: GET <payment instrument> payment
    Activate PayEx
    PayEx-->>Merchant: payment resource
    Deactivate PayEx
```


## Problems 

When performing operations against the API, it will respond with a problem message that contain details of the error type if the request could not be successfully performed. Regardless of why the error occurred, the problem message will follow the same structure as specified in the [Problem Details for HTTP APIs (RFC 7807)][rfc7807] specification.

The structure of a problem message will look like this:

{:.code-header}
**Response**

```HTTP
{
    "type": "https://api.payex.com/psp/<error_type>",
    "title": "There was an input error",
    "detail": "Please correct the errors and retry the request",
    "instance": "9a20d737-670d-42bf-9a9a-d36736de8721",
    "status": 400,
    "action": "RetryNewData",
    "problems": [{
        "name": "CreditCardParameters.Issuer",
        "description": "minimum one issuer must be enabled "
    }]
}
```



{:.table .table-striped}
|**Parameter**|**Data type**|**Description**
|type|string|The URI that identifies the error type. This is the **only property usable for programmatic identification** of the type of error! When dereferenced, it might lead you to a human readable description of the error and how it can be recovered from.
|title|string|The title contains a human readable description of the error.
|detail|string|A detailed, human readable description of the error.
|instance|string|The identifier of the error instance. This might be of use to PayEx support personnel in order to find the exact error and the context it occurred in.
|status|integer|The HTTP status code that the problem was served with.
|action|string|The action indicates how the error can be recovered from.
|problems|array|The array of problem detail objects.
|problems[].name|string|The name of the property, header, object, entity or likewise that was erroneous.
|problems[].description|string|The description of what was wrong with the property, header, object, entity or likewise identified by `name`.

### Common Problems 

All common problem types will have a URI in the format [https://api.payex.com/psp/<error-type>][error-link]. The **URI is an identifier** and is currently not possible to dereference, although that might be possible in the future.

{:.table .table-striped}
|**Type**|**Status**|**Notes**
|inputerror|400|The server cannot or will not process the request due to an apparent client error (e.g. malformed request syntax, size to large, invalid request).
|forbidden|403|The request was valid, but the server is refusing the action. The necessary permissions to access the resource might be lacking.
|notfound|404|The requested resource could not be found, but may be available in the future. Subsequent requests are permissible.
|systemerror|500|A generic error message.
|configurationerror|500|A error relating to configuration issues.

### Payment Instrument Specific Problems 

Problem types for a specific payment instrument will have a URI in the format ##https://api.payex.com/psp/<payment-instrument>/<error-type>##. You can read more about the payment instrument specific problem messages below:

* [**Card Payments**][card-payment]
* [**Invoice**][invoice]
* [**Swish**][swish]
* [**Vipps**][vipps]



[consumers-resource]: #
[payment-orders-resource]: #
[checkin]: /checkout/payment/#Checkin
[payment-menu]: /checkout/payment/#payment-menu
[checkout]: /checkout/
[java]: https://blogs.oracle.com/java-platform-group/jdk-8-will-use-tls-12-as-default
[php-curl]: https://stackoverflow.com/a/32926813/61818
[php-zend]: https://zend18.zendesk.com/hc/en-us/articles/219131697-HowTo-Implement-TLS-1-2-Support-with-the-cURL-PHP-Extension-in-Zend-Server
[ruby]: https://stackoverflow.com/a/11059873/61818
[python]: https://docs.python.org/2/library/ssl.html#ssl.PROTOCOL_TLSv1_2
[node]: https://stackoverflow.com/a/44635449/61818
[tls-and-cipher-suite]: https://www.ssllabs.com/ssltest/analyze.html?d=api.payex.com
[content-type]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type
[payex-admin]: https://admin.externalintegration.payex.com/psp/login
[admin-guide]: #
[rfc7329]: https://tools.ietf.org/html/rfc7329
[guid-uuid]: https://en.wikipedia.org/wiki/Universally_unique_identifier
[test-uri]: https://api.externalintegration.payex.com/
[production-uri]: https://api.payex.com/
[hypermedia-video-url]: https://www.youtube.com/watch?v=QIv9YR1bMwY
[iso4217]: https://en.wikipedia.org/wiki/ISO_4217
[iso8601]: https://en.wikipedia.org/wiki/ISO_8601
[iso639-1]: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
[iso3166]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
[rfc7807]: https://tools.ietf.org/html/rfc7807
[error-link]: https://api.payex.com/psp/
[card-payment]: #
[invoice]: #
[swish]: #
[vipps]: #
