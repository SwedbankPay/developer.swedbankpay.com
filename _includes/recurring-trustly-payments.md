## Trustly recurring

{% include jumbotron.html body="A service where consumer interaction is not possible, where the payment is pulled from the consumer’s bank account by sending a request to Trustly. " %}

{% include alert.html type="warning" icon="warning" body="Please note that this feature is only available through Payment Order." %}

### Prerequisites

Prior to making any server-to-server requests, you need to make sure the `directDebitEnabled` setting in your Trustly contract is set to `true`. Then you need to supply the payment instrument details and a payment token to Swedbank Pay by initial purchase or [select account verification][payment-verify]. Note that the `email` field must be set, as this is a required parameter.

There are two ways to initiate recurring payments procedures, depending on if you want to make an initial charge or not:

*   Initiate a recurring payment flow and **charge the bank account**. This is done by creating a "Purchase Payment" and generating a recurrence token.

*   Initiate a recurring payment flow **without charging the bank account**. This is done by creating a "Verify Payment" and generating a recurrence token.

#### Generate RecurrenceToken

*   When posting a `Purchase` payment, you need to make sure that the field `generateRecurrenceToken` is set to `true`.

{:.code-view-header}
**Field**

```json
"generateRecurrenceToken": true
```

*   When posting a `Verify` payment, you need to make sure that the the field `generateRecurrenceToken` is set to `true`.

{:.code-view-header}
**Field**

```json
"generateRecurrenceToken": true
```

#### Creating a Payment

*   You need to `POST` a [Purchase payment][trustly-payment-purchase] / and generate a recurrence token (for later recurring use).

*   You need to `POST` a [Verify payment][payment-verify] / and generate a recurrence token (for later recurring use).

#### Delete Recurrence Token

You can delete a created recurrence token. Please see technical reference for
details [here][trustly-remove-payment-token].

### Recurring purchases

When you have a Recurrence token, you can use the same token in a subsequent [`recurring payment`][trustly-payment-recur] `POST`. This will be a server-to-server affair, as we have both payment instrument details and recurrence token from the initial payment.

{:.code-view-header}
**Request**

```http
POST /psp/trustly/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Recur",
        "intent": "Sale",
        "recurrenceToken": "{{ page.payment_id }}",
        "currency": "SEK",
        "prices": [
            {
                "type": "Trustly",
                "amount": 4201,
                "vatAmount": 0
            }
        ],
        "description": "Test Recurrence",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "callbackUrl": "https://example.com/payment-callback"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12345"
        }
    },
    "trustly": {
        "email": "test@test.no",
        "bank": "Swedbank",
        "accountId": "1980908426"
    }
}
```

{:.table .table-striped}
|     Required     | Field                          | Type         | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :----------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `payment`                      | `object`     | The payment object.                                                                                                                                                                                                                                                                  |
| {% icon check %} | `operation`                    | `object`     | `Recur`.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`recurrenceToken`      | `string`     | The created recurrenceToken, if `operation: Verify` or `operation: Recur`, and `generateRecurrenceToken: true` was used.                                                                                                                                                                  |
| {% icon check %} | └➔&nbsp;`currency`             | `string`     | The currency of the payment order.                                                                                                                                                                                                                                                    |
| {% icon check %} | └➔&nbsp;`prices`               | `object`    | {% include prices.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`type`            | `string`    | The type of the price object.                                                                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`amount`            | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`vatAmount`            | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | └➔&nbsp;`description`          | `string`     | {% include field-description-description.md %}                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`userAgent`           | `string`     | The [`User-Agent` string](https://en.wikipedia.org/wiki/User_agent) of the payer's web browser.                                                                                                                                                                                                                  |
| {% icon check %} | └─➔&nbsp;`language`            | `string`     | {% include field-description-language.md %}                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`urls`                | `string`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`callbackUrl`         | `string`     | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][technical-reference-callback] for details.                                                                                                                              |
| {% icon check %} | └➔&nbsp;`payeeInfo`            | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`payeeId`             | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`payeeReference`       | `string(30)` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`payeeName`           | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`productCategory`     | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                        |
| {% icon check %} | └─➔&nbsp;`orderReference`      | `String(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`trustly`             | `object`     | An object containing trustly specific parameters.                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`email`             | `string`     | The email address of the end user. This is required when using Direct Debit.                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`bank`             | `string`     | The bank used for the payment. This is mostly used for support purposes.                                                                                                                                                |
| {% icon check %} | └─➔&nbsp;`accountId`             | `string`     | The accountId recieved from an account notification which shall be charged                                                                                                                                               |

{% include alert.html type="informative" icon="info" body="
Please note that this `POST`request is made directly on the payment level,
and will not create a payment order." %}

#### Verify

A `Verify` payment lets you post verifications to confirm the validity of one of your bank accounts, without reserving or charging any amount. This option is often used to initiate a recurring payment flow where you do not want to charge the payer right away.

{:.code-view-header}
**Request**

```http
POST /psp/trustly/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "firstname": "Bruce",
        "lastname": "Wayne",
        "redirectFromTrustlyUrl": "http://example.com/redirectfromtrustlyurl"
    }
}
```

<!--lint disable final-definition -->

[payment-verify]: #verify
[trustly-payment-purchase]: #create-payment
[trustly-remove-payment-token]: /payment-menu/features/technical-reference/delete-token
