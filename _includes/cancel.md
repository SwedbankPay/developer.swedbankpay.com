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

{% capture request_table%}
{:.table .table-striped .mb-5}
| {% icon check %}︎ | Field                    | Type         | Description                                                                           |
| :--------------- | :----------------------- | :----------- | :------------------------------------------------------------------------------------ |
| {% icon check %}︎ | `transaction`            | `string`     | The transaction object contains information about this cancellation.                  |
| {% icon check %}︎ | └➔&nbsp;`description`    | `string`     | A textual description of the reason for the cancellation.                             |
| {% icon check %}︎ | └➔&nbsp;`payeeReference` | `string` | {% include fields/payee-reference.md documentation_section=include.documentation_section %} |
{% endcapture %}
{% include accordion-table.html content = request_table
%}

## Cancel Response

{% include transaction-response.md api_resource=include.api_resource
documentation_section=include.documentation_section transaction="cancel" %}

### Cancel Sequence Diagram

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
