## Balance

{:.code-view-header}
**Request**

```http
POST /api/payments/payment-account/balance HTTP/1.1
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
    }
}
```

{:.table .table-striped}
|     Required     | Field               | Type     | Description                                                                                                                     |
| :--------------: | :------------------ | :------- | :------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `accountIdentifier` | `Object` |                                                                                                                                 |
|                  | `accountId`         | `string` | Swedbank Pay internal id for card/account.                                                                                      |
| {% icon check %} | `accountKey`        | `string` | Primary Account Number (PAN) for card/account. This is mandatory if ‘track2’ is not present.                                    |
|                  | `cvc`               | `string` | Card Verification Code.                                                                                                         |
|                  | `encryptedPin`      | `string` | If ‘000’ is set on authorization request, encrypted PIN block will be returned here.                                            |
|                  | `expiryDate`        | `string` | Expiry date on card (only applicable for PaymentInstrumentType ‘creditcard’) where expiry date is printed on card. Format MM/YY |
|                  | `securityCode`      | `string` | Card Security Code.                                                                                                             |
|                  | `track2`            | `string` | Track 2 excluding start and end sentinel.                                                                                       |

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
    "paymentAccount": {
        "accountSummary": {
            "accountId": 123456789,
            "balance": 10000,
            "currency": "NOK",
            "expiryDate": "2020-01-15",
            "paymentInstrumentType": "giftcard"
        },
        "issuerSummary": {
            "acquirerId": "string",
            "acquirerName": "string",
            "issuerId": "string",
            "issuerName": "string",
            "settlementProvided": true
        }
    }
}
```
