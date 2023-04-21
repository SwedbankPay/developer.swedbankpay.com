---
title: After Payment
redirect_from: /payments/card/after-payment
description: |
  Apart from capturing the authorized funds, there are still a couple of options
  available to you after a payment. Authorizations can cancelled, captures can
  be both partially and fully reversed. Read more about the options here.
menu_order: 900
---

## Options After Posting A Payment

When you detect that the payer reach your `completeUrl` , you need to do a `GET`
request on the payment resource, containing the `paymentID` generated in the
first step, to receive the state of the transaction. You will also be able to
see the available operations after posting a payment.

*   *Abort:* It is possible to abort the process if the payment has no successful
  transactions. [See the Abort description here][abort].
*   If the payment shown above is done as a two phase (`Authorization`), you will
  need to implement the `Capture` and `Cancel` requests.
*   For `reversals`, you will need to implement the [Reversal request][reversal].
*   If `CallbackURL` is set: Whenever changes to the payment occur a [Callback
  request][callback] will be posted to the `callbackUrl`, which was generated
  when the payment was created.

## Cancellations

`Cancel` can only be done on a authorized transaction. If you do cancel after
doing a part-capture you will cancel the difference between the capture amount
and the authorization amount.

## Cancel Request

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
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
|     Required     | Field                    | Type          | Description                                                                              |
| :--------------: | :----------------------- | :------------ | :--------------------------------------------------------------------------------------- |
| {% icon check %} | `transaction`            | `object`      | The `object` representation of the generic [transaction resource][transaction-resource]. |
| {% icon check %} | {% f description %}    | `string`      | A textual description of the reason for the `cancellation`.                              |
| {% icon check %} | {% f payeeReference %} | `string` | {% include fields/payee-reference.md %}          |

## Cancel Response

The `cancel` resource contains information about a cancellation transaction
made against a payment.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "cancellation": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/cancellations/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Cancellation",
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test Cancellation",
            "payeeReference": "ABC123",
            "failedReason": "",
            "isOperational": false,
            "operations": []
        }
    }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Property                  | Type      | Description                                                                                                                                                                                                  |
| :------------------------ | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                 | `string`  | The relative URL of the payment this `cancellation` transaction belongs to.                                                                                                                                  |
| {% f cancellation, 0 %}            | `object`  | The `cancellation` resource contains information about the `cancellation` transaction made against a card payment.                                                                                           |
| {% f id %}              | `string`  | The relative URL of the created `cancellation` transaction.                                                                                                                                                  |
| {% f transaction %}     | `object`  | {% include fields/transaction.md %}                                                                                                                       |
| {% f id, 2 %}             | `string`  | The relative URL of the current  transaction  resource.                                                                                                                                                      |
| {% f created, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| {% f updated, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| {% f type, 2 %}           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| {% f state, 2 %}          | `string`  | Initialized ,  Completed  or  Failed . Indicates the state of the transaction                                                                                                                                |
| {% f number, 2 %}         | `integer` | {% include fields/number.md %} |
| {% f amount, 2 %}         | `integer` | {% include fields/amount.md %}                                                                                                                                                                    |
| {% f vatAmount, 2 %}      | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                 |
| {% f description, 2 %}    | `string`  | {% include fields/description.md %}                                                                                                                                  |
| {% f payeeReference, 2 %} | `string`  | {% include fields/payee-reference.md %}                                                                                                                              |
| {% f isOperational, 2 %}  | `boolean` | `true`  if the transaction is operational; otherwise  `false` .                                                                                                                                              |
| {% f operations, 2 %}     | `array`   | {% include fields/operations.md %}                                                                                                  |
{% endcapture %}
{% include accordion-table.html content=table %}

## List Cancel Transactions

The `cancellations` resource lists the cancellation transactions on a specific
payment.

{:.code-view-header}
**Request**

```http
GET /psp/creditcard/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md transaction="cancellation" %}

## Cancel Sequence Diagram

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>-SwedbankPay: POST [creditcard cancellactions]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```

## Reversals

This transaction is used when a captured payment needs to be reversed.

## Reversal Request

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Reversal",
        "payeeReference": "ABC123"
    }
}
```

{:.table .table-striped}
|     Required     | Field                    | Type          | Description                                                                              |
| :--------------: | :----------------------- | :------------ | :--------------------------------------------------------------------------------------- |
| {% icon check %} | `transaction`            | `object`      | The `object` representation of the generic [transaction resource][transaction-resource]. |
| {% icon check %} | {% f amount %}         | `integer`     | {% include fields/amount.md %}                                                |
| {% icon check %} | {% f vatAmount %}      | `integer`     | {% include fields/vat-amount.md %}                                             |
| {% icon check %} | {% f description %}    | `string`      | A textual description of the `reversal`.                                                 |
| {% icon check %} | {% f payeeReference %} | `string` | {% include fields/payee-reference.md %}          |

## Reversal Response

The `reversal` resource contains information about the newly created reversal
transaction.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "reversal": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/reversal/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Reversal",
            "state": "Completed",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "",
            "isOperational": false,
            "operations": []
        }
    }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Property                  | Type      | Description                                                                                                                                                                                                  |
| :------------------------ | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}        | `string`  | The relative URL of the payment this `reversal` transaction belongs to.                                                                                                                                      |
| {% f reversal, 0 %}       | `object`  | The `reversal` resource contains information about the `reversal` transaction made against a card payment.                                                                                                    |
| {% f id %}                | `string`  | The relative URL of the created `reversal`transaction.                                                                                                                                                       |
| {% f transaction %}       | `object`  | {% include fields/transaction.md %}                                                                                                                       |
| {% f id, 2 %}             | `string`  | The relative URL of the current  transaction  resource.                                                                                                                                                      |
| {% f created, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| {% f updated, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| {% f type, 2 %}           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| {% f state, 2 %}          | `string`  | {% include fields/state.md %}        |
| {% f number, 2 %}         | `string`  | {% include fields/number.md %}     |
| {% f amount, 2 %}         | `integer` | {% include fields/amount.md %}                                                                                                                                                                    |
| {% f vatAmount, 2 %}      | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                 |
| {% f description, 2 %}    | `string`  | {% include fields/description.md %}                                                                                                                                  |
| {% f payeeReference, 2 %} | `string`  | {% include fields/payee-reference.md %}                                                                                                                              |
| {% f failedReason, 2 %}   | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| {% f isOperational, 2 %}  | `boolean` | `true`  if the transaction is operational; otherwise  `false` .                                                                                                                                              |
| {% f operations, 2 %}     | `array`   | {% include fields/operations.md %}                                                                                                  |
{% endcapture %}
{% include accordion-table.html content=table %}

## List Reversal Transactions

The `reversals` resource lists the reversal transactions (one or more) on a
specific payment.

{:.code-view-header}
**Request**

```http
GET /psp/creditcard/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md transaction="reversal" %}

## Reversal Sequence Diagram

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>-SwedbankPay: POST [creditcard reversals]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```

{% include abort-reference.md %}

## Remove Payment Token

If you, for any reason, need to delete a paymentToken you use the
`Delete payment token` request.

{% include alert.html type="warning"
                      icon="warning"
                      body="Please note that this call does not erase the card number stored at Swedbank
  Pay. A card number is automatically deleted six months after a successful
  `Delete payment token` request. If you want to remove card information
  beforehand, you need to contact
  [ehandelsetup@swedbankpay.dk](mailto:ehandelsetup@swedbankpay.dk),
  [verkkokauppa.setup@swedbankpay.fi](mailto:verkkokauppa.setup@swedbankpay.fi),
  [ehandelsetup@swedbankpay.no](mailto:ehandelsetup@swedbankpay.no) or
  [ehandelsetup@swedbankpay.se](mailto:ehandelsetup@swedbankpay.se); and supply
  them with the relevant transaction reference or payment token." %}

## Delete Token Request

{:.code-view-header}
**Request**

```http
PATCH /psp/creditcard/payments/instrumentData/{{ page.payment_token }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "state": "Deleted",
  "tokenType" : "PaymentToken",
  "comment": "Comment on why the deletion is happening"
}
```

## Delete Token Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "instrumentData": {
        "id": "/psp/creditcard/payments/instrumentdata/{{ page.payment_token }}",
        "paymentToken": "{{ page.payment_token }}",
        "payeeId": "{{ page.merchant_id }}",
        "isDeleted": true,
        "isPayeeToken": false,
        "cardBrand": "MasterCard",
        "maskedPan": "123456xxxxxx1111",
        "expiryDate": "MM/YYYY"
    }
}
```

{% include iterator.html prev_href="mobile-card-payments" prev_title="Mobile Card Payments"
next_href="features" next_title="Features" %}

[abort]: /old-implementations/payment-instruments-v1/card/after-payment#abort
[callback]: /old-implementations/payment-instruments-v1/card/features/core/callback
[reversal]: /old-implementations/payment-instruments-v1/card/features/core/reversal
[transaction-resource]: /old-implementations/payment-instruments-v1/card/features/technical-reference/transactions
