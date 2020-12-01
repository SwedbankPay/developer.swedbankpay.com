{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

## Card authorization transaction

The `authorization` resource contains information about an authorization
transaction made towards a payment. To create a new `authorization` transaction,
perform a `POST` towards the URI obtained from the `payment.authorization.id`
from the `payment` resource below. The example is abbreviated for brevity.

{:.code-view-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/ HTTP/1.1
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
    "payment": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
        "authorizations": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations"
        },
    }
}
```

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "cardNumber": "4925000000000004",
        "cardExpiryMonth": "12",
        "cardExpiryYear": "22",
        "cardVerificationCode": "749",
        "cardholderName": "Olivia Nyhuus",
        "chosenCoBrand": "Visa"
    }
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json
{
  "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
  "authorization": {
    "id": "/psp/creditcard/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }}",
    "paymentToken" : "{{ page.payment_token }}",
    "recurrenceToken" : "{{ page.payment_id }}",
    "maskedPan" : "123456xxxxxx1234",
    "expiryDate" : "mm/yyyy",
    "panToken" : "{{ page.transaction_id }}"
    "cardBrand": "Visa",
    "cardType": "Credit",
    "issuingBank": "UTL MAESTRO",
    "countryCode": "999",
    "acquirerTransactionType": "3DSECURE",
    "issuerAuthorizationApprovalCode": "397136",
    "acquirerStan": "39736",
    "acquirerTerminalId": "39",
    "acquirerTransactionTime": "2017-08-29T13:42:18Z",
    "authenticationStatus": "Y",
    "nonPaymentToken" : "",
    "externalNonPaymentToken" : "",
    "transaction": {
      "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
      "created": "2016-09-14T01:01:01.01Z",
      "updated": "2016-09-14T01:01:01.03Z",
      "type": "Authorization",
      "state": "Initialized",
      "number": 1234567890,
      "amount": 1000,
      "vatAmount": 250,
      "description": "Test transaction",
      "payeeReference": "AH123456",
      "failedReason": "ExternalResponseError",
      "failedActivityName": "Authorize",
      "failedErrorCode": "REJECTED_BY_ACQUIRER",
      "failedErrorDescription": "General decline, response-code: 05",
      "isOperational": "TRUE",
      "activities": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}/activities" },
      "operations": [
        {
          "href": "https://api.payex.com/psp/creditcard/payments/{{ page.payment_id }}",
          "rel": "edit-authorization",
          "method": "PATCH"
        }
      ]
    }
  }
}
```

{:.table .table-striped}
|     Required     | Field                          | Type      | Description                                                                     |
| :--------------: | :----------------------------- | :-------- | :------------------------------------------------------------------------------ |
| {% icon check %} | `transaction`                  | `object`  | The transaction object.                                                         |
| {% icon check %} | └➔&nbsp;`cardNumber`           | `string`  | Primary Account Number (PAN) of the card, printed on the face of the card.      |
| {% icon check %} | └➔&nbsp;`cardExpiryMonth`      | `integer` | Expiry month of the card, printed on the face of the card.                      |
| {% icon check %} | └➔&nbsp;`cardExpiryYear`       | `integer` | Expiry year of the card, printed on the face of the card.                       |
|                  | └➔&nbsp;`cardVerificationCode` | `string`  | Card verification code (CVC/CVV/CVC2), usually printed on the back of the card. |
|                  | └➔&nbsp;`cardholderName`       | `string`  | Name of the card holder, usually printed on the face of the card.               |

{:.table .table-striped}
| Field                             | Type      | Description                                                                                                                                                                                                                                                                                          |
| :-------------------------------- | :-------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                         | `object`  | The payment object.                                                                                                                                                                                                                                                                                  |
| `authorization`                   | `object`  | The authorization object.                                                                                                                                                                                                                                                                            |
| └➔&nbsp;`direct`                  | `string`  | The type of the authorization.                                                                                                                                                                                                                                                                       |
| └➔&nbsp;`cardBrand`               | `string`  | `Visa`, `MC`, etc. The brand of the card.                                                                                                                                                                                                                                                            |
| └➔&nbsp;`cardType`                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| └➔&nbsp;`issuingBank`             | `string`  | The name of the bank that issued the card used for the authorization.                                                                                                                                                                                                                                |
| └➔&nbsp;`paymentToken`            | `string`  | The payment token created for the card used in the authorization.                                                                                                                                                                                                                                    |
| └➔&nbsp;`maskedPan`               | `string`  | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| └➔&nbsp;`expiryDate`              | `string`  | The month and year of when the card expires.                                                                                                                                                                                                                                                         |
| └➔&nbsp;`panToken`                | `string`  | The token representing the specific PAN of the card.                                                                                                                                                                                                                                                 |
| └➔&nbsp;`panEnrolled`             | `string`  |                                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`acquirerTransactionTime` | `string`  | `3DSECURE` or `SSL`. Indicates the transaction type of the acquirer.                                                                                                                                                                                                                                 |
| └➔&nbsp;`id`                      | `string`  | {% include field-description-id.md resource="itemDescriptions" %}                                                                                                                                                                                                                                    |
| └➔&nbsp;`nonPaymentToken`         | `string`  | Result of our own tokenization of the card used. Activated in POS on merchant or merchant group.                                                                                                                                                                                                     |
| └➔&nbsp;`externalNonPaymentToken` | `string`  | Result of external tokenization. This value varies depending on cards, acquirer, customer, etc. For ICA cards, the token comes in response from Swedbank. For Mass Transit(SL) it is populated with PAR if it comes in response from the redeemer (Visa). If not, our own token (Mastercard / Amex).                                                                                                                                                                 |
| └➔&nbsp;`transaction`             | `object`  | The transaction object, containing information about the current transaction.                                                                                                                                                                                                                        |
| └─➔&nbsp;`id`                     | `string`  | {% include field-description-id.md resource="transaction" %}                                                                                                                                                                                                                                         |
| └─➔&nbsp;`created`                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                                                                                                                      |
| └─➔&nbsp;`updated`                | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                                                                                                                      |
| └─➔&nbsp;`type`                   | `string`  | Indicates the transaction type.                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`state`                  | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                                                                                                                      |
| └─➔&nbsp;`number`                 | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead.                                                                                         |
| └─➔&nbsp;`amount`                 | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                                                                                                             |
| └─➔&nbsp;`vatAmount`              | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                   |
| └─➔&nbsp;`description`            | `string`  | {% include field-description-description.md %}                                                                                                                                                                                                                          |
| └─➔&nbsp;`payeeReference`         | `string`  | {% include field-description-payee-reference.md %}                                                                                                                                                                                                                      |
| └─➔&nbsp;`failedReason`           | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                                                                                                            |
| └─➔&nbsp;`isOperational`          | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                                                                                                         |
| └─➔&nbsp;`operations`             | `array`   | The array of operations that are possible to perform on the transaction in its current state.                                                                                                                                                                                                        |
