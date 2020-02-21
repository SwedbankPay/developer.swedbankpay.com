### Create authorization transaction

The `direct-authorization` operation creates an authorization transaction
directly whilst the `redirect-authorization` operation redirects the consumer to
a Swedbank Pay hosted payment page, where the payment is authorized by the
consumer.

{% include alert.html type="warning" icon="warning" header="Note" body="In order
to use the `direct-authorization` operation, the servers and application
involved in retrieving and transferring the credit card number from the payer to
Swedbank Pay needs to be [PCI DSS](https://www.pcisecuritystandards.org/)
certified." %}

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
            "hostUrls": [ "http://example.com", "http://example.net" ],
            "completeUrl": "http://example.com/payment-completed",
            "cancelUrl": "http://example.com/payment-canceled",
            "callbackUrl": "http://example.com/payment-callback",
            "logoUrl": "http://example.com/payment-logo.png",
            "termsOfServiceUrl": "http://example.com/payment-terms.pdf",
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
| Required | Property                       | Type      | Description                                                                     |
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
