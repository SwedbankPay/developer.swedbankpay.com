---
title: After Payment
redirect_from: /payments/invoice/after-payment
menu_order: 900
---

## Options After Posting A Payment

When you detect that the payer has reached your `completeUrl`, you need to do a
GET request on the payment resource, which contains the paymentID generated in
the first step, to receive the state of the transaction. You will also be able
to see the available operations after posting a payment.

*   **Abort:** It is possible to abort the process if the payment has no
  successful transactions. [See the `abort` description](#abort).
*   An invoice authorization must be followed by a `capture` or
  `cancel` request.
*   For reversals, you will need to implement the `reversal` request.
*   **If CallbackURL is set:** Whenever changes to the payment occur a [Callback
  request][callback-request] will be posted to the callbackUrl, which was
  generated when the payment was created.

{% include abort-reference.md %}

## Cancellations

Perform the `create-cancellation` operation to cancel a previously authorized
or partially captured invoice payment.

## Cancel Request

{:.code-view-header}
***Request***

```http
POST /psp/invoice/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "activity": "FinancingConsumer",
        "payeeReference": "customer order reference-unique",
        "description": "description for transaction"
    }
}
```

{:.table .table-striped}
|     Required     | Parameter name               | Datatype     | Value (with description)                                                                                                                                                                                                              |
| :--------------: | :--------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %}︎ | `transaction.activity`       | `string`     | `FinancingConsumer`.                                                                                                                                                                                                                  |
| {% icon check %}︎ | `transaction.payeeReference` | `string`     | The `payeeReference` is the receipt/invoice number, which is a **unique** reference with max 50 characters set by the merchant system. This must be unique for each operation and must follow the regex pattern `[\w-]*`. |
| {% icon check %}︎ | `transaction.description`    | `string(50)` | A textual description for the cancellation.                                                                                                                                                                                           |

## Cancel Response

The `cancel` resource will be returned, containing information about the
newly created `cancel` transaction.

{% include transaction-response.md transaction="cancel" %}

### List Cancel Transactions

The `cancellations` resource lists the cancellation transaction made on a
specific payment.

{:.code-view-header}
**Request**

```http
GET /psp/invoice/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md transaction="cancel" %}

### Cancel Sequence

A `cancel` can only be performed on a successfully authorized transaction which
has not been captured yet. If you perform a cancellation after doing a partial
capture, you will only cancel the remaining authorized amount.

```mermaid
sequenceDiagram
  participant SwedbankPay as Swedbank Pay

  Merchant->>SwedbankPay: Post <Invoice cancellations>
  activate Merchant
  activate SwedbankPay
  SwedbankPay-->>Merchant: transaction resource
  deactivate Merchant
  deactivate SwedbankPay
```

## Reversals

The `create-reversal` operation will reverse a previously captured payment and
refund the amount to the payer. To reverse a payment, perform the
`create-reversal` operation.

## Reversal Request

{:.code-view-header}
**Request**

```http
POST /psp/invoice/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "activity": "FinancingConsumer",
        "amount": 1500,
        "vatAmount": 0,
        "payeeReference": "ABC856",
        "receiptReference": "ABC855",
        "description": "description for transaction"
    }
}
```

{:.table .table-striped}
|     Required     | Field                      | Type         | Description                                                                                                                                                                                                                                                                |
| :--------------: | :------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %}︎ | `transaction`              | `object`     | The transaction object containing details about the reversal transaction.                                                                                                                                                                                                  |
| {% icon check %}︎ | {% f activity %}         | `string`     | `FinancingConsumer`.                                                                                                                                                                                                                                                       |
| {% icon check %}︎ | {% f amount %}           | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                  |
| {% icon check %}︎ | {% f vatAmount %}        | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                                                                               |
| {% icon check %}︎ | {% f payeeReference %}   | `string` | The `payeeReference` is the receipt/invoice number if `receiptReference` is not defined, which is a **unique** reference with max 50 characters set by the merchant system. This must be unique for each operation and must follow the regex pattern `[\w-]*`. |
|                  | {% f receiptReference %} | `string(50)` | {% include fields/receipt-reference.md %}                                                                                                                                                       |
| {% icon check %}︎ | {% f description %}      | `string`     | A textual description of the reversal.                                                                                                                                                                                                                                     |

## Reversal Response

The `reversal` resource will be returned, containing information about the newly created reversal transaction.

{% include transaction-response.md transaction="reversal" %}

## List Reversal Transactions

The `reversals` resource will list the reversal transactions
(one or more) on a specific payment.

{:.code-view-header}
***Request***

```http
GET /psp/invoice/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md transaction="reversal" %}

## Reversal Sequence

`Reversal` can only be done on an captured transaction where there are
some captured amount not yet reversed.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    Merchant->>SwedbankPay: Post <Invoice reversals>
    activate Merchant
    activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    deactivate Merchant
    deactivate SwedbankPay
```

{% include iterator.html prev_href="capture" prev_title="Capture"
next_href="features" next_title="Features" %}

[callback-request]: /old-implementations/payment-instruments-v1/invoice/features/core/callback
