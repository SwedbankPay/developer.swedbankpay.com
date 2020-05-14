---
title: Gift Cards – Other Features
sidebar:
  navigation:
  - title: Gift Cards
    items:
    - url: /gift-cards/
      title: Introduction
    - url: /gift-cards/operations
      title: Operations
    - url: /gift-cards/security
      title: Security
    - url: /gift-cards/payment-client
      title: Test Client
    - url: /gift-cards/other-features
      title: Other Features
---

## Purchase

{:.code-header}
**Request**

```http
POST /api/payments/payment-account/{paymentAccountId}/payment/purchase HTTP/1.1
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
    "products": [
        {
            "amount": 1337,
            "description": "1x banana",
            "productId": "001",
            "quantity": 13.37,
            "unitOfMeasure": "L",
            "vatAmount": 337,
            "vatRate": 25
        }
    ],
    "repeat": true,
    "stan": 123456
}
```

{:.table .table-striped}
|     Required     | Field                   | Type      | Description                                                                                                                                                                             |
| :--------------: | :---------------------- | :-------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `accountIdentifier`     | `Object`  |                                                                                                                                                                                         |
|                  | `accountId`             | `string`  | Swedbank Pay internal id for card/account.                                                                                                                                                     |
| {% icon check %} | `accountKey`            | `string`  | Primary Account Number (PAN) for card/account. This is mandatory if ‘track2’ is not present.                                                                                            |
|                  | `cvc`                   | `string`  | Card Verification Code.                                                                                                                                                                 |
|                  | `encryptedPin`          | `string`  | If ‘000’ is set on authorization request, encrypted PIN block will be returned here.                                                                                                    |
|                  | `expiryDate`            | `string`  | Expiry date on card (only applicable for PaymentInstrumentType ‘creditcard’) where expiry date is printed on card. Format MM/YY                                                         |
|                  | `securityCode`          | `string`  | Card Security Code.                                                                                                                                                                     |
|                  | `track2`                | `string`  | Track 2 excluding start and end sentinel.                                                                                                                                               |
|                  | `additionalData`        | `string`  | Optional additional data stored on transaction.                                                                                                                                         |
| {% icon check %} | `amount`                | `integer` | Total amount of Payment (in cents), ie. 100Kr -> 10000.                                                                                                                                 |
| {% icon check %} | `currency`              | `string`  | Currency for Payment.                                                                                                                                                                   |
|                  | `description`           | `string`  | Payment description.                                                                                                                                                                    |
| {% icon check %} | `merchant`              | `object`  |                                                                                                                                                                                         |
| {% icon check %} | `merchantName`          | `string`  | Name of merchant where payment was performed                                                                                                                                            |
|                  | `terminalId`            | `string`  | Used to identify terminal.                                                                                                                                                              |
| {% icon check %} | `paymentOrderRef`       | `string`  | Unique ID to bind 2-phase transactions.                                                                                                                                                 |
| {% icon check %} | `paymentTransactionRef` | `string`  | Unique ID for each payment.                                                                                                                                                             |
|                  | `products`              | `list`    |                                                                                                                                                                                         |
| {% icon check %} | `amount`                | `integer` | Monetary value of purchased product (in cents).                                                                                                                                         |
|                  | `description`           | `string`  | Optional product description.                                                                                                                                                           |
| {% icon check %} | `productId`             | `string`  | Used to identify a product.                                                                                                                                                             |
| {% icon check %} | `quantity`              | `number`  | Number of product units sold (both integer and decimal numbers supported).                                                                                                              |
| {% icon check %} | `unitOfMeasure`         | `string`  | Type of measurement, L=Litre, U=Unit, G=Grams This may refer to the number of packs, number of bottles etc., O=present, this denotes that there is no measurement. Enum:[ L, U, G, O ]. |
|                  | `vatAmount`             | `integer` | Monetary value of vat-amount for purchased product (in cents).                                                                                                                          |
|                  | `vatRate`               | `number`  | Vat-rate for purchased product (both integer and decimal numbers supported).                                                                                                            |
|                  | `repeat`                | `boolean` | Notifies this is a repeat message.                                                                                                                                                      |
|                  | `stan`                  | `string`  | Systems trace audit number.                                                                                                                                                             |

{:.code-header}
**Response**

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
    "created": "2020-05-11T08:20:13.829Z",
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
    "transmissionTime": "2020-05-11T08:20:13.829Z",
    "updated": "2020-05-11T08:20:13.829Z"
}
```

{:.table .table-striped}
| Field   | Type   | Description                                                              |
| :------ | :----- | :----------------------------------------------------------------------- |
| `state` | `enum` | `OK`, `FAILED`, `REVERSED` or `DUPLICATE`. The state of the transaction. |

## Deposit

{:.code-header}
**Request**

```http
POST /api/payments/payment-account/{paymentAccountId}/payment/deposit HTTP/1.1
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
|                  | `accountId`             | `string`  | Swedbank Pay internal id for card/account.                                                                                             |
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

{:.code-header}
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
    "created": "2020-05-11T09:58:33.431Z",
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
    "transmissionTime": "2020-05-11T09:58:33.431Z",
    "updated": "2020-05-11T09:58:33.431Z"
}
```

{:.table .table-striped}
| Field   | Type   | Description                                                              |
| :------ | :----- | :----------------------------------------------------------------------- |
| `state` | `enum` | `OK`, `FAILED`, `REVERSED` or `DUPLICATE`. The state of the transaction. |

## Balance

{:.code-header}
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
|                  | `accountId`         | `string` | Swedbank Pay internal id for card/account.                                                                                             |
| {% icon check %} | `accountKey`        | `string` | Primary Account Number (PAN) for card/account. This is mandatory if ‘track2’ is not present.                                    |
|                  | `cvc`               | `string` | Card Verification Code.                                                                                                         |
|                  | `encryptedPin`      | `string` | If ‘000’ is set on authorization request, encrypted PIN block will be returned here.                                            |
|                  | `expiryDate`        | `string` | Expiry date on card (only applicable for PaymentInstrumentType ‘creditcard’) where expiry date is printed on card. Format MM/YY |
|                  | `securityCode`      | `string` | Card Security Code.                                                                                                             |
|                  | `track2`            | `string` | Track 2 excluding start and end sentinel.                                                                                       |

{:.code-header}
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

## Authentication

{:.code-header}
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
|                  | `accountId`             | `string`  | Swedbank Pay internal id for card/account.                                                                                             |
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

{:.code-header}
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
