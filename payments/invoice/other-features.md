---
title: Swedbank Pay Payments Invoice Other Features
sidebar:
  navigation:
  - title: Invoice Payments
    items:
    - url: /payments/invoice
      title: Introduction
    - url: /payments/invoice/redirect
      title: Redirect
    - url: /payments/invoice/seamless-view
      title: Seamless View
    - url: /payments/invoice/after-payment
      title: After Payment
    - url: /payments/invoice/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="This section of the Developer Portal is under construction and
                      should not be used to integrate against Swedbank Pay's
                      APIs yet." %}

## API requests

The API requests are displayed in the [invoice flow][invoice-flow].
The options you can choose from when creating a payment with key operation
set to Value FinancingConsumer are listed below.

### Options before posting a payment

{:.table .table-striped}
|                 | **Sweden** ![Swedish flag][se-png] | **Norway** ![Norwegian flag][no-png] | **FInland** ![Finish flag][fi-png] |
| :-------------: | :--------------------------------: | :----------------------------------: | :--------------------------------: |
|  **Operation**  |         FinancingConsumer          |          FinancingConsumer           |         FinancingConsumer          |
|   **Intent**    |           Authorization            |            Authorization             |           Authorization            |
|  **Currency**   |                SEK                 |                 NOK                  |                EUR                 |
| **InvoiceType** |          PayExFinancingSE          |           PayExFinancingNO           |          PayExFinancingFI          |

* An invoice payment is always two-phased based -  you create an Authorize
    transaction, that is followed by a Capture or Cancel request.
* **Defining CallbackURL**: When implementing a scenario, it is optional
    to set a [CallbackURL][callback-api] in the `POST` request.
    If callbackURL is set PayEx will send a postback request to this URL when
    the consumer has fulfilled the payment.
    [See the Callback API description here.][callback-api]

### Authorizations

The `authorizations` resource will list the authorization transactions
made on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/invoice/payments/<payments-id>/authorizations HTTP/1.1
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
  "payment": "/psp/invoice/payments/<payments-id>",
  "authorizations": {
    "id": "/psp/invoice/payments/<payments-id>/authorizations",
    "authorizationList": [
      {
        "id": "/psp/invoice/payments/<payments-id>/authorizations/<transaction-id>",
        "consumer": {
          "id": "/psp/invoice/payments/<payments-id>/consumer"
        },
        "legalAddress": {
          "id": "/psp/invoice/payments/<payments-id>/legaladdress"
        },
        "billingAddress": {
          "id": "/psp/invoice/payments/<payments-id>/billingaddress"
        },
        "transaction": {
          "id": "/psp/invoice/payments/<payments-id>/transactions/<transaction-id>",
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
              "href": "https://api.externalintegration.payex.com/psp/invoice/payments/<payments-id>",
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
POST /psp/invoice/payments/<payments-id>/authorizations HTTP/1.1
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
| **Required** | **Property**                    | **Data type** | **Description**                                                                                                                    |
| :----------- | :------------------------------ | :------------ | :--------------------------------------------------------------------------------------------------------------------------------- |
| ✔︎︎︎︎︎       | `transaction.activity`          | `string`      | `FinancingConsumer`                                                                                                                |
| ✔︎︎︎︎︎       | `consumer.socialSecurityNumber` | `string`      | The social security number (national identity number) of the consumer. Format Sweden: `YYMMDD-NNNN`. Format Norway: `DDMMYYNNNNN`. |
|              | `consumer.customerNumber`       | `string`      | The customer number in the merchant system.                                                                                        |
|              | `consumer.email`                | `string`      | The e-mail address of the consumer.                                                                                                |
| ✔︎︎︎︎︎       | `consumer.msisdn`               | `string`      | The mobile phone number of the consumer. Format Sweden: `+46707777777`. Format Norway: `+4799999999`.                              |
| ✔︎︎︎︎︎       | `consumer.ip`                   | `string`      | The IP address of the consumer.                                                                                                    |
| ✔︎︎︎︎︎       | `legalAddress.addressee`        | `string`      | The full (first and last) name of the consumer.                                                                                    |
|              | `legalAddress.coAddress`        | `string`      | The CO-address (if used)                                                                                                           |
|              | `legalAddress.streetAddress`    | `string`      | The street address of the consumer.                                                                                                |
| ✔︎︎︎︎︎       | `legalAddress.zipCode`          | `string`      | The postal code (ZIP code) of the consumer.                                                                                        |
| ✔︎︎︎︎︎       | `legalAddress.city`             | `string`      | The city to the consumer.                                                                                                          |
| ✔︎︎︎︎︎       | `legalAddress.countryCode`      | `string`      | `SE` or `NO`. The country code of the consumer.                                                                                    |

{:.table .table-striped}
| **Required** | **Property**                   | **Data type** | **Description**                               |
| :----------- | :----------------------------- | :------------ | :-------------------------------------------- |
| ✔︎︎︎︎︎       | `billingAddress.addressee`     | `string`      | The "firstName + lastName" to the consumer.   |
|              | `billingAddress.coAddress`     | `string`      | The CO-address (if used)                      |
| ✔︎︎︎︎ ︎      | `billingAddress.streetAddress` | `string`      | The street address to the consumer.           |
| ✔︎︎︎︎︎       | `billingAddress.zipCode`       | `string`      | The postal number (ZIP code) to the consumer. |
| ✔︎︎︎︎︎       | `billingAddress.city`          | `string`      | The city to the consumer.                     |
| ✔︎︎︎︎︎       | `billingAddress.countryCode`   | `string`      | `SE` or `NO`.                                 |

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
  "payment": "/psp/invoice/payments/<payments-id>",
  "authorization": {
    "id": "/psp/invoice/payments/<payments-id>/authorizations/<transaction-id>",
    "consumer": {
      "id": "/psp/invoice/payments/<payments-id>/consumer"
    },
    "legalAddress": {
      "id": "/psp/invoice/payments/<payments-id>/legaladdress"
    },
    "billingAddress": {
      "id": "/psp/invoice/payments/<payments-id>/billingaddress"
    },
    "transaction": {
      "id": "/psp/invoice/payments/<payments-id>/transactions/<transaction-id>",
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
          "href": "https://api.externalintegration.payex.com/psp/invoice/payments/<payments-id>",
          "rel": "edit-authorization",
          "method": "PATCH"
        }
      ]
    }
  }
}
```

### Problem messages

When performing unsuccessful operations, the eCommerce API will respond with
a problem message. We generally use the problem message type and status code
to identify the nature of the problem. The problem name and description will
often help narrow down the specifics of the problem.

#### Error types from Swedbank Pay Invoice and third parties

All invoice error types will have the following URI in front of type:
`https://api.payex.com/psp/errordetail/invoice/<errorType>`

{:.table .table-striped}
| **Type**        | **Status** |
| :-------------- | :--------- |
| *externalerror* | 500        | No error code                 |
| *inputerror*    | 400        | 10 - ValidationWarning        |
| *inputerror*    | 400        | 30 - ValidationError          |
| *inputerror*    | 400        | 3010 - ClientRequestInvalid   |
| *externalerror* | 502        | 40 - Error                    |
| *externalerror* | 502        | 60 - SystemError              |
| *externalerror* | 502        | 50 - SystemConfigurationError |
| *externalerror* | 502        | 9999 - ServerOtherServer      |
| *forbidden*     | 403        | Any other error code          |

{% include settlement-reconciliation.md %}

{% include payment-link.md %}

{% include callback-reference.md %}

## Payment Orders

{% include payment-order-get.md %}

{% include transactions-reference.md %}

{% include operations-reference.md %}

### Payee Info

{% include payeeinfo.md %}

{% include iterator.html prev_href="./" prev_title="Back: Introduction"
next_href="after-payment" next_title="Next: After Payment" %}

[fi-png]: /assets/img/fi.png
[no-png]: /assets/img/no.png
[se-png]: /assets/img/se.png
[callback-api]: #callback
[invoice-flow]: /payments/invoice/index/#invoice-flow
[payment-order]: #payment-orders
