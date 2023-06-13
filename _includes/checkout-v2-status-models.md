{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}

## Paid

The payment order response with status `paid`, and the `paid` resource expanded.
Please note that the main code example is of a card payment. We have included
`paid` resources of the remaining instruments below the main code example.
Resource examples where details are empty indicate that no details are
available.

The wallets Apple Pay and Vipps do not return `maskedPan`. Please note that
while MobilePay does return this field, the value present is actually a
`networkToken`, which **represents** the PAN, but is not a PAN in itself.

### Card `Paid` Resource

{:.code-view-header}
**Card Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentOrder": {
        "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b",
        "created": "2022-01-07T07:58:26.1300282Z",
        "updated": "2022-01-07T08:17:44.6839034Z",
        "operation": "Purchase",
        "status": "Paid",
        "currency": "SEK",
        "transactionType": "Authorization",
        "amount": 1500,
        "submittedAmount": 1500,
        "feeAmount": 0,
        "discountAmount": 0,
        "vatAmount": 375,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "Invoice-PayMonthlyInvoiceSe",
            "Swish",
            "CreditAccount",
            "Trustly"
        ],{% if documentation_section contains "checkout-v3/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect", {% endif %}
        "instrumentMode": false,
        "guestMode": false,
        "orderItems": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/orderitems"
        },
        "urls": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/payers"
        },
        "history": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/history"
        },
        "failed": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/paid",
            "instrument": "CreditCard",
            "number": 99101548603,
            "payeeReference": "1641542301",
            "amount": 1500,
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
        },
        "cancelled": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/metadata"
        }
    },
    "operations": [
        {
            "method": "POST",
            "href": "https://api.internaltest.payex.com/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/cancellations",
            "rel": "cancel",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.internaltest.payex.com/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/captures",
            "rel": "capture",
            "contentType": "application/json"
        },{% if include.integration_mode=="redirect" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        }{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        }{% endif %}
    ]
}
```

### Apple Pay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Apple Pay Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "cardType": "Credit",
        "expiryDate": "12/0023",
        "issuerAuthorizationApprovalCode": "L00392",
        "acquirerTransactionType": "WALLET",
        "acquirerStan": "392",
        "acquirerTerminalId": "80100001190",
        "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
        "transactionInitiator": "CARDHOLDER"
        "bin": "489537"
    }
  }
}
```

### MobilePay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**MobilePay Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
        "acquirerTransactionTime": "2022-09-05T09:54:05Z"
        "bin": "489537"
    }
  }
}
```

### Vipps `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Vipps Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/a463b145-3278-4aa0-c4db-08da8f1813a2/paid",
    "instrument": "Vipps",
    "number": 99463794,
    "payeeReference": "1662366424",
    "amount": 1500,
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890"
        "cardBrand": "Visa",
        "acquirerTransactionType": "WALLET",
        "acquirerTerminalId": "99488282",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z",
        "transactionInitiator": "CARDHOLDER",
        "bin": "489537"
    }
  }
}
```

### Swish `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Swish Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
}
```

### Invoice `Paid` Resource

Please note that this is an abbreviated example. See the main `Paid` example for
more context.

{:.code-view-header}
**Invoice Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
}
```

### Credit Account `Paid` Resource

Please note that this is an abbreviated example. See the main `Paid` example for
more context.

{:.code-view-header}
**Credit Account Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
}
```

### Trustly `Paid` Resource

Please note that this is an abbreviated example. See the main `Paid` example for
more context.

{:.code-view-header}
**Trustly Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
    "details": {}
  }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description    |
| :----------------------- | :----------- | :------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | {% include fields/operation.md %}                                                                                                                                                                                                                |
| {% f status %}          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. [See the `Paid` section for further information]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in the failed section. `Cancelled` is returned when an authorized amount has been fully cancelled. It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment or if the payer cancelled the payment in the redirect integration (on the redirect page). |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of instruments available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Checkout v3 implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Checkout v3 integration type. `HostedView` (Seamless View) or `Redirect`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the integration types might be subject to name changes. If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment instrument available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Enterprise implementation, this is triggered by not including a `payerReference` or `nationalIdentifier` in the original payment order request.                                                                                                                                                   |
| {% f payer %}         | `string`     | The URL to the `payer` resource where information about the payer can be retrieved.                                                                                                                 |
| {% f orderItems %}     | `string`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f history %}     | `string`     | The URL to the `history` resource where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `string`     | The URL to the `failed` resource where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `string`     | The URL to the `aborted` resource where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}                | `object`     | The paid object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f instrument %}             | `string`     | The payment instrument used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a `capture` is needed, we recommend using `operations` or the `transactionType` field. |
| {% f number, 2 %}         | `integer`  | {% include fields/number.md resource="paymentorder" %} |
| {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md %} |
| {% f transactionType, 2 %}          | `string` | This will either be set to `Authorization` or `Sale`. Can be used to understand if there is a need for doing a capture on this payment order. Swedbank Pay recommends using the different operations to figure out if a capture is needed. |
| {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                            |
| {% f remainingCaptureAmount %}      | `integer`    | The remaining authorized amount that is still possible to capture.                                                                                                                                                                             |
| {% f remainingCancellationAmount %}      | `integer`    | The remaining authorized amount that is still possible to cancel.                                                                                                                                                                             |
| {% f submittedAmount %}                   | `integer`    | This field will display the initial payment order amount, not including any instrument specific discounts or fees. The final payment order amount will be displayed in the `amount` field.                                            |
| {% f feeAmount %}                   | `integer`    | If the payment instrument used had a unique fee, it will be displayed in this field.                                            |
| {% f discountAmount %}                   | `integer`    | If the payment instrument used had a unique discount, it will be displayed in this field.                                                |
| {% f details %}                   | `integer`    | Details connected to the payment. |
| {% f nonPaymentToken, 2 %}         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| {% f externalNonPaymentToken, 2 %} | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token. |
| {% f cardType, 2 %}                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| {% f maskedPan, 2 %}               | `string`  | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| {% f expiryDate, 2 %}              | `string`  | The month and year of when the card expires.                                                                                                                                                                                                                                                         |
| {% f issuerAuthorizationApprovalCode, 2 %} | `string`     | Payment reference code provided by the issuer.                                                                                                                                                                                                                                |
| {% f acquirerTransactionType, 2 %} | `string`     | `3DSECURE` or `STANDARD`. Indicates the transaction type of the acquirer.                                                                                                                                                                                                                                 |
| {% f acquirerStan, 2 %}            | `string`     | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                                                                                                         |
| {% f acquirerTerminalId, 2 %}      | `string`     | The ID of the acquirer terminal.                                                                                                                                                                                                                                                                     |
| {% f acquirerTransactionTime, 2 %} | `string`     | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                                                                                                              |
| {% f transactionInitatior, 2 %} | `string`     | The party which initiated the transaction. `MERCHANT` or `CARDHOLDER`.                                                                                                                                                                                                                                              |
| {% f bin, 2 %} | `string`     | The first six digits of the maskedPan.                                                                                                                                                                                                                                              |
| {% f msisdn, 2 %} | `string`     | The msisdn used in the purchase. Only available when paid with Swish.                                                                                                                                                                                                                                              |
| {% f cancelled %}     | `string`     | The URL to the `cancelled` resource where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `string`     | The URL to the `financialTransactions` resource where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `string`     | The URL to the `failedAttempts` resource where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `string`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}     | `array`      | {% include fields/operations.md %} As this is a paid payment, the available operations are `capture`, `cancel` and `redirect-checkout` or `view-checkout`, depending on the integration. [See Operations for details]({{ features_url }}/technical-reference/operations)
{% endcapture %}
{% include accordion-table.html content=table %}

If there e.g. is a recurrence or an unscheduled (below) token connected to the
payment, it will appear like this.

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
        "paid": {
            "id": "/psp/paymentorders/91c3ca0d-3710-40f0-0f78-08d9d133750b/paid",
            "instrument": "CreditCard",
            "number": 99101548605,
            "payeeReference": "1641543637",
            "amount": 1500,
            "tokens": [
                {
                    "type": "recurrence",
                    "token": "48806524-6422-4db7-9fbd-c8b81611132f",
                    "name": "492500******0004",
                    "expiryDate": "02/2023"
                }
            ],
            "details": {}
        }
}
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
        "paid": {
            "id": "/psp/paymentorders/9f786139-3537-4a8b-0f79-08d9d133750b/paid",
            "instrument": "CreditCard",
            "number": 99101548607,
            "payeeReference": "1641543818",
            "amount": 1500,
            "tokens": [
                {
                    "type": "Unscheduled",
                    "token": "6d495aac-cb2b-4d94-a5f1-577baa143f2c",
                    "name": "492500******0004",
                    "expiryDate": "02/2023"
                }
            ],
            "details": {}
        }
}
```

Response fields introduced in this section:

{:.table .table-striped}
| Field                    | Type         | Description    |
| :----------------------- | :----------- | :------------------------------ |
| {% f tokens %}                   | `integer`    | A list of tokens connected to the payment.                                                   |
| {% f type, 2 %}  | `string`   | {% f payment, 0 %}, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| {% f token, 2 %}  | `string`   | The token `guid`. |
| {% f name, 2 %}  | `string`   | The name of the token. In the example, a masked version of a card number. |
| {% f expiryDate, 2 %}  | `string`   | The expiry date of the token. |
