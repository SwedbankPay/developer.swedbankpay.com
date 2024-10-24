{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{%- capture url -%}
    {%- include utils/documentation-section-url.md
        href='/features/technical-reference/resource-sub-models' -%}
{%- endcapture -%}

The `status` field indicates the payment order's current status. `Initialized`
is returned when the payment is created and still ongoing.

The request example above has this status. `Paid` is returned when the payer has
completed the payment successfully.

`Failed` is returned when a payment has failed. You will find an error message
in the failed section.

`Cancelled` is returned when an authorized amount has been **fully** cancelled.

`Reversed` is returned when the full amount of a sale transaction or a captured
transaction has been reversed. The transaction will now have status `Reversed`
instead of `Paid`.

It will contain fields from both the cancelled description and paid section.
`Aborted` is returned when the merchant has aborted the payment or if the payer
cancelled the payment in the redirect integration (on the redirect page).

## Aborted

A payment order response with the status `Aborted`.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd",
        "created": "2022-01-24T10:54:05.6243371Z",
        "updated": "2022-01-24T10:54:19.2679591Z",
        "operation": "Purchase",
        "status": "Aborted",
        "currency": "SEK",
        "amount": 32000,
        "vatAmount": 0,
        "description": "Abort test",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "Invoice-PayMonthlyInvoiceSe",
            "Swish",
            "CreditAccount",
            "Trustly"
        ], {% if documentation_section contains "old-implementations/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect", {% endif %}
        "instrumentMode": false,
        "guestMode": false,
        "orderItems": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/orderitems"
        },
        "urls": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/payers"
        },
        "history": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/history"
        },
        "failed": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/metadata"
        }
    },
    "operations": [ {% if include.integration_mode=="redirect" %}
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
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

Response fields not covered in the [`Initialized`]({{ features_url }}/technical-reference/status-models#initialized) redirect or seamless view
responses:

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f operations %}     | `array`      | {% include fields/operations.md %} As this is an aborted payment, the available operations are `redirect-checkout` or `view-checkout`, depending on the integration. [See Operations for details]({{ features_url }}/technical-reference/operations) |

## Cancelled

The `cancel` response is not yet converted to the new standard.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/paymentorders/payments/{{ page.payment_id }}",
    "cancellation": {
        "id": "/psp/paymentorders/payments/{{ page.payment_id }}/cancellations/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/paymentorders/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2022-01-31T09:49:13.7567756Z",
            "updated": "2022-01-31T09:49:14.7374165Z",
            "type": "Cancellation",
            "state": "Completed",
            "number": 71100732065,
            "amount": 1500,
            "vatAmount": 375,
            "description": "Test Cancellation",
            "payeeReference": "AB123"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Property                  | Type      | Description                                                                                                                                                                                                  |
| :------------------------ | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                 | `string`  | The relative URL of the payment this cancellation transaction belongs to.                                                                                                                                    |
| {% f cancellation, 0 %}            | `object`  | The cancellation object, containing information about the cancellation transaction.                                                                                                                          |
| {% f id %}              | `string`  | The relative URL of the cancellation transaction.                                                                                                                                                            |
| {% f transaction %}     | `object`  | {% include fields/transaction.md %}                                                                                                                                |
| {% f id, 2 %}             | `string`  | The relative URL of the current `transaction` resource.                                                                                                                                                      |
| {% f created, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| {% f updated, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| {% f type, 2 %}           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| {% f state, 2 %}          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| {% f number, 2 %}         | `integer` | {% include fields/number.md %} |
| {% f amount, 2 %}         | `integer` | {% include fields/amount.md %}                                                                                                                                                                    |
| {% f vatAmount, 2 %}      | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                 |
| {% f description, 2 %}    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| {% f payeeReference, 2 %} | `string`  | {% include fields/payee-reference.md describe_receipt=true %}                                                                                         |
{% endcapture %}
{% include accordion-table.html content=table %}

## Failed

The failed response is not yet converted to the new standard.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/paymentorders/payments/{{ page.payment_id }}",
        "failed": {
            "id": "/psp/paymentorders/bc2832a7-0e0f-45f2-57d6-08d9ea4cff66/failed",
            "problem": {
                "type": "acquirerinsufficientfunds",
                "title": "Operation failed",
                "status": 403,
                "detail": "Unable to complete Recurrence transaction, look at problem node!",
                "problems": [
                    {
                        "name": "ExternalResponse",
                        "description": "REJECTED_BY_ACQUIRER_INSUFFICIENT_FUNDS-insufficient funds, response-code: 61"
                    }
                  ]
                }
              }
            }{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description     |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f failed, 0 %}                | `object`     | The failed object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f problem %}             | `object`     | The problem object.  |
| {% f type, 2 %}  | `string`   | The type of problem that occurred. |
| {% f title, 2 %}  | `string`   | The title of the problem that occurred. |
| {% f status, 2 %}              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                              |
| {% f detail, 2 %}              | `string`  | A detailed, human readable description of the error.                                                                                                                                                                |
| {% f problems, 2 %}            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                |
| {% f name %}        | `string`  | The name of the field, header, object, entity or likewise that was erroneous.                                                                                                                                                                       |
| {% f description %} | `string`  | The human readable description of what was wrong with the field, header, object, entity or likewise identified by `name`.                                                                                                                           |
{% endcapture %}
{% include accordion-table.html content=table %}

## Initialized

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b",
        "created": "2022-01-07T07:58:26.1300282Z",
        "updated": "2022-01-07T08:17:44.6839034Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
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
        ],{% if documentation_section contains "old-implementations/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect", {% endif %}
        "instrumentMode": false,
        "guestMode": false,
       "payer": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
        },
        "orderItems": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        },
        "history": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/history"
        },
        "failed": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/failed"
        },
        "aborted": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/aborted"
        },
        "paid": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/paid"
        },
        "cancelled": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/cancelled"
        },
        "financialTransactions": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/financialtransactions"
        },
        "failedAttempts": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/failedattempts"
        },
        "metadata": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/metadata"
        }
      },
    "operations": [ {% if include.integration_mode=="redirect" %}
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
        },{% endif %}
                {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel":"update-order",
          "method":"PATCH",
          "contentType":"application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel": "abort",
          "method": "PATCH",
          "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | {% include fields/operation.md %}                                                                                                                                                                                                                |
| {% f status %}          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. See the [`Paid` section for further information]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in the failed section. [Further information here]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. See the [`Cancel` feature section for further information]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment or if the payer cancelled the payment in the redirect integration (on the redirect page). See the [`Abort` feature section for further information]({{ features_url }}/technical-reference/status-models#aborted). |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Digital Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Digital Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the integration types might be subject to name changes. If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment method available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Enterprise implementation, this is triggered by not including a `payerReference` or `nationalIdentifier` in the original payment order request.                                                                                                                                                   |
| {% f payer %}         | `id`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                 |
| {% f orderItems %}     | `id`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f history %}     | `id`     | The URL to the [`history` resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `id`     | The URL to the [`failed` resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `id`     | The URL to the [`aborted` resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `id`     | The URL to the [`paid` resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `id`     | The URL to the [`cancelled` resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the [`financialTransactions` resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `id`     | The URL to the [`failedAttempts` resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}     | `array`      | {% include fields/operations.md %} As this is an initialized payment, the available operations are `abort`, `update-order` and `redirect-checkout` or `view-checkout`, depending on the integration. [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

## Paid

The payment order response with status `paid`, and the `paid` resource expanded.
Please note that the main code example is of a card payment. We have included
`paid` resources of the remaining payment methods below the main code example.
Resource examples where details are empty indicate that no details are
available.

The wallets Apple Pay and Vipps do not return `maskedPan`. Please note that
while MobilePay does return this field, the value present is actually a
`networkToken`, which **represents** the PAN, but is not a PAN in itself.

### Card `Paid` Resource

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
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
        "paymentTokenGenerated": false,
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
        ],{% if documentation_section contains "old-implementations/enterprise" %}
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
                "paymentAccountReference": "43f6b6d2cbd30c36627ec02247259",
                "cardBrand": "Visa",
                "cardType": "Credit",
                "maskedPan": "492500******0004",
                "maskedDPan": "49250000******04",
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
}{% endcapture %}

{% include code-example.html
    title='Card Response'
    header=response_header
    json= response_content
    %}

### Apple Pay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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
    "paymentTokenGenerated": false,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "cardType": "Credit",
        "maskedDPan": "49250000******04",
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
}{% endcapture %}

{% include code-example.html
    title='Apple Pay Response'
    header=response_header
    json= response_content
    %}

### Click to Pay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "ClickToPay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "paymentTokenGenerated": false,
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "49250000******04",
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
}{% endcapture %}

{% include code-example.html
    title='Click to Pay Response'
    header=response_header
    json= response_content
    %}

### Google Pay&trade; `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "GooglePay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "paymentTokenGenerated": false,
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "49250000******04",
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
}{% endcapture %}

{% include code-example.html
    title='Google Pay&trade; Response'
    header=response_header
    json= response_content
    %}

### MobilePay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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
    "paymentTokenGenerated": false,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "maskedPan": "492500******0004",
        "maskedDPan": "49250000******04",
        "expiryDate": "12/2022",
        "issuerAuthorizationApprovalCode": "018117",
        "acquirerTransactionType": "MOBILEPAY",
        "acquirerStan": "53889",
        "acquirerTerminalId": "42",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z"
        "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='MobilePay Response'
    header=response_header
    json= response_content
    %}

### Vipps `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Vipps Response**

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
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
    "paymentTokenGenerated": false,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890"
        "cardBrand": "Visa",
        "maskedDPan": "49250000******04",
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

### Swish `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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
    "paymentTokenGenerated": false,
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

Please note that this is an abbreviated example. See the main `Paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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
    "paymentTokenGenerated": false,
    "details": {}
  }
}{% endcapture %}

{% include code-example.html
    title='Invoice Response'
    header=response_header
    json= response_content
    %}

### Installment Account `Paid` Resource

Please note that this is an abbreviated example. See the main `Paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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
    "paymentTokenGenerated": false,
    "details": {}
  }
}{% endcapture %}

{% include code-example.html
    title='Installment Account Response'
    header=response_header
    json= response_content
    %}

### Trustly `Paid` Resource

Please note that this is an abbreviated example. See the main `Paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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
    "paymentTokenGenerated": false,
    "details": {
      "trustlyOrderId": 123456789
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Trustly Response'
    header=response_header
    json= response_content
    %}

Response fields not covered in the [`Initialized`]({{ features_url }}/technical-reference/status-models#initialized) redirect or seamless view responses:

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description    |
| :----------------------- | :----------- | :------------------------------ |
| {% f remainingCaptureAmount %}      | `integer`    | The remaining authorized amount that is still possible to capture.                                                                                                                                                                             |
| {% f remainingCancellationAmount %}      | `integer`    | The remaining authorized amount that is still possible to cancel.                                                                                                                                                                             |
| {% f paid, 0 %}                | `object`     | The paid object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f instrument %}             | `string`     | The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a `capture` is needed, we recommend using `operations` or the `transactionType` field. |
| {% f number, 2 %}         | `integer` | {% include fields/number.md %} |
| {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md %} |
| {% f transactionType, 2 %}          | `string` | This will either be set to `Authorization` or `Sale`. Can be used to understand if there is a need for doing a capture on this payment order. Swedbank Pay recommends using the different operations to figure out if a capture is needed. |
| {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                            |
| {% f submittedAmount %}                   | `integer`    | This field will display the initial payment order amount, not including any discounts or fees specific to a payment method. The final payment order amount will be displayed in the `amount` field.                                            |
| {% f feeAmount %}                   | `integer`    | If the payment method used had a unique fee, it will be displayed in this field.                                            |
| {% f discountAmount %}                   | `integer`    | If the payment method used had a unique discount, it will be displayed in this field.                                                |
| {% f paymentTokenGenerated %}                | `bool`       | Set to `true` or `false`. Used to show if a payment token has been generated or not. Will be set to `true` if the checkbox enabled by `EnablePaymentDetailsConsentCheckbox` has been checked by the payer during a payment, otherwise `false`.                                           |
| {% f details %}                   | `integer`    | Details connected to the payment. |
| {% f nonPaymentToken, 2 %}         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| {% f externalNonPaymentToken, 2 %} | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions will be populated with the `paymentAccountReference`. |
| {% f paymentAccountReference, 2 %} | `string`     | The result of an external tokenization. The value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, the `paymentAccountReference` will also populate the externalNonPaymentToken field. |
| {% f cardType, 2 %}                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| {% f maskedPan, 2 %}               | `string`  | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| {% f maskedDPan, 2 %}               | `string`  | A masked version of a network token representing the card. It will only appear if the chosen payment method is tokenized and the card used is tokenized by Visa or MasterCard.                                                                                                                                                                                                                                                                  |
| {% f expiryDate, 2 %}              | `string`  | The month and year of when the card expires.                                                                                                                                                                                                                                                         |
| {% f issuerAuthorizationApprovalCode, 2 %} | `string`     | Payment reference code provided by the issuer.                                                                                                                                                                                                                                |
| {% f acquirerTransactionType, 2 %} | `string`     | `3DSECURE` or `STANDARD`. Indicates the transaction type of the acquirer.                                                                                                                                                                                                                                 |
| {% f acquirerStan, 2 %}            | `string`     | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                                                                                                         |
| {% f acquirerTerminalId, 2 %}      | `string`     | The ID of the acquirer terminal.                                                                                                                                                                                                                                                                     |
| {% f acquirerTransactionTime, 2 %} | `string`     | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                                                                                                              |
| {% f transactionInitatior, 2 %} | `string`     | The party which initiated the transaction. `MERCHANT` or `CARDHOLDER`.                                                                                                                                                                                                                                              |
| {% f bin, 2 %} | `string`     | The first six digits of the maskedPan.                                                                                                                                                                                                                                              |
| {% f msisdn, 2 %} | `string`     | The msisdn used in the purchase. Only available when paid with Swish.                                                                                                                                                                                                                                              |
| {% f operations %}     | `array`      | {% include fields/operations.md %} As this is a paid payment, the available operations are `capture`, `cancel` and `redirect-checkout` or `view-checkout`, depending on the integration. [See Operations for details]({{ features_url }}/technical-reference/operations)
{% endcapture %}
{% include accordion-table.html content=table %}

### Paid Examples With Connected Tokens

If there e.g. is a recurrence or an unscheduled (below) token connected to the
payment, it will appear like this.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
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
}{% endcapture %}

{% include code-example.html
    title='Recurrence Token Response'
    header=response_header
    json= response_content
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
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
}{% endcapture %}

{% include code-example.html
    title='Unscheduled Token Response'
    header=response_header
    json= response_content
    %}

Response fields not covered in the [`Initialized`]({{ features_url }}/technical-reference/status-models#initialized) redirect or seamless view
responses:

{:.table .table-striped}
| Field                    | Type         | Description    |
| :----------------------- | :----------- | :------------------------------ |
| {% f tokens %}                   | `integer`    | A list of tokens connected to the payment.                                                   |
| {% f type, 2 %}  | `string`   | {% f payment, 0 %}, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| {% f token, 2 %}  | `string`   | The token `guid`. |
| {% f name, 2 %}  | `string`   | The name of the token. In the example, a masked version of a card number. |
| {% f expiryDate, 2 %}  | `string`   | The expiry date of the token. |

## Reversed

The payment order response with `status` equal to `Reversed`, and the `reversed`
resource expanded. Please note that the main code example is of a card reversal.

Apart from the id and number fields, the output will be inherited from the
corresponding `Paid` transaction. As several `Reversed` transactions can exist
on a single payment, the number and payerReference will be from the latest
`Reversed`.

We have included `reversal` resources of the remaining payment methods below the
main code example. Resource examples where details are empty indicate that no
details are available.

The wallets Apple Pay and Vipps do not return `maskedPan`. Please note that
while MobilePay does return this field, the value present is actually a
`networkToken`, which **represents** the PAN, but is not a PAN in itself.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/reversed HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

### Card `Reversed` Resource

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "reversed": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/reversed",
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
      "paymentAccountReference": "43f6b6d2cbd30c36627ec02247259",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "49250000******04",
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

### Apple Pay `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "reversed": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/reversed",
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
        "maskedDPan": "49250000******04",
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

### Click to Pay `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "reversed": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/reversed",
    "instrument": "ClickToPay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "49250000******04",
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
}{% endcapture %}

{% include code-example.html
    title='Click to Pay Response'
    header=response_header
    json= response_content
    %}

### Google Pay&trade; `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "reversed": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/reversed",
    "instrument": "GooglePay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "49250000******04",
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
}{% endcapture %}

{% include code-example.html
    title='Google Pay&trade; Response'
    header=response_header
    json= response_content
    %}

### MobilePay `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "reversed": {
    "id": "/psp/paymentorders/efdcbf77-9a62-426b-a3b1-08da8caf7918/reversed",
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
        "maskedDPan": "48953700******04",
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

### Vipps `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "reversed": {
    "id": "/psp/paymentorders/a463b145-3278-4aa0-c4db-08da8f1813a2/reversed",
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
        "maskedDPan": "49250000******04",
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

### Swish `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "reversed": {
    "id": "/psp/paymentorders/b0410cd0-61df-4548-a3ad-08da8caf7918/reversed",
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

### Invoice `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"reversed": {
    "id": "/psp/paymentorders/05a356df-05e2-49e6-8858-08da8cb4d651/reversed",
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

### Installment Account `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"reversed": {
    "id": "/psp/paymentorders/39eef759-a619-4c91-885b-08da8cb4d651/reversed",
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

### Trustly `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"reversed": {
    "id": "/psp/paymentorders/bf660901-93d0-4245-4e6b-08da8f165366/reversed",
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
      "trustlyOrderId": 123456789
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
| {% f reversed, 0 %}                | `object`     | The reversed object.                     |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f instrument %}             | `string`     | The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a `capture` is needed, we recommend using `operations` or the `transactionType` field. |
| {% f number, 2 %}         | `integer` | {% include fields/number.md resource="paymentorder" %} |
| {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md %} |
| {% f orderReference, 2 %}          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems. |
| {% f transactionType, 2 %}          | `string` | This will either be set to `Authorization` or `Sale`. Can be used to understand if there is a need for doing a `capture` on this payment order. Swedbank Pay recommends using the different `operations` to figure out if a `capture` is needed. |
| {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                            |
| {% f submittedAmount %}                   | `integer`    | This field will display the initial payment order amount, not including any discounts or fees specific to a payment method. The final payment order amount will be displayed in the `amount` field.                                            |
| {% f feeAmount %}                   | `integer`    | If the payment method used had a unique fee, it will be displayed in this field.                                            |
| {% f discountAmount %}                   | `integer`    | If the payment method used had a unique discount, it will be displayed in this field.                                                |
| {% f tokens %}                   | `integer`    | A list of tokens connected to the payment.                                    |
| {% f type, 2 %}  | `string`   | {% f payment, 0 %}, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| {% f token, 2 %}  | `string`   | The token `guid`. |
| {% f name, 2 %}  | `string`   | The name of the token. In the example, a masked version of a card number. |
| {% f expiryDate, 2 %}  | `string`   | The expiry date of the token. |
| {% f details %}                   | `integer`    | Details connected to the payment. |
| {% f nonPaymentToken, 2 %}         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| {% f externalNonPaymentToken, 2 %} | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions will be populated with the `paymentAccountReference`. |
| {% f paymentAccountReference, 2 %} | `string`     | The result of an external tokenization. The value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, the `paymentAccountReference` will also populate the externalNonPaymentToken field. |
| {% f cardType, 2 %}                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| {% f maskedPan, 2 %}               | `string`  | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| {% f maskedDPan, 2 %}               | `string`  | A masked version of a network token representing the card. It will only appear if the chosen payment method is tokenized and the card used is tokenized by Visa or MasterCard.                                                                                                                                                                                                                                                                  |
| {% f expiryDate, 2 %}              | `string`  | The month and year of when the card expires.                                                                                                                                                                                                                                                         |
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
