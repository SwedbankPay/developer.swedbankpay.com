---
title: Swedbank Pay Payments Swish Other Features
sidebar:
  navigation:
  - title: Swish Payments
    items:
    - url: /payments/swish
      title: Introduction
    - url: /payments/swish/direct
      title: Direct
    - url: /payments/swish/redirect
      title: Redirect
    - url: /payments/swish/seamless-view
      title: Seamless View
    - url: /payments/swish/after-payment
      title: After Payment
    - url: /payments/swish/other-features
      title: Other Features
---

{% include payment-resource.md payment_instrument="swish" showStatusOperations=true%}

{% include payment-transaction-states.md %}

## Create Payment

To create a Swish payment, you perform an HTTP `POST` against the
`/psp/swish/payments` resource.

An example of a payment creation request is provided below.
Each individual field of the JSON document is described in the following
section.
Use the [expand][technical-reference-expand] request parameter to get a
response that includes one or more expanded sub-resources inlined.

{:.code-header}
**Request**

```http
POST /psp/swish/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Sale",
        "currency": "SEK",
        "prices": [{
            "type": "Swish",
            "amount": 1500,
            "vatAmount": 0
        }],
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "ref-123456",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        },
        "prefillInfo": {
            "msisdn": "+46739000001"
        },
        "swish": {
            "ecomOnlyEnabled": false
        }
    }
}
```

{:.table .table-striped}
| Required | Field                           | Type         | Description                                                                                                                                                                                                                                               |
| :------: | :------------------------------ | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|    ✔︎    | `payment`                       | `object`     | The `payment`object.                                                                                                                                                                                                                                      |
|    ✔︎    | └➔&nbsp;`operation`             | `string`     | `Purchase`                                                                                                                                                                                                                                                |
|    ✔︎    | └➔&nbsp;`intent`                | `string`     | `Sale`                                                                                                                                                                                                                                                    |
|    ✔︎    | └➔&nbsp;`currency`              | `string`     | `SEK`                                                                                                                                                                                                                                                     |
|    ✔︎    | └➔&nbsp;`prices`                | `object`     | The `prices` object contains information about what is being bought in this payment.                                                                                                                                                                      |
|    ✔︎    | └─➔&nbsp;`type`                 | `string`     | `Swish`                                                                                                                                                                                                                                                   |
|    ✔︎    | └─➔&nbsp;`amount`               | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                 |
|    ✔︎    | └─➔&nbsp;`vatAmount`            | `integer`    | {% include field-description-vatamount.md %}                                                                                                        |
|    ✔︎    | └➔&nbsp;`description`           | `string(40)` | A textual description max 40 characters of the purchase.                                                                                                                                                                                                  |
|          | └➔&nbsp;`payerReference`        | `string`     | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc.                                                                                                                                         |
|    ✔︎    | └➔&nbsp;`userAgent`             | `string`     | The user agent reference of the consumer's browser - [see user agent definition][user-agent]                                                                                                                                                              |
|    ✔︎    | └➔&nbsp;`language`              | `string`     | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                              |
|    ✔︎    | └➔&nbsp;`urls`                  | `object`     | The URLS object contains information about what urls this payment should use.                                                                                                                                                                             |
|    ✔︎    | └─➔&nbsp;`hostUrls`             | `array`      | The array of URIs valid for embedding of Swedbank Pay Hosted Views.                                                                                                                                                                                       |
|    ✔︎    | └─➔&nbsp;`completeUrl`          | `string`     | The URI that Swedbank Pay will redirect back to when the payment page is completed. This does not indicate a successful payment, only that it has reached a completion state. A `GET` request needs to be performed on the payment to inspect it further. |
|    ✔︎    | └─➔&nbsp;`cancelUrl`            | `string`     | The URI that Swedbank Pay will redirect back to when the user presses the cancel button in the payment page.                                                                                                                                              |
|          | └─➔&nbsp;`callbackUrl`          | `string`     | The URI that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][technical-reference-callback] for details.                                                                                 |
|          | └─➔&nbsp;`logoUrl`              | `string`     | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width. Require https.                                                                                                                       |
|          | └─➔&nbsp;`termsOfServiceUrl`    | `string`     | A URI that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                           |
|    ✔︎    | └➔&nbsp;`payeeInfo`             | `object`     | A object containing info about the payee.                                                                                                                                                                                                                 |
|    ✔︎    | └─➔&nbsp;`payeeId`              | `string`     | This is the unique id that identifies this payee (like merchant) set by PayEx.                                                                                                                                                                            |
|    ✔︎    | └─➔&nbsp;`payeeReference`       | `string(35)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [`payeeReference`][technical-reference-payeeReference] for details.                                             |
|          | └➔&nbsp;`payeeName`             | `string`     | The payee name (like merchant name) that will be displayed to consumer when redirected to PayEx.                                                                                                                                                          |
|          | └➔&nbsp;`productCategory`       | `string`     | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                   |
|          | └➔&nbsp;`orderReference`        | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|          | └➔&nbsp;`subsite`               | `string(40)` | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                               |
|          | └➔&nbsp;`prefillInfo.msisdn`    | `string`     | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                    |
|          | └➔&nbsp;`swish.ecomOnlyEnabled` | `boolean`    | `true` if to only enable Swish on browser based transactions.; otherwise `false` to also enable Swish transactions via mobile app.                                                                                                                        |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/swish/payments/{{ page.payment_id }}",
        "number": 992308,
        "created": "2017-10-23T08:38:57.2248733Z",
        "instrument": "Swish",
        "operation": "Purchase",
        "intent": "Sale",
        "state": "Ready",
        "currency": "SEK",
        "amount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/swish/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/swish/payments/{{ page.payment_id }}/payeeinfo"
        }
    },
    "operations": [
        {
            "method": "POST",
            "href": "http://{{ page.api_host }}/psp/swish/payments/{{ page.payment_id }}/sales",
            "rel": "create-sale"
        }
}
```

### Mobile Number Validation

#### eCommerce

All international mobile numbers are supported. To be valid, the number input
must be with a country code prefix and consist of 8 to 15 characters. Digits are
the only characters allowed, and the regex used is `\\+[1-9]\\d{7,14}`. A valid
Swedish mobile number would be `+46739000001`, a valid Norwegian mobile number
would be `+4792345678`.

#### mCommerce

No number input is needed in the mCommerce flow. The payer's mobile number must
be connected to a Swish account.

{% include settlement-reconciliation.md %}

{% include payment-link.md show_3d_secure=false show_authorization=false %}

{% include prices.md payment_instrument="swish" %}

{% include payee-info.md %}

{% include expand-parameter.md %}

{% include transactions-reference.md payment_instrument="swish" %}

{% include callback-reference.md payment_instrument="swish" %}

### Problem messages

When performing unsuccessful operations, the eCommerce API will respond with a
problem message.
We generally use the problem message type and status code to identify
the nature of the problem.
The problem name and description will often help narrow down the specifics
of the problem.

## Swish API errors

All Swish error types will have the following URI in front of type:
`{{ page.api_url }}/psp/errordetail/<errortype>`

### `inputerror`

Caused By:

- MSISDN is invalid.
- Payer's MSISDN is not enrolled at Swish.

{:.code-header}
Example response inputerror

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/inputerror",
    "title": "Input error",
    "status": 400,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Msisdn is invalid."
}
```

### `configerror`

Caused By:

- Payee alias is missing or not correct.
- PaymentReference is invalid.
- Amount value is missing or not a valid number.
- Amount is less than agreed minimum.
- Amount value is too large.
- Invalid or missing currency.
- Wrong formatted message.
- Amount value is too large, or amount exceeds the amount of the original payment minus any previous refunds.
- Counterpart is not activated.
- Payee not enrolled.

{:.code-header}
Example response configerror

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/configerror",
    "title": "Config error",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Payee alias is missing or not correct."
}
```

### `swishdeclined`

Caused By:

- Original payment not found or original payment is more than than 13 months old.
- It appears that merchant's organization number has changed since sale was made.
- The MSISDN of the original payer seems to have changed owner.
- Transaction declined. Could be that the payer has exceeded their swish limit or have insufficient founds.
- Payment request not cancellable.

{:.code-header}
Example response swishdeclined

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishdeclined",
    "title": "Swish Declined",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The MSISDN of the original payer seems to have changed owner."
}
```

### `swisherror`

Caused By:

- Bank system processing error.
- Swish timed out waiting for an answer from the banks after payment was started.

{:.code-header}
Example response swisherror

```http
HTTP/1.1 502 Bad Gateway
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swisherror",
    "title": "Error in Swish",
    "status": 502,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Bank system processing error."
}
```

### `swishalreadyinuse`

Caused By:

- The payer's Swish is already in use.

{:.code-header}
Example response swishalreadyinuse

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishalreadyinuse",
    "title": "Error in Swish",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer's Swish is already in use."
}
```

### `swishtimeout`

Caused By:

- Swish timed out before the payment was started.

{:.code-header}
Example response swishtimeout

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishtimeout",
    "title": "Swish Timed Out",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Swish timed out before the payment was started."
}
```

### `bankidcancelled`

Caused By:

- The payer cancelled BankID authorization.

{:.code-header}
Example response bankidcancelled

```http
HTTP/1.1 409 Conflict
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankidcancelled",
    "title": "BankID Authorization Cancelled",
    "status": 409,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer cancelled BankID authorization."
}
```

### `bankidalreadyinuse`

Caused By:

- The payer's BankID is already in use

{:.code-header}
Example response bankidalreadyinuse

```http
HTTP/1.1 409 Conflict
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankidalreadyinuse",
    "title": "BankID Already in Use",
    "status": 409,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer's BankID is already in use."
}
```

### `bankiderror`

Caused By:

- Something went wrong with the payer's BankID authorization.

{:.code-header}
Example response bankiderror

```http
HTTP/1.1 502 Bad Gateway
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankiderror",
    "title": "BankID error",
    "status": 502,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Something went wrong with the payer's BankID authorization."
}
```

### `socialsecuritynumbermismatch`

Caused By:

- The payer's social security number does not match with the one required by this payment.

{:.code-header}
Example response socialsecuritynumbermismatch

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/socialsecuritynumbermismatch",
    "title": "Social Security Number Mismatch",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer's social security number does not match with the one required by this payment."
}
```

### `paymentagelimitnotmet`

Caused By:

- The payer does not meet the payment's age limit.

{:.code-header}
Example response paymentagelimitnotmet

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/paymentagelimitnotmet",
    "title": "Payment Age Limit Not Met",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer does not meet the payment's age limit."
}
```

### `usercancelled`

Caused By:

- The payer cancelled the payment in the Swish app.

{:.code-header}
Example response usercancelled

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/usercancelled",
    "title": "User Cancelled",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer cancelled the payment in the Swish app."
}
```

### `systemerror`

{:.code-header}
Example response systemerror

```http
HTTP/1.1 500 Internal Server Error
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/systemerror",
    "title": "Error in System",
    "status": 500,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "A system error occurred. We are working on it."
}
```

{% include iterator.html prev_href="after-payment" prev_title="Back: After
Payment" %}

[payee-reference]: #payeeReference
[transaction-resource]: #Transactions
