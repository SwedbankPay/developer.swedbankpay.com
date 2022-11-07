## Aborted

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/aborted HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "aborted": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/aborted",
    "abortReason": "Payment aborted by payer"
  }
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| `paymentorder`           | `object`     | The payment order object.                      |
| `aborted`                | `object`     | The abort object.                     |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}  |
| └➔&nbsp;`abortReason`             | `string`     | Why the payment was aborted. |

## Cancelled

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/cancelled HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "cancelled": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/paid",
    "cancelReason": "<should be the description from the merchant when doing cancel on the authorisation payment>",
    "instrument": "Creditcard",
    "number": 1234567890,
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount: 0,
    "discountAmount": 0
    "tokens": [
      {
        "type": "payment",
        "token": "12345678-1234-1234-1234-1234567890AB",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "recurrence",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      }
    ],
    "details": {
      "nonPaymentToken" : "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken" : "1234567890",
    }
  }
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| `paymentorder`           | `object`     | The payment order object.                      |
| `cancelled`                | `object`     | The cancel object.                     |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}  |
| └➔&nbsp;`cancelReason`             | `string`     | Why the payment was cancelled. |
| └➔&nbsp;`instrument`             | `string`     | Payment instrument used in the cancelled payment. |
| └─➔&nbsp;`number`         | `string`  | The transaction number, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where id should be used instead. |
| └─➔&nbsp;`payeeReference`          | `string` | {% include field-description-payee-reference.md %} |
| └─➔&nbsp;`orderReference`          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems. |
| └─➔&nbsp;`transactionType`          | `string` | This will either be set to `Authorization` or `Sale`. Can be used to understand if there is a need for doing a capture on this payment order. Swedbank Pay recommends using the different operations to figure out if a capture is needed. |
| └➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                                            |
| └➔&nbsp;`submittedAmount`                   | `integer`    | This field will display the initial payment order amount, not including any instrument specific discounts or fees. The final payment order amount will be displayed in the `amount` field.                                            |
| └➔&nbsp;`feeAmount`                   | `integer`    | If the payment instrument used had a unique fee, it will be displayed in this field.                                            |
| └➔&nbsp;`discountAmount`                   | `integer`    | If the payment instrument used had a unique discount, it will be displayed in this field.                                                |
| └➔&nbsp;`tokens`                   | `integer`    | A list of tokens connected to the payment.                                                                                                                                                                                                                                                                           |
| └─➔&nbsp;`type`  | `string`   | `payment`, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| └─➔&nbsp;`token`  | `string`   | The token `guid`. |
| └─➔&nbsp;`name`  | `string`   | The name of the token. In the example, a masked version of a card number. |
| └─➔&nbsp;`expiryDate`  | `string`   | The expiry date of the token. |
| └➔&nbsp;`details`                   | `integer`    | Details connected to the payment. |
| └─➔&nbsp;`nonPaymentToken`         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| └─➔&nbsp;`externalNonPaymentToken` | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token. |

## Failed

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/failed HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "failed": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/failed",
    "problem": {
      "type": "https://api.payex.com/psp/errordetail/creditcard/acquirererror",
      "title": "Operation failed",
      "status": 403,
      "detail": "Unable to complete Authorization transaction, look at problem node!",
      "problems": [
        {
          "name": "ExternalResponse",
          "description": "REJECTED_BY_ACQUIRER-unknown error, response-code: 51"
        }
      ]
    }
  }
}
```

{:.table .table-striped}
| Field                    | Type         | Description     |
| `paymentorder`           | `object`     | The payment order object.                      |
| `failed`                | `object`     | The failed object.                     |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}  |
| └➔&nbsp;`problem`             | `object`     | The problem object.  |
| └─➔&nbsp;`type`  | `string`   | The type of problem that occurred. |
| └─➔&nbsp;`title`  | `string`   | The title of the problem that occurred. |
| └─➔&nbsp;`status`              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                              |
| └─➔&nbsp;`detail`              | `string`  | A detailed, human readable description of the error.                                                                                                                                                                |
| └─➔&nbsp;`problems`            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                |
| └➔&nbsp;`name`        | `string`  | The name of the field, header, object, entity or likewise that was erroneous.                                                                                                                                                                       |
| └➔&nbsp;`description` | `string`  | The human readable description of what was wrong with the field, header, object, entity or likewise identified by `name`.                                                                                                                           |

## FailedAttempts

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/failedattempts HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "failedAttempts": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/failedattempts"
    "failedAttemptList": [
      {
        "created": "2020-03-03T07:21:01.1893466Z",
        "instrument": "CreditCard",
        "number": 123456,
        "status": "Aborted",
        "problem": {
          "type": "https://api.payex.com/psp/errordetail/creditcard/3dsecureusercanceled",
          "title": "Operation failed",
          "status": 403,
          "detail": "Unable to complete VerifyAuthentication transaction, look at problem node!",
          "problems": [
            {
              "name": "ExternalResponse",
              "description": "UserCancelled-CANCELED"
            }
          ]
        }
      },
      {
        "created": "2020-03-03T07:22:21.1893466Z",
        "instrument": "CreditCard",
        "number": 123457,
        "status": "Failed",
        "problem": {
          "type": "https://api.payex.com/psp/errordetail/creditcard/3dsecureacquirergatewayerror",
          "title": "Operation failed",
          "status": 502,
          "detail": "Unable to complete VerifyAuthentication transaction, look at problem node!",
          "problems": [
            {
              "name": "ExternalResponse",
              "description": "ARCOT_MERCHANT_PLUGIN_ERROR-merchant plugin error [98]: This is a triggered error message."
            }
          ]
        }
      }
    ]
  }
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| `paymentorder`           | `object`     | The payment order object.                      |
| └➔&nbsp;`id`  | `string`   | {% include field-description-id.md resource="paymentorder" %} |
| `failedAttempts`                | `object`     | The failed attempt object.                     |
| └➔&nbsp;`financialTransactionsList`  | `array`   | The array of failed attempts. |
| └─➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| └─➔&nbsp;`instrument`             | `string`     | Payment instrument used in the failed payment. |
| └─➔&nbsp;`number`         | `string`  | The transaction number, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where id should be used instead. |
| └─➔&nbsp;`status`             | `string`     | The status of the payment attempt. `Failed` or `Aborted`. |
| └➔&nbsp;`problem`             | `object`     | The problem object.  |
| └─➔&nbsp;`type`  | `string`   | The type of problem that occurred. |
| └─➔&nbsp;`title`  | `string`   | The title of the problem that occurred. |
| └─➔&nbsp;`status`              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                              |
| └─➔&nbsp;`detail`              | `string`  | A detailed, human readable description of the error.                                                                                                                                                                |
| └─➔&nbsp;`problems`            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                |
| └➔&nbsp;`name`        | `string`  | The name of the field, header, object, entity or likewise that was erroneous.                                                                                                                                                                       |
| └➔&nbsp;`description` | `string`  | The human readable description of what was wrong with the field, header, object, entity or likewise identified by `name`.                                                                                                                           |

## FinancialTransactions

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/financialtransactions HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "financialTransactions" {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions",
    "financialTransactionList": [
      {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/7e6cdfc3-1276-44e9-9992-7cf4419750e1",
        "created": "2020-03-04T01:01:01.01Z",
        "updated": "2020-03-04T01:01:01.03Z",
        "type": "Capture",
        "number": 123459,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction1",
        "payeeReference": "AH123456",
        "receiptReference": "OL1234"
        "orderItems": {
          "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/7e6cdfc3-1276-44e9-9992-7cf4419750e1/orderitems"
        }
      },
      {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/<transactionId>",
        "created": "2020-03-05T01:01:01.01Z",
        "updated": "2020-03-05T01:01:01.03Z",
        "type": "Capture",
        "number": 123460,
        "amount": 500,
        "vatAmount": 125,
        "description": "Test transaction2",
        "payeeReference": "AH234567",
        "receiptReference": "OL5678"
        "orderItems": {
          "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/7e6cdfc3-1276-44e9-9992-7cf4419750e1/orderitems"
        }
      },
      {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/<transactionId>",
        "created": "2020-04-02T01:01:01.01Z",
        "updated": "2020-04-02T01:01:01.03Z",
        "type": "Reversal",
        "number": 123461,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction3",
        "payeeReference": "AH345678",
        "receiptReference": "OL1357"
        "orderItems": {
          "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/7e6cdfc3-1276-44e9-9992-7cf4419750e1/orderitems"
        }
      }
    ]
  }
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| `paymentorder`           | `object`     | The payment order object.                      |
| `financialTransactions`                | `object`     | The financial transactions object.                     |
| └➔&nbsp;`id`  | `string`   | {% include field-description-id.md resource="paymentorder" %} |
| └➔&nbsp;`financialTransactionsList`  | `array`   | The array of financial transactions. |
| └─➔&nbsp;`id`  | `string`   | The id of the financial transaction. |
| └─➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| └─➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| └─➔&nbsp;`type`  | `string`   | The type of transaction. `Capture`, `Authorization`, `Cancellation`, `Reversal`, `Sale`. |
| └─➔&nbsp;`number`         | `string`  | The transaction number, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where id should be used instead. |
| └─➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                                            |
| └─➔&nbsp;`vatAmount`                | `integer`    | {% include field-description-vatamount.md %}                                          |
| └➔&nbsp;`description`              | `string`     | The description of the payment order.                                                                                                                                                         |
| └─➔&nbsp;`payeeReference`          | `string` | {% include field-description-payee-reference.md %} |
| └➔&nbsp;`receiptReference`     | `string(30)` | A unique reference from the merchant system. It is used to supplement `payeeReference` as an additional receipt number.                                                                                                                                                               |
| └➔&nbsp;`orderItems`           | `array`      | {% include field-description-orderitems.md %}                                                                                                                                                                                                                                         |

## History

We advise you to not build logic around the content of these fields. They are
mainly for information purposes, and might be subject to name changes. If these
should occur, updates will be available in the list below.

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/history HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "history": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/history",
    "historyList": [
      {
        "created": "2020-03-04T01:00:00.00Z",
        "name": "PaymentCreated",
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-04T01:01:00.00Z",
        "name": "PaymentLoaded",
        "initiatedBy" "System"
      },
      {
        "created": "2020-03-04T01:00:15.00Z",
        "name": "CheckinInitiated",
        "initiatedBy" "System"
      },
      {
        "created": "2020-03-04T01:00:16.00Z",
        "name": "PayerDetailsRetrieved",
        "initiatedBy" "System"
      },
      {
        "created": "2020-03-04T01:00:20.00Z",
        "name": "PayerCheckedIn",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T01:01:01.01Z",
        "name": "PaymentInstrumentSelected",
        "instrument": "CreditCard",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T01:03:01.01Z",
        "name": "PaymentAttemptStarted",
        "instrument": "CreditCard",
        "number": 123456,
        "prefill": true,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T01:03:01.01Z",
        "name": "PaymentAttemptAborted",
        "number": 123456,
        "instrument": "CreditCard",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentInstrumentSelected",
        "instrument": "Vipps",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T03:01:01.01Z",
        "name": "PaymentInstrumentSelected",
        "instrument": "CreditCard",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentAttemptStarted",
        "instrument": "CreditCard",
        "number": 123457,
        "prefill": true,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentAttemptFailed",
        "instrument": "CreditCard",
        "number": 123457,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentAttemptStarted",
        "instrument": "CreditCard",
        "number": 123458,
        "prefill": true,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentPaid",
        "instrument": "CreditCard"
        "number": 123458,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-05T02:01:01.01Z",
        "name": "PaymentPartialCaptured",
        "instrument": "CreditCard"
        "number": 123459,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-06T02:01:01.01Z",
        "name": "PaymentPartialCaptured",
        "instrument": "CreditCard"
        "number": 123460,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-07T02:01:01.01Z",
        "name": "PaymentPartialReversed",
        "instrument": "CreditCard"
        "number": 123461,
        "initiatedBy" "Merchant"
      }
    ]
  }
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| `paymentorder`           | `object`     | The payment order object.                      |
| `history`                | `object`     | The history object.                     |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}  |
| └➔&nbsp;`historyList`  | `array`   | The array of history objects. |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the history event was created.                                 |
| └➔&nbsp;`name`              | `string`     | Name of the history event. See list below for information.     |
| └➔&nbsp;`instrument`        | `string`     | The payment instrument used when the event occurred.       |
| └➔&nbsp;`number`              | `string`   | Payment number associated with the event.                 |
| └➔&nbsp;`prefill`              | `bool`   | Indicates if payment info was prefilled or not.                 |
| └➔&nbsp;`initiatedBy`        | `string`     | `Consumer`, `Merchant` or `System`. The party that initiated the event.       |

{:.table .table-striped}
| History Event Name         | Description  |
| :----------------------- | :----------- |
| `PaymentCreated`         | This event will occur as soon as the merchant initiates the payment order.     |
| `CheckinInitiated`        | Will be set when checkin is started, if checkin is activated for the merchant. The merchant must be configured with ProductPackage=Checkout                  |
| `PayerDetailsRetrieved`   | Will be set if a consumer profile is found. The merchant must be configured with ProductPackage=Checkout                  |
| `PayerCheckedIn`      | Will be set when checkin is completed. The merchant must be configured with ProductPackage=Checkout                  |
| `PaymentInstrumentSet`      | If the `PaymentOrder` is initiated in InstrumentMode, the first occurrence will be set to the value from the merchant´s POST statement. Following values will be set for each time the merchant to a PATCH to change the instrument used for that payment. The instrument set will be in the instrument parameter.                |
| `PaymentLoaded`       | Will be set the first time the payer loads the payment window. If this event hasn't occurred, the payment window hasn't been loaded.              |
| `PaymentInstrumentSelected`       | Will occur each time the payer expands an instrument in the payment menu. The instrument selected will be set in the instrument parameter.                 |
| `PaymentAttemptStarted`      | Will occur when the payer presses the first button in the payment process (either "pay" or "next" if the payment has multiple steps). The instrument parameter will contain the instrument for this attempt. The prefill will be true if the payment page was prefilled with payment information. The transaction number for this payment will be available in the number field.                |
| `PaymentAttemptAborted`      | Will occur if the payer aborts the payment attempt. Both the number and instrument parameters will be available on this event.                  |
| `PaymentAttemptFailed`     | Will occur if the payment failed. Both the number and instrument parameters will be available on this event.                  |
| `PaymentPaid`      | Will occur if the payment succeeds. Both the number and instrument parameters will be available on this event.                 |
| `PaymentCaptured`      | Will occur when the merchant has captured the full authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the `financialTransaction` node for easy linking.                  |
| `PaymentPartialCaptured`     | Will occur when the merchant has done a partial capture of authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the `financialTransaction` node for easy linking.               |
| `PaymentCancelled`     | Will occur when the merchant has cancelled the full authorization amount. Both the number and instrument parameters will be available on this event.                  |
| `PaymentPartialCancelled`      | Will occur when the merchant has cancelled part of the authorization amount. Both the number and instrument parameters will be available on this event.                 |
| `PaymentReversed`    | Will occur when the merchant reverses the full authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the `financialTransaction` node for easy linking.                  |
| `PaymentPartialReversed`    | Will occur when the merchant reverses a part of the authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the `financialTransaction` node for easy linking.                  |

## Paid

The payment order response with status `paid`, and the `paid` resource expanded.
Please note that the main code example is of a card payment. We have included
`paid` resources of the remaining instruments below the main code example.
Resource examples where details are empty indicate that no details are
available.

The wallets Apple Pay and Vipps do not return `maskedPan`. Please note that
while MobilePay does return this field, the value present is actually a
`networkToken`, which **represents** the PAN, but is not a PAN in itself.

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/paid",
    "instrument": "Creditcard",
    "number": 1234567890,
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount: 0,
    "discountAmount": 0
    "tokens": [
      {
        "type": "payment",
        "token": "12345678-1234-1234-1234-1234567890AB",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "recurrence",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "unscheduled",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "transactionsOnFile",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      }
    ],
    "details": {
      "nonPaymentToken" : "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken" : "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "expiryDate": "12/2022",
      "issuerAuthorizationApprovalCode": "L00302",
      "acquirerTransactionType": "STANDARD",
      "acquirerStan": "302",
      "acquirerTerminalId": "70101301389",
      "acquirerTransactionTime": "2022-06-15T14:12:55.029Z",
      "transactionInitiator": "CARDHOLDER"
    }
  }
```

### Apple Pay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Apple Pay**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "ApplePay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "details": {
        "cardBrand": "Visa",
        "cardType": "Credit",
        "expiryDate": "12/0023",
        "issuerAuthorizationApprovalCode": "L00392",
        "acquirerTransactionType": "WALLET",
        "acquirerStan": "392",
        "acquirerTerminalId": "80100001190",
        "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
        "transactionInitiator": "CARDHOLDER"
    }
  }
}
```

### Click to Pay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Clikck to Pay**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "ClickToPay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "details": {
        "cardBrand": "Visa",
        "cardType": "Credit",
        "expiryDate": "12/0023",
        "issuerAuthorizationApprovalCode": "L00392",
        "acquirerTransactionType": "WALLET",
        "acquirerStan": "392",
        "acquirerTerminalId": "80100001190",
        "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
        "transactionInitiator": "CARDHOLDER"
    }
  }
}
```

### MobilePay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**MobilePay**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/efdcbf77-9a62-426b-a3b1-08da8caf7918/paid",
    "instrument": "MobilePay",
    "number": 75100106637,
    "payeeReference": "1662364327",
    "amount": 1500,
    "details": {
        "cardBrand": "Visa",
        "maskedPan": "489537******1424",
        "expiryDate": "12/2022",
        "issuerAuthorizationApprovalCode": "018117",
        "acquirerTransactionType": "MOBILEPAY",
        "acquirerStan": "53889",
        "acquirerTerminalId": "42",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z"
    }
  }
}
```

### Vipps `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Vipps**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/a463b145-3278-4aa0-c4db-08da8f1813a2/paid",
    "instrument": "Vipps",
    "number": 99463794,
    "payeeReference": "1662366424",
    "amount": 1500,
    "details": {}
  }
}
```

### Swish `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Swish**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/b0410cd0-61df-4548-a3ad-08da8caf7918/paid",
    "instrument": "Swish",
    "number": 74100413405,
    "payeeReference": "1662360831",
    "amount": 1500,
    "details": {}
  }
}
```

### Invoice `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Invoice**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"paid": {
    "id": "/psp/paymentorders/05a356df-05e2-49e6-8858-08da8cb4d651/paid",
    "instrument": "Invoice",
    "number": 71100775379,
    "payeeReference": "1662360980",
    "amount": 2000,
    "details": {}
  }
}
```

### Credit Account `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**CreditAccount**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"paid": {
    "id": "/psp/paymentorders/39eef759-a619-4c91-885b-08da8cb4d651/paid",
    "instrument": "CreditAccount",
    "number": 77100038000,
    "payeeReference": "1662361777",
    "amount": 1500,
    "details": {}
  }
}
```

### Trustly `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Trustly**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"paid": {
    "id": "/psp/paymentorders/bf660901-93d0-4245-4e6b-08da8f165366/paid",
    "instrument": "Trustly",
    "number": 79100113652,
    "payeeReference": "1662373401",
    "orderReference": "orderReference",
    "amount": 90361,
    "details": {}
  }
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| `paymentorder`           | `object`     | The payment order object.                      |
| `paid`                | `object`     | The paid object.                     |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}  |
| └➔&nbsp;`instrument`             | `string`     | Payment instrument used in the cancelled payment. |
| └─➔&nbsp;`number`         | `string`  | The transaction number , useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where id should be used instead. |
| └─➔&nbsp;`payeeReference`          | `string` | {% include field-description-payee-reference.md %} |
| └─➔&nbsp;`orderReference`          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems. |
| └─➔&nbsp;`transactionType`          | `string` | This will either be set to `Authorization` or `Sale`. Can be used to understand if there is a need for doing a capture on this payment order. Swedbank Pay recommends using the different operations to figure out if a capture is needed. |
| └➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                                            |
| └➔&nbsp;`submittedAmount`                   | `integer`    | This field will display the initial payment order amount, not including any instrument specific discounts or fees. The final payment order amount will be displayed in the `amount` field.                                            |
| └➔&nbsp;`feeAmount`                   | `integer`    | If the payment instrument used had a unique fee, it will be displayed in this field.                                            |
| └➔&nbsp;`discountAmount`                   | `integer`    | If the payment instrument used had a unique discount, it will be displayed in this field.                                                |
| └➔&nbsp;`tokens`                   | `integer`    | A list of tokens connected to the payment.                                    |
| └─➔&nbsp;`type`  | `string`   | `payment`, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| └─➔&nbsp;`token`  | `string`   | The token `guid`. |
| └─➔&nbsp;`name`  | `string`   | The name of the token. In the example, a masked version of a card number. |
| └─➔&nbsp;`expiryDate`  | `string`   | The expiry date of the token. |
| └➔&nbsp;`details`                   | `integer`    | Details connected to the payment. |
| └─➔&nbsp;`nonPaymentToken`         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| └─➔&nbsp;`externalNonPaymentToken` | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token. |
| └➔&nbsp;`cardType`                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| └➔&nbsp;`maskedPan`               | `string`  | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| └➔&nbsp;`expiryDate`              | `string`  | The month and year of when the card expires.                                                                                                                                                                                                                                                         |
| └─➔&nbsp;`issuerAuthorizationApprovalCode` | `string`     | Payment reference code provided by the issuer.                                                                                                                                                                                                                                |
| └─➔&nbsp;`acquirerTransactionType` | `string`     | `3DSECURE` or `STANDARD`. Indicates the transaction type of the acquirer.                                                                                                                                                                                                                                 |
| └─➔&nbsp;`acquirerStan`            | `string`     | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                                                                                                         |
| └─➔&nbsp;`acquirerTerminalId`      | `string`     | The ID of the acquirer terminal.                                                                                                                                                                                                                                                                     |
| └─➔&nbsp;`acquirerTransactionTime` | `string`     | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                                                                                                              |
| └─➔&nbsp;`transactionInitatior` | `string`     | The party which initiated the transaction. `MERCHANT` or `CARDHOLDER`.                                                                                                                                                                                                                                              |
