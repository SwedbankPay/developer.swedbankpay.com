## Unscheduled Purchase

{% include alert-agreement-required.md %}

An `unscheduled purchase`, also called a Merchant Initiated Transaction (MIT),
is a payment which uses a `paymentToken` generated through a previous payment in
order to charge the same card at a later time. They are done by the merchant
without the cardholder being present.

`unscheduled purchase`s differ from `recur` as they are not meant to be
recurring, but occur as singular transactions. Examples of this can be car
rental companies charging the payer's card for toll road expenses after the
rental period.

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "UnscheduledPurchase",
        "intent": "Authorization",
        "paymentToken": "{{ page.payment_id }}",
        "currency": "NOK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Unscheduled",
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

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": {
    "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
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
    "description": "Test Unscheduled",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "nb-NO",
    "paymentToken": "{{ page.payment_id }}",
    "prices": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/prices" },
    "transactions": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions" },
    "authorizations": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/authorizations" },
    "captures": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/captures" },
    "reversals": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/reversals" },
    "cancellations": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/cancellations" },
    "urls" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/urls" },
    "payeeInfo" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payeeInfo" }
  }
}
```
