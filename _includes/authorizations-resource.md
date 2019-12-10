{% assign payment-instrument = include.payment-instrument | default: creditcard %}

### Authorizations

The `authorizations` resource will list the authorization transactions
made on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/{{payment-instrument}}/payments/<payment-id>/authorizations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": "/psp/{{payment-instrument}}/payments/<payment-id>",
  "authorizations": {
    "id": "/psp/{{payment-instrument}}/payments/<payment-id>/authorizations",
    "authorizationList": [
      {
        "id": "/psp/{{payment-instrument}}/payments/<payment-id>/authorizations/<transaction-id>",
        "consumer": {
          "id": "/psp/{{payment-instrument}}/payments/<payment-id>/consumer"
        },
        "legalAddress": {
          "id": "/psp/{{payment-instrument}}/payments/<payment-id>/legaladdress"
        },
        "billingAddress": {
          "id": "/psp/{{payment-instrument}}/payments/<payment-id>/billingaddress"
        },
        "transaction": {
          "id": "/psp/{{payment-instrument}}/payments/<payment-id>/transactions/<transaction-id>",
          "created": "2016-09-14T01:01:01.01Z",
          "updated": "2016-09-14T01:01:01.03Z",
          "type": "Authorization",
          "state": "Initialized|Completed|Failed",
          "number": 1234567890,
          "amount": 1000,
          "vatAmount": 250,
          "description": "Test transaction",
          "payeeReference": "AH123456",
          "failedReason": "",
          "isOperational": false,
          "operations": [
            {
              "href": "https://api.externalintegration.payex.com/psp/{{payment-instrument}}/payments/<payment-id>",
              "rel": "edit-authorization",
              "method": "PATCH"
            }
          ]
        }
      }
    ]
  }
}
```

#### Create Authorization transaction

To create an `authorization` transaction, perform the `create-authorization`
operation as returned in a previously created invoice payment.

{:.code-header}
**Request**

```http
POST /psp/{{payment-instrument}}/payments/<payment-id>/authorizations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "transaction": {
    "activity": "FinancingConsumer"
  },
  "consumer": {
    "socialSecurityNumber": "socialSecurityNumber",
    "customerNumber": "customerNumber",
    "name": "consumer name",
    "email": "email",
    "msisdn": "msisdn",
    "ip": "consumer ip address"
  },
  "legalAddress": {
    "addressee": "firstName + lastName",
    "coAddress": "coAddress",
    "streetAddress": "streetAddress",
    "zipCode": "zipCode",
    "city": "city",
    "countryCode": "countryCode"
  },
  "billingAddress": {
    "addressee": "firstName + lastName",
    "coAddress": "coAddress",
    "streetAddress": "streetAddress",
    "zipCode": "zipCode",
    "city": "city",
    "countryCode": "countryCode"
  }
}
```

{:.table .table-striped}
| Required | Property                        | Data type | Description                                                                                                                                                      |
| :------- | :------------------------------ | :-------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✔︎︎︎︎︎   | `transaction.activity`          | `string`  | `FinancingConsumer`                                                                                                                                              |
| ✔︎︎︎︎︎   | `consumer.socialSecurityNumber` | `string`  | The social security number (national identity number) of the consumer. Format Sweden: `YYMMDD-NNNN`. Format Norway: `DDMMYYNNNNN`. Format Finland: `DDMMYYNNNNN` |
|          | `consumer.customerNumber`       | `string`  | The customer number in the merchant system.                                                                                                                      |
|          | `consumer.email`                | `string`  | The e-mail address of the consumer.                                                                                                                              |
| ✔︎︎︎︎︎   | `consumer.msisdn`               | `string`  | The mobile phone number of the consumer. Format Sweden: `+46707777777`. Format Norway: `+4799999999`. Format Finland: `+358501234567`                            |
| ✔︎︎︎︎︎   | `consumer.ip`                   | `string`  | The IP address of the consumer.                                                                                                                                  |
| ✔︎︎︎︎︎   | `legalAddress.addressee`        | `string`  | The full (first and last) name of the consumer.                                                                                                                  |
|          | `legalAddress.coAddress`        | `string`  | The CO-address (if used)                                                                                                                                         |
|          | `legalAddress.streetAddress`    | `string`  | The street address of the consumer.                                                                                                                              |
| ✔︎︎︎︎︎   | `legalAddress.zipCode`          | `string`  | The postal code (ZIP code) of the consumer.                                                                                                                      |
| ✔︎︎︎︎︎   | `legalAddress.city`             | `string`  | The city to the consumer.                                                                                                                                        |
| ✔︎︎︎︎︎   | `legalAddress.countryCode`      | `string`  | `SE`, `NO`, or `FI`. The country code of the consumer.                                                                                                           |
| ✔︎︎︎︎︎   | `billingAddress.addressee`      | `string`  | The full (first and last) name of the consumer.                                                                                                                  |
|          | `billingAddress.coAddress`      | `string`  | The CO-address (if used)                                                                                                                                         |
| ✔︎︎︎︎ ︎  | `billingAddress.streetAddress`  | `string`  | The street address to the consumer.                                                                                                                              |
| ✔︎︎︎︎︎   | `billingAddress.zipCode`        | `string`  | The postal number (ZIP code) to the consumer.                                                                                                                    |
| ✔︎︎︎︎︎   | `billingAddress.city`           | `string`  | The city to the consumer.                                                                                                                                        |
| ✔︎︎︎︎︎   | `billingAddress.countryCode`    | `string`  | `SE`, `NO`, or `FI`.                                                                                                                                             |

{% include alert.html type="neutral" icon="info" body="
Note: The legal address must be the registered address of the consumer." %}

The `authorization` resource will be returned, containing information about
the newly created authorization transaction.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": "/psp/{{payment-instrument}}/payments/<payment-id>",
  "authorization": {
    "id": "/psp/{{payment-instrument}}/payments/<payment-id>/authorizations/<transaction-id>",
    "consumer": {
      "id": "/psp/{{payment-instrument}}/payments/<payment-id>/consumer"
    },
    "legalAddress": {
      "id": "/psp/{{payment-instrument}}/payments/<payment-id>/legaladdress"
    },
    "billingAddress": {
      "id": "/psp/{{payment-instrument}}/payments/<payment-id>/billingaddress"
    },
    "transaction": {
      "id": "/psp/{{payment-instrument}}/payments/<payment-id>/transactions/<transaction-id>",
      "created": "2016-09-14T01:01:01.01Z",
      "updated": "2016-09-14T01:01:01.03Z",
      "type": "Authorization",
      "state": "Initialized|Completed|Failed",
      "number": 1234567890,
      "amount": 1000,
      "vatAmount": 250,
      "description": "Test transaction",
      "payeeReference": "AH123456",
      "failedReason": "",
      "isOperational": "TRUE|FALSE",
      "operations": [
        {
          "href": "https://api.externalintegration.payex.com/psp/{{payment-instrument}}/payments/<payment-id>",
          "rel": "edit-authorization",
          "method": "PATCH"
        }
      ]
    }
  }
}
```
