---
title: Swedbank Pay MobilePay Online Payments – After Payment
sidebar:
  navigation:
  - title: MobilePay Online Payments
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

## Options after posting a payment

*   **Abort**: It is possible to [abort a payment][abort]
    if the payment has no successful transactions.
*   If the payment shown above has a completed `authorization`,
    you will need to implement the `Capture` and `Cancel` requests.
*   For reversals, you will need to implement the `Reversal` request.
*   **If CallbackURL is set**: Whenever changes to the payment occur
    a [Callback request][technical-reference-callback] will be posted to
    the `callbackUrl`, generated when the payment was created.

## Capture

{% include transaction-list-response.md api_resource="mobilepay"
documentation_section="mobile-pay" %}

## Create capture transaction

A `capture` transaction - to withdraw money from the payer's MobilePay - can be
created after a completed authorization by performing the `create-capture`
operation.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
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
|     Required     | Field                    | Type         | Description                                                                                          |
| :--------------: | :----------------------- | :----------- | :--------------------------------------------------------------------------------------------------- |
| {% icon check %}︎ | `transaction`            | `object`     | Object representing the capture transaction.                                                         |
| {% icon check %}︎ | └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md %}                                                            |
| {% icon check %}︎ | └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md %}                                                         |
| {% icon check %}︎ | └➔&nbsp;`description`    | `string`     | A textual description of the capture transaction.                                                    |
| {% icon check %}︎ | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the capture transaction. See [`payeeReference`][payee-reference] for details. |

{% include transaction-response.md api_resource="mobilepay" documentation_section="mobile-pay" %}

## Capture Sequence

`Capture` can only be done on a authorized transaction.
It is possible to do a part-capture where you only capture a smaller amount
than the authorization amount.
You can later do more captures on the same payment up to the total
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

### Create cancellation transaction

Perform the `create-cancel` operation to cancel a previously created payment.
You can only cancel a payment - or part of payment - not yet captured.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.payment_id }}/cancellations HTTP/1.1
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
| {% icon check %}︎ | Field                    | Type         | Description                                                                                               |
| :--------------- | :----------------------- | :----------- | :-------------------------------------------------------------------------------------------------------- |
| {% icon check %}︎ | `transaction`            | `string`     | The transaction object contains information about this cancellation.                                      |
| {% icon check %}︎ | └➔&nbsp;`description`    | `string`     | A textual description of the reason for the cancellation.                                                 |
| {% icon check %}︎ | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the cancellation transaction. See [`payeeReference`][payee-reference] for details. |

{% include transaction-response.md api_resource="mobilepay"
documentation_section="mobile-pay" transaction="cancel" %}

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

{% include transaction-list-response.md api_resource="mobilepay" documentation_section="mobile-pay"
transaction="reversal" %}

## Create reversal transaction

The `create-reversal` operation reverses a previously created and
captured payment.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
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
| {% icon check %}︎ | Field                    | Type         | Description                                                                                           |
| :--------------- | :----------------------- | :----------- | :---------------------------------------------------------------------------------------------------- |
| {% icon check %}︎ | `transaction`            | `integer`    | The reversal `transaction`.                                                                           |
| {% icon check %}︎ | └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md %}                                                             |
| {% icon check %}︎ | └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md %}                                                          |
| {% icon check %}︎ | └➔&nbsp;`description`    | `string`     | A textual description of the capture                                                                  |
| {% icon check %}︎ | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the reversal transaction. See [`payeeReference`][payee-reference] for details. |

{% include transaction-response.md api_resource="mobilepay"
documentation_section="mobile-pay" transaction="reversal"%}

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

{% include abort-reference.md api_resource="mobilepay"
documentation_section="mobile-pay" %}

{% include iterator.html prev_href="redirect"
                         prev_title="Back: Redirect"
                         next_href="other-features"
                         next_title="Next: Other Features" %}

[authorization]: /payments/mobile-pay/redirect#type-of-authorization-intent
[mobilepay-cancel]: /payments/mobile-pay/other-features#cancel-sequence
[mobilepay-capture]: /payments/mobile-pay/other-features#capture-sequence
[mobilepay-reversal]: /payments/mobile-pay/other-features#reversal-sequence
[payee-reference]: /payments/mobile-pay/other-features#payee-reference
[abort]: /payments/mobile-pay/after-payment#abort
[technical-reference-callback]: /payments/mobile-pay/other-features#callback
[technical-reference-payeeReference]: /payments/mobile-pay/other-features#payee-reference
[transaction-resource]: /payments/mobile-pay/other-features#transactions
