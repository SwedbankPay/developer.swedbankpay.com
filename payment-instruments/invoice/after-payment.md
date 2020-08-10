---
title: After Payment
redirect_from: /payments/invoice/after-payment
estimated_read: 11
menu_order: 900
---

## Options after posting a payment

When you detect that the payer has reached your `completeUrl`, you need to do a
GET request on the payment resource, which contains the paymentID generated in
the first step, to receive the state of the transaction. You will also be able
to see the available operations after posting a payment.

*   **Abort:** It is possible to abort the process if the payment has no
  successful transactions. [See the `abort`
  description][abort-description].
*   An invoice authorization must be followed by a `capture` or
  `cancel` request.
*   For reversals, you will need to implement the `reversal` request.
*   **If CallbackURL is set:** Whenever changes to the payment occur a [Callback
  request][callback-request] will be posted to the callbackUrl, which was
  generated when the payment was created.

{% include abort-reference.md %}

## Cancellations

### Create cancel transaction

Perform the `create-cancellation` operation to cancel a previously authorized
or partially captured invoice payment.

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

The `cancel` resource will be returned, containing information about the
newly created `cancel` transaction.

{% include transaction-response.md transaction="cancel" %}

### Inspecting the Cancellation

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

### Create reversal transaction

The `create-reversal` operation will reverse a previously captured payment and
refund the amount to the payer. To reverse a payment, perform the
`create-reversal` operation. The HTTP body of the request should look as
follows:

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
| {% icon check %}︎ | └➔&nbsp;`activity`         | `string`     | `FinancingConsumer`.                                                                                                                                                                                                                                                       |
| {% icon check %}︎ | └➔&nbsp;`amount`           | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                  |
| {% icon check %}︎ | └➔&nbsp;`vatAmount`        | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                               |
| {% icon check %}︎ | └➔&nbsp;`payeeReference`   | `string(50)` | The `payeeReference` is the receipt/invoice number if `receiptReference` is not defined, which is a **unique** reference with max 50 characters set by the merchant system. This must be unique for each operation and must follow the regex pattern `[\w-]*`. |
|                  | └➔&nbsp;`receiptReference` | `string(50)` | The `receiptReference` is a reference from the merchant system. This reference is used as an invoice/receipt number.                                                                                                                                                       |
| {% icon check %}︎ | └➔&nbsp;`description`      | `string`     | A textual description of the reversal.                                                                                                                                                                                                                                     |

The `reversal` resource will be returned, containing information about the newly created reversal transaction.

{% include transaction-response.md transaction="reversal" %}

### Inspecting the Reversal

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

### Reversal Sequence

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
next_href="other-features" next_title="Other Features" %}

----------------------------------------------------------
[abort-description]: #abort
[callback-request]: /payment-instruments/invoice/other-features#callback
[invoice-captures]: #captures
[invoice-cancellations]: #cancellations
[invoice-reversals]: #reversals
[other-features-transaction]: /payment-instruments/invoice/other-features#transactions
