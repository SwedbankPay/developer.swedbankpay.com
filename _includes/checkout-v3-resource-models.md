{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

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
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f aborted, 0 %}                | `object`     | The abort object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f abortReason %}             | `string`     | Why the payment was aborted. |

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
    "feeAmount": 0,
    "discountAmount": 0,
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
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
    }
  }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f cancelled, 0 %}                | `object`     | The cancel object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f cancelReason %}             | `string`     | Why the payment was cancelled. |
| {% f instrument %}             | `string`     | The payment instrument used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a `capture` is needed, we recommend using `operations` or the `transactionType` field. |
| {% f number, 2 %}         | `integer`  | {% include fields/number.md %} |
| {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md %} |
| {% f orderReference, 2 %}          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems. |
| {% f transactionType, 2 %}          | `string` | This will either be set to `Authorization` or `Sale`. Can be used to understand if there is a need for doing a capture on this payment order. Swedbank Pay recommends using the different operations to figure out if a capture is needed. |
| {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                            |
| {% f submittedAmount %}                   | `integer`    | This field will display the initial payment order amount, not including any instrument specific discounts or fees. The final payment order amount will be displayed in the `amount` field.                                            |
| {% f feeAmount %}                   | `integer`    | If the payment instrument used had a unique fee, it will be displayed in this field.                                            |
| {% f discountAmount %}                   | `integer`    | If the payment instrument used had a unique discount, it will be displayed in this field.                                                |
| {% f tokens %}                   | `integer`    | A list of tokens connected to the payment.                                                                                                                                                                                                                                                                           |
| {% f type, 2 %}  | `string`   | {% f payment, 0 %}, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| {% f token, 2 %}  | `string`   | The token `guid`. |
| {% f name, 2 %}  | `string`   | The name of the token. In the example, a masked version of a card number. |
| {% f expiryDate, 2 %}  | `string`   | The expiry date of the token. |
| {% f details %}                   | `integer`    | Details connected to the payment. |
| {% f nonPaymentToken, 2 %}         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| {% f externalNonPaymentToken, 2 %} | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token. |
{% endcapture %}
{% include accordion-table.html content=table %}

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

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description     |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f failed, 0 %}                | `object`     | The failed object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f problem %}             | `object`     | The problem object.  |
| {% f type, 2 %}  | `string`   | The type of problem that occurred. |
| {% f title, 2 %}  | `string`   | The title of the problem that occurred. |
| {% f status, 2 %}              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                              |
| {% f detail, 2 %}              | `string`  | A detailed, human readable description of the error.                                                                                                                                                                |
| {% f problems, 2 %}            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                |
| {% f name %}        | `string`  | The name of the field, header, object, entity or likewise that was erroneous.                                                                                                                                                                       |
| {% f description %} | `string`  | The human readable description of what was wrong with the field, header, object, entity or likewise identified by `name`.                                                                                                                           |
{% endcapture %}
{% include accordion-table.html content=table %}

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

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f id %}  | `string`   | {% include fields/id.md resource="paymentorder" %} |
| {% f failedAttempts, 0 %}                | `object`     | The failed attempt object.                     |
| {% f financialTransactionsList %}  | `array`   | The array of failed attempts. |
| {% f created, 2 %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f instrument, 2 %}             | `string`     | Payment instrument used in the failed payment. |
| {% f number, 2 %}         | `integer`  | {% include fields/number.md resource="paymentorder" %} |
| {% f status, 2 %}             | `string`     | The status of the payment attempt. `Failed` or `Aborted`. |
| {% f problem %}             | `object`     | The problem object.  |
| {% f type, 2 %}  | `string`   | The type of problem that occurred. |
| {% f title, 2 %}  | `string`   | The title of the problem that occurred. |
| {% f status, 2 %}              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                              |
| {% f detail, 2 %}              | `string`  | A detailed, human readable description of the error.                                                                                                                                                                |
| {% f problems, 2 %}            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                |
| {% f name %}        | `string`  | The name of the field, header, object, entity or likewise that was erroneous.                                                                                                                                                                       |
| {% f description %} | `string`  | The human readable description of what was wrong with the field, header, object, entity or likewise identified by `name`.                                                                                                                           |
{% endcapture %}
{% include accordion-table.html content=table %}

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

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f financialTransactions, 0 %}                | `object`     | The financial transactions object.                     |
| {% f id %}  | `string`   | {% include fields/id.md resource="paymentorder" %} |
| {% f financialTransactionsList %}  | `array`   | The array of financial transactions. |
| {% f id, 2 %}  | `string`   | The id of the financial transaction. |
| {% f created, 2 %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated, 2 %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f type, 2 %}  | `string`   | The type of transaction. `Capture`, `Authorization`, `Cancellation`, `Reversal`, `Sale`. |
| {% f number, 2 %}         | `integer`  | {% include fields/number.md resource="paymentorder" %} |
| {% f amount, 2 %}                   | `integer`    | {% include fields/amount.md %}                                            |
| {% f vatAmount, 2 %}                | `integer`    | {% include fields/vat-amount.md %}                                          |
| {% f description %}              | `string`     | The description of the payment order.                                                                                                                                                         |
| {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md %} |
| {% f receiptReference %}     | `string(30)` | {% include fields/receipt-reference.md %}                                                                                                                                                               |
| {% f orderItems %}           | `array`      | {% include fields/order-items.md %}                                                                                                                                                                                                                                         |
{% endcapture %}
{% include accordion-table.html content=table %}

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

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f history, 0 %}                | `object`     | The history object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f historyList %}  | `array`   | The array of history objects. |
| {% f created %}        | `string`     | The ISO-8601 date of when the history event was created.                                 |
| {% f name %}              | `string`     | Name of the history event. See list below for information.     |
| {% f instrument %}        | `string`     | The payment instrument used when the event occurred.       |
| {% f number %}              | `integer`   | Payment number associated with the event.                 |
| {% f prefill %}              | `bool`   | Indicates if payment info was prefilled or not.                 |
{% endcapture %}
{% include accordion-table.html content=table %}

{% capture table %}
{:.table .table-striped .mb-5}
| History Event Name         | Description  |
| :----------------------- | :----------- |
| {% f PaymentCreated, 0 %}         | This event will occur as soon as the merchant initiates the payment order.     |
| {% f CheckinInitiated, 0 %}        | Will be set when checkin is started, if checkin is activated for the merchant. The merchant must be configured with ProductPackage=Checkout                  |
| {% f PayerDetailsRetrieved, 0 %}   | Will be set if a consumer profile is found. The merchant must be configured with ProductPackage=Checkout                  |
| {% f PayerCheckedIn, 0 %}      | Will be set when checkin is completed. The merchant must be configured with ProductPackage=Checkout                  |
| {% f PaymentInstrumentSet, 0 %}      | If the `PaymentOrder` is initiated in InstrumentMode, the first occurrence will be set to the value from the merchant´s POST statement. Following values will be set for each time the merchant to a PATCH to change the instrument used for that payment. The instrument set will be in the instrument parameter.                |
| {% f PaymentLoaded, 0 %}       | Will be set the first time the payer loads the payment window. If this event hasn't occurred, the payment window hasn't been loaded.              |
| {% f PaymentInstrumentSelected, 0 %}       | Will occur each time the payer expands an instrument in the payment menu. The instrument selected will be set in the instrument parameter.                 |
| {% f PaymentAttemptStarted, 0 %}      | Will occur when the payer presses the first button in the payment process (either "pay" or "next" if the payment has multiple steps). The instrument parameter will contain the instrument for this attempt. The prefill will be true if the payment page was prefilled with payment information. The transaction number for this payment will be available in the number field.                |
| {% f PaymentAttemptAborted, 0 %}      | Will occur if the payer aborts the payment attempt. Both the number and instrument parameters will be available on this event.                  |
| {% f PaymentAttemptFailed, 0 %}     | Will occur if the payment failed. Both the number and instrument parameters will be available on this event.                  |
| {% f PaymentPaid, 0 %}      | Will occur if the payment succeeds. Both the number and instrument parameters will be available on this event.                 |
| {% f PaymentCaptured, 0 %}      | Will occur when the merchant has captured the full authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the `financialTransaction` field for easy linking.                  |
| {% f PaymentPartialCaptured, 0 %}     | Will occur when the merchant has done a partial capture of authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the `financialTransaction` field for easy linking.               |
| {% f PaymentCancelled, 0 %}     | Will occur when the merchant has cancelled the full authorization amount. Both the number and instrument parameters will be available on this event.                  |
| {% f PaymentPartialCancelled, 0 %}      | Will occur when the merchant has cancelled part of the authorization amount. Both the number and instrument parameters will be available on this event.                 |
| {% f PaymentReversed, 0 %}    | Will occur when the merchant reverses the full authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the `financialTransaction` field for easy linking.                  |
| {% f PaymentPartialReversed, 0 %}    | Will occur when the merchant reverses a part of the authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the `financialTransaction` field for easy linking.                  |
{% endcapture %}
{% include accordion-table.html content=table %}

## Paid

The payment order response with `status` equal to `Paid`, and the `paid`
resource expanded. Please note that the main code example is of a card payment.

We have included `paid` resources of the remaining instruments below the main
code example. Resource examples where details are empty indicate that no details
are available.

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

### Card `Paid` Resource

{:.code-view-header}
**Card Response**

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
    "feeAmount": 0,
    "discountAmount": 0,
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
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "paymentAccountReference": "43f6b6d2cbd30c36627ec02247259",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "49250000******04",
      "expiryDate": "12/2022",
      "issuerAuthorizationApprovalCode": "L00302",
      "acquirerTransactionType": "STANDARD",
      "acquirerStan": "302",
      "acquirerTerminalId": "70101301389",
      "acquirerTransactionTime": "2022-06-15T14:12:55.029Z",
      "transactionInitiator": "CARDHOLDER",
      "bin": "492500"
    }
  }
```

### Apple Pay `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Apple Pay Response**

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
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "cardBrand": "Visa",
        "cardType": "Credit",
        "maskedDPan": "49250000******04",
        "expiryDate": "12/2023",
        "issuerAuthorizationApprovalCode": "L00392",
        "acquirerTransactionType": "WALLET",
        "acquirerStan": "392",
        "acquirerTerminalId": "80100001190",
        "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
        "transactionInitiator": "CARDHOLDER",
        "bin": "492500"
    }
  }
}
```

### Click to Pay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

 {:.code-view-header}
 **Click to Pay Response**

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
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "49250000******04",
      "expiryDate": "12/0023",
      "issuerAuthorizationApprovalCode": "L00392",
      "acquirerTransactionType": "WALLET",
      "acquirerStan": "392",
      "acquirerTerminalId": "80100001190",
      "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
      "transactionInitiator": "CARDHOLDER"
      "bin": "489537"
    }
  }
}
```

### Google Pay&trade; `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

 {:.code-view-header}
 **Google Pay&trade; Response**

 ```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "GooglePay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "49250000******04",
      "expiryDate": "12/0023",
      "issuerAuthorizationApprovalCode": "L00392",
      "acquirerTransactionType": "WALLET",
      "acquirerStan": "392",
      "acquirerTerminalId": "80100001190",
      "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
      "transactionInitiator": "CARDHOLDER"
      "bin": "489537"
    }
  }
}
```

### MobilePay `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**MobilePay Response**

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
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "maskedDPan": "48953700******04",
        "expiryDate": "12/2022",
        "issuerAuthorizationApprovalCode": "018117",
        "acquirerTransactionType": "MOBILEPAY",
        "acquirerStan": "53889",
        "acquirerTerminalId": "42",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z",
        "bin": "489537"
    }
  }
}
```

### Vipps `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Vipps Response**

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
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "maskedDPan": "49250000******04",
        "acquirerTransactionType": "WALLET",
        "acquirerTerminalId": "99488282",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z",
        "transactionInitiator": "CARDHOLDER",
        "bin": "489537"
    }
  }
}
```

### Swish `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Swish Response**

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
    "transactionType": "Sale",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
      "misidn": "+46739000001"
    }
  }
}
```

### Invoice `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Invoice Response**

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
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {}
  }
}
```

### Installment Account `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Installment Account Response**

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
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {}
  }
}
```

### Trustly `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Trustly Response**

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
    "transactionType": "Sale",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
      "trustlyOrderId": 123456789
    }
  }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f paid, 0 %}                | `object`     | The paid object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f instrument %}             | `string`     | The payment instrument used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a `capture` is needed, we recommend using `operations` or the `transactionType` field. |
| {% f number, 2 %}         | `integer` | {% include fields/number.md resource="paymentorder" %} |
| {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md %} |
| {% f orderReference, 2 %}          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems. |
| {% f transactionType, 2 %}          | `string` | This will either be set to `Authorization` or `Sale`. Can be used to understand if there is a need for doing a `capture` on this payment order. Swedbank Pay recommends using the different `operations` to figure out if a `capture` is needed. |
| {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                            |
| {% f submittedAmount %}                   | `integer`    | This field will display the initial payment order amount, not including any instrument specific discounts or fees. The final payment order amount will be displayed in the `amount` field.                                            |
| {% f feeAmount %}                   | `integer`    | If the payment instrument used had a unique fee, it will be displayed in this field.                                            |
| {% f discountAmount %}                   | `integer`    | If the payment instrument used had a unique discount, it will be displayed in this field.                                                |
| {% f tokens %}                   | `integer`    | A list of tokens connected to the payment.                                    |
| {% f type, 2 %}  | `string`   | {% f payment, 0 %}, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| {% f token, 2 %}  | `string`   | The token `guid`. |
| {% f name, 2 %}  | `string`   | The name of the token. In the example, a masked version of a card number. |
| {% f expiryDate, 2 %}  | `string`   | The expiry date of the token. |
| {% f details %}                   | `integer`    | Details connected to the payment. |
| {% f nonPaymentToken, 2 %}         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| {% f externalNonPaymentToken, 2 %} | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions will be populated with the `paymentAccountReference`. |
| {% f paymentAccountReference, 2 %} | `string`     | The result of an external tokenization. The value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, the `paymentAccountReference` will also populate the externalNonPaymentToken field. |
| {% f cardType, 2 %}                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| {% f maskedPan, 2 %}               | `string`  | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| {% f maskedDPan, 2 %}               | `string`  | A masked version of a network token representing the card. It will only appear if the chosen payment instrument is tokenized and the card used is tokenized by Visa or MasterCard.                                                                                                                                                                                                                                                                  |
| {% f expiryDate, 2 %}              | `string`  | The month and year of when the card expires.                                                                                                                                                                                                                                                         |
| {% f issuerAuthorizationApprovalCode, 2 %} | `string`     | Payment reference code provided by the issuer.                                                                                                                                                                                                                                |
| {% f acquirerTransactionType, 2 %} | `string`     | `3DSECURE` or `STANDARD`. Indicates the transaction type of the acquirer.                                                                                                                                                                                                                                 |
| {% f acquirerStan, 2 %}            | `string`     | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                                                                                                         |
| {% f acquirerTerminalId, 2 %}      | `string`     | The ID of the acquirer terminal.                                                                                                                                                                                                                                                                     |
| {% f acquirerTransactionTime, 2 %} | `string`     | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                                                                                                              |
| {% f transactionInitatior, 2 %} | `string`     | The party which initiated the transaction. `MERCHANT` or `CARDHOLDER`.                                                                                                                                                                                                                                              |
| {% f bin, 2 %} | `string`     | The first six digits of the maskedPan.                                                                                                                                                                                                                                              |
| {% f msisdn, 2 %} | `string`     | The msisdn used in the purchase. Only available when paid with Swish.                                                                                                                                                                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

## Payer

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "payer": {
    "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers",
    "reference": "reference to payer"
    "name": "Azra Oliveira",
    "email": "azra@payex.com",
    "msisdn": "+46722345678",  {% unless documentation_section contains "checkout-v3/payments-only" %}
    "gender": "male",
    "birthYear": "1980", {% endunless %}
    "hashedFields": {
      "emailHash": "968e23eda8818f8647d15775c939b3bc32ba592e",
      "msisdnHash": "a23ec9d5b9def87cae2769cfffb0b8a0487a5afd"  {% unless documentation_section contains "checkout-v3/payments-only" %},
      "socialSecurityNumberHash": "50288c11d79c1ba0671e6426ffddbb4954347ba4" {% endunless %}
    },
    "shippingAddress": {
      "addressee": "firstName + lastName",
      "coAddress": "coAddress",
      "streetAddress": "streetAddress",
      "zipCode": "zipCode",
      "city": "city",
      "countryCode": "countryCode"
    },
    "device": {
      "detectionAccuracy": 48,
      "ipAddress": "127.0.0.1",
      "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36 Edg/97.0.1072.62",
      "deviceType": "Desktop",
      "hardwareFamily": "Emulator",
      "hardwareName": "Desktop|Emulator",
      "hardwareVendor": "Unknown",
      "platformName": "Windows",
      "platformVendor": "Microsoft",
      "platformVersion": "10.0",
      "browserName": "Edge (Chromium) for Windows",
      "browserVendor": "Microsoft",
      "browserVersion": "95.0",
      "browserJavaEnabled": false
    }
  }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f payer, 0 %}                | `object`     | The payer object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f reference %}  | `string`   | The reference to the payer. In checkout, this will be the `consumerReference`. |
| {% f name %}        | `string`     | The name of the payer. |
| {% f email %}              | `string`     | The email address of the payer.     |
| {% f msisdn %}        | `string`     | The msisdn of the payer.       | {% unless documentation_section contains "checkout-v3/payments-only" %}
| {% f gender %}              | `string`   | The gender of the payer.                 |
| {% f birthYear %}              | `string`   | The birth year of the payer. | {% endunless %}
| {% f hashedFields %}        | `object`     | The `hashedFields` object, containing hashed versions of the payer's email, msisdn and if present, Social Security Number. |
| {% f emailHash %}              | `string`   | A hashed version of the payer's email. |
| {% f msisdnHash %}              | `string`   | A hashed version of the payer's email. |  {% unless documentation_section contains "checkout-v3/payments-only" %}
| {% f socialSecurityNumberHash %}              | `string`   | A hashed version of the payer's social security number. | {% endunless %}
| {% f shippingAddress %}            | `object` | The shipping address object related to the `payer`. |
| {% f addressee, 2 %}                   | `string` | First and last name of the addressee – the receiver of the shipped goods. |
| {% f coAddress, 2 %}                  | `string` | Payer's c/o address, if applicable. |
| {% f streetAddress, 2 %}              | `string` | Payer's street address. Maximum 50 characters long. |
| {% f coAddress, 2 %}                  | `string` | Payer's c/o address, if applicable. |
| {% f zipCode, 2 %}                    | `string` | Payer's zip code. |
| {% f city, 2 %}                       | `string` | Payer's city of residence. |
| {% f countryCode, 2 %}                | `string` | Country code for country of residence, e.g. `SE`, `NO`, or `FI`. |
| {% f device, 2 %}                       | `object` | The device detection object. |
| {% f detectionAccuracy, 2 %}            | `string` | Indicates the accuracy of the device detection on a scale from 0 to 100. |
| {% f ipAddress, 2 %}                    | `string` | The IP address of the payer's device. |
| {% f userAgent, 2 %}                    | `string` | {% include fields/user-agent.md %} |
| {% f deviceType, 2 %}                   | `string` | The type of device used by the payer. |
| {% f hardwareFamily, 2 %}               | `string` | The type of hardware used by the payer. |
| {% f hardwareName, 2 %}                 | `string` | The name of the payer's hardware. |
| {% f hardwareVendor, 2 %}               | `string` | The vendor of the payer's hardware. |
| {% f platformName, 2 %}                 | `string` | Name of the operating system used on the payer's device.  |
| {% f platformVendor, 2 %}               | `string` | Vendor of the operating system used on the payer's device. |
| {% f platformVersion, 2 %}              | `string` | Version of the operating system used on the payer's device. |
| {% f browserName, 2 %}                  | `string` | Name of the browser used on the payer's device. |
| {% f browserVendor, 2 %}                | `string` | Vendor of the browser used on the payer's device. |
| {% f browserVersion, 2 %}               | `string` | Version of the browser used on the payer's device. |
| {% f browserJavaEnabled, 2 %}           | `bool` | Indicates if the browser has Java enabled. Either `true` or `false`. |
{% endcapture %}
{% include accordion-table.html content=table %}
