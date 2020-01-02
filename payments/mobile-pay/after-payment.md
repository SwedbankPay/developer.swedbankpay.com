---
title: Swedbank Pay Payments Mobile Pay After Payment
sidebar:
  navigation:
  - title: MobilePay Payments
    items:
    - url: /payments/mobile-pay
      title: Introduction
    - url: /payments/mobile-pay/redirect
      title: Redirect
    - url: /payments/mobile-pay/after-payment
      title: After Payment
    - url: /payments/mobile-pay/other-features
      title: Other Features
---

{% include alert-development-section.md %}

## Options after posting a payment

* **Abort**: It is possible to [abort a payment][technical-reference-abort]
  if the payment has no successful transactions.
* If the payment shown above has a completed `authorization`,
  you will need to implement the `Capture` and `Cancel` requests.
* For reversals, you will need to implement the `Reversal` request.
* **If CallbackURL is set**: Whenever changes to the payment occur
  a [Callback request][technical-reference-callback] will be posted to
  the `callbackUrl`, generated when the payment was created.

## Capture

The `captures` resource lists the capture transactions performed on a
specific payment.

{% include transaction-response.md payment-instrument="mobile-pay" transaction="capture" %}

## Create capture transaction

A `capture` transaction - to withdraw money from the payer's Mobile Pay - can be
created after a completed authorization by performing the `create-capture`
operation.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.paymentId }}/captures HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 1000,
        "vatAmount": 250,
        "payeeReference": 1234,
        "description" : "description for transaction"
    }
}
```

{:.table .table-striped}
| Required | Property                 | Type         | Description                                                                                                               |
| :------: | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------ |
|    ✔︎    | `transaction`            | `object`     | Object representing the capture transaction.                                                                              |
|    ✔︎    | └➔&nbsp;`amount`         | `integer`    | Amount entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`. |
|    ✔︎    | └➔&nbsp;`vatAmount`      | `integer`    | Amount entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`. |
|    ✔︎    | └➔&nbsp;`description`    | `string`     | A textual description of the capture transaction.                                                                         |
|    ✔︎    | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the capture transaction. See [payeeReference][payee-reference] for details.                        |

The `capture` resource contains information about the capture transaction made
against a MobilePay payment.
You can return a specific capture transaction by adding the transaction id to
 the `GET` request.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/mobilepay/payments/{{ page.paymentId }}",
    "captures": {
        "id": "/psp/mobilepay/payments/{{ page.paymentId }}/captures",
        "captureList": [
            {
                "id": "/psp/mobilepay/payments/{{ page.paymentId }}/captures/{{ page.transactionId }}",
                "transaction": {
                    "id": "/psp/mobilepay/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
                    "created": "2018-09-11T12:14:20.3155727Z",
                    "updated": "2018-09-11T12:14:21.3834204Z",
                    "type": "Capture",
                    "state": "Completed",
                    "number": 75100000126,
                    "amount": 1000,
                    "vatAmount": 250,
                    "description": "description for transaction",
                    "payeeReference": "1234",
                    "isOperational": false,
                    "operations": []
                }
            }
        ]
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                                            |
| :-------------------- | :------- | :------------------------------------------------------------------------------------- |
| `payment`             | `string` | The relative URI of the payment this capture transaction belongs to.                   |
| `capture`             | `string` | The capture transaction object.                                                        |
| └➔&nbsp;`id`          | `string` | The relative URI of the created capture transaction.                                   |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [transaction resource][transaction-resource]. |

## Capture Sequence

`Capture` can only be done on a authorized transaction.
It is possible to do a part-capture where you only capture a smaller amount
than the authorization amount.
You can later do more captures on the sam payment upto the total
authorization amount.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    Merchant->>SwedbankPay: POST <mobilepay capture>
    Activate Merchant
    Activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    Deactivate SwedbankPay
    Deactivate Merchant
```

## Cancellations

The `cancellations` resource lists the cancellation transactions on a
specific payment.

{% include transaction-response.md payment-instrument="mobile-pay" transaction="cancellation" %}

## Create cancellation transaction

Perform the `create-cancel` operation to cancel a previously created payment.
You can only cancel a payment - or part of payment - not yet captured.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.paymentId }}/cancellations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "description": "Test Cancellation",
        "payeeReference": "ABC123"
    }
}
```

{:.table .table-striped}
| ✔︎   | Property                 | Type         | Description                                                                                             |
| :--- | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------ |
| ✔︎   | `transaction`            | `string`     | The transaction object contains information about this cancellation.                                    |
| ✔︎   | └➔&nbsp;`description`    | `string`     | A textual description of the reason for the cancellation.                                               |
| ✔︎   | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the cancellation transaction. See [payeeReference][payee-reference] for details. |

The `cancel` resource contains information about a cancellation transaction
made against a payment.
You can return a specific cancellation transaction by adding the transaction
id to the `GET` request.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/mobilepay/payments/{{ page.paymentId }}",
    "cancellation": {
        "id": "/psp/mobilepay/payments/{{ page.paymentId }}/cancellations/{{ page.transactionId }}",
        "transaction": {
            "id": "/psp/mobilepay/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
            "created": "2018-09-11T12:19:38.1247314Z",
            "updated": "2018-09-11T12:19:38.3059149Z",
            "type": "Cancellation",
            "state": "Completed",
            "number": 75100000127,
            "amount": 500,
            "vatAmount": 0,
            "description": "Test Cancellation",
            "payeeReference": "ABC123",
            "isOperational": false,
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                                            |
| :-------------------- | :------- | :------------------------------------------------------------------------------------- |
| `payment`             | `string` | The relative URI of the payment this cancellation transaction belongs to.              |
| `cancellation`        | `string` | The current cancellation transaction object.                                           |
| └➔&nbsp;`id`          | `string` | The relative URI of the current cancellation transaction resource.                     |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [transaction resource][transaction-resource]. |

## Cancel Sequence

Cancel can only be done on a authorized transaction.
If you do cancel after doing a part-capture you will cancel the different
between the capture amount and the authorization amount.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    Merchant->>SwedbankPay: POST <mobilepay cancellation>
    Activate Merchant
    Activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    Deactivate SwedbankPay
    Deactivate Merchant
```

## Reversals

The `reversals` resource lists the reversal transactions performed on a
specific payment.

{% include transaction-response.md payment-instrument="mobile-pay" transaction="reversal" %}

## Create reversal transaction

The `create-reversal` operation reverses a previously created and
captured payment.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.paymentId }}/reversals HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 1000,
        "vatAmount": 0,
        "description" : "Test Reversal",
        "payeeReference": "DEF456"
    }
}
```

{:.table .table-striped}
| ✔︎   | Property                 | Type         | Description                                                                                                               |
| :--- | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------ |
| ✔︎   | `transaction`            | `integer`    | The reversal `transaction`.                                                                                               |
| ✔︎   | └➔&nbsp;`amount`         | `integer`    | Amount entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`. |
| ✔︎   | └➔&nbsp;`vatAmount`      | `integer`    | Amount entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`. |
| ✔︎   | └➔&nbsp;`description`    | `string`     | A textual description of the capture                                                                                      |
| ✔︎   | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the reversal transaction. See [payeeReference][payee-reference] for details.                       |

The `reversal` resource contains information about a reversal transaction made
against a payment.
You can return a specific reversal transaction by adding the transaction id to
the `GET` request.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/mobilepay/payments/{{ page.paymentId }}",
    "reversal": {
        "id": "/psp/mobilepay/payments/{{ page.paymentId }}/reversals/{{ page.transactionId }}",
        "transaction": {
            "id": "/psp/mobilepay/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
            "created": "2018-09-11T12:25:54.339611Z",
            "updated": "2018-09-11T12:25:54.5738079Z",
            "type": "Reversal",
            "state": "Completed",
            "number": 75100000128,
            "amount": 1000,
            "vatAmount": 0,
            "description": "Reversal reason",
            "payeeReference": "DEF456",
            "isOperational": false,
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                                            |
| :-------------------- | :------- | :------------------------------------------------------------------------------------- |
| `payment`             | `string` | The relative URI of the payment this capture transaction belongs to.                   |
| `reversal`            | `string` | The reversal transaction.                                                              |
| └➔&nbsp;`id`          | `string` | The relative URI of the created capture transaction.                                   |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [transaction resource][transaction-resource]. |

## Reversal Sequence

Reversal can only be done on a payment where there are some
captured amount not yet reversed.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    Merchant->>SwedbankPay: POST <mobilepay reversal>
    Activate Merchant
    Activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    Deactivate SwedbankPay
    Deactivate Merchant
```

{% include iterator.html prev_href="redirect"
                         prev_title="Back: Redirect"
                         next_href="other-features"
                         next_title="Next: Other Features" %}

[authorization]: /payments/mobile-pay/redirect#type-of-authorization-intent
[mobilepay-cancel]: /payments/mobile-pay/other-features#cancel-sequence
[mobilepay-capture]: /payments/mobile-pay/other-features#capture-sequence
[mobilepay-reversal]: /payments/mobile-pay/other-features#reversal-sequence
[payee-reference]: /payments/mobile-pay/other-features#payee-reference
[technical-reference-abort]: /payments/mobile-pay/other-features#abort-a-payment
[technical-reference-callback]: /payments/mobile-pay/other-features#callback
[technical-reference-payeeReference]: /payments/mobile-pay/other-features#payee-reference
[transaction-resource]: /payments/mobile-pay/other-features#transactions
