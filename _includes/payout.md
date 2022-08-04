## Payout

{% include jumbotron.html body="**Payout to Card** is an add-on service which
enables you to deposit winnings directly to the winner's card. This without
having to collect card details a second time." %}

## Introduction

*   The only acquirer for this service is Swedbank. You require a separate
    Swedbank acquiring number to ensure that payout transactions and regular
    card transactions are kept separate.
*   You need to have the 3-D Secure protocol enabled.
*   The service is available through a Swedbank Pay hosted payment page.
*   The current implementation is only available for gaming transactions
    (Merchant Category Code 7995).
*   The payout service is not a part of Swedbank Pay Settlement Service.

## API Requests

The API requests are displayed in the [payout flow](#payout-flow).  You create
a payout by performing a `POST` creditcard payments with key `operation` set to
`payout`.

## Payout Request

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Payout",
        "intent": "AutoCapture",
        "paymentToken": "{{ page.payment_id }}",
        "currency": "NOK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Payout",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "callbackUrl": "https://example.com/payment-callback"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}"
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        }
    }
}
```

## Payout Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": {
    "id": "/psp/creditcard/payments/{{ page.payment_id }}",
    "number": 1234567890,
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Payout",
    "currency": "NOK",
    "amount": 1500,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Recurrence",
    "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
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
    "payeeInfo" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payeeInfo" },
    "settings": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/settings" }
  }
}
```

### Payout Flow

You must set `Operation` to `Payout` in the initial `POST` request.

```mermaid
sequenceDiagram
  activate Payer
  Payer->>-Merchant: Start payout
  activate Merchant
  Merchant->>-SwedbankPay: POST [Credit Card Payout]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: Payment resource
  activate Merchant
  Merchant-->>-Payer: Display Payout result
```
