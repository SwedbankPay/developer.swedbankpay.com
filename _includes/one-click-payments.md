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

### API Requests To Generate paymentToken

When making the initial purchase request, you need to generate a `paymentToken`.
You can do this either by by setting the `generatePaymentToken` property to
`true` (see example below) when doing a card purchase, or set the initial
operation to [`Verify`][verify].

{:.code-header}
generatePaymentToken property

```
"generatePaymentToken": "true"
```

### Finding paymentToken value

When the initial purchase is followed through, a `paymentToken` will linked to
the payment.  You can return the value by making a `GET` request towards payment
resource (expanding either the authorizations or verifications sub-resource),
after the consumer successfully has completed the purchase. The two examples are
provided below.

{:.code-header}
**Request Towards Authorizations Resource**

```http
GET https://api.payex.com/psp/creditcard/payments/<payment-id>/<authorizations> HTTP/1.1
Host: api.payex.com
```

{:.code-header}
**Request Towards Verifications Resource**

```http
GET https://api.payex.com/psp/creditcard/payments/<payment-id>/<verifications> HTTP/1.1
Host: api.payex.com
```

You need to store the `paymentToken` from the response in your system and keep
track of the corresponding consumer-ID in your system.

### Returning Purchases

When a known consumer (where you have attained a consumer-ID or similar) returns
to your system, you can use the payment token, using already stored payment
data, to initiate one-click payments. You will need to make a standard
purchase, following the sequence as specified in the Redirect or Seamless View
scenarios for [credit card][card] and [financing invoice][invoice]. When making
the first `POST` request you insert the `paymentToken` property. This must be
the `paymentToken` you received in the initial purchase, where you specified the
`generatePaymentToken` to `true`.

See the Other Feature sections for how to create a [card][create-card-payment]
and [invoice][create-invoice-payment] payment.

Abbrevated code example:

{:.code-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "<operation>",
        "intent": "<intent>",
        "paymentToken": "<paymentToken>"
    },
}
```

{:.table .table-striped}
| Required | Property            | Type     | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :------: | ------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `payment`           | `object` | The `payment` object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation` | `string` | Determines the initial operation, that defines the type card payment created.<br> <br> `Purchase`. Used to charge a card. It is followed up by a capture or cancel operation.<br> <br> `Recur`.Used to charge a card on a recurring basis. Is followed up by a capture or cancel operation (if not Autocapture is used, that is).<br> <br>`Payout`. Used to deposit funds directly to credit card. No more requests are necessary from the merchant side.<br> <br>`Verify`. Used when authorizing a card withouth reserveing any funds.  It is followed up by a verification transaction. |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`    | `string` | The intent of the payment identifies how and when the charge will be effectuated. This determine the type transactions used during the payment process.<br> <br>`Authorization`. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br>`AutoCapture`. A one phase-option that enable capture of funds automatically after authorization.              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`paymentToken`    | `string` | The `paymentToken` value received in `GET` response towards the Payment Resource is the same `paymentToken` generated in the initial purchase request. The token allow you to use already stored card data to initiate one-click payments.                    |

{% include alert.html type="neutral" icon="info" body="
When redirecting to Swedbank Pay the payment page will be
prefilled with the payer's card details. See example below." %}

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
[card]: /payments/card
[invoice]: /payments/invoice
[one-click-image]: /assets/img/checkout/one-click.png
[delete-payment-token]: #delete-payment-token
[create-card-payment]: /payments/card/other-features#create-payment
[create-invoice-payment]: /payments/invoice/other-features#create-payment
[verify]: ./other-features#verify
