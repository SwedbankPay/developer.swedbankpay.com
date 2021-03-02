{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

{% if api_resource == "creditcard" %}
    {% assign api_resource_field_name = "payment" %}
    {% assign api_redirect_rel = "authorization" %}
    {% assign api_redirect_link = "creditcard/payments/authorize" %}
{% else %}
    {% assign api_resource_field_name = "paymentorder" %}
    {% assign api_redirect_rel = "paymentorder" %}
    {% assign api_redirect_link = "paymentmenu" %}
{% endif %}

## MOTO

{% include alert-agreement-required.md %}

MOTO (Mail Order / Telephone Order) is a purchase where you, as a merchant,
enter the payer's card details in order to make a payment. The payer provides
the card details to the sales representative by telephone or in writing.
The sales representative will then enter the details into the payment interface.

Common use cases are travel or hotel bookings, where the payer calls the sales
representative to make a booking. This feature is only supported in the
`Purchase` operation. See the abbreviated example below on how to implement MOTO
by setting the `generateMotoPayment` to `true`.


{:.code-view-header}
**Request**

```http
POST /psp/{{ api_resource }}/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "{{api_resource_field_name}}": {
        "operation": "Purchase",
        "intent": "Authorization",
        "generateMotoPayment": true,
        "currency": "NOK",
        "prices": [{
                "type": "CreditCard",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Moto",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
            "hostUrls": ["https://example.com"],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "callbackUrl": "https://example.com/payment-callback"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        }
    }
}
```

To authorize the payment, find the operation with `rel` equal to
`redirect-{{ api_redirect_rel }}` in the response, and redirect the merchant
employee to the provided `href` to fill out the payer’s card details. You will
find an abbreviated example of the response provided below.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "{{api_resource_field_name}}": {
        "id": "/psp/creditcard/payments/a205c77e-2f0a-4564-3e60-08d8d3ed4699",
        "number": 40106480687,
        "created": "2021-02-24T12:51:51.0932275Z",
        "updated": "2021-02-24T12:51:51.2935307Z",
        "instrument": "CreditCard",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "NOK",
        "prices": {
            "id": "/psp/creditcard/payments/a205c77e-2f0a-4564-3e60-08d8d3ed4699/prices"
        },
        "amount": 0,
        "description": "Test Moto",
        "initiatingSystemUserAgent": "PostmanRuntime/7.26.10",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
            "id": "/psp/{{ api_resource }}/payments/a205c77e-2f0a-4564-3e60-08d8d3ed4699/urls"
        },
        "payeeInfo": {
            "id": "id": "/psp/{{ api_resource }}/payments/a205c77e-2f0a-4564-3e60-08d8d3ed4699/payeeInfo"
        },
        "metadata": {
            "id": "/psp/{{ api_resource }}/payments/a205c77e-2f0a-4564-3e60-08d8d3ed4699/metadata"
        }
    },
       "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/creditcard/payments/a205c77e-2f0a-4564-3e60-08d8d3ed4699",
            "rel": "update-payment-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/creditcardv3/core/js/px.creditcard.client.js?token=a0a2da77fe9582387d384b77cc0d7d04fb861d10ba13fc46d3abca00f4a1368f&operation=authorize",
            "rel": "view-authorization",
            "contentType": "application/javascript"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/creditcardv3/payments/authorize/a0a2da77fe9582387d384b77cc0d7d04fb861d10ba13fc46d3abca00f4a1368f",
            "rel": "redirect-authorization",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/creditcardv3/core/js/px.creditcard.client.js?token=a0a2da77fe9582387d384b77cc0d7d04fb861d10ba13fc46d3abca00f4a1368f",
            "rel": "view-payment",
            "contentType": "application/javascript"
        }
    ]
}
```
