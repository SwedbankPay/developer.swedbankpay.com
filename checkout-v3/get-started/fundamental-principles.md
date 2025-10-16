---
title: Fundamental Principles
permalink: /:path/fundamental-principles/
menu_order: 13
description: |
    Read on to learn about the fundamentals and common architectural principles
    of the Swedbank Pay API Platform.
---

## Foundation

The **Swedbank Pay API Platform** is built using the
[REST architectural style][rest]{:target="_blank"} and the request and responses
come in the [JSON] format. The API has predictable, resource-oriented URLs and
use default HTTP features, like HTTP authentication (using OAuth 2), HTTP
methods and headers. These techniques are widely used and understood by most
HTTP client libraries.

## Connection and Protocol

All requests towards Swedbank Pay API Platform are made with **HTTP/1.1** over
a secure **TLS 1.2** (or higher) connection. Older HTTP clients running on
older operating systems and frameworks might receive connection errors when
connecting to Swedbank Pay's APIs. This is most likely due to the connection
being made from the client with TLS 1.0 or even SSL, which are all insecure and
deprecated. If such is the case, ensure that you are able to connect over a
TLS 1.2 connection by reading information regarding your programming languages
and environments ([Java][java-tls]{:target="_blank"},
[PHP Curl][php-curl-tls]{:target="_blank"}, [PHP Zend][php-zend-tls],{:target="_blank"}
[Ruby][ruby-tls]{:target="_blank"}, [Python][python-tls]{:target="_blank"},
[Node.js Request][node-tls]{:target="_blank"}).

You can inspect [Swedbank Pay's TLS and cipher suite][ssllabs]{:target="_blank"}
support at SSL Labs. Support for HTTP/2 in our APIs is being investigated.

## Postel's Robustness Principle

We encourage you to keep [Postel's robustness principle][robustness-principle]{:target="_blank"}
in mind. Build your integration in a way that is resilient to change, wherever
it may come. Don't confine yourself to the limits of our current documentation
examples. A `string` looking like a `guid` must still be handled and stored like
a `string`, not as a `guid`, as it could be a `URL` in the future. The day our
`transactionNumber` ticks past 1,000,000, make sure your integration can handle
1,000,001. If some `fields`, `operations` or `headers` can't be understood, you
must be able to ignore them. We have built our requests in a way which allows
the `payeeInfo` field to be placed before `metadata`, or vice versa if you want.
We don't expect a specific order of elements, so we ask that you shouldn't
either.

## Headers

All requests against the API Platform should have a few common headers:

{% capture request_header %}POST /some/resource HTTP/1.1
Content-Type: application/json;version=3.x/2.0  charset=utf-8  // Version optional except for 3.1
Authorization: "Bearer 123456781234123412341234567890AB"
User-Agent: swedbankpay-sdk-dotnet/3.0.1
Accept: application/problem+json; q=1.0, application/json; q=0.9
Session-Id: 779da454399742248f2942bb064c4707
Forwarded: for=82.115.151.177; host=example.com; proto=https{% endcapture %}

{% include code-example.html
    title='HTTP Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" role="table" aria-label="Request">  
    <div class="header" role="row">
        <div role="columnheader">Field</div>
        <div role="columnheader">Type</div>
        <div role="columnheader">Required</div>
    </div>
    <details class="api-item" role="rowgroup" data-level="0">
        <summary role="row">
            <span class="field" role="rowheader">{% f Content-Type, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
            <span class="type"><code>string</code></span>
            <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">The [content type][content-type] of the body of the HTTP request. Usually set to <code>application/json</code>.</div></div>
    </details>

    <!-- Authorization -->
    <details class="api-item" role="rowgroup" data-level="0">
        <summary role="row">
          <span class="field" role="rowheader">{% f Authorization, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">The OAuth 2 Access Token is generated in the [Merchant Portal][admin].</div></div>
    </details>

    <!-- User-Agent -->
    <details class="api-item" role="rowgroup" data-level="0">
        <summary role="row">
          <span class="field" role="rowheader">{% f User-Agent, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-0">The [user agent][user-agent] of the HTTP client making the HTTP request. Should be set to identify the system performing requests towards Swedbank Pay. The value submitted here will be returned in the response field <code>initiatingSystemUserAgent</code>.</div></div>
    </details>

    <!-- Accept -->
    <details class="api-item" role="rowgroup" data-level="0">
        <summary role="row">
          <span class="field" role="rowheader">{% f Accept, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">The [content type][content-type] accepted by the client. Usually set to <code>application/json</code> and <code>application/problem+json</code> so both regular responses as well as errors can be received properly.</div></div>
    </details>

    <!-- Session-Id -->
    <details class="api-item" role="rowgroup" data-level="0">
        <summary role="row">
          <span class="field" role="rowheader">{% f Session-Id, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-0">A trace identifier used to trace calls through the API Platform (ref [RFC 7329][rfc-7329]). Each request must mint a new [GUID/UUID][uuid]. If no <code>Session-Id</code> is provided, Swedbank Pay will generate one for the request.</div></div>
    </details>

    <!-- Forwarded -->
    <details class="api-item" role="rowgroup" data-level="0">
        <summary role="row">
          <span class="field" role="rowheader">{% f Forwarded, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-0">The IP address of the payer as well as the host and protocol of the payer-facing web page. When the header is present, only the <code>for</code> parameter containing the payer's IP address is required, the other parameters are optional. See [RFC 7239][rfc-7239] for details.</div></div>
    </details>
</div>


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
get an
[introduction to **hypermedia**, please watch this 20 minute video][the-rest-and-then-some]{:target="_blank"}.

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
general, URLs should be **discovered** in responses to previous requests, **not
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

{% capture request_header %}POST /psp/creditcard/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0  // Version optional except for 3.1{% endcapture %}

{% capture request_content %}{
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
 }{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
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
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## Uniform Responses

When a `POST` or `PATCH` request is performed, the whole target resource
representation is returned in the response, as when performing a `GET`
request on the resource URL. This is an economic approach that limits the
number of necessary `GET` requests.

## Expansion

The payment resource contain the ID of related sub-resources in its response
properties. These sub-resources can be expanded inline by using the request
parameter `expand`. The `Paid` resource would for example be expanded by adding
`?$expand=paid` after the `paymentOrderId`. This is an effective way to limit
the number of necessary calls to the API, as you return several properties
related to a Payment resource in a single request.

Note that the `expand` parameter is available to all API requests but only
applies to the request response. This means that you can use the expand
parameter on a `POST`  or `PATCH` request to get a response containing the
target resource including expanded properties.

This example below add the `urls` and `authorizations` field inlines to the
response, enabling you to access information from these sub-resources.

{% capture request_header %}GET /psp/creditcard/payments/{{ page.payment_id }}?$expand=urls,authorizations HTTP/1.1
Host: {{ page.api_host }}{% endcapture %}

{% include code-example.html
    title='HTTP Request with expansion'
    header=request_header
    %}

To avoid unnecessary overhead, you should only expand the fields you need info
about.

## Data Types

Some datatypes, like currency, dates and amounts, are managed in a coherent
manner across the entire API Platform.

### Currency

All currencies are expressed according to the
[ISO 4217][iso-4217]{:target="_blank"} standard, e.g `SEK`, `EUR`, `NOK`.

### Dates

All dates are expressed according to the [ISO 8601][iso-8601]{:target="_blank"}
standard that combine dates, time and timezone data into a string, e.g.
`2018-09-14T13:21:57.6627579Z`.

### Locale

When defining locale, we use the combination of [language][iso-639-1]{:target="_blank"}
and [country codes][iso-3166]{:target="_blank"}. Our payment menu UI is
currently limited to `nb-NO`, `sv-SE`, `da-DK` `fi-FI` and `en-US`.

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

## Migration of E-Commerce to Microsoft Azure - FAQ

We have gathered answers to the most common questions regarding the migration of
our e-commerce platform and associated services to Microsoft Azure. The goal is
to ensure that this transition takes place as smoothly as possible – without
requiring any action from you as an integrated partner.

{% capture acc-1 %}
{: .p .pl-3 .pr-3  }
We are upgrading our data centers to enhance performance, stability and
security, while enabling innovation for our customers and partners. As part of
this, our e-commerce platform and its services are migrating to Microsoft Azure.
{% endcapture %}
{% include accordion-table.html content=acc-1 header_text='Why is this change being made?' header_expand_css='font-weight-normal' %}
{% capture acc-2 %}
{: .p .pl-3 .pr-3  }
Data protection, privacy, IT security, and information security have always been
of utmost importance to us at Swedbank Pay. After careful consideration, we have
chosen Microsoft Azure as a secure cloud platform for data storage and services.
Azure offers a trusted and reliable solution which meets our high standards for
security and privacy.
{% endcapture %}
{% include accordion-table.html content=acc-2 header_text='Why did you choose Microsoft Azure?' header_expand_css='font-weight-normal' %}
{% capture acc-3 %}
{: .p .pl-3 .pr-3  }
We will provide an exact date later, but our goal is to carry out the migration
gradually, starting in mid-August 2025. You will receive separate information
well in advance before it affects you.
{% endcapture %}
{% include accordion-table.html content=acc-3 header_text='When will the migration take place?' header_expand_css='font-weight-normal' %}
{% capture acc-4 %}
{: .p .pl-3 .pr-3  }
This migration means that the e-commerce platform and its services will run on
Microsoft’s cloud platform, Microsoft Azure. It is a technical improvement
taking place in the background, which will result in enhanced performance for
you.
{% endcapture %}
{% include accordion-table.html content=acc-4 header_text='What does the migration to Microsoft Azure mean for me?' header_expand_css='font-weight-normal' %}
{% capture acc-5 %}
{: .p .pl-3 .pr-3  }
No, there is nothing you need to do. The migration will run its course without
impacting your systems or integrations.
{% endcapture %}
{% include accordion-table.html content=acc-5 header_text='Do I need to take any action before, during or after the migration?' header_expand_css='font-weight-normal' %}
{% capture acc-6 %}
{: .p .pl-3 .pr-3  }
No, the transition to Microsoft Azure is planned, and will be carried out,
without any interruptions to operations. Services will continue to function as
usual throughout the process.
{% endcapture %}
{% include accordion-table.html content=acc-6 header_text='Will there be any service disruptions?' header_expand_css='font-weight-normal' %}
{% capture acc-7 %}
{: .p .pl-3 .pr-3  }
No, all APIs and integrations will remain unchanged. You will continue to use
the same technical interfaces as before.
{% endcapture %}
{% include accordion-table.html content=acc-7 header_text='Will any APIs, endpoints or integrations change?' header_expand_css='font-weight-normal' %}
{% capture acc-8 %}
{: .p .pl-3 .pr-3  }
Your customers will not be impacted. Payment flows and services will continue to
function as usual, without interruptions or changes.
{% endcapture %}
{% include accordion-table.html content=acc-8 header_text='How will my customers be affected by the migration?' header_expand_css='font-weight-normal' %}
{% capture acc-9 %}
{: .p .pl-3 .pr-3  }
No, the migration is free of charge and will not result in any additional costs
for you.
{% endcapture %}
{% include accordion-table.html content=acc-9 header_text='Will there be any additional costs for me?' header_expand_css='font-weight-normal' %}
{% capture acc-10 %}
{: .p .pl-3 .pr-3  }
All data will be stored within the EU/EEA, in compliance with GDPR (General Data
Protection Regulation). We have chosen to store all data in two primary data
centers in Sweden – one in Gävle and one in Sandviken. The selected backup
center is also in Sweden, in Staffanstorp.
{% endcapture %}
{% include accordion-table.html content=acc-10 header_text='Where will my data be stored after the migration to Microsoft Azure?' header_expand_css='font-weight-normal' %}
{% capture acc-11 %}
{: .p .pl-3 .pr-3  }
Swedbank Pay uploads personal data to Microsoft’s cloud service, Azure.
Microsoft will then act as a data processor for Swedbank Pay (or a subprocessor
if Swedbank Pay is acting as a data processor for you). This applies even in the
case of automated data processing.

{: .p .pl-3 .pr-3  }
According to Microsoft’s standard DPA, data may be transferred to the USA. On
July 10, 2023, the EU Commission determined that this is compliant with GDPR,
meaning no additional safeguards are required as long as the transfer adheres to
relevant GDPR provisions.

{: .p .pl-3 .pr-3  }
Microsoft offers 24/7 support, which means that support personnel may be located
globally. The support is focused on the cloud application and generally does not
have access to stored data. To access stored data, our approval is required (see
question 11 below regarding security measures).
{% endcapture %}
{% include accordion-table.html content=acc-11 header_text='How is the data handled by Microsoft?' header_expand_css='font-weight-normal' %}
{% capture acc-12 %}
{: .p .pl-3 .pr-3  }
At Swedbank Pay, we use cryptographic techniques to ensure the integrity and
confidentiality of the information, both during transmission and at rest. All
data is encrypted in transit and at rest.

{: .p .pl-3 .pr-3  }
We have opted for the EU Data Boundary add-on for Microsoft services and control
Microsoft’s support access through lockbox functionality, where each access must
be approved by us and meet our requirements for the geographic location of
support staff (EU or a country with an adequacy decision).

*   Learn more about the [EU Data Boundary add-on.](https://learn.microsoft.com/en-us/privacy/eudb/eu-data-boundary-learn)

*   Learn more about [Lockbox.](https://learn.microsoft.com/sv-se/azure/security/fundamentals/customer-lockbox-overview)
{% endcapture %}
{% include accordion-table.html content=acc-12 header_text='What security measures are in place for storage and transfer?' header_expand_css='font-weight-normal' %}
{% capture acc-13 %}
{: .p .pl-3 .pr-3  }
We have designed our migration process with a strong focus on security and
stability. Each step undergoes thorough testing and checks to ensure everything
works correctly. In the event of an issue during the migration, we have
procedures in place to quickly identify, address and, if necessary, roll back
changes. All steps are monitored, and technical support is available throughout
the process. Our goal is to ensure you are not negatively impacted, and we are
always here to assist if needed.
{% endcapture %}
{% include accordion-table.html content=acc-13 header_text='What happens if an issue occurs during the migration to Microsoft Azure?' header_expand_css='font-weight-normal' %}
{% capture acc-14 %}
{: .p .pl-3 .pr-3  }
Yes, you will have the opportunity to test our e-commerce platform in a
Microsoft Azure-based test environment before the migration. We will contact you
with more details on how and when you can perform the tests, including any
necessary adjustments for your specific solution.
{% endcapture %}
{% include accordion-table.html content=acc-14 header_text='Can I test our e-commerce platform in the Microsoft Azure environment?' header_expand_css='font-weight-normal' %}
{% capture acc-15 %}
{: .p .pl-3 .pr-3  }
We are here to answer your questions. Where you should direct your inquiries
depends on how you are connected to our e-commerce platform:

*   **Are you a partner or technical provider?**
Reach out your usual contact person at Swedbank Pay.

{: .p .pl-3 .pr-3  }
For technical questions:
**Phone:** +46 8 411 10 80
**Email:** support.psp@swedbankpay.se

*   **Are you connected to our e-commerce platform via a partner or technical provider?**
Reach out to your contact person at the partner or provider first.

{: .p .pl-3 .pr-3  }
For technical questions:
**Phone:** +46 8 411 10 80
**Email:** support.psp@swedbankpay.se

*   **Are you integrated directly with our e-commerce platform at Swedbank Pay?**
Reach out to your contact person at Swedbank Pay, Key Account Manager (KAM) or
Technical Account Manager (TAM).

{: .p .pl-3 .pr-3  }
For technical questions:
**Phone:** +46 8 411 10 80
**Email:** support.psp@swedbankpay.se
{% endcapture %}
{% include accordion-table.html content=acc-15 header_text='Where do I turn if have further questions or need support?' header_expand_css='font-weight-normal' %}

[admin]: https://merchantportal.externalintegration.swedbankpay.com
[content-type]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type
[iso-3166]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
[iso-4217]: https://en.wikipedia.org/wiki/ISO_4217
[iso-639-1]: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
[iso-8601]: https://en.wikipedia.org/wiki/ISO_8601
[java-tls]: https://blogs.oracle.com/java/post/jdk-8-will-use-tls-12-as-default
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
[ssllabs]: https://www.ssllabs.com/ssltest/analyze.html?d=api.payex.com
[the-rest-and-then-some]: https://www.youtube.com/watch?v=QIv9YR1bMwY
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[uuid]: https://en.wikipedia.org/wiki/Universally_unique_identifier
