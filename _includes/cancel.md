## Cancel

The `cancellations` resource lists the cancellation transactions on a
specific payment.

## Create Cancel Transaction

{% if documentation_section contains "checkout-v3" %}

Perform the `cancel` operation to cancel a previously created payment.
You can only cancel a payment - or part of payment - not yet captured.

{% else %}

Perform the `create-cancel` operation to cancel a previously created payment.
You can only cancel a payment - or part of payment - not yet captured.

{% endif %}

## Cancel Request

{% capture request_header %}POST /psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Test Cancellation",
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{:.table .table-striped .mb-5}
| {% icon check %}︎ | Field                    | Type         | Description                                                                           |
| :--------------- | :----------------------- | :----------- | :------------------------------------------------------------------------------------ |
| {% icon check %}︎ | `transaction`            | `string`     | The transaction object contains information about this cancellation.                  |
| {% icon check %}︎ | {% f description %}    | `string`     | A textual description of the reason for the cancellation.                             |
| {% icon check %}︎ | {% f payeeReference %} | `string` | {% include fields/payee-reference.md documentation_section=include.documentation_section %} |

## Cancel Response

{% include transaction-response.md api_resource=include.api_resource
documentation_section=include.documentation_section transaction="cancel" %}

### Cancel Sequence Diagram

Cancel can only be done on a authorized transaction.
If you do cancel after doing a part-capture you will cancel the difference
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
