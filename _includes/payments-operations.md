{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

## Operation `paid-payment`

The `paid-payment` operation confirms that the transaction has been successful
and that the payment is completed.

A `paid-payment` operation looks like this:

```json
{
   "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/paid",
   "rel": "paid-payment",
   "method": "GET",
   "contentType": "application/json"
}
```

To inspect the paid payment, you need to perform an HTTP `GET` request
towards the operation's `href` field. An example of the request and
response is given below.

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
            "number": 1234567891
        },
        "payeeReference": "CD123",
        "orderReference": "AB1234",
        "amount": 1500,
        "tokens": [
            {
                "type": "payment",
                "token": "{{ page.payment_token }}",
                "name": "4925xxxxxx000004",
                "expiryDate": "mm/yyyy"
            },
            {
                "type": "recurrence",
                "token": "{{ page.payment_token }}",
                "name": "4925xxxxxx000004",
                "expiryDate": "mm/yyyy"
            },
            {
                "type": "transactionsOnFile",
                "token": "{{ page.payment_token }}",
                "name": "4925xxxxxx000004",
                "expiryDate": "mm/yyyy"
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
            "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
            "externalNonPaymentToken": "1234567890",
            "transactionInitiator": "MERCHANT"
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
            "number": 1234567891
        },
        "payeeReference": "CD123",
        "orderReference": "AB1234",
        "amount": 1500
    }
}
```

{% endif %}

{:.table .table-striped}
| Field                              | Type         | Description                                                                                                                                                                                                                                                                                          |
| :--------------------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                          | `string`     | {% include fields/id.md sub_resource="transaction" %}                                                                                                                                                                                                                                     |
| {% f transaction %}              | `string`     | The transaction object, containing information about the current transaction.                                                                                                                                                                                                                        |
| {% f id, 2 %}                      | `string`     | {% include fields/id.md resource="transaction" %}                                                                                                                                                                                                                                         |
| {% f number, 2 %}                  | `string`     | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where `id` should be used instead.                                                                                         |
| {% f payeeReference %}           | `string`     | {% include fields/payee-reference.md %}                                                                                                                                                                                                       |
| {% f orderReference %}           | `string(50)` | The order reference, which should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                              |
| {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                            |
| {% f tokens %}                   | `integer`    | A list of generated tokens.                                                                                                                                                                                                                                                                            |
| {% f details %}                  | `integer`    | A human readable and descriptive text of the payment.                                                                                                                                                                                                                                                |
| {% f cardBrand, 2 %}               | `string`     | `Visa`, `MC`, etc. The brand of the card.                                                                                                                                                                                                                                                            |
| {% f maskedPan, 2 %}               | `string`     | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| {% f cardType, 2 %}                | `string`     | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| {% f issuingBank, 2 %}             | `string`     | The name of the bank that issued the card used for the authorization.                                                                                                                                                                                                                                |
| {% f countryCode, 2 %}             | `string`     | The country the card is issued in.                                                                                                                                                                                                                                                                   |
| {% f acquirerTransactionType, 2 %} | `string`     | `3DSECURE` or `SSL`. Indicates the transaction type of the acquirer.                                                                                                                                                                                                                                 |
| {% f acquirerStan, 2 %}            | `string`     | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                                                                                                         |
| {% f acquirerTerminalId, 2 %}      | `string`     | The ID of the acquirer terminal.                                                                                                                                                                                                                                                                     |
| {% f acquirerTransactionTime, 2 %} | `string`     | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                                                                                                              |
| {% f nonPaymentToken, 2 %}         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| {% f externalNonPaymentToken, 2 %} | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token. |

## Operation `failed-payment`

The `failed-payment` operation means that something went wrong during the
payment process. The transaction was not authorized, and no further transactions
can be created if the payment is in this state.

A `failed-payment` operation looks like this:

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

The problem message can be found in `details` field. Under `problems` you can
see which problem occurred, a `description` of the problem and the corresponding
error code.

An example of the request and response is given below.

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

```

## Operation `aborted-payment`

The `aborted-payment` operation means that the merchant aborted the payment
before the payer fulfilled the payment process. You can see this under
`abortReason` in the response.

An `aborted-payment` operation looks like this:

```json
{
    "href": "{{ page.api_url }}/psp/creditcard/payments/<paymentId>/aborted",
    "rel": "aborted-payment",
    "method": "GET",
    "contentType": "application/json"
}
```

To inspect why the payment was aborted, you need to perform an HTTP `GET`
request towards the operation's `href` field. An example of the request and
response is given below.

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
