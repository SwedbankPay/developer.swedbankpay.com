## Authentication

{:.code-view-header}
**Request**

```http
POST /api/payments/payment-account/{paymentAccountId}/payment/authorize HTTP/1.1
Authorization: Bearer <AccessToken>
Hmac: HMAC authentication filter
Content-Type: application/json

{
    "accountIdentifier": {
        "accountId": 123456789,
        "accountKey": 7013360000000001000,
        "cvc": 123,
        "encryptedPin": "000",
        "expiryDate": "12/20",
        "securityCode": 123,
        "track2": "7013360000000000000=2012125123"
    },
    "additionalData": "string",
    "amount": 10000,
    "currency": "NOK",
    "description": "string",
    "merchant": {
        "merchantName": "Test Merchant 101",
        "terminalId": 12345
    },
    "paymentOrderRef": "UUID",
    "paymentTransactionRef": "UUID",
    "repeat": true,
    "stan": 123456
}
```

{:.table .table-striped}
|     Required     | Field                   | Type      | Description                                                                                                                     |
| :--------------: | :---------------------- | :-------- | :------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `accountIdentifier`     | `Object`  |                                                                                                                                 |
|                  | `accountId`             | `string`  | Swedbank Pay internal id for card/account.                                                                                      |
| {% icon check %} | `accountKey`            | `string`  | Primary Account Number (PAN) for card/account. This is mandatory if ‘track2’ is not present.                                    |
|                  | `cvc`                   | `string`  | Card Verification Code.                                                                                                         |
|                  | `encryptedPin`          | `string`  | If ‘000’ is set on authorization request, encrypted PIN block will be returned here.                                            |
|                  | `expiryDate`            | `string`  | Expiry date on card (only applicable for PaymentInstrumentType ‘creditcard’) where expiry date is printed on card. Format MM/YY |
|                  | `securityCode`          | `string`  | Card Security Code.                                                                                                             |
|                  | `track2`                | `string`  | Track 2 excluding start and end sentinel.                                                                                       |
|                  | `additionalData`        | `string`  | Optional additional data stored on transaction.                                                                                 |
| {% icon check %} | `amount`                | `integer` | Total amount of Payment (in cents), ie. 100Kr -> 10000.                                                                         |
| {% icon check %} | `currency`              | `string`  | Currency for Payment.                                                                                                           |
|                  | `description`           | `string`  | Payment description.                                                                                                            |
| {% icon check %} | `merchant`              | `object`  |                                                                                                                                 |
| {% icon check %} | `merchantName`          | `string`  | Name of merchant where payment was performed                                                                                    |
|                  | `terminalId`            | `string`  | Used to identify terminal.                                                                                                      |
| {% icon check %} | `paymentOrderRef`       | `string`  | Unique ID to bind 2-phase transactions.                                                                                         |
| {% icon check %} | `paymentTransactionRef` | `string`  | Unique ID for each payment.                                                                                                     |
|                  | `repeat`                | `boolean` | Notifies this is a repeat message.                                                                                              |
|                  | `stan`                  | `string`  | Systems trace audit number.                                                                                                     |

{:.code-view-header}
**Response:**

```json
{
    "_links": [
        {
            "deprecation": "string",
            "href": "string",
            "hreflang": "string",
            "media": "string",
            "rel": "string",
            "templated": true,
            "title": "string",
            "type": "string"
        }
    ],
    "accountIdentifier": {
        "accountId": 123456789,
        "accountKey": 7013360000000001000,
        "cvc": 123,
        "encryptedPin": "000",
        "expiryDate": "12/20",
        "securityCode": 123,
        "track2": "7013360000000000000=2012125123"
    },
    "allowedProductIds": [
        "string"
    ],
    "amount": 0,
    "created": "2020-05-12T07:02:36.719Z",
    "currency": "string",
    "description": "string",
    "issuer": {
        "acquirerId": "string",
        "acquirerName": "string",
        "issuerId": "string",
        "issuerName": "string",
        "settlementProvided": true
    },
    "merchant": {
        "merchantName": "Test Merchant 101",
        "terminalId": 12345
    },
    "operation": "string",
    "paymentId": "string",
    "paymentOrderRef": "string",
    "paymentTransactionRef": "string",
    "remainingCancelAmount": 0,
    "remainingCaptureAmount": 0,
    "remainingReversalAmount": 0,
    "state": "OK",
    "transmissionTime": "2020-05-12T07:02:36.719Z",
    "updated": "2020-05-12T07:02:36.719Z"
}
```

{:.table .table-striped}
| Field   | Type   | Description                                                              |
| :------ | :----- | :----------------------------------------------------------------------- |
| `state` | `enum` | `OK`, `FAILED`, `REVERSED` or `DUPLICATE`. The state of the transaction. |
