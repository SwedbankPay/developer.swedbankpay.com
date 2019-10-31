## One-Click Payments

{% include jumbotron.html body="One-Click Payments utilize a previously
generated payment token to prefill payment details for credit card or
invoice payments pages - which means that the payer don't need to enter
these details for every purchase." %}

### Introduction 

The main purchase flow and implementation is exactly the same as described in the [Redirect][redirect] and [Hosted View][hosted-view] scenarios for [credit card][card] and [financing invoice][invoice] payments, the difference being the use of a `paymentToken`. The details in this section describe explicitly the parameters that must be set to enable one-click purchases.

### Payment Url

For our hosted view, the URL property called `paymentUrl` will be used if the consumer is redirected out of the hosted view frame through our [Credit Card API][credit-card-api]. The consumer is redirected out of frame when at the 3d secure verification for credit card payments. The URL should represent the page of where the payment hosted view was hosted originally, such as the checkout page, shopping cart page, or similar. Basically, `paymentUrl` should be set to the same URL as that of the page where the JavaScript for the hosted payment view was added to in order to initiate the payment. Please note that the `paymentUrl` must be able to invoke the same JavaScript URL from the same Payment as the one that initiated the payment originally, so it should include some sort of state identifier in the URL. The state identifier is the ID of the order, shopping cart or similar that has the URL of the Payment stored.

With `paymentUrl` in place, the retry process becomes much more convenient for both the integration and the payer.

### Returning purchases

When a known consumer (where you have attained a consumer-ID or similar) returns to your system, you can use the payment token, using already stored payment data, to initiate enable one-click payments. You will need to make a standard redirect purchase, following the sequence as specified in the Redirect scenarios for [credit card][card] and [financing invoice][invoice]. When making the first `POST` request you insert the `paymentToken` attribute. This must be the  `paymentToken` you received in the initial purchase, where you specified the `generatePaymentToken` to `true`.

See the technical reference, for how to create a [card][technical-reference] and [invoice][technical-reference] payment.

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


When redirecting to PayEx (as specified in [the Redirect scenario][redirect]) the payment page will be prefilled with the payer's card details.

### Screenshots 

![One click payment page][one-click-image]

### Delete payment token 

Please see [Delete payment token][delete-payment-token]


[redirect]: #
[hosted-view]: #
[card]: #
[invoice]: #
[credit-card-api]: #
[technical-reference]: #
[one-click-image]: /assets/img/checkout/one_click.png
[delete-payment-token]: #