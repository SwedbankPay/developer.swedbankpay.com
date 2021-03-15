{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}

## Recurring payments

{% include jumbotron.html body="A recurring payment enables you to charge a card
without payer interaction. When an initial payment token is generated subsequent
payments are made through server-to-server requests. " %}

### Prerequisites

Prior to making any server-to-server requests, you need to supply the payment
instrument details and a payment token to Swedbank Pay by initial purchase or
[card verification][payment-verify].

There are two ways to initiate recurring payments procedures,
depending on if you want to make an initial charge or not:

*   Initiate a recurring payment flow and **charge the credit card**.
    This is done by creating a "Purchase Payment" and generating a
    recurrence token.

*   Initiate a recurring payment flow **without charging the credit card**.
    This is done by creating  a "Verify Payment" and generating a recurrence
    token.

#### Generate RecurrenceToken

*   When posting a `Purchase` payment, you need to make sure that the field
    `generateRecurrenceToken` is set to `true`

{:.code-view-header}
**Field**

```json
"generateRecurrenceToken": true
```

*   When posting a `Verify` payment, a payment token will be generated
    automatically.

#### Creating a Payment

*   You need to `POST` a [Purchase payment][card-payment-purchase] / and
    generate a recurrence token (safekeep for later recurring use).

*   You need to `POST` a [Verify payment][payment-verify], that will
    automatically generate a recurrence token (for later recurring use).

#### Retrieve Recurrence Token

The recurrence token can then be retrieved by doing a `GET` request against the
`payment`. You need to store this `recurrenceToken` in your system and keep
track of the corresponding `payerReference`.

#### Delete Recurrence Token

You can delete a created recurrence token.
Please see technical reference for details
[here][card-payments-remove-payment-token].

### Recurring purchases

When you have a Recurrence token stored away. You can use the same token in a
subsequent [`recurring payment`][card-payment-recur] `POST`.
This will be a server-to-server affair, as we have both payment instrument
details and recurrence token from the initial payment.

{:.code-view-header}
**Request**

```http
POST /psp/{{ include.api_resource }}/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Recur",
        "intent": "Authorization",
        "recurrenceToken": "{{ page.payment_id }}",
        "currency": "NOK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Recurrence",
        "userAgent": "Mozilla/5.0...",
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
        },
        "payer": {
            "payerReference": "AB1234",
        },
        "metadata": {
            "key1": "value1",
            "key2": 2,
            "key3": 3.1,
            "key4": false
        }
    }
}
```

{:.table .table-striped}
|     Required     | Field                          | Type         | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :----------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `payment`                      | `object`     | The payment object.                                                                                                                                                                                                                                                                  |
| {% icon check %} | `operation`                    | `object`     | `Recur`.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`recurrenceToken`      | `string`     | The created recurrenceToken, if `operation: Verify`, `operation: Recur` or `generateRecurrenceToken: true` was used.                                                                                                                                                                  |
| {% icon check %} | └➔&nbsp;`currency`             | `string`     | The currency of the payment order.                                                                                                                                                                                                                                                    |
| {% icon check %} | └➔&nbsp;`amount`               | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`vatAmount`            | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | └➔&nbsp;`description`          | `string`     | {% include field-description-description.md %}                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`userAgent`           | `string`     | The [`User-Agent` string](https://en.wikipedia.org/wiki/User_agent) of the payer's web browser.                                                                                                                                                                                                                  |
| {% icon check %} | └─➔&nbsp;`language`            | `string`     | {% include field-description-language.md %}                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`urls`                | `string`     | The URI to the `urls` resource where all URIs related to the payment order can be retrieved.                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`callbackUrl`         | `string`     | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][technical-reference-callback] for details.                                                                                                                              |
| {% icon check %} | └➔&nbsp;`payeeInfo`            | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`payeeId`             | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`payeeReference`       | `string(30)` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                          |
|                  | └➔&nbsp;`receiptReference`     | `string(30)` | A unique reference from the merchant system. It is used to supplement `payeeReference` as an additional receipt number.                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`payeeName`           | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`productCategory`     | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                        |
| {% icon check %} | └─➔&nbsp;`orderReference`      | `String(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`subsite`             | `String(40)` | The subsite field can be used to perform [split settlement][settlement-reconciliation-split] on the payment. The subsites must be resolved with Swedbank Pay [reconciliation][settlement-reconciliation] before being used.                                                                      |
|                  | └➔&nbsp;`payer`                | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | └─➔&nbsp;`payerReference`      | `string`     | {% include field-description-payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | └➔&nbsp;`metadata`             | `object`     | {% include field-description-metadata.md %}                                                                                                                                                 |

{% include alert.html type="informative" icon="info" body="
Please note that this `POST`request is made directly on the payment level,
and will not create a payment order." %}

#### Options after a payment

You have the following options after a server-to-server Recur payment `POST`.

##### Autorization (intent)

*   **Authorization (two-phase):** If you want the credit card to reserve the
    amount, you will have to specify that the intent of the purchase is
    Authorization.
    The amount will be reserved but not charged.
    You will later (i.e. when you are ready to ship the purchased products)
    have to make a [Capture][card-payment-capture] or
    [Cancel][card-payment-cancel] request.

##### Capture (intent)

*   **AutoCapture (one-phase)**: If you want the credit card to be charged right
    away, you will have to specify that the intent of the purchase is
    AutoCapture. This is only allowed if the payer purchases digital products.
    The card will be charged and you don't need to do any more financial
    operations to this purchase.​​​​​

##### General

*   **Defining CallbackURL**: When implementing a scenario,
    it is optional to set a [`CallbackURL`][technical-reference-callback]
    in the `POST` request.
    If callbackURL is set Swedbank Pay will send a postback request to this URL
    when the payer has fulfilled the payment.

### Verify

A `Verify` payment lets you post verifications to confirm the validity of
card information, without reserving or charging any amount.
This option is often used to initiate a recurring payment
flow where you do not want to charge the payer right away.

{% include alert.html type="informative" icon="info" body="
Please note that all boolean credit card attributes involving rejection of
certain card types are optional and set on contract level." %}

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Verify",
        "currency": "NOK",
        "description": "Test Verification",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "generatePaymentToken": true,
        "generateRecurrenceToken": false,
        "urls": {
            "hostUrls": [ "https://example.com" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "https://example.com/perform-payment",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.html"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}"
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
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
        "operation": "Verify",
        "state": "Ready",
        "currency": "NOK",
        "amount": 0,
        "description": "Test Verification",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "transactions": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions" },
        "verifications": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/verifications" },
        "urls" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/urls" },
        "payeeInfo" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payeeInfo" },
        "payers": {"id": "/psp/creditcard/payments/{{ page.payment_id }}/payers" },
        "settings": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/settings" }
    },
    "operations": [
        {
            "href": "{{ page.api_url }}/psp/creditcard/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort",
            "method": "PATCH",
            "contentType": "application/json"
        },
        {
            "href": "{{ page.front_end_url }}/creditcard/payments/verification/{{ page.payment_token }}",
            "rel": "redirect-verification",
            "method": "GET",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/creditcard/core/scripts/client/px.creditcard.client.js?token={{ page.payment_token }}",
            "rel": "view-verification",
            "contentType": "application/javascript"
        },
        {
            "method": "POST",
            "href": "{{ page.front_end_url }}/psp/creditcard/confined/payments/{{ page.payment_id }}/verifications",
            "rel": "direct-verification",
            "contentType": "application/json"
        }
    ]
}
```

[payment-verify]: #verify
[card-payment-purchase]: #create-payment
[card-payment-recur]: /payment-instruments/card/features/optional/recur
[card-payment-capture]: #capture-sequence
[card-payment-cancel]: #cancel-sequence
[card-payments-remove-payment-token]: #delete-payment-token
[settlement-reconciliation]: {{ features_url }}/core/settlement-reconciliation
[settlement-reconciliation-split]: {{ features_url }}/core/settlement-reconciliation#split-settlement
[technical-reference-callback]: {{ features_url }}/technical-reference/callback
