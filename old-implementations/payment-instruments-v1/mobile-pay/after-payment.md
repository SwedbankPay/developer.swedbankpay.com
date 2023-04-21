---
title: After Payment
redirect_from: /payments/mobile-pay/after-payment
menu_order: 900
---

## Options After Posting A Payment

*   **Abort**: It is possible to [abort a payment][abort] if the payment has no
    successful transactions.
*   If the payment shown above has a completed `authorization`, you will need to
    implement the `Capture` and `Cancel` requests.
*   For reversals, you will need to implement the `Reversal` request.
*   **If CallbackURL is set**: Whenever changes to the payment occur a [Callback
    request][technical-reference-callback] will be posted to the `callbackUrl`,
    generated when the payment was created.

## Cancellations

The `cancellations` resource lists the cancellation transactions on a
specific payment.

## Create Cancel Transaction

Perform the `create-cancel` operation to cancel a previously created payment.
You can only cancel a payment - or part of payment - not yet captured.

## Cancel Request

{:.code-view-header}
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

{% capture table %}
{:.table .table-striped .mb-5}
| {% icon check %}︎ | Field                    | Type         | Description                                                                           |
| :--------------- | :----------------------- | :----------- | :------------------------------------------------------------------------------------ |
| {% icon check %}︎ | `transaction`            | `string`     | The transaction object contains information about this cancellation.                  |
| {% icon check %}︎ | {% f description %}    | `string`     | A textual description of the reason for the cancellation.                             |
| {% icon check %}︎ | {% f payeeReference %} | `string(50)` | {% include fields/payee-reference.md %} |
{% endcapture %}
{% include accordion-table.html content=table %}

## Cancel Response

{% include transaction-response.md transaction="cancel" %}

## Cancel Sequence Diagram

Cancel can only be done on a authorized transaction.
If you do cancel after doing a part-capture you will cancel the different
between the capture amount and the authorization amount.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    Merchant->>SwedbankPay: POST <mobilepay cancellation>
    activate Merchant
    activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    deactivate SwedbankPay
    deactivate Merchant
```

## Reversals

{% include transaction-list-response.md transaction="reversal" %}

### Create Reversal Transaction

The `create-reversal` operation reverses a previously created and
captured payment.

## Reversal Request

{:.code-view-header}
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

{% capture table %}
{:.table .table-striped .mb-5}
| {% icon check %}︎ | Field                    | Type         | Description                                                                           |
| :--------------- | :----------------------- | :----------- | :------------------------------------------------------------------------------------ |
| {% icon check %}︎ | `transaction`            | `integer`    | The reversal `transaction`.                                                           |
| {% icon check %}︎ | {% f amount %}         | `integer`    | {% include fields/amount.md %}                                             |
| {% icon check %}︎ | {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                          |
| {% icon check %}︎ | {% f description %}    | `string`     | A textual description of the capture                                                  |
| {% icon check %}︎ | {% f payeeReference %} | `string` | {% include fields/payee-reference.md %} |
{% endcapture %}
{% include accordion-table.html content=table %}

## Reversal Response

{% include transaction-response.md transaction="reversal"%}

## Reversal Sequence

Reversal can only be done on a payment where there are some
captured amount not yet reversed.

```mermaid
sequenceDiagram
  participant SwedbankPay as Swedbank Pay

  Merchant->>SwedbankPay: POST <mobilepay reversal>
  activate Merchant
  activate SwedbankPay
  SwedbankPay-->>Merchant: transaction resource
  deactivate SwedbankPay
  deactivate Merchant
```

{% include abort-reference.md %}

{% include iterator.html prev_href="seamless-view"
                         prev_title="Seamless View"
                         next_href="features"
                         next_title="Features" %}

[abort]: /old-implementations/payment-instruments-v1/mobile-pay/after-payment#abort
[technical-reference-callback]: /old-implementations/payment-instruments-v1/mobile-pay/features/core/callback
