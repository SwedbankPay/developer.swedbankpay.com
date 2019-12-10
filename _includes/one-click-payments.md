## One-Click Payments

{% include jumbotron.html body="One-Click Payments utilize a previously
generated payment token to prefill payment details for credit card or
invoice payments pages - which means that the payer don't need to enter
these details for every purchase." %}

### Introduction

For [credit card][card] and [financing invoice][invoice] payments the
payment flow and implementation varies from your default only being the
use of a `paymentToken`.
The details in this section describe explicitly the parameters that must
be set to enable one-click purchases.

### Payment Url

{% include payment-url.md
when="at the 3-D Secure verification for credit card payments" %}

### Returning purchases

When a known consumer (where you have attained a consumer-ID or similar) returns
to your system, you can use the payment token, using already stored payment
data, to initiate enable one-click payments. You will need to make a standard
redirect purchase, following the sequence as specified in the Redirect scenarios
for [credit card][card] and [financing invoice][invoice]. When making the first
`POST` request you insert the `paymentToken` property. This must be the
`paymentToken` you received in the initial purchase, where you specified the
`generatePaymentToken` to `true`.

See the technical reference, for how to create a [card][create-card-payment]
and [invoice][create-invoice-payment] payment.

{:.code-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Verify",
        "currency": "NOK",
        "description": "Test Verification",
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "generatePaymentToken": true,
        "generateRecurrenceToken": false,
        "urls": {
            "hostUrls": [ "https://example.com" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "http://example.com/perform-payment",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.html"
        },
        "payeeInfo": {
            "payeeId": "12345678-1234-1234-1234-123456789012",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        }
    },
    "creditCard": {
        "rejectCreditCards": false,
        "rejectDebitCards": false,
        "rejectConsumerCards": false,
        "rejectCorporateCards": false
    }
}
```

_When redirecting to Swedbank Pay the payment page will be
prefilled with the payer's card details._

### Screenshots

![One click payment page][one-click-image]{:height="450px" width="425px"}

### Delete payment token

If you, for any reason, need to delete a `paymentToken`
you use the `Delete payment token` request.

{:.code-header}
**Request**

```http
PATCH /psp/creditcard/payments/instrumentData/<paymentToken> HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "state": "Deleted",
    "tokenType": "PaymentToken|RecurrenceToken",
    "comment": "Comment on why the deletion is happening"
}
```

{% comment %}
TODO: Remove pipes from the above code example and add a property table
      explaining each property here.
{% endcomment %}

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "instrumentData": {
        "id": "/psp/creditcard/payments/instrumentdata/12345678-1234-1234-1234-123456789000",
        "paymentToken": "12345678-1234-1234-1234-123456789000",
        "payeeId": "61c65499-de5c-454e-bf4c-043f22538d49",
        "isDeleted": true,
        "isPayeeToken": false,
        "cardBrand": "Visa|MasterCard|...",
        "maskedPan": "123456xxxxxx1111",
        "expiryDate": "MM/YYYY"
    }
}
```

{% comment %}
TODO: Remove pipes from the above code example and add a property table
      explaining each property here.
{% endcomment %}

-----------------------------
[card]: /payments/card/
[invoice]: /payments/invoice/
[one-click-image]: /assets/img/checkout/one-click.png
[delete-payment-token]: #delete-payment-token
[create-card-payment]: /payments/card/
[create-invoice-payment]: /payments/invoice/
