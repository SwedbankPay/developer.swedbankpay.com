## Financing Consumer

A `FinancingConsumer` payment is an invoice.

{:.code-view-header}
**Request**

```http
POST /psp/invoice/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
{
    "payment": {
        "operation": "FinancingConsumer",
        "intent": "<intent>",
        "currency": "NOK",
        "prices": [
            {
                "type": "Invoice",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "generateRecurrenceToken": "false",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "http://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "PR123",
            "payeeName": "Merchant1",
            "productCategory": "PC1234",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
        }
    },
    "invoice": {
        "invoiceType": "PayExFinancingNo"
    }
}
```

## API requests

The options you can choose from when creating a payment with key operation
set to value `FinancingConsumer` are listed below.

### Options before posting a payment

{:.table .table-striped}
|               | Norway {% flag no %} | Finland {% flag fi %} | Sweden {% flag se %} |
| :------------ | :------------------- | :-------------------- | :------------------- |
| `operation`   | `FinancingConsumer`  | `FinancingConsumer`   | `FinancingConsumer`  |
| `currency`    | `NOK`                | `EUR`                 | `SEK`                |
| `invoiceType` | `PayExFinancingNO`   | `PayExFinancingFI`    | `PayExFinancingSE`   |

*   An invoice payment is always two-phased based -  you create an Authorize
  transaction that is followed by a Capture or Cancel request.
