## Cancel

The `cancellations` resource lists the cancellation transactions on a
specific payment.

### Create cancellation transaction

Perform the `create-cancel` operation to cancel a previously created payment.
You can only cancel a payment - or part of payment - not yet captured.

{:.code-view-header}
**Request**

```http
POST /psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/cancellations HTTP/1.1
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
| {% icon check %}︎ | Field                    | Type         | Description                                                                           |
| :--------------- | :----------------------- | :----------- | :------------------------------------------------------------------------------------ |
| {% icon check %}︎ | `transaction`            | `string`     | The transaction object contains information about this cancellation.                  |
| {% icon check %}︎ | └➔&nbsp;`description`    | `string`     | A textual description of the reason for the cancellation.                             |
| {% icon check %}︎ | └➔&nbsp;`payeeReference` | `string(50)` | {% include field-description-payee-reference.md documentation_section=include.documentation_section %} |

{% include transaction-response.md api_resource=include.api_resource
documentation_section=include.documentation_section transaction="cancel" %}

### Cancel Sequence

Cancel can only be done on a authorized transaction.
If you do cancel after doing a part-capture you will cancel the different
between the capture amount and the authorization amount.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    Merchant->>SwedbankPay: POST < {{ include.api_resource }} cancellation>
    activate Merchant
    activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    deactivate SwedbankPay
    deactivate Merchant
```
