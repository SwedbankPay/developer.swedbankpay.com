---
title: Swedbank Pay Trustly Payments – After Payment
sidebar:
  navigation:
  - title: Trustly Payments
    items:
    - url: /payments/trustly
      title: Introduction
    - url: /payments/trustly/redirect
      title: Redirect
    - url: /payments/trustly/seamless-view
      title: Seamless View
    - url: /payments/trustly/after-payment
      title: After Payment
    - url: /payments/trustly/other-features
      title: Other Features
---

## Options after posting a payment

When you detect that the payer has reached your `completeUrl`, you need to do a
`GET` request on the payment resource, which contains the `id` of the `payment`
generated in the first step, to receive the state of the transaction. You will
also be able to see the available `operations` after posting a payment.

*   **Abort:** It is possible to abort the process if the payment has no
    successful transactions. [See the `abort`
    description][abort-description].
*   For reversals, you will need to implement the `reversal` request.
*   **If CallbackURL is set:** Whenever changes to the payment occur a
    [Callback request][callback-request] will be posted to the `callbackUrl`,
    which was set when the payment was created.

{% include abort-reference.md api_resource="trustly" %}

## Reversals

### Create reversal transaction

The `create-reversal` operation will reverse a payment and
refund the amount to the consumer. To reverse a payment, perform the
`create-reversal` operation. The HTTP body of the request should look as
follows:

{:.code-header}
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
| {% icon check %}︎ | └➔&nbsp;`activity`         | `string`     | `FinancingConsumer`.                                                                                                                                                                                                                                                       |
| {% icon check %}︎ | └➔&nbsp;`amount`           | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                  |
| {% icon check %}︎ | └➔&nbsp;`vatAmount`        | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                               |
| {% icon check %}︎ | └➔&nbsp;`payeeReference`   | `string(50)` | The `payeeReference` is the receipt/invoice number if `receiptReference` is not defined, which is a **unique** reference with max 50 characters set by the merchant system. This must be unique for each operation and must follow the regex pattern `[\w]* (a-zA-Z0-9_)`. |
|                  | └➔&nbsp;`receiptReference` | `string(50)` | The `receiptReference` is a reference from the merchant system. This reference is used as an invoice/receipt number.                                                                                                                                                       |
| {% icon check %}︎ | └➔&nbsp;`description`      | `string`     | A textual description of the reversal.                                                                                                                                                                                                                                     |

The `reversal` resource will be returned, containing information about the newly created reversal transaction.

{% include transaction-response.md api_resource="trustly"
documentation_section="trustly" transaction="reversal" %}

### Inspecting the Reversal

The `reversals` resource will list the reversal transactions
(one or more) on a specific payment. The URI will be found on a `payment` that has a
succesful `sale` operation.

{:.code-header}
***Request***

```http
GET /psp/trustly/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md api_resource="trustly" documentation_section="trustly" transaction="reversal" %}

### Reversal Sequence

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

## Cancellations

The `cancellations` resource lists the cancellation transactions on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/trustly/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md api_resource="trustly"
documentation_section="vipps" transaction="cancel" %}

## Create cancellation transaction

A payment may be cancelled if the operation `create-cancellation` is available.

{:.code-header}
**Request**

```http
POST /psp/trustly/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "payeeReference": "testabc",
        "description" : "description for transaction"
    }
}
```

{% include transaction-response.md api_resource="trustly"
documentation_section="trustly" transaction="cancel" %}

{% include iterator.html prev_href="seamless-view" prev_title="Back: Seamless View"
next_href="other-features" next_title="Next: Other Features" %}

----------------------------------------------------------
[abort-description]: #abort
[callback-request]: /payments/trustly/other-features#callback
[trustly-cancellations]: /payments/trustly/after-payment#cancellations
[trustly-reversals]: /payments/trustly/after-payment##reversals
[other-features-transaction]: /payments/trustly/other-features#transactions
