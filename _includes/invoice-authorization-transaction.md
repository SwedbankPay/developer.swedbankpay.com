## Create Authorization Transaction

The `redirect-authorization` operation redirects the payer to Swedbank Pay
Payments where the payment is authorized.

{:.code-view-header}
**Request**

```http
POST /psp/invoice/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "activity": "FinancingConsumer"
    },
    "consumer": {
        "socialSecurityNumber": "{{ page.consumer_ssn_no }}",
        "customerNumber": "123456",
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
        "streetAddress": "SaltnesToppen 43",
        "zipCode": "1642",
        "city": "Saltnes",
        "countryCode": "no"
    }
}
```

{:.table .table-striped}
|     Required     | Field                          | Type     | Description                                                            |
| :--------------: | :----------------------------- | :------- | :--------------------------------------------------------------------- |
| {% icon check %} | `transaction`                  | `object` | The transaction object.                                                |
|                  | └➔&nbsp;`activity`             | `string` | Only the value `"FinancingConsumer"` or `"AccountsReceivableConsumer"` |
|                  | `consumer`                     | `object` | The payer object.                                                   |
|                  | └➔&nbsp;`socialSecurityNumber` | `string` | The social security number of the payer.                            |
|                  | └➔&nbsp;`customerNumber`       | `string` | Customer number of the payer.                                       |
|                  | └➔&nbsp;`email`                | `string` | The customer email address.                                            |
|                  | └➔&nbsp;`msisdn`               | `string` | The MSISDN of the payer.                                            |
|                  | └➔&nbsp;`ip`                   | `string` | The IP address of the payer.                                        |
|                  | `legalAddress`                 | `object` | The Address object.                                                    |
|                  | └➔&nbsp;`addressee`            | `string` | The full name of the addressee of this invoice                         |
|                  | └➔&nbsp;`coAddress`            | `string` | The co Address of the addressee.                                       |
|                  | └➔&nbsp;`streetAddress`        | `string` | The street address of the addresse. Maximum 50 characters long.        |
|                  | └➔&nbsp;`zipCode`              | `string` | The zip code of the addresse.                                          |
|                  | └➔&nbsp;`city`                 | `string` | The city name  of the addresse.                                        |
|                  | └➔&nbsp;`countryCode`          | `string` | The country code of the addresse.                                      |
|                  | `billingAddress`               | `object` | The BillingAddress object for the billing address of the addresse.     |
|                  | └➔&nbsp;`addressee`            | `string` | The full name of the billing address adressee.                         |
|                  | └➔&nbsp;`coAddress`            | `string` | The co address of the billing address adressee.                        |
|                  | └➔&nbsp;`streetAddress`        | `string` | The street address of the billing address adressee. Maximum 50 characters long.|
|                  | └➔&nbsp;`zipCode`              | `string` | The zip code of the billing address adressee.                          |
|                  | └➔&nbsp;`city`                 | `string` | The city name of the billing address adressee.                         |
|                  | └➔&nbsp;`countryCode`          | `string` | The country code of the billing address adressee.                      |

{:.code-view-header}
**Response**

```json
{
    "payment": "/psp/invoice/payments/{{ page.payment_id }}",
    "authorization": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }}",
        "consumer": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/consumer"
        },
        "legalAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/legaladdress"
        },
        "billingAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/billingaddress"
        },
        "transaction": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Failed",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "ExternalResponseError",
            "failedActivityName": "Authorize",
            "failedErrorCode": "ThirdPartyErrorCode",
            "failedErrorDescription": "ThirdPartyErrorMessage",
            "isOperational": "TRUE",
            "activities": {
                "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}/activities"
            },
            "operations": [
                {
                    "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}",
                    "rel": "edit-authorization",
                    "method": "PATCH"
                }
            ]
        }
    }
}
```

{:.table .table-striped}
| Field                    | Type      | Description                                                                                                                                                                                                  |
| :----------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                | `string`  | {% include field-description-id.md sub_resource="authorization" %}                                                                                                                                           |
| `authorization`          | `object`  | The transaction object.                                                                                                                                                                                      |
| └➔&nbsp;`id`             | `string`  | {% include field-description-id.md resource="authorization" %}                                                                                                                                               |
| └➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| └➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └➔&nbsp;`amount`         | `integer` | {% include field-description-amount.md %}                                                                                                                                                                    |
| └➔&nbsp;`vatAmount`      | `integer` | {% include field-description-vatamount.md %}                                                                                                                                                                 |
| └➔&nbsp;`description`    | `string`  | {% include field-description-description.md %}                                                                                                                               |
| └➔&nbsp;`payeeReference` | `string`  | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                     |
| └➔&nbsp;`failedReason`   | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| └➔&nbsp;`isOperational`  | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| └➔&nbsp;`operations`     | `array`   | The array of operations that are possible to perform on the transaction in its current state.                                                                                                                |

The `authorization` resource contains information about an authorization
transaction made towards a payment, as previously described.
