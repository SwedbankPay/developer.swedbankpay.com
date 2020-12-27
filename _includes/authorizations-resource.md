{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

### Authorizations

The `authorizations` resource will list the authorization transactions
made on a specific payment.

{:.code-view-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md transaction="authorization" %}

#### Create Authorization transaction

To create an `authorization` transaction, perform the `create-authorization`
operation as returned in a previously created invoice payment.

{:.code-view-header}
**Request**

```http
POST /psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations HTTP/1.1
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
| Required          | Field                          | Data type | Description                                                                                                                                                      |
| :---------------- | :----------------------------- | :-------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %}  | `transaction.activity`         | `string`  | `FinancingConsumer`                                                                                                                                              |
| {% icon check %}  | `consumer`                     | `object`  | The payer object.                                                                                                                                             |
| {% icon check %}  | └➔&nbsp;`socialSecurityNumber` | `string`  | The social security number (national identity number) of the payer. Format Sweden: `YYMMDD-NNNN`. Format Norway: `DDMMYYNNNNN`. Format Finland: `DDMMYYNNNNN` |
|                   | └➔&nbsp;`customerNumber`       | `string`  | The customer number in the merchant system.                                                                                                                      |
|                   | └➔&nbsp;`email`                | `string`  | The e-mail address of the payer.                                                                                                                              |
| {% icon check %}  | └➔&nbsp;`msisdn`               | `string`  | The mobile phone number of the payer. Format Sweden: `+46707777777`. Format Norway: `+4799999999`. Format Finland: `+358501234567`                            |
| {% icon check %}  | └➔&nbsp;`ip`                   | `string`  | The IP address of the payer.                                                                                                                                  |
| {% icon check %}  | `legalAddress`                 | `object`  | The legal address object containing information about the payer's legal address.                                                                                |
| {% icon check %}  | └➔&nbsp;`addressee`            | `string`  | The full (first and last) name of the payer.                                                                                                                  |
|                   | └➔&nbsp;`coAddress`            | `string`  | The CO-address (if used)                                                                                                                                         |
|                   | └➔&nbsp;`streetAddress`        | `string`  | The street address of the payer. Maximum 50 characters long.                                                                                                  |
| {% icon check %}  | └➔&nbsp;`zipCode`              | `string`  | The postal code (ZIP code) of the payer.                                                                                                                      |
| {% icon check %}  | └➔&nbsp;`city`                 | `string`  | The city of the payer.                                                                                                                                        |
| {% icon check %}  | └➔&nbsp;`countryCode`          | `string`  | `SE`, `NO`, or `FI`. The country code of the payer.                                                                                                           |
| {% icon check %}  | `billingAddress`               | `object`  | The billing address object containing information about the payer's billing address.                                                                            |
| {% icon check %}  | └➔&nbsp;`addressee`            | `string`  | The full (first and last) name of the payer.                                                                                                                  |
|                   | └➔&nbsp;`coAddress`            | `string`  | The CO-address (if used)                                                                                                                                         |
| {% icon check %}︎︎︎︎ ︎ | └➔&nbsp;`streetAddress`        | `string`  | The street address of the payer. Maximum 50 characters long.                                                                                                   |
| {% icon check %}  | └➔&nbsp;`zipCode`              | `string`  | The postal number (ZIP code) of the payer.                                                                                                                    |
| {% icon check %}  | └➔&nbsp;`city`                 | `string`  | The city of the payer.                                                                                                                                        |
| {% icon check %}  | └➔&nbsp;`countryCode`          | `string`  | `SE`, `NO`, or `FI`.                                                                                                                                             |

{% include alert.html type="informative" icon="info" body="
Note: The legal address must be the registered address of the payer." %}

The `authorization` resource will be returned, containing information about
the newly created authorization transaction.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "authorization": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id}}",
        "consumer": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/consumer"
        },
        "legalAddress": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/legaladdress"
        },
        "billingAddress": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/billingaddress"
        },
        "transaction": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id}}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "isOperational": false,
            "operations": [
                {
                    "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
                    "rel": "edit-authorization",
                    "method": "PATCH"
                }
            ]
        }
    }
}
```
