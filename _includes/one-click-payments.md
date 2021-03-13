{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}

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

### API Requests To Generate paymentToken

When making the initial purchase request, you need to generate a `paymentToken`.
You can do this either by by setting the `generatePaymentToken` field to
`true` (see example below) when doing a card purchase, or set the initial
operation to [`Verify`][verify].

{:.code-view-header}
**generatePaymentToken field**

```json
{
    "generatePaymentToken": true
}
```

### Finding paymentToken value

When the initial purchase is successful, a `paymentToken` is linked to
the payment.  You can return the value by sending a `GET` request towards the
payment resource (expanding either the authorizations or verifications
sub-resource), after the payer successfully has completed the purchase. The two
examples are provided below.

{:.code-view-header}
**Request Towards Authorizations Resource**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
```

{:.code-view-header}
**Request Towards Verifications Resource**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/verifications HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
```

You need to store the `paymentToken` from the response in your system and keep
track of the corresponding `payerReference` in your system.

### Returning Purchases

When a known payer (where you have attained a `payerReference` or similar)
returns to your system, you can use the `paymentToken`, using already stored
payment data, to initiate one-click payments. You will need to make a standard
purchase, following the sequence as specified in the Redirect or Seamless View
scenarios for [credit card][card] and [financing invoice][invoice]. When
creating the first `POST` request you insert the `paymentToken` field. This must
be the `paymentToken` you received in the initial purchase, where you specified
the `generatePaymentToken` to `true`.

See the Other Feature sections for how to create a [card][create-card-payment]
and [invoice][create-invoice-payment] payment.

Abbreviated code example:

{:.code-view-header}
**Request**

```http
POST /psp/{{ api_resource }}/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "paymentToken": "{{ page.payment_token }}"
    },
    "creditCard": {
        "noCvc": true
    }
}
```

{:.table .table-striped}
|     Required     | Field                  | Type      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :--------------: | ---------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `payment`              | `object`  | The `payment` object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | └➔&nbsp;`operation`    | `string`  | Determines the initial operation, that defines the type card payment created.<br> <br> `Purchase`. Used to charge a card. It is followed up by a capture or cancel operation.<br> <br> `Recur`.Used to charge a card on a recurring basis. Is followed up by a capture or cancel operation (if not Autocapture is used, that is).<br> <br>`Payout`. Used to deposit funds directly to credit card. No more requests are necessary from the merchant side.<br> <br>`Verify`. Used when authorizing a card withouth reserveing any funds.  It is followed up by a verification transaction. |
| {% icon check %} | └➔&nbsp;`intent`       | `string`  | The intent of the payment identifies how and when the charge will be effectuated. This determine the type transactions used during the payment process.<br> <br>`Authorization`. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br>`AutoCapture`. A one phase-option that enable capture of funds automatically after authorization.                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`paymentToken` | `string`  | The `paymentToken` value received in `GET` response towards the Payment Resource is the same `paymentToken` generated in the initial purchase request. The token allow you to use already stored card data to initiate one-click payments.                                                                                                                                                                                                                                                                                                                                                |
|                  | └➔&nbsp;`creditCard`   | `object`  | An object that holds different scenarios for card payments.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | └─➔&nbsp;`noCvc`       | `boolean` | `true` if the CVC field should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                 |

{% include alert.html type="informative" icon="info" body="
When redirecting to Swedbank Pay the payment page will be
prefilled with the payer's card details. See example below." %}

{:.text-center}
![One click payment page][one-click-image]{:height="510px" width="475px"}

### Delete payment token

If you, for any reason, need to delete a `paymentToken`
you use the `Delete payment token` request.

{% include alert.html type="warning"
                      icon="warning"
                      body="Please note that this call does not erase the card
  number stored at Swedbank Pay.
  A card number is automatically deleted six months after a successful
  `Delete payment token` request.
  If you want card information removed at an earlier date, you need to contact
  [ehandelsetup@swedbankpay.dk](mailto:ehandelsetup@swedbankpay.dk),
  [verkkokauppa.setup@swedbankpay.fi](mailto:verkkokauppa.setup@swedbankpay.fi),
  [ehandelsetup@swedbankpay.no](mailto:ehandelsetup@swedbankpay.no) or
  [ehandelsetup@swedbankpay.se](mailto:ehandelsetup@swedbankpay.se);
  and supply them with the relevant transaction reference or payment token." %}

{:.code-view-header}
**Request**

```http
PATCH /psp/creditcard/payments/instrumentData/{{ page.payment_token }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "state": "Deleted",
    "tokenType": "PaymentToken",
    "comment": "Comment on why the deletion is happening"
}
```

{% comment %}
TODO: Remove pipes from the above code example and add a field table
      explaining each field here.
{% endcomment %}

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "instrumentData": {
        "id": "/psp/{{ api_resource }}/payments/instrumentdata/{{ page.payment_token }}",
        "paymentToken": "{{ page.payment_token }}",
        "payeeId": "{{ page.merchant_id }}",
        "isDeleted": true,
        "isPayeeToken": false,
        "cardBrand": "Visa",
        "maskedPan": "123456xxxxxx1111",
        "expiryDate": "MM/YYYY"
    }
}
```

{% comment %}
TODO: Remove pipes from the above code example and add a field table
      explaining each field here.
{% endcomment %}

-----------------------------
[card]: /payment-instruments/card
[invoice]: /payment-instruments/invoice
[one-click-image]: /assets/img/checkout/one-click.png
[delete-payment-token]: #delete-payment-token
[cancel]: {{ features_url }}/core/cancel
[capture]: {{ features_url }}/core/capture
[create-card-payment]: /payment-instruments/card/features/technical-reference/create-payment
[create-invoice-payment]: /payment-instruments/invoice/features/technical-reference/create-payment
[verify]: {{ features_url }}/optional/verify
