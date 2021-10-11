---
title: Introduction
estimated_read: 15
menu_order: 1
description: |
    Read on to learn about the fundamentals and common architectural principles
    of the Swedbank Pay API Platform.
---

## Foundation

The **Swedbank Pay API Platform** is built using the [REST architectural
style][rest] and the request and responses come in the [JSON] format. The API
has predictable, resource-oriented URLs and use default HTTP features, like HTTP
authentication (using OAuth 2), HTTP methods and headers. These techniques are
widely used and understood by most HTTP client libraries.

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

## Postel's Robustness Principle

We encourage you to keep [Postel's robustness principle][robustness-principle]
in mind. Build your integration in a way that is resilient to change, wherever
it may come. Don't confine yourself to the limits of our current documentation
examples. A `string` looking like a `guid` must still be handled and stored like
a `string`, not as a guid, as it could be a `URL` in the future. The day our
`transactionNumber` ticks past 1,000,000, make sure your integration can handle
number 1,000,001. If some `fields`, `operations` or `headers` can't be
understood, you must be able to ignore them. We have built our requests in a way
which allows the `payeeInfo` field to be placed before `metadata`, or vice versa
if you want. We don't expect a specific order of elements, so we ask that you
shouldn't either.

## Headers

All requests against the API Platform should have a few common headers:

{:.code-view-header}
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
|     Required     | Header              | Description                                                                                                                                                                                                                                                                    |
| :--------------: | :------------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %}︎ | **`Content-Type`**  | The [content type][content-type] of the body of the HTTP request. Usually set to `application/json`.                                                                                                                                                                           |
| {% icon check %}︎ | **`Accept`**        | The [content type][content-type] accepted by the client. Usually set to `application/json` and `application/problem+json` so both regular responses as well as errors can be received properly.                                                                                |
| {% icon check %}︎ | **`Authorization`** | The OAuth 2 Access Token is generated in [Swedbank Pay Admin][admin].                                                                                                                                                                                                          |
|                  | **`Session-Id`**    | A trace identifier used to trace calls through the API Platform (ref [RFC 7329][rfc-7329]). Each request must mint a new [GUID/UUID][uuid]. If no `Session-Id` is provided, Swedbank Pay will generate one for the request.                                                    |
|                  | **`Forwarded`**     | The IP address of the payer as well as the host and protocol of the payer-facing web page. When the header is present, only the `for` parameter containing the payer's IP address is required, the other parameters are optional. See [RFC 7239][rfc-7239] for details. |

## URL Usage

The base URLs of the API Platform are:

{% assign api_url_prod = 'https://api.payex.com/' %}

{:.table .table-striped}
| Environment                          | Base URL              |
| :----------------------------------- | :---------------------|
| [**Test**]({{ page.api_url }})       | `{{ page.api_url }}/` |
| [**Production**]({{ api_url_prod }}) | `{{ api_url_prod }}`  |

An important part of REST is its use of **hypermedia**. Instead of having to
perform complex state management and hard coding URLs and the availability of
different operations in the client, this task is moved to the server. The client
simply follows links and performs operations provided by the API, given the
current state of the resource. The server controls the state and lets the client
know through hypermedia what's possible in the current state of the resource. To
get an [introduction to **hypermedia**, please watch this 20 minute
video][the-rest-and-then-some].

{% include alert.html type="warning" icon="warning" header="Don't build URLs"
body=" It is very important that only the base URLs of Swedbank Pay's APIs are
stored in your system. All other URLs are returned dynamically in the response.
Swedbank Pay cannot guarantee that your implementation will remain working if
you store any other URLs in your system. When performing requests, please make
sure to use the complete URLs that are returned in the response. **Do not
attempt to parse or build** upon the returned data – you should not put any
special significance to the information you might glean from an URL. URLs should
be treated as opaque identifiers you can use to retrieve the identified resource
– nothing more, nothing less. If you don't follow this advice, your integration
most assuredly will break when Swedbank Pay makes updates in the future.
" %}

### Storing URLs

{% include alert.html type="success" icon="link" header="Storing URLs" body="In
general, URLs should be **discovered** in responses to previous requets, **not
stored**." %}

However, URLs that are used to create new resources can be stored or hard coded.
Also, the URL of the generated resource can be stored on your end to `GET` it at
a later point. Note that the URLs should be stored as opaque identifiers and
should not be parsed or interpreted in any way.

{% include alert.html type="warning" icon="warning" header="Operation URLs"
body="URLs that are returned as part of the `operations` in each response should
not be stored." %}

See the abbreviated example below where `psp/creditcard/payments` from the
`POST` header is an example of the URL that can be stored, as it is used to
create a new resource. Also, the `/psp/creditcard/payments/{{ page.payment_id}}`
URL can be stored in order to retrieve the created payment with an HTTP `GET`
request later.

The URLs found within `operations` such as the `href` of `update-payment-abort`,
`{{ page.api_url }}/psp/creditcard/payments/{{ page.payment_id }}` should not be
stored.

In order to find which operations you can perform on a resource and the URL of
the operation to perform, you need to retrieve the resource with an HTTP `GET`
request first and then find the operation in question within the `operations`
field.

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "SEK",
        "prices": [{
                "type": "CreditCard",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "generatePaymentToken": false,
        "generateRecurrenceToken": false,
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
     }
 }
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "instrument": "CreditCard",
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": "Authorization",
        },
    "operations": [
        {
            "rel": "update-payment-abort",
            "href": "{{ page.api_url }}/psp/creditcard/payments/{{ page.payment_id }}",
            "method": "PATCH",
            "contentType": "application/json"
        },
        {
            "rel": "redirect-authorization",
            "href": "{{ page.front_end_url }}/creditcard/payments/authorize/{{ page.payment_token }}",
            "method": "GET",
            "contentType": "text/html"
        },
        {
            "rel": "view-authorization",
            "href": "{{ page.front_end_url }}/creditcard/core/scripts/client/px.creditcard.client.js?token={{ page.payment_token }}",
            "method": "GET",
            "contentType": "application/javascript"
        }
    ]
}
```

## Uniform Responses

When a `POST` or `PATCH` request is performed, the whole target resource
representation is returned in the response, as when performing a `GET`
request on the resource URL. This is an economic approach that limits the
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

{:.code-view-header}
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
combine dates, time and timezone data into a string, e.g.
`2018-09-14T13:21:57.6627579Z`.

### Locale

When defining locale, we use the combination of [language][iso-639-1]
and [country codes][iso-3166], e.g. `nb-NO`, `sv-SE`, `en-US`.

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

{:.code-view-header}
**JSON with Operations**

```json
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
| Field    | Description                                                         |
| :------- | :------------------------------------------------------------------ |
| `href`   | The target URL to perform the operation against.                    |
| `rel`    | The name of the relation the operation has to the current resource. |
| `method` | The HTTP method to use when performing the operation.               |

**The operations should be performed as described in each response and not as
described here in the documentation**. Always use the `href` and `method` as
specified in the response by finding the appropriate operation based on its
`rel` value.

{% include payee-reference.md %}

[Read more about the settlement process here][settlement].

{% include callback.md %}

{% include problems/problems.md %}

[admin]: https://admin.externalintegration.payex.com/psp/login
[content-type]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type
[iso-3166]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
[iso-4217]: https://en.wikipedia.org/wiki/ISO_4217
[iso-639-1]: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
[iso-8601]: https://en.wikipedia.org/wiki/ISO_8601
[java-tls]: https://blogs.oracle.com/java-platform-group/jdk-8-will-use-tls-12-as-default
[json]: https://www.json.org/
[node-tls]: https://stackoverflow.com/a/44635449/61818
[php-curl-tls]: https://stackoverflow.com/a/32926813/61818
[php-zend-tls]: https://zend18.zendesk.com/hc/en-us/articles/219131697-HowTo-Implement-TLS-1-2-Support-with-the-cURL-PHP-Extension-in-Zend-Server
[python-tls]: https://docs.python.org/2/library/ssl.html#ssl.PROTOCOL_TLSv1_2
[rest]: https://en.wikipedia.org/wiki/Representational_state_transfer
[rfc-7239]: https://tools.ietf.org/html/rfc7239
[rfc-7329]: https://tools.ietf.org/html/rfc7329
[robustness-principle]: https://en.wikipedia.org/wiki/Robustness_principle
[ruby-tls]: https://stackoverflow.com/a/11059873/61818
[settlement]: /payment-instruments/invoice/features/core/settlement-reconciliation
[ssllabs]: https://www.ssllabs.com/ssltest/analyze.html?d=api.payex.com
[the-rest-and-then-some]: https://www.youtube.com/watch?v=QIv9YR1bMwY
[uuid]: https://en.wikipedia.org/wiki/Universally_unique_identifier
