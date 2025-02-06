## Paid

The payment order response with status `paid`, and the `paid` resource expanded.
Please note that the main code example is of a **Card** payment. We have
included `paid` resources of the remaining methods below the main code
example. Resource examples where details are empty indicate that no details are
available.

The wallets Apple Pay and Vipps do not return `maskedPan`. Please note that
while MobilePay does return this field, the value present is actually a
`networkToken`, which **represents** the PAN, but is not a PAN in itself.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=2.0      // Version optional for 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

### Card `Paid` Resource

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/paid",
    "instrument": "Creditcard",
    "number": 1234567890,
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "tokens": [
      {
        "type": "payment",
        "token": "12345678-1234-1234-1234-1234567890AB",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "recurrence",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "unscheduled",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "transactionsOnFile",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      }
    ],
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "expiryDate": "12/2022",
      "issuerAuthorizationApprovalCode": "L00302",
      "acquirerTransactionType": "STANDARD",
      "acquirerStan": "302",
      "acquirerTerminalId": "70101301389",
      "acquirerTransactionTime": "2022-06-15T14:12:55.029Z",
      "transactionInitiator": "CARDHOLDER",
      "bin": "492500"
    }
  }{% endcapture %}

{% include code-example.html
    title='Card Response'
    header=response_header
    json= response_content
    %}

### Apple Pay `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "ApplePay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "cardBrand": "Visa",
        "cardType": "Credit",
        "expiryDate": "12/2023",
        "issuerAuthorizationApprovalCode": "L00392",
        "acquirerTransactionType": "WALLET",
        "acquirerStan": "392",
        "acquirerTerminalId": "80100001190",
        "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
        "transactionInitiator": "CARDHOLDER",
        "bin": "492500"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Apple Pay Response'
    header=response_header
    json= response_content
    %}

### MobilePay `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/efdcbf77-9a62-426b-a3b1-08da8caf7918/paid",
    "instrument": "MobilePay",
    "number": 75100106637,
    "payeeReference": "1662364327",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "maskedPan": "489537******1424",
        "expiryDate": "12/2022",
        "issuerAuthorizationApprovalCode": "018117",
        "acquirerTransactionType": "MOBILEPAY",
        "acquirerStan": "53889",
        "acquirerTerminalId": "42",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z",
        "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='MobilePay Response'
    header=response_header
    json= response_content
    %}

### Vipps `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/a463b145-3278-4aa0-c4db-08da8f1813a2/paid",
    "instrument": "Vipps",
    "number": 99463794,
    "payeeReference": "1662366424",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "acquirerTransactionType": "WALLET",
        "acquirerTerminalId": "99488282",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z",
        "transactionInitiator": "CARDHOLDER",
        "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Vipps Response'
    header=response_header
    json= response_content
    %}

### Swish `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/b0410cd0-61df-4548-a3ad-08da8caf7918/paid",
    "instrument": "Swish",
    "number": 74100413405,
    "payeeReference": "1662360831",
    "transactionType": "Sale",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
      "misidn": "+46739000001"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Swish Response'
    header=response_header
    json= response_content
    %}

### Invoice `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"paid": {
    "id": "/psp/paymentorders/05a356df-05e2-49e6-8858-08da8cb4d651/paid",
    "instrument": "Invoice",
    "number": 71100775379,
    "payeeReference": "1662360980",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {}
  }
}{% endcapture %}

{% include code-example.html
    title='Invoice Response'
    header=response_header
    json= response_content
    %}

### Installment Account `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"paid": {
    "id": "/psp/paymentorders/39eef759-a619-4c91-885b-08da8cb4d651/paid",
    "instrument": "CreditAccount",
    "number": 77100038000,
    "payeeReference": "1662361777",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {}
  }
}{% endcapture %}

{% include code-example.html
    title='Installment Account Response'
    header=response_header
    json= response_content
    %}

### Trustly `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"paid": {
    "id": "/psp/paymentorders/bf660901-93d0-4245-4e6b-08da8f165366/paid",
    "instrument": "Trustly",
    "number": 79100113652,
    "payeeReference": "1662373401",
    "orderReference": "orderReference",
    "transactionType": "Sale",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
      "trustlyOrderId": 1234567890
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Trustly Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f paid, 0 %}                | `object`     | The paid object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f instrument %}             | `string`     | The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a `capture` is needed, we recommend using `operations` or the `transactionType` field. |
| {% f number, 2 %}         | `integer` | {% include fields/number.md resource="payment" %} |
| {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md %} |
| {% f orderReference, 2 %}          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems. |
| {% f transactionType, 2 %}          | `string` | This will either be set to `Authorization` or `Sale`. Can be used to understand if there is a need for doing a `capture` on this payment order. Swedbank Pay recommends using the different `operations` to figure out if a `capture` is needed. |
| {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                            |
| {% f submittedAmount %}                   | `integer`    | This field will display the initial payment order amount, not including any discounts or fees specific to one payment method. The final payment order amount will be displayed in the `amount` field.                                            |
| {% f feeAmount %}                   | `integer`    | If the payment method used had a unique fee, it will be displayed in this field.                                            |
| {% f discountAmount %}                   | `integer`    | If the payment method used had a unique discount, it will be displayed in this field.                                                |
| {% f tokens %}                   | `integer`    | A list of tokens connected to the payment.                                    |
| {% f type, 2 %}  | `string`   | {% f payment, 0 %}, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| {% f token, 2 %}  | `string`   | The token `guid`. |
| {% f name, 2 %}  | `string`   | The name of the token. In the example, a masked version of a card number. |
| {% f expiryDate, 2 %}  | `string`   | The expiry date of the token. |
| {% f details %}                   | `integer`    | Details connected to the payment. |
| {% f nonPaymentToken, 2 %}         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| {% f externalNonPaymentToken, 2 %} | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token. |
| {% f cardType %}                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| {% f maskedPan %}               | `string`  | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| {% f expiryDate %}              | `string`  | The month and year of when the card expires.                                                                                                                                                                                                                                                         |
| {% f issuerAuthorizationApprovalCode, 2 %} | `string`     | Payment reference code provided by the issuer.                                                                                                                                                                                                                                |
| {% f acquirerTransactionType, 2 %} | `string`     | `3DSECURE` or `STANDARD`. Indicates the transaction type of the acquirer.                                                                                                                                                                                                                                 |
| {% f acquirerStan, 2 %}            | `string`     | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                                                                                                         |
| {% f acquirerTerminalId, 2 %}      | `string`     | The ID of the acquirer terminal.                                                                                                                                                                                                                                                                     |
| {% f acquirerTransactionTime, 2 %} | `string`     | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                                                                                                              |
| {% f transactionInitatior, 2 %} | `string`     | The party which initiated the transaction. `MERCHANT` or `CARDHOLDER`.                                                                                                                                                                                                                                              |
| {% f bin, 2 %} | `string`     | The first six digits of the maskedPan.                                                                                                                                                                                                                                              |
| {% f msisdn, 2 %} | `string`     | The msisdn used in the purchase. Only available when paid with Swish.                                                                                                                                                                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}
