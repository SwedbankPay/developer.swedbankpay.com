{% assign api_resource = include.api_resource | default: "api-resource-not-set" %}

## Abort

To abort a payment, perform the `update-payment-abort` operation that is
returned in the payment request.
You need to include the following HTTP body:

{:.code-header}
**Request**

```http
PATCH /psp/{{ api_resource }}/payments/{{ page.payment_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "payment": {
    "operation": "Abort",
    "abortReason": "CancelledByConsumer"
  }
}
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
        "number": 70100130293,
        "created": "2019-01-09T13:11:28.371179Z",
        "updated": "2019-01-09T13:11:46.5949967Z",
        "instrument": "{{ api_resource | capitalize }}",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Aborted",
        "currency": "SEK",
        "prices": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/prices"
        },
        "amount": 0,
        "description": "{{ api_resource }} Test",
        "payerReference": "100500",
        "initiatingSystemUserAgent": "PostmanRuntime/7.1.1",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payeeinfo"
        },
        "metadata": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/metadata"
        }
    },
    "operations": []
}
```

The response will be the `payment` resource with its `state` set to `Aborted`.
