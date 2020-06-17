### Operation `paid-payment`

The `paid-payment` operation confirms that the transaction has been successful
and that the payment is completed. Under `details` you can see which card was
used to complete the payment. 

{:.code-header}
**Response**

```http
GET /psp/creditcard/payments/{{ site.payment_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": "/psp/{{ api_resource }}/payments/{{ site.payment_id }}",
  "paid": {
    "id": "/psp/{{ api_resource }}/payments/{{ site.payment_id }}/paid",
    "number": 1234567890,
    "transaction": {
      "id": "/psp{{ api_resource }}/payments/{{ site.payment_id }}/transactions/{{ site.transaction_id }}",
      "number" : 1234567891
    },
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "amount": 1500,
    "tokens": [
      {
        "type": "payment",
        "token": "{{ page.payment_token }}",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "recurrence",
        "token": "{{ page.payment_token }}",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "transactionsOnFile",
        "token": "{{ page.payment_token }}",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      }
    ],
    "details": {
      "cardBrand": "Visa",
      "MaskedPan": "4925xxxxxx000004",
      "cardType": "Credit",
      "issuingBank": "UTL MAESTRO",
      "countryCode": "999",
      "acquirerTransactionType": "3DSECURE",
      "issuerAuthorizationApprovalCode": "397136",
      "acquirerStan": "39736",
      "acquirerTerminalId": "39",
      "acquirerTransactionTime": "2017-08-29T13:42:18Z",
      "nonPaymentToken" : "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken" : "1234567890",
      "transactionInitiator" : "MERCHANT"    
    }
  }
}
```

{:.table .table-striped}
| Field                             | Type      | Description                                                                                                                                                                                                  |
| :-------------------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                         | `string`  | {% include field-description-id.md sub_resource=transaction %}                                                                                                                                               |
| └➔&nbsp;`transaction`                     | `string`  | The transaction object, containing information about the current transaction.                                                                                                                                |
| └─➔&nbsp;`id`                     | `string`  | {% include field-description-id.md resource=transaction %}                                                                                                                                                   | 
| └─➔&nbsp;`number`                 | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead.                                                                                                                                                               |
| └➔&nbsp;`payeeReference`          | `string`  | A unique reference for the transaction.                                                                                                                                                                      | 
| └➔&nbsp;`orderReference`          | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                  |                                                             
| └➔&nbsp;`amount`                  | `integer` | {% include field-description-amount.md %}                                                                                                                                                                    |
| └➔&nbsp;`tokens`                  | `integer` | List of tokens generated.                                                                                                                                                                                    |
| └➔&nbsp;`details`                 | `integer` | A human readable and descriptive text of the payment.                                                                                                                                                       | 
| └─➔&nbsp;`cardBrand`              | `string`  | `Visa`, `MC`, etc. The brand of the card.                                                                                                                                                                    |      
| └─➔&nbsp;`maskedPan`              | `string`  | The masked PAN number of the card.                                                                                                                                                                           | 
| └─➔&nbsp;`cardType`               | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                        |
| └─➔&nbsp;`issuingBank`            | `string`  | The name of the bank that issued the card used for the authorization.                                                                                                                                        |
| └─➔&nbsp;`countryCode`            | `string`  | The country the card is issued in.                                                                                                                                                                           |
| └─➔&nbsp;`acquirerTransactionType`| `string`  | `3DSECURE` or `SSL`. Indicates the transaction type of the acquirer.                                                                                                                                         |
| └─➔&nbsp;`acquirerStan`           | `string`  | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                 |
| └─➔&nbsp;`acquirerTerminalId`     | `string`  | The ID of the acquirer terminal.                                                                                                                                                                             |
| └─➔&nbsp;`acquirerTransactionTime`| `string`  | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                      |
| └─➔&nbsp;`nonPaymentToken`        | `string`  |  Result of our own tokenization of the card used. Activated in POS on merchant or merchant group.                                                                                                            |
| └─➔&nbsp;`externalNonPaymentToken`| `string`  | Result of external tokenization. This value varies depending on cards, acquirer, customer, etc. For ICA cards, the token comes in response from Swedbank. For Mass Transit(SL) it is populated with PAR if it comes in response from the redeemer (Visa). If not, our own token (Mastercard / Amex).                                                                                                                                                      |
