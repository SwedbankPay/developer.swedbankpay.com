{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% assign token_url_without_psp = api_resource %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

{% unless api_resource == "paymentorders" %}
    {% assign token_url_without_psp = token_url_without_psp | append: '/payments' %}
{% endunless %}

{% assign token_url = token_url_without_psp | prepend: '/psp/' %}

## Transaction On File

{% include alert-agreement-required.md %}

In rare use cases, it can be necessary for merchants who operate with payment
tokens (recurring, one-click, etc) to be able to submit subsequent transactions
via file transfer rather than using the regular operations in our API. Reasons
for this could be that the subsequent transactions are triggered from an older
system which doesn't support real-time API communication. For those use cases,
Swedbank Pay offers a service called Transaction on File. This way of completing
transactions is slightly outdated, so we strongly recommend that you consider
our regular API operations instead, and only use transaction on file when it is
the only option.

Do you want to know more about this service? Please contact our integration
support.

### How It Looks

You will redirect the payer to Swedbank Pay hosted pages to collect
their card information.

{:.text-center}
![screenshot of the swedish card verification page][swedish-verify]{:height="600px" width="475px"}

### API Requests

The API requests are displayed in the flow below. The generated token will be
returned in the parameter 'transactionOnFileToken'. For more information
regarding the flow, see Verify.

## Transaction On File Request

{:.code-view-header}
**Request**

```http
POST {{ token_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Verify",
        "currency": "NOK",
        "description": "Create TransactionOnFileToken",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "generateTransactionOnFileToken": true, {% if documentation_section contains "checkout-v3" %}
        "productName": "Checkout3",
        "implementation": "{{implementation}}",{% endif %}
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.html"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite", {% if documentation_section contains "checkout-v3" %}
            "siteId": "MySiteId", {% endif %}
        },
        "payer": {
            "payerReference": "AB1234",
        }
    }
}
```

## Transaction On File Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "{{ token_url }}/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "operation": "Verify",
        "state": "Ready",
        "currency": "NOK",
        "amount": 0,
        "description": "Test Verification",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "transactions": { "id": "{{ token_url }}/{{ page.payment_id }}/transactions" },
        "verifications": { "id": "{{ token_url }}/{{ page.payment_id }}/verifications" },
        "urls" : { "id": "{{ token_url }}/{{ page.payment_id }}/urls" },
        "payeeInfo" : { "id": "{{ token_url }}/{{ page.payment_id }}/payeeInfo" },
        "payers": { "id": "{{ token_url }}/{{ page.payment_id }}/payers" },
        "settings": { "id": "{{ token_url }}/{{ page.payment_id }}/settings" }
    },
    "operations": [
        {
            "href": "{{ page.api_url }}{{ token_url }}/{{ page.payment_id }}",
            "rel": "update-payment-abort",
            "method": "PATCH",
            "contentType": "application/json"
        },
        {
            "href": "{{ page.front_end_url }}/{{ token_url_without_psp }}/verification/{{ page.payment_token }}",
            "rel": "redirect-verification",
            "method": "GET",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/{{ api_resource }}/core/scripts/client/px.creditcard.client.js?token={{ page.payment_token }}",
            "rel": "view-verification",
            "contentType": "application/javascript"
        }{% if api_resource == "creditcard" %},
        {
            "method": "POST",
            "href": "{{ page.front_end_url }}/psp/{{ api_resource }}/confined/payments/{{ page.payment_id }}/verifications",
            "rel": "direct-verification",
            "contentType": "application/json"
        }{% endif %}
    ]
}
```

[swedish-verify]: /assets/img/payments/swedish-verify.png
