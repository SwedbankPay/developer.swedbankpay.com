{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}
{% if features_url contains "payment-instruments" %}
    {% capture capture_url %}capture{% endcapture %}
{% else %}
    {% capture capture_url %}payment-order-capture{% endcapture %}
{% endif %}
{% if documentation_section == "payment-menu" %}
    {% capture verification_url %}/psp/paymentorders/{{ page.payment_id }}/verifications{% endcapture %}
    {% capture authorization_url %}/psp/paymentorders/{{ page.payment_id }}/authorizations{% endcapture %}
    {% capture purchase_url %}/psp/paymentorders/{{ page.payment_id }}{% endcapture %}
{% else %}
    {% capture verification_url %}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/verifications{% endcapture %}
    {% capture authorization_url %}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations{% endcapture %}
    {% capture purchase_url %}/psp/{{ api_resource }}/payments/{{ page.payment_id }}{% endcapture %}
{% endif %}

## One-Click Payments

{% include jumbotron.html body="One-Click Payments utilize a previously
generated payment token to prefill payment details for credit card or
invoice payments pages - which means that the payer don't need to enter
these details for every purchase." %}

### Introduction

{% if documentation_section contains "checkout-v3" %}

For card and invoice payments, the payment flow and implementation varies from
your default only being the use of a `paymentToken`. The details in this section
describe explicitly the parameters that must be set to enable one-click
purchases.

{% else %}

For [card][card] and [invoice][invoice] payments, the payment flow and
implementation varies from your default only being the use of a `paymentToken`.
The details in this section describe explicitly the parameters that must be set
to enable one-click purchases.

{% endif %}

### API Requests To Generate The Payment Token

When making the initial purchase request, you need to generate a `paymentToken`.
You can do this by setting the `generatePaymentToken` field in the request's
payment object to `true` (see example below) when doing a card purchase, or
setting the initial operation to [`Verify`][verify].

{:.code-view-header}
**generatePaymentToken field**

```json
{
    "generatePaymentToken": true,
    "payer": {
    "payerReference": "AB1234",
    }
}
```

### Finding The `paymentToken` Value

When the initial purchase is successful, a `paymentToken` is linked to
the payment.  You can return the value by sending a `GET` request towards the
payment resource (expanding either the authorizations or verifications
sub-resource), after the payer successfully has completed the purchase. The two
examples are provided below.

{:.code-view-header}
**Request Towards Authorizations Resource**

```http
GET  {{ verification_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
```

{:.code-view-header}
**Request Towards Verifications Resource**

```http
GET {{ authorization_url }} HTTP/1.1
Authorization: Bearer <AccessToken>
```

You need to store the `paymentToken` from the response in your system and keep
track of the corresponding `payerReference` in your system.

### Returning Purchases

When a known payer (where you have attained a `payerReference` or similar)
returns to your system, you can use the `paymentToken`, using already stored
payment data, to initiate one-click payments.

You will need to make a standard purchase, following the sequence as specified
in the Redirect or Seamless View scenarios for [credit card][card] and
[financing invoice][invoice]. When creating the first `POST` request you insert
the `paymentToken` field. This must be the `paymentToken` you received in the
initial purchase, where you specified the `generatePaymentToken` to `true`.

You can add the field `noCvc` set to `true` in the `creditcard` object, which
card specific feature fields. This disables the CVC field.

{% unless documentation_section contains "checkout-v3" %}

See the Features section for how to create a [card][create-card-payment]
and [invoice][create-invoice-payment] payment.

{% endunless%}

## One-Click Request

Abbreviated code example:

{:.code-view-header}
**Request**

```http
POST {{ purchase_url }} HTTP/1.1
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
| {% icon check %} | └➔&nbsp;`operation`    | `string`  | Determines the initial operation, that defines the type card payment created.<br> <br> `Purchase`. Used to charge a card. It is followed up by a capture or cancel operation.<br> <br> `Recur`.Used to charge a card on a recurring basis. Is followed up by a capture or cancel operation (if not Autocapture is used, that is).<br> <br>`Payout`. Used to deposit funds directly to credit card. No more requests are necessary from the merchant side.<br> <br>`Verify`. Used when authorizing a card withouth reserveing any funds.  It is followed up by a verification transaction. | {% if documentation_section contains "checkout-v3" %}
| {% icon check %} | └➔&nbsp;`intent`       | `string`  | The intent of the payment identifies how and when the charge will be effectuated. This determine the type transactions used during the payment process.<br> <br>`Authorization`. Reserves the amount, and is followed by a cancellation or capture of funds.<br> <br>`AutoCapture`. A one phase-option that enable capture of funds automatically after authorization.                     | {% else %}
| {% icon check %} | └➔&nbsp;`intent`       | `string`  | The intent of the payment identifies how and when the charge will be effectuated. This determine the type transactions used during the payment process.<br> <br>`Authorization`. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br>`AutoCapture`. A one phase-option that enable capture of funds automatically after authorization.                     | {% endif %}
| {% icon check %} | └➔&nbsp;`paymentToken` | `string`  | The `paymentToken` value received in `GET` response towards the Payment Resource is the same `paymentToken` generated in the initial purchase request. The token allow you to use already stored card data to initiate one-click payments.                                                                                                                                                                                                                                                                                                                                                |
|                  | └➔&nbsp;`creditCard`   | `object`  | An object that holds different scenarios for card payments.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | └─➔&nbsp;`noCvc`       | `boolean` | `true` if the CVC field should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                 |

{% include alert.html type="informative" icon="info" body="
When redirecting to Swedbank Pay the payment page will be
prefilled with the payer's card details. See example below." %}

## How It Looks

{:.text-center}
![One click payment page][one-click-image]{:height="510px" width="475px"}

### Delete Payment Token

If you need to delete a `paymentToken`, you have two options. The first is by
`payerReference`, which deletes all payment, recurrence and/or unscheduled
tokens associated with the payer. The second is by `paymentToken`, which only
deletes a specific token.

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

## Delete Payment Token Request

If you want to delete tokens by `payerReference`, the request and response
should look like this:

{:.code-view-header}
**Request**

```http
PATCH /psp/paymentorders/payerownedtokens/<payerReference> HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "state": "Deleted",
  "comment": "Comment stating why this is being deleted"
}
```

{% comment %}
TODO: Remove pipes from the above code example and add a field table
      explaining each field here.
{% endcomment %}

## Delete Payment Token Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payerOwnedTokens": {
        "id": "/psp/paymentorders/payerownedtokens/{payerReference}",
        "payerReference": "{payerReference}",
        "tokens": [
            {
                "token": "{paymentToken}",
                "tokenType": "Payment",
                "instrument": "Invoice-payexfinancingno",
                "instrumentDisplayName": "260267*****",
                "instrumentParameters": {
                    "email": "hei@hei.no",
                    "msisdn": "+4798765432",
                    "zipCode": "1642"
                }
            },
            {
                "token": "{paymentToken}",
                "tokenType": "Unscheduled",
                "instrument": "CreditCard",
                "instrumentDisplayName": "492500******0004",
                "instrumentParameters": {
                    "expiryDate": "12/2020",
                    "cardBrand": "Visa"
                }
            }
        ]
    }
}
```

## Deleting Single Tokens

{% if documentation_section contains "checkout" %}

For single token deletions, the request and response should look like this. In
this example, the token is connected to a card. If it was a token connected to
an invoice, the `instrumentDisplayName` would be the payer's date of birth.

## Delete Single Token Request

{:.code-view-header}
**Request**

```http
PATCH /psp/paymentorders/paymenttokens/{{ page.payment_token }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "state": "Deleted",
  "comment": "Comment stating why this is being deleted"
}
```

## Delete Single Token Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentToken": "{{paymentToken}}",
    "instrument": "CreditCard",
    "instrumentDisplayName": "492500******0004",
    "instrumentParameters": {
        "expiryDate": "12/2022",
        "cardBrand": "Visa"
    }
}
```

{% else %}

For single token deletions, the request and response should look like this. In
this example, the token is a payment token and is connected to a card.

## Delete Single Token Request

{:.code-view-header}
**Request**

```http
PATCH /psp/creditcard/payments/instrumentData/{{ page.payment_token }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
{
  "state": "Deleted",
  "comment": "Comment on why the deletion is happening",
  "tokenType" : "PaymentToken"

}
}
```

## Delete Single Token Response

{:.code-view-header}
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
    "cardBrand": "Visa",
    "maskedPan": "123456xxxxxx1111",
    "expiryDate": "MM/YYYY",
    "tokenType" : "PaymentToken"
  }
}
```

{% endif %}

<!--lint disable final-definition -->

[card]: /payment-instruments/card
[invoice]: /payment-instruments/invoice
[one-click-image]: /assets/img/checkout/one-click.png
[delete-payment-token]: {{ features_url }}/optional/delete-token
[cancel]: {{ features_url }}/core/cancel
[capture]: {{ features_url }}/core/{{ capture_url }}
[create-card-payment]: /payment-instruments/card/features/technical-reference/create-payment
[create-invoice-payment]: /payment-instruments/invoice/features/technical-reference/create-payment
[verify]: /payment-instruments/card/features/optional/verify
