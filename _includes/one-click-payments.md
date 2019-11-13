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

For our Seamless View, the URL property called `paymentUrl` will be used if the
consumer is redirected out of the Seamless View frame through our
[Credit Card API][credit-card-api]. The consumer is redirected out of frame when
at the 3d secure verification for credit card payments. The URL should represent
the page of where the payment Seamless View was hosted originally, such as the
checkout page, shopping cart page, or similar. Basically, `paymentUrl` should be
set to the same URL as that of the page where the JavaScript for the hosted
payment view was added to in order to initiate the payment. Please note that the
`paymentUrl` must be able to invoke the same JavaScript URL from the same
Payment as the one that initiated the payment originally, so it should include
some sort of state identifier in the URL. The state identifier is the ID of the
order, shopping cart or similar that has the URL of the Payment stored.

With `paymentUrl` in place, the retry process becomes much more convenient for
both the integration and the payer.

### Returning purchases

When a known consumer (where you have attained a consumer-ID or similar) returns
to your system, you can use the payment token, using already stored payment
data, to initiate enable one-click payments. You will need to make a standard
redirect purchase, following the sequence as specified in the Redirect scenarios
for [credit card][card] and [financing invoice][invoice]. When making the first
`POST` request you insert the `paymentToken` attribute. This must be the
`paymentToken` you received in the initial purchase, where you specified the
`generatePaymentToken` to `true`.

See the technical reference, for how to create a [card][create-card-payment]
and [invoice][create-invoice-payment] payment.

{:.code-header}
**Request**

```HTTP
POST /psp/creditcard/payments HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
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
      "hostUrls": ["http://test-dummy.net"],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://example.com/perform-payment",
      "logoUrl": "https://test-dummy.net/payment-logo.png",
      "termsOfServiceUrl": "https://test-dummy.net/payment-terms.html"
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

![One click payment page][one-click-image]

### Delete payment token

If you, for any reason, need to delete a `paymentToken` 
you use the `Delete payment token` request.

{:.code-header}
**Request**

```http
PATCH /psp/creditcard/payments/instrumentData/<paymentToken> HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "state": "Deleted", 
  "tokenType" : "PaymentToken|RecurrenceToken",
  "comment": "Comment on why the deletion is happening"
}
```

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
    "isDeleted": true|false,
    "isPayeeToken": false,
    "cardBrand": "Visa|MasterCard|...",
    "maskedPan": "123456xxxxxx1111",
    "expiryDate": "MM/YYYY"
  }
}
```

-----------------------------
[card]: /payments/credit-card/
[invoice]: /payments/invoice/
[credit-card-api]: /payments/credit-card/
[one-click-image]: /assets/img/checkout/one-click.png
[delete-payment-token]: #delete-payment-token
[create-card-payment]: /payments/credit-card/
[create-invoice-payment]: /payments/invoice/