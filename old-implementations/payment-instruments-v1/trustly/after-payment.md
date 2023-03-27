---
title: After Payment
redirect_from: /payments/trustly/after-payment
menu_order: 1000
---

## Options After Posting A Payment

When you detect that the payer has reached your `completeUrl`, you need to do a
`GET` request on the payment resource, which contains the `id` of the `payment`
generated in the first step, to receive the state of the transaction. You will
also be able to see the available `operations` after posting a payment.

*   **Abort:** It is possible to abort the process if the payment has no
  successful transactions. [See the `abort` description](#abort).
*   For reversals, you will need to implement the `reversal` request.
*   **If CallbackURL is set:** Whenever changes to the payment occur a[Callback
  request][callback-request] will be posted to the `callbackUrl`,which was set
  when the payment was created.

{% include abort-reference.md %}

## Reversals

The `create-reversal` operation will reverse a payment and
refund the amount to the payer. To reverse a payment, perform the
`create-reversal` operation. The HTTP body of the request should look as
follows:

## Reversal Request

{:.code-view-header}
**Request**

```http
POST /psp/trustly/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "activity": "Sale",
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
(one or more) on a specific payment. The URL will be found on a `payment` that has a
successful `sale` operation.

{:.code-view-header}
**Request**

```http
GET /psp/trustly/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md transaction="reversal" %}

## Reversal Sequence Diagram

`Reversal` can only be done on completed Sales transactions.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay
    participant Merchant

    Merchant->>SwedbankPay: Post <Trustly reversals>
    activate Merchant
    activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    deactivate Merchant
    deactivate SwedbankPay
```

{% include iterator.html prev_href="seamless-view" prev_title="Seamless View"
next_href="features" next_title="Features" %}

[callback-request]: /old-implementations/payment-instruments-v1/trustly/features/core/callback
