### Create authorization transaction

The `direct-authorization` operation creates an authorization transaction
directly whilst the `redirect-authorization` operation redirects the consumer to
a Swedbank Pay hosted payment page, where the payment is authorized by the
consumer.

{% include alert.html type="warning" icon="warning" header="PCI-DSS Complicance"
body="In order to use the `direct-authorization` operation, you need to collect
card data on your website, which means it must be [PCI-DSS
Compliant](https://www.pcisecuritystandards.org/)." %}

{:.code-header}
**Request**

```http
POST /psp/creditcard/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "NOK",
        "prices": [
            {
                "type": "CreditCard",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.pdf",
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant",
            "productCategory": "A123"
        }
}
```

{:.table .table-striped}
| Required | Field                       | Type      | Description                                                                     |
| :------: | :----------------------------- | :-------- | :------------------------------------------------------------------------------ |
|  ✔︎︎︎︎︎  | `transaction`                  | `object`  | The transaction object.                                                         |
|  ✔︎︎︎︎︎  | └➔&nbsp;`cardNumber`           | `string`  | Primary Account Number (PAN) of the card, printed on the face of the card.      |
|  ✔︎︎︎︎︎  | └➔&nbsp;`cardExpiryMonth`      | `integer` | Expiry month of the card, printed on the face of the card.                      |
|  ✔︎︎︎︎︎  | └➔&nbsp;`cardExpiryYear`       | `integer` | Expiry year of the card, printed on the face of the card.                       |
|          | └➔&nbsp;`cardVerificationCode` | `string`  | Card verification code (CVC/CVV/CVC2), usually printed on the back of the card. |
|          | └➔&nbsp;`cardholderName`       | `string`  | Name of the card holder, usually printed on the face of the card.               |

**Response**

The `authorization` resource contains information about an authorization
transaction made towards a payment, as previously described.
