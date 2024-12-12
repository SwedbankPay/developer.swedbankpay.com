Unlike the other payment methods, performing an invoice capture won't move
any funds in itself. It will generate the actual invoice and distribute it to
the payer.

{% if documentation_section contains "invoice" %}
A `capture` can only be performed on a successfully authorized transaction.
It is possible to do a partial `capture` where you only capture a part of the
authorized amount. You can do other captures on the same payment later, up to
the total authorized amount.
{% endif %}

## Step 1: Create The Capture Request

To capture a `FinancingConsumer` invoice payment, perform the `create-capture`
operation with the following request body:

{% capture request_header %}POST /psp/invoice/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "activity": "FinancingConsumer",
        "amount": 13500,
        "vatAmount": 2500,
        "payeeReference": "ABC856",
        "receiptReference": "ABC855",
        "description": "description for transaction",
        "itemDescriptions": [
          {
            "amount": 12500,
            "description": "item description 1"
          },
          {
            "amount": 1000,
            "description": "item description 2"
          }
        ],
        "vatSummary": [
          {
            "amount": 12500,
            "vatPercent": 2500,
            "vatAmount": 2500
          },
          {
            "amount": 1000,
            "vatPercent": 0,
            "vatAmount": 0
          }
        ]
  }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture request_table %}
{:.table .table-striped .mb-5}
|     Required     | Parameter name                 | Datatype     | Value (with description)                                                                                                                                                                                                                                                   |
| :--------------: | :----------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %}︎ | `transaction.activity`         | `string`     | FinancingConsumer.                                                                                                                                                                                                                                                         |
| {% icon check %}︎ | `transaction.Amount`           | `integer`    | Amount entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 SEK`, `5000` = `50.00 SEK`.                                                                                                                                                  |
| {% icon check %}︎ | `transaction.vatAmount`        | `integer`    | Amount entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 SEK`, `5000` = `50.00 SEK`.                                                                                                                                                  |
| {% icon check %}︎ | `transaction.payeeReference`   | `string` | The `payeeReference` is the receipt/invoice number if `receiptReference` is not defined, which is a **unique** reference with max 50 characters set by the merchant system. This must be unique for each operation and must follow the regex pattern `[\w-]*`. |
|                  | `transaction.receiptReference` | `string(50)` | The `receiptReference` is a reference from the merchant system. This reference is used as an invoice/receipt number to supplement `payeeReference`.                                                                                                                        |
| {% icon check %}︎ | `transaction.description`      | `string`     | A textual description of the capture                                                                                                                                                                                                                                       |
| {% icon check %}︎ | `itemDescriptions.amount`      | `integer`    | Total price for this order line - entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 SEK`, `5000` = `50.00 SEK`.                                                                                                                       |
| {% icon check %}︎ | `itemDescriptions.description` | `string`     | A textual description of this product                                                                                                                                                                                                                                      |
| {% icon check %}︎ | `vatSummary.amount`            | `integer`    | Total price for this order line - entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 SEK`, `5000` = `50.00 SEK`.                                                                                                                       |
| {% icon check %}︎ | `vatSummary.vatAmount`         | `integer`    | VAT Amount entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 SEK`, `5000` =`50.00 SEK`.                                                                                                                                               |
| {% icon check %}︎ | `vatSummary.vatPercent`        | `integer`     | The percent value of the VAT multiplied by 100. Supported values : `0`, `600`, `800`, `1000`, `1200`, `1400`, `1500`, `2200`, `2400`, `2500`.                                                                                                                                               |
{% endcapture %}
{% include accordion-table.html content = request_table %}

Notes on `FinancingConsumer` captures:

*   The due date is set by Swedbank Pay based on the agreement with merchant.
    Standard due date is 14 days.
*   The invoice number is set by Swedbank Pay.

{% include transaction-response.md transaction="capture" %}

## Step 2: Inspecting The Captures

The `captures` resource lists the capture transactions performed on a
specific invoice payment.

## GET Capture Request

{% capture request_header %}GET /psp/invoice/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

## GET Capture Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/invoice/payments/{{ page.payment_id }}",
    "captures": [{
        "itemDescriptions": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/{{ page.payment_id }}/itemdescriptions"
        },
        "receiptReference": "ABC855",
        "invoiceCopy": "/psp/invoice/payments/{{ page.payment_id }}/captures/{{ page.payment_id }}/invoicecopy",
        "transaction": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/{{ page.payment_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Capture",
            "state": "Failed",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "",
            "isOperational": false,
            "operations": []
        }
    }]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## Capture Flow

```mermaid
sequenceDiagram
  participant SwedbankPay as Swedbank Pay

  Merchant->>SwedbankPay: Post <Invoice captures>
  activate Merchant
  activate SwedbankPay
  SwedbankPay-->>Merchant: transaction resource
  deactivate Merchant
  deactivate SwedbankPay
```
