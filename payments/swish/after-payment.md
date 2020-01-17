---
title: Swedbank Pay Payments Swish After Payment
sidebar:
  navigation:
  - title: Swish Payments
    items:
    - url: /payments/swish
      title: Introduction
    - url: /payments/swish/direct
      title: Direct
    - url: /payments/swish/redirect
      title: Redirect
    - url: /payments/swish/seamless-view
      title: Seamless View
    - url: /payments/swish/after-payment
      title: After Payment
    - url: /payments/swish/other-features
      title: Other Features
---

{% include alert-review-section.md %}

After the payment is confirmed, the consumer will be redirected from the Swish
app to the `completeUrl` set in the [create payment request][create-payment].
You need to retrieve payment status with `GET`
[Sales transaction][sales-transaction] before presenting a confirmation page to
the consumer.

## Options after posting a payment

* **If CallbackURL is set**: Whenever changes to the payment occur a [Callback
  request][technical-reference-callback] will be posted to the `callbackUrl`,
  which was generated when the payment was created.
* You can create a reversal transactions by implementing the Reversal request.
  You can also access and reverse a payment through your merchant pages in the
  [Swedbank Pay admin portal][payex-admin-portal].

### Reversal Sequence

A reversal transcation need to match the Payee reference of a completed
sales transaction.

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>- SwedbankPay: POST <Swish reversal>
  activate  SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```

## Payment Resource

When a payment resource is created and during its lifetime, it will have a set
of operations that can be performed on it.
Which operations are available will vary depending on the state of the payment
resource, what the access token is authorized to do, etc.
A list of possible operations for Swish Payments and their explanation
is given below.

{:.code-header}
**Operations**

```js
{
    "operations": [
        {
            "method": "POST",
            "href": "{{ page.apiUrl }}/psp/swish/payments/{{ page.paymentId }}/sales",
            "rel": "create-sale"
        },
        {
            "method": "GET",
            "href": "{{ page.frontEndUrl }}/swish/payments/sales/{{ page.paymentToken }}",
            "rel": "redirect-sale"
        },
        {
            "method": "GET",
            "href": "{{ page.frontEndUrl }}/swish/core/scripts/client/px.swish.client.js?token={{ page.paymentToken }}",
            "rel": "view-sales",
            "contentType": "application/javascript"
        }
    ]
}
```

{:.table .table-striped}
| Property | Description                                                         |
| :------- | :------------------------------------------------------------------ |
| `href`   | The target URI to perform the operation against.                    |
| `rel`    | The name of the relation the operation has to the current resource. |
| `method` | The HTTP method to use when performing the operation.               |

The operations should be performed as described in each response and not as
described here in the documentation.
Always use the `href` and `method` as specified in the response by finding the
appropriate operation based on its `rel` value.
The only thing that should be hard coded in the client is the value of
the `rel` and the request that will be sent in the HTTP body of the
request for the given operation.

{:.table .table-striped}
| Operation              | Description                                                                                                                                |
| :--------------------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
| `create-sale`          | Creates a `sales` transaction without redirection to a payment page. `Msisdn` is required in browser based scenarioes.                     |
| `redirect-sale`        | Contains the redirect-URI that redirects the consumer to a Swedbank Pay hosted payment page prior to creating a sales transaction.         |
| `view-sales`         | Contains the URI of the JavaScript used to create a Hosted View iframe directly without redirecting the consumer to separate payment page. |

## Swish transactions

All Swish transactions are described below.

## Sales

The `sales` resource lists the sales transactions (one or more)
on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/swish/payments/{{ page.paymentId }}/sales HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": "/psp/swish/payments/{{ page.paymentId }}",
  "sales": {
    "id": "/psp/swish/payments/{{ page.paymentId }}/sale",
    "saleList": [
      {
        "date": "8/13/2019 8:58:23 AM +00:00",
        "payerAlias": "46739000001",
        "swishPaymentReference": "8D0A30A7804E40479F88FFBA26111F04",
        "swishStatus": "PAID",
        "id": "/psp/swish/payments/{{ page.paymentId }}/sales/{{ page.transactionId }}",
        "transaction": {
          "id": "{{ page.transactionId }}",
          "created": "2016-09-14T01:01:01.01Z",
          "updated": "2016-09-14T01:01:01.03Z",
          "type": "Sale",
          "state": "Initialized",
          "number": 1234567890,
          "amount": 1000,
          "vatAmount": 250,
          "description": "Test transaction",
          "payeeReference": "AH123456",
          "isOperational": true,
          "reconciliationNumber": 737283,
          "operations": []
        }
      }
    ]
  }
}
```

### Create Sales transaction

In browser based solutions the payers `msisdn` (mobile number) is required.
This is managed either by sending a `POST` request as seen below,
or by redirecting the end-user to the hosted payment page.
The `msisdn` is only required for browser based solutions.
With mobile app based solutions, the consumer uses the device that hosts the Swish app
to manage the purchase, making `msisdn` optional.

{:.code-header}
**Browser-based Request**

```http
POST /psp/swish/payments/{{ page.paymentId }}/sales HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "msisdn": "+46739000001"
    }
}
```

{:.code-header}
**Browser-based Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/swish/payments/{{ page.paymentId }}",
    "sale": {
        "date": "23.10.2017 08:39:37 +00:00",
        "paymentRequestToken": "LhXrK84MSpWU2RO09f8kUP-FHiBo-1pB",
        "id": "/psp/swish/payments/{{ page.paymentId }}/sales/{{ page.transactionId }}",
        "transaction": {
            "id": "{{ page.transactionId }}",
            "created": "2017-10-23T08:39:35.6478733Z",
            "updated": "2017-10-23T08:39:37.3788733Z",
            "type": "Sale",
            "state": "AwaitingActivity",
            "number": 992309,
            "amount": 1500,
            "vatAmount": 0,
            "description": "Test Purchase",
            "payeeReference": "Postman1508747933",
            "isOperational": true,
            "operations": []
        }
    }
}
```

{:.code-header}
**In-app Request**

```http
POST /psp/swish/payments/{{ page.paymentId }}/sales HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
    }
}
```

{:.code-header}
**In-app Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/swish/payments/{{ page.paymentId }}",
    "sale": {
        "date": "23.10.2017 08:39:37 +00:00",
        "paymentRequestToken": "LhXrK84MSpWU2RO09f8kUP-FHiBo-1pB",
        "id": "/psp/swish/payments/{{ page.paymentId }}/sales/{{ page.transactionId }}",
        "transaction": {
            "id": "{{ page.transactionId }}",
            "created": "2017-10-23T08:39:35.6478733Z",
            "updated": "2017-10-23T08:39:37.3788733Z",
            "type": "Sale",
            "state": "AwaitingActivity",
            "number": 992309,
            "amount": 1500,
            "vatAmount": 0,
            "description": "Test Purchase",
            "payeeReference": "Postman1508747933",
            "isOperational": true,
            "operations": [
                {
                    "href": "swish://paymentrequest?token=<swishtoken>&callbackurl=<completeUrl>",
                    "method": "GET",
                    "rel": "redirect-app-swish"
                }
            ]
        }
    }
}
```

The `operation` `redirect-app-swish` is only returned when using in-app flows.

The payment now contains a sale transaction with the status (state)
`AwaitingActivity`, meaning we are awaiting a response from Swish.
When the consumer confirms the payment a callback request will follow
from Swedbank Pay.

## Reversals

The `Reversals` resource list the reversals transactions (one or more) on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/swish/payments/{{ page.paymentId }}/reversals HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/swish/payments/{{ page.paymentId }}",
    "reversals": {
        "id": "/psp/swish/payments/{{ page.paymentId }}/reversals",
        "reversalList": [
            {
                "id": "/psp/swish/payments/{{ page.paymentId }}/reversals/{{ page.transactionId }}",
                "transaction": {
                    "id": "/psp/swish/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
                    "created": "2016-09-14T01:01:01.01Z",
                    "updated": "2016-09-14T01:01:01.03Z",
                    "type": "Reversal",
                    "state": "Completed",
                    "number": 1234567890,
                    "amount": 1000,
                    "vatAmount": 250,
                    "description": "Test transaction",
                    "payeeReference": "AH123456",
                    "isOperational": true,
                    "operations": []
                }
            }
        ]
    }
}
```

{:.table .table-striped}
| Property                 | Type     | Description                                                                                          |
| :----------------------- | :------- | :--------------------------------------------------------------------------------------------------- |
| `payment`                | `string` | The relative URI of the payment that the reversal transactions belong to.                            |
| `reversals`              | `object` | The reversal object.                                                                                 |
| └➔&nbsp;`reversalList[]` | `array`  | The array of reversal transaction objects.                                                           |
| └─➔&nbsp;`transaction`   | `object` | The reversal transaction object representation of the reversal transaction resource described below. |

### Create Reversal transaction

A reversal transaction can be created after a completed authorization by
performing a request to the `create-reversal` operation.
A [callback][technical-reference-callback] request will follow from
Swedbank Pay.

{:.code-header}
**Request**

```http
POST /psp/swish/payments/{{ page.paymentId }}/reversals HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 1500,
        "vatAmount": 0,
        "description" : "Test Reversal",
        "payeeReference": "ABC123"
    }
}
```

{:.table .table-striped}
| Required | Property                 | Type         | Description                                                                                                                                                            |
| :------: | :----------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|    ✔︎    | `transaction`            | `object`     | The `transaction` object, containing information about this `reversal`.                                                                                                |
|    ✔︎    | └➔&nbsp;`amount`         | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 SEK`, `5000` = `50.00 SEK`                                               |
|    ✔︎    | └➔&nbsp;`vatAmount`      | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 SEK`, `5000` = `50.00 SEK`                                               |
|    ✔︎    | └➔&nbsp;`description`    | `string`     | A textual description of the capture                                                                                                                                   |
|    ✔︎    | └➔&nbsp;`payeeReference` | `string(35)` | A  reference that must match the  `payeeReference` of the sales transaction you want to reverse. See [payeeReference][technical-reference-payeeReference] for details. |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/swish/payments/{{ page.paymentId }}",
    "reversal": {
        "id": "/psp/swish/payments/{{ page.paymentId }}/reversals/{{ page.transactionId }}",
        "transaction": {
            "id": "/psp/swish/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Reversal",
            "state": "Completed",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "isOperational": false,
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                                              |
| :-------------------- | :------- | :--------------------------------------------------------------------------------------- |
| `payment`             | `string` | The relative URI of the payment this capture transaction belongs to.                     |
| `reversal`            | `object` | The `reversal` object contains information about this `reversal`.                        |
| └➔&nbsp;`id`          | `string` | The relative URI of the created capture transaction.                                     |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [transaction][technical-reference-transaction]. |

## Capture

Swish does not support `capture` as it is a one-phase payment method all
completed payments are captured.

## Cancel

Swish does not support `cancel` as `cancel` can only be used on two-phase
payments before they are captured or reversed.

## Recurring

Swish does not support `recurring` payments.

[core-payment-resources]: /payments
[general-http-info]: /resources/
[payex-admin-portal]: https://admin.payex.com/psp/login/
[payment-order]: #create-payment
[technical-reference-abort]: #abort
[technical-reference-callback]: /payments/swish/other-features#callback
[technical-reference-expand]: /payments/swish/other-features#expansion
[technical-reference-payeeReference]: /payments/swish/other-features#payee-reference
[technical-reference-problemmessages]: /payments/swish/other-features#problem-messages
[technical-reference-transaction]: /payments/swish/other-features#transaction
[user-agent]: https://en.wikipedia.org/wiki/User_agent
