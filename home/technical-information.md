---
title: Swedbank Pay Developer Portal
sidebar:
  navigation:
  - title: Home
    items:
    - url: /home/technical-information
      title: Technical Information
---

## Connection and Protocol

All requests towards Swedbank Pay API Platform are made with **HTTP/1.1** over
a secure a **TLS 1.2** (or higher) connection. Older HTTP clients running on
older operating systems and frameworks might receive connection errors when
connecting to Swedbank Pay's APIs. This is most likely due to the connection
being made from the client with TLS 1.0 or even SSL, which are all insecure and
deprecated. If such is the case, ensure that you are able to connect over a
TLS 1.2 connection by reading information regarding your programming languages
and environments ([Java][java-tls], [PHP Curl][php-curl-tls],
[PHP Zend][php-zend-tls], [Ruby][ruby-tls], [Python][python-tls],
[Node.js Request][node-tls]).

You can inspect [Swedbank Pay's TLS and cipher suite][ssllabs] support at
SSL Labs. Support for HTTP/2 in our APIs is being investigated.

## Headers

All requests against the API Platform should have a few common headers:

{:.code-header}
**HTTP request**

```http
POST /some/resource HTTP/1.1
Content-Type: application/json; charset=utf-8
Accept: application/problem+json; q=1.0, application/json; q=0.9
Authorization: "Bearer 123456781234123412341234567890AB"
Session-Id: 779da454399742248f2942bb064c4707
Forwarded: for=82.115.151.177; host=example.com; proto=https
```

{:.table .table-striped}
| Required | Header              | Description                                                                                                                                                                                                                                                                    |
| :------: | :------------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|    ✔︎    | **`Content-Type`**  | The [content type][content-type] of the body of the HTTP request. Usually set to `application/json`.                                                                                                                                                                           |
|    ✔︎    | **`Accept`**        | The [content type][content-type] accepted by the client. Usually set to `application/json` and `application/problem+json` so both regular responses as well as errors can be received properly.                                                                                |
|    ✔︎    | **`Authorization`** | The OAuth 2 Access Token is generated in [Swedbank Pay Admin][admin]. See the [admin guide][admin-guide] on how to get started.                                                                                                                                                |
|          | **`Session-Id`**    | A trace identifier used to trace calls through the API Platform (ref [RFC 7329][rfc-7329]). Each request must mint a new [GUID/UUID][uuid]. If no `Session-Id` is provided, Swedbank Pay will generate one for the request.                                                    |
|          | **`Forwarded`**     | The IP address of the consumer as well as the host and protocol of the consumer-facing web page. When the header is present, only the `for` parameter containing the consumer IP address is required, the other parameters are optional. See [RFC 7239][rfc-7239] for details. |

## URI Usage

The base URIs of the API Platform are:

{:.table .table-striped}
| Environment                      | Base URL                 |
| :------------------------------- | :----------------------- |
| [**Test**][external-integration] | `{{ page.api_url }}/`    |
| [**Production**][production]     | `https://api.payex.com/` |

An important part of REST is its use of **hypermedia**. Instead of having to
perform complex state management and hard coding URIs and the availability of
different operations in the client, this task is moved to the server. The
client simply follows links and performs operations provided by the API, given
the current state of the resource. The server controls the state and lets the
client know through hypermedia what's possible in the current state of the
resource. To get an [introduction to **hypermedia**, please watch this 20 minute video][the-rest-and-then-some].

{% include alert.html type="warning" icon="warning" header="Don't build URIs" body="
It is very important that only the base URIs of Swedbank Pay's APIs are stored
in your system. All other URIs are returned dynamically in the response.
Swedbank Pay cannot guarantee that your implementation will remain working if
you store any other URIs in your system. When performing requests, please make
sure to use the complete URIs that are returned in the response.
**Do not attempt to parse or build** upon the returned data – you should not
put any special significance to the information you might glean from an URI.
URIs should be treated as opaque identifiers you can use to retrieve the
identified resource – nothing more, nothing less. If you don't follow this
advice, your integration most assuredly will break when Swedbank Pay makes
updates in the future.
" %}

## Uniform Responses

When a `POST` or `PATCH` request is performed, the whole target resource
representation is returned in the response, as when performing a `GET`
request on the resource URI. This is an economic approach that limits the
number of necessary `GET` requests.

## Expansion

The payment resource contain the ID of related sub-resources in its response
properties. These sub-resources can be expanded inline by using the request
parameter `expand`. This is an effective way to limit the number of necessary
calls to the API, as you return several properties related to a Payment
resource in a single request.

Note that the `expand` parameter is available to all API requests but only
applies to the request response. This means that you can use the expand
parameter on a `POST`  or `PATCH`request to get a response containing the
target resource including expanded properties.

This example below add the `urls` and `authorizations` field inlines to the
response, enabling you to access information from these sub-resources.

{:.code-header}
**HTTP request with expansion**

```http
GET /psp/creditcard/payments/{{ page.payment_id }}?$expand=urls,authorizations HTTP/1.1
Host: {{ page.api_host }}
```

To avoid unnecessary overhead, you should only expand the nodes you need info
about.

## Data Types

Some datatypes, like currency, dates and amounts, are managed in a coherent
manner across the entire API Platform.

### Currency

All currencies are expressed according to the [ISO 4217][iso-4217] standard,
e.g `SEK`, `EUR`, `NOK`.

### Dates

All dates are expressed according to the [ISO 8601][iso-8601] standard that
combine dates, time and timezone data into a string, e.g. `2018-09-14T13:21:57.6627579Z`.

### Locale

When defining locale, we use the combination of language
([ISO 639-1][iso-639-1]) and country codes ([ISO 3166][iso-3166]), e.g.
`nb-NO`, `sv-SE`, `en-US`.

### Monetary Amounts

All monetary amounts are entered in the lowest momentary units of the selected
currency. The amount of SEK and NOK are in ören/ører, and EUR is in cents.
Another way to put it is that the code amount is expressed as if the true
amount is multiplied by 100.

{:.table .table-striped}
| True amount | Code amount |
| ----------: | ----------: |
|  NOK 100.00 |     `10000` |
|   SEK 50.00 |      `5000` |
|     € 10.00 |      `1000` |

## Operations

When a resource is created and during its lifetime, it will have a set of
operations that can be performed on it. Which operations that are available
in a given state varies depending on payment instrument used, what the access
token is authorized to do, etc. A subset of possible operations are described
below. Visit the technical reference page of a payment instrument for
instrument specific operations.

{:.code-header}
**JSON with Operations**

```js
{
    "payment": {},
    "operations": [
        {
            "href": "http://{{ page.api_host }}/psp/creditcard/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort",
            "method": "PATCH"
        },
        {
            "href": "{{ page.front_end_url }}/creditcard/payments/authorize/{{ page.payment_token }}",
            "rel": "redirect-authorization",
            "method": "GET"
        },
        {
            "href": "{{ page.front_end_url }}/swish/core/scripts/client/px.swish.client.js?token={{ page.payment_token }}",
            "rel": "view-payment",
            "method": "GET",
            "contentType": "application/javascript"
        },
        {
            "href": "{{ page.api_url }}/psp/creditcard/payments/{{ page.payment_id }}/captures",
            "rel": "create-capture",
            "method": "POST"
        }
    ]
}
```

{:.table .table-striped}
| Field | Description                                                         |
| :------- | :------------------------------------------------------------------ |
| `href`   | The target URI to perform the operation against.                    |
| `rel`    | The name of the relation the operation has to the current resource. |
| `method` | The HTTP method to use when performing the operation.               |

**The operations should be performed as described in each response and not as
described here in the documentation**. Always use the `href` and `method` as
specified in the response by finding the appropriate operation based on its
`rel` value.

### PayeeReference

{% include payee-reference.md %}

[Read more about the settlement process here][settlement].

{% include callback-reference.md payment_instrument="creditcard" %}

## Problems

When performing operations against the API, it will respond with a problem
message that contain details of the error type if the request could not be
successfully performed. Regardless of why the error occurred, the problem
message will follow the same structure as specified in the
[Problem Details for HTTP APIs (RFC 7807)][rfc-7807] specification.

The structure of a problem message will look like this:

{:.code-header}
**Problem Example**

```js
{
    "type": "https://api.payex.com/psp/errordetail/creditcard/inputerror",
    "title": "There was an input error",
    "detail": "Please correct the errors and retry the request",
    "instance": "{{ page.transaction_id }}",
    "status": 400,
    "action": "RetryNewData",
    "problems": [{
        "name": "CreditCardParameters.Issuer",
        "description": "minimum one issuer must be enabled"
    }]
}
```

{:.table .table-striped}
| Field              | Type      | Description                                                                                                                                                                                                                                            |
| :-------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `type`                | `string`  | The URI that identifies the error type. This is the **only field usable for programmatic identification** of the type of error! When dereferenced, it might lead you to a human readable description of the error and how it can be recovered from. |
| `title`               | `string`  | The title contains a human readable description of the error.                                                                                                                                                                                          |
| `detail`              | `string`  | A detailed, human readable description of the error and how you can recover from it.                                                                                                                                                                   |
| `instance`            | `string`  | The identifier of the error instance. This might be of use to Swedbank Pay support personnel in order to find the exact error and the context it occurred in.                                                                                          |
| `status`              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                                 |
| `action`              | `string`  | The `action` indicates how the error can be recovered from.                                                                                                                                                                                            |
| `problems`            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                   |
| └➔&nbsp;`name`        | `string`  | The name of the field, header, object, entity or likewise that was erroneous.                                                                                                                                                                       |
| └➔&nbsp;`description` | `string`  | The human readable description of what was wrong with the field, header, object, entity or likewise identified by `name`.                                                                                                                           |

### Common Problems

All common problem types will have a URI in the format
`https://api.payex.com/psp/errordetail/<payment-instrument>/<error-type>`. The
**URI is an identifier** that you can hard-code and implement logic around. It
is currently not not possible to dereference this URI, although that might be
possible in the future.

{:.table .table-striped}
| Type                 | Status | Description                                                                                                                                        |
| :------------------- | :----: | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| `inputerror`         | `400`  | The server cannot or will not process the request due to an apparent client error (e.g. malformed request syntax, size to large, invalid request). |
| `forbidden`          | `403`  | The request was valid, but the server is refusing the action. The necessary permissions to access the resource might be lacking.                   |
| `notfound`           | `404`  | The requested resource could not be found, but may be available in the future. Subsequent requests are permissible.                                |
| `systemerror`        | `500`  | A generic error message.                                                                                                                           |
| `configurationerror` | `500`  | A error relating to configuration issues.                                                                                                          |

### Payment Instrument Specific Problems

Problem types for a specific payment instrument will have a URI in the format
`https://api.payex.com/psp/errordetail/<payment-instrument>/<error-type>`. You
can read more about the payment instrument specific problem messages below:

* [Card Payments][card-problems]
* [Invoice Payments][invoice-problems]
* [Swish Payments][swish-problems]
* [Vipps Payments][vipps-problems]

  [java-tls]: https://blogs.oracle.com/java-platform-group/jdk-8-will-use-tls-12-as-default
  [php-curl-tls]: https://stackoverflow.com/a/32926813/61818
  [php-zend-tls]: https://zend18.zendesk.com/hc/en-us/articles/219131697-HowTo-Implement-TLS-1-2-Support-with-the-cURL-PHP-Extension-in-Zend-Server
  [ruby-tls]: https://stackoverflow.com/a/11059873/61818
  [python-tls]: https://docs.python.org/2/library/ssl.html#ssl.PROTOCOL_TLSv1_2
  [node-tls]: https://stackoverflow.com/a/44635449/61818
  [ssllabs]: https://www.ssllabs.com/ssltest/analyze.html?d=api.payex.com
  [content-type]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type
  [admin]: https://admin.externalintegration.payex.com/psp/login
  [admin-guide]: #
  [rfc-7329]: https://tools.ietf.org/html/rfc7329
  [rfc-7239]: https://tools.ietf.org/html/rfc7239
  [rfc-7807]: https://tools.ietf.org/html/rfc7807
  [iso-4217]: https://en.wikipedia.org/wiki/ISO_4217
  [iso-8601]: https://en.wikipedia.org/wiki/ISO_8601
  [iso-639-1]: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
  [iso-3166]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
  [uuid]: https://en.wikipedia.org/wiki/Universally_unique_identifier
  [external-integration]: {{ page.api_url }}/
  [production]: https://api.payex.com/
  [the-rest-and-then-some]: https://www.youtube.com/watch?v=QIv9YR1bMwY
  [settlement]: #
  [card-problems]: #
  [invoice-problems]: #
  [swish-problems]: #
  [vipps-problems]: #
