{% assign documentation_section = include.documentation_section %}
{% assign api_resource = include.api_resource %}

### Operation `paid-payment`

The `paid-payment` operation confirms that the transaction has been successful
and that the payment is completed. 

A `paid-payment` operation looks like the following:

```json
{
   "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/paid",
   "rel": "paid-payment",
   "method": "GET",
   "contentType": "application/json"
}
```

To inspect the paid payment, you need to perform an HTTP `GET` request
towards the operation's `href` field. An example of how the request and
response look like is given below.

{:.code-view-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% if documentation_section == "card" %}

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
  "paid": {
    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/paid",
    "number": 1234567890,
    "transaction": {
      "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ site.transaction_id }}",
      "number" : 1234567891
    },
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "amount": 1500,
    "tokens": [
      {
        "type": "payment",
        "token": "{{ page.payment_token }}",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "recurrence",
        "token": "{{ page.payment_token }}",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "transactionsOnFile",
        "token": "{{ page.payment_token }}",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      }
    ],
    "details": {
      "cardBrand": "Visa",
      "MaskedPan": "4925xxxxxx000004",
      "cardType": "Credit",
      "issuingBank": "UTL MAESTRO",
      "countryCode": "999",
      "acquirerTransactionType": "3DSECURE",
      "issuerAuthorizationApprovalCode": "397136",
      "acquirerStan": "39736",
      "acquirerTerminalId": "39",
      "acquirerTransactionTime": "2017-08-29T13:42:18Z",
      "nonPaymentToken" : "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken" : "1234567890",
      "transactionInitiator" : "MERCHANT"
    }
  }
}
```
{% else %}

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
  "paid": {
    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/paid",
    "number": 1234567890,
    "transaction": {
      "id": "/psp{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ site.transaction_id }}",
      "number" : 1234567891
    },
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "amount": 1500,
  }
}
```
{% endif %}

{:.table .table-striped}
| Field                              | Type         | Description                                                                                                                                                                                                                                                                                          |
| :--------------------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                          | `string`     | {% include field-description-id.md sub_resource="transaction" %}                                                                                                                                                                                                                                     |
| └➔&nbsp;`transaction`              | `string`     | The transaction object, containing information about the current transaction.                                                                                                                                                                                                                        |
| └─➔&nbsp;`id`                      | `string`     | {% include field-description-id.md resource="transaction" %}                                                                                                                                                                                                                                         |
| └─➔&nbsp;`number`                  | `string`     | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead.                                                                                         |
| └➔&nbsp;`payeeReference`           | `string`     | {% include field-description-payee-reference.md documentation_section=documentation_section %}                                                                                                                                                                                                       |
| └➔&nbsp;`orderReference`           | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                              |
| └➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                                            |
| └➔&nbsp;`tokens`                   | `integer`    | List of tokens generated.                                                                                                                                                                                                                                                                            |
| └➔&nbsp;`details`                  | `integer`    | A human readable and descriptive text of the payment.                                                                                                                                                                                                                                                |
| └─➔&nbsp;`cardBrand`               | `string`     | `Visa`, `MC`, etc. The brand of the card.                                                                                                                                                                                                                                                            |
| └─➔&nbsp;`maskedPan`               | `string`     | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| └─➔&nbsp;`cardType`                | `string`     | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| └─➔&nbsp;`issuingBank`             | `string`     | The name of the bank that issued the card used for the authorization.                                                                                                                                                                                                                                |
| └─➔&nbsp;`countryCode`             | `string`     | The country the card is issued in.                                                                                                                                                                                                                                                                   |
| └─➔&nbsp;`acquirerTransactionType` | `string`     | `3DSECURE` or `SSL`. Indicates the transaction type of the acquirer.                                                                                                                                                                                                                                 |
| └─➔&nbsp;`acquirerStan`            | `string`     | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                                                                                                         |
| └─➔&nbsp;`acquirerTerminalId`      | `string`     | The ID of the acquirer terminal.                                                                                                                                                                                                                                                                     |
| └─➔&nbsp;`acquirerTransactionTime` | `string`     | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                                                                                                              |
| └─➔&nbsp;`nonPaymentToken`         | `string`     | Result of our own tokenization of the card used. Activated in POS on merchant or merchant group.                                                                                                                                                                                                     |
| └─➔&nbsp;`externalNonPaymentToken` | `string`     | Result of external tokenization. This value varies depending on cards, acquirer, customer, etc. For ICA cards, the token comes in response from Swedbank. For Mass Transit(SL) it is populated with PAR if it comes in response from the redeemer (Visa). If not, our own token (Mastercard / Amex). |

### Operation `failed-payment`

The `failed-payment` operation means that something went wrong during the
payment process, the transaction was not authorized, and no further transactions
can be created if the payment is in this state.

A `failed-payment` operation looks like the following:

```json
{
   "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/failed",
   "rel": "failed-payment",
   "method": "GET",
   "contentType": "application/problem+json"
}
```

To inspect why the payment failed, you need to perform an HTTP `GET` request
towards the operation's `href` field.

Under `details` you can see the problem message and under `problems` you can
see which problem and the `description` of the problem with the corresponding
error code.

An example of how the request and response look like is given below.

{:.code-view-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/failed HTTP/1.1
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
   "problem": {
       "type": "{{ page.api_url }}/psp/errordetail/{{ api_resource }}/acquirererror",
       "title": "Operation failed",
       "status": 403,
       "detail": {% if documentation_section == "trustly" %} "Unable to complete operation, error calling 3rd party", {% else %} "Unable to complete Authorization transaction, look at problem node!", {% endif %}
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

### Operation `aborted-payment`

The `aborted-payment` operation means that the merchant has aborted the payment
before the payer has fulfilled the payment process. You can see this under
`abortReason` in the response.

An `aborted-payment` operation looks like the following:

```json
{
    "href": "{{ page.api_url }}/psp/creditcard/payments/<paymentId>/aborted",
    "rel": "aborted-payment",
    "method": "GET",
    "contentType": "application/json"
}
```

To inspect why the payment was aborted, you need to perform an HTTP `GET`
request towards the operation's `href` field. An example of how the request and
response looks like is given below.

{:.code-view-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/aborted HTTP/1.1
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
  "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
  "aborted": {
    "abortReason": "Aborted by consumer"
  }
}
```
