{% if include.api_resource == "creditcard" %}
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

MOTO (Mail Order / Telephone Order) is a purchase where you as a merchant enter 
the payer's card details in order to make a payment. The card details are given
over telephone or in writing, and then filled out to the payment interface by the
sales representative. 

Common use-cases are travel or hotel bookings, where the payer calls the sales
representative to make a booking. This feature is only supported in the
`Purchase` operation. See the abbreviated example below on how to implement MOTO
by setting the `generateMotoPayment` to `true`. 
 

{:.code-view-header}
**Request**

```http
POST /psp/{{ include.api_resource }}/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "{{api_resource_field_name}}": {
        "operation": "Purchase",
        "intent": "Authorization",
        "generateMotoPayment": true,
        "currency": "NOK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Moto",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
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
`redirect-{{ api_redirect_rel }}` in the response and redirect the merchant
employee to the provided `href` to fill out the payer’s card details. You will
find an abbreviated example of the response provided below.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "{{api_resource_field_name}}": {
    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "number": 1234567890,
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "NOK",
    "amount": 1500,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Moto",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "nb-NO",
    "prices": { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/prices" },
    "transactions": { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions" },
    "authorizations": { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations" },
    "captures": { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/captures" },
    "reversals": { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/reversals" },
    "cancellations": { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/cancellations" },
    "urls" : { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/urls" },
    "payeeInfo" : { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payeeInfo" }
  },
  "operations": [
        {
            "rel": "redirect-{{ api_redirect_rel }}",
            "href": "{{ page.front_end_url }}/{{ api_redirect_link }}/{{ page.payment_token }}",
            "method": "GET",
            "contentType": "text/html"
        }
  ]
}
```
