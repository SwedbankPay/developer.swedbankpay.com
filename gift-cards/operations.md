---
title: Gift Cards – Operations
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

## Gift card resource

For security and headers see [Security][security].

## Get New Gift Card

{:.code-header}
**Request**

```http
POST /api/payments/gift-card/get-new-gift-card HTTP/1.1
Authorization: Bearer <AccessToken>
Hmac: HMAC authentication filter
Content-Type: application/json

{
    "amount": 10000,
    "email": "example@exampleprovider.com",
    "msisdn": 99999999,
    "productId": 7854
}
```

{:.table .table-striped}
|     Required     | Field       | Type      | Description                                                                                |
| :--------------: | :---------- | :-------- | :----------------------------------------------------------------------------------------- |
| {% icon check %} | `amount`    | `integer` | Total amount of Payment (in cents), ie. 100Kr -> 10000. If amount is 0 no deposit is made. |
|                  | `email`     | `string`  | customers email.                                                                           |
|                  | `msisdn`    | `string`  | customers mobile number.                                                                   |
|                  | `productId` | `string`  | A human readable and descriptive text of the error.                                        |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

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
    "accountSummaryGiftCard": {
        "accountKey": 7013360000000001000,
        "balance": 10000,
        "cvc": 123,
        "expiryDate": "2020-01-15"
    },
    "paymentId": 4526987
}
```

## Pre Deposit

{:.code-header}
**Request**

```http
POST /api/payments/gift-card/pre-deposit HTTP/1.1
Authorization: Bearer <AccessToken>
Hmac: HMAC authentication filter
Content-Type: application/json

{
    "amount": 10000,
    "currency": "NOK",
    "description": "string",
    "orderRef": "UUID",
    "simpleAccountIdentifier": {
        "accountKey": 7013360000000001000,
        "cvc": 123,
        "expiryDate": "12/20"
    },
    "transactionRef": "UUID"
}
```

{:.table .table-striped}
|     Required     | Field                     | Type      | Description                                                                                                                      |
| :--------------: | :------------------------ | :-------- | :------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `amount`                  | `integer` | Total amount of Payment (in cents), ie. 100Kr -> 10000. If amount is 0 no deposit is made.                                       |
| {% icon check %} | `currency`                | `string`  | Currency for Payment.                                                                                                            |
|                  | `description`             | `string`  | Payment description.                                                                                                             |
| {% icon check %} | `orderRef`                | `string`  | Merchant ref, Unique from merchant per session.                                                                                  |
|                  | `transactionRef`          | `string`  | Unique ID for each transaction.                                                                                                  |
| {% icon check %} | `SimpleAccountIdentifier` | `Object`  |                                                                                                                                  |
| {% icon check %} | `accountKey`              | `string`  | Primary Account Number (PAN) for card/account. This is mandatory if ‘track2’ is not present.                                     |
|                  | `cvc`                     | `string`  | Card Verification Code.                                                                                                          |
|                  | `expiryDate`              | `string`  | Expiry date on card (only applicable for PaymentInstrumentType ‘creditcard’) where expiry date is printed on card. Format MM/YY. |

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
    "balance": 10000,
    "paymentId": 4526987
}
```

[auth]: /gift-cards/other-features#authentication
[balance]: /gift-cards/other-features#balance
[deposit]: /gift-cards/other-features#deposit
[purchase]: /gift-cards/other-features#purchase
[security]: /gift-cards/security
