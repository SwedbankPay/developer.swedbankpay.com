{% assign payment_instrument = include.payment_instrument | default: creditcard %}

### Authorizations

The `authorizations` resource will list the authorization transactions
made on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}",
    "authorizations": {
        "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/authorizations",
        "authorizationList": [
            {
                "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id}}",
                "consumer": {
                    "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/consumer"
                },
                "legalAddress": {
                    "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/legaladdress"
                },
                "billingAddress": {
                    "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/billingaddress"
                },
                "transaction": {
                    "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id}}",
                    "created": "2016-09-14T01:01:01.01Z",
                    "updated": "2016-09-14T01:01:01.03Z",
                    "type": "Authorization",
                    "state": "Initialized",
                    "number": 1234567890,
                    "amount": 1000,
                    "vatAmount": 250,
                    "description": "Test transaction",
                    "payeeReference": "AH123456",
                    "failedReason": "",
                    "isOperational": false,
                    "operations": [
                        {
                            "method": "POST",
                            "href": "{{ page.api_url }}/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/authorizations",
                            "rel": "create-authorization",
                            "contentType": "application/json"
                        },
                        {
                            "href": "{{ page.api_url }}/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}",
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
POST /psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "activity": "FinancingConsumer"
    },
    "consumer": {
        "socialSecurityNumber": "socialSecurityNumber",
        "customerNumber": "123456",
        "name": "Olivia Nyhuus",
        "email": "olivia.nyhuus@payex.com",
        "msisdn": "+4798765432",
        "ip": "127.0.0.1"
    },
    "legalAddress": {
        "addressee": "Olivia Nyhuus",
        "streetAddress": "SaltnesToppen 43",
        "zipCode": "1642",
        "city": "Saltnes",
        "countryCode": "no"
    },
    "billingAddress": {
        "addressee": "Olivia Nyhuus",
        "coAddress": "Bernt Nyhuus",
        "streetAddress": "SaltnesToppen 43",
        "zipCode": "1642",
        "city": "Saltnes",
        "countryCode": "no"
    }
}
```

{:.table .table-striped}
| Required | Property                       | Data type | Description                                                                                                                                                      |
| :------- | :----------------------------- | :-------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✔︎︎︎︎︎   | `transaction.activity`         | `string`  | `FinancingConsumer`                                                                                                                                              |
| ✔︎︎︎︎︎   | `consumer`                     | `object`  | The consumer object.                                                                                                                                             |
| ✔︎︎︎︎︎   | └➔&nbsp;`socialSecurityNumber` | `string`  | The social security number (national identity number) of the consumer. Format Sweden: `YYMMDD-NNNN`. Format Norway: `DDMMYYNNNNN`. Format Finland: `DDMMYYNNNNN` |
|          | └➔&nbsp;`customerNumber`       | `string`  | The customer number in the merchant system.                                                                                                                      |
|          | └➔&nbsp;`email`                | `string`  | The e-mail address of the consumer.                                                                                                                              |
| ✔︎︎︎︎︎   | └➔&nbsp;`msisdn`               | `string`  | The mobile phone number of the consumer. Format Sweden: `+46707777777`. Format Norway: `+4799999999`. Format Finland: `+358501234567`                            |
| ✔︎︎︎︎︎   | └➔&nbsp;`ip`                   | `string`  | The IP address of the consumer.                                                                                                                                  |
| ✔︎︎︎︎︎   | `legalAddress`                 | `object`  | The legal address object containing information about the consumers legal addres.                                                                                |
| ✔︎︎︎︎︎   | └➔&nbsp;`addressee`            | `string`  | The full (first and last) name of the consumer.                                                                                                                  |
|          | └➔&nbsp;`coAddress`            | `string`  | The CO-address (if used)                                                                                                                                         |
|          | └➔&nbsp;`streetAddress`        | `string`  | The street address of the consumer.                                                                                                                              |
| ✔︎︎︎︎︎   | └➔&nbsp;`zipCode`              | `string`  | The postal code (ZIP code) of the consumer.                                                                                                                      |
| ✔︎︎︎︎︎   | └➔&nbsp;`city`                 | `string`  | The city to the consumer.                                                                                                                                        |
| ✔︎︎︎︎︎   | └➔&nbsp;`countryCode`          | `string`  | `SE`, `NO`, or `FI`. The country code of the consumer.                                                                                                           |
| ✔︎︎︎︎︎   | `billingAddress`               | `object`  | The billing address object containing information about the consumers billing addres.                                                                            |
| ✔︎︎︎︎︎   | └➔&nbsp;`addressee`            | `string`  | The full (first and last) name of the consumer.                                                                                                                  |
|          | └➔&nbsp;`coAddress`            | `string`  | The CO-address (if used)                                                                                                                                         |
| ✔︎︎︎︎ ︎  | └➔&nbsp;`streetAddress`        | `string`  | The street address to the consumer.                                                                                                                              |
| ✔︎︎︎︎︎   | └➔&nbsp;`zipCode`              | `string`  | The postal number (ZIP code) to the consumer.                                                                                                                    |
| ✔︎︎︎︎︎   | └➔&nbsp;`city`                 | `string`  | The city to the consumer.                                                                                                                                        |
| ✔︎︎︎︎︎   | └➔&nbsp;`countryCode`          | `string`  | `SE`, `NO`, or `FI`.                                                                                                                                             |

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
    "payment": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}",
    "authorization": {
        "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id}}",
        "consumer": {
            "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/consumer"
        },
        "legalAddress": {
            "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/legaladdress"
        },
        "billingAddress": {
            "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/billingaddress"
        },
        "transaction": {
            "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id}}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "",
            "isOperational": false,
            "operations": [
                {
                    "href": "{{ page.api_url }}/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}",
                    "rel": "edit-authorization",
                    "method": "PATCH"
                }
            ]
        }
    }
}
```
