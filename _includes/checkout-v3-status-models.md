{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}

## Aborted

A payment order response with the status `Aborted`.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
        ], {% if documentation_section contains "checkout-v3/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if documentation_section contains "checkout-v3/business" %}
        "implementation": "Business", {% endif %} {% if documentation_section contains "checkout-v3/starter" %}
        "implementation": "Starter", {% endif %} { {% if include.integration_mode=="seamless-view" %}
        "integration": "Seamless View", {% endif %} { {% if include.integration_mode=="redirect" %}
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
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        }{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        }{% endif %}
    ]
}
```

Response fields not covered in the [`Initialized`]({{ features_url }}/technical-reference/status-models#initialized) redirect or seamless view
responses:

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| └➔&nbsp;`operations`     | `array`      | The array of possible operations to perform, given the state of the payment order. As this is an aborted payment, the available operations are `redirect-checkout` or `view-checkout`, depending on the integration. [See Operations for details]({{ features_url }}/technical-reference/operations) |

## Cancelled

The `cancel` response is not yet converted to the new Checkout v3 standard.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
}
```

{:.table .table-striped}
| Property                  | Type      | Description                                                                                                                                                                                                  |
| :------------------------ | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                 | `string`  | The relative URL of the payment this cancellation transaction belongs to.                                                                                                                                    |
| `cancellation`            | `object`  | The cancellation object, containing information about the cancellation transaction.                                                                                                                          |
| └➔&nbsp;`id`              | `string`  | The relative URL of the cancellation transaction.                                                                                                                                                            |
| └➔&nbsp;`transaction`     | `object`  | The transaction object, containing information about the current transaction.                                                                                                                                |
| └─➔&nbsp;`id`             | `string`  | The relative URL of the current `transaction` resource.                                                                                                                                                      |
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └─➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └─➔&nbsp;`amount`         | `integer` | {% include field-description-amount.md %}                                                                                                                                                                    |
| └─➔&nbsp;`vatAmount`      | `integer` | {% include field-description-vatamount.md %}                                                                                                                                                                 |
| └─➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └─➔&nbsp;`payeeReference` | `string`  | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                         |

## Failed

The failed response is not yet converted to the new Checkout v3 standard.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
            }
```

{:.table .table-striped}
| Field                    | Type         | Description     |
| `paymentorder`           | `object`     | The payment order object.                      |
| `failed`                | `object`     | The failed object.                     |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}  |
| └➔&nbsp;`problem`             | `object`     | The problem object.  |
| └─➔&nbsp;`type`  | `string`   | The type of problem that occurred. |
| └─➔&nbsp;`title`  | `string`   | The title of the problem that occurred. |
| └─➔&nbsp;`status`              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                              |
| └─➔&nbsp;`detail`              | `string`  | A detailed, human readable description of the error.                                                                                                                                                                |
| └─➔&nbsp;`problems`            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                |
| └➔&nbsp;`name`        | `string`  | The name of the field, header, object, entity or likewise that was erroneous.                                                                                                                                                                       |
| └➔&nbsp;`description` | `string`  | The human readable description of what was wrong with the field, header, object, entity or likewise identified by `name`.                                                                                                                           |

## Initialized

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
        ],{% if documentation_section contains "checkout-v3/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if documentation_section contains "checkout-v3/business" %}
        "implementation": "Business", {% endif %} {% if documentation_section contains "checkout-v3/starter" %}
        "implementation": "Starter", {% endif %} { {% if include.integration_mode=="seamless-view" %}
        "integration": "Seamless View", {% endif %} { {% if include.integration_mode=="redirect" %}
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
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        }{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO",
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
}

```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `paymentorder`           | `object`     | The payment order object.                                                                                                                                                                                                 |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}                                                                                                                                                             |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| └➔&nbsp;`operation`      | `string`     | `Purchase`                                                                                                                                                                                                                |
| └➔&nbsp;`status`          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. [See the `Paid` section for further information]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in the failed section. [Further information here]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. [See the cancel feature section for further information]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment or if the payer cancelled the payment in the redirect integration (on the redirect page). [See the Abort feature section for further information]({{ features_url }}/technical-reference/status-models#aborted). |
| └➔&nbsp;`currency`       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                 |
| └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                              |
| └➔&nbsp;`description`    | `string(40)` | {% include field-description-description.md %}                                                                                                                        |
| └➔&nbsp;`initiatingSystemUserAgent`      | `string`     | {% include field-description-initiating-system-user-agent.md %}                                                                                                                                                          |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md %}                                                                                                                                                  |
| └➔&nbsp;`availableInstruments`       | `string`     | A list of instruments available for this payment.                                                                                                                                                   |
| └➔&nbsp;`implementation`       | `string`     | The merchant's Checkout v3 implementation type. `Business`, `Enterprise`, `PaymentsOnly` or `Starter`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| └➔&nbsp;`integration`       | `string`     | The merchant's Checkout v3 integration type. `HostedView` (Seamless View) or `Redirect`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the integration types might be subject to name changes. If this should happen, updated information will be available in this table.                           |
| └➔&nbsp;`instrumentMode`       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment instrument available.                                                                                    |
| └➔&nbsp;`guestMode`       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Enterprise implementation, this is triggered by not including a `payerReference` or `nationalIdentifier` in the original payment order request.                                                                                                                                                   |
| └➔&nbsp;`payer`         | `string`     | The URL to the `payers` resource where information about the payee of the payment order can be retrieved.                                                                                                                 |
| └➔&nbsp;`orderItems`     | `string`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| └➔&nbsp;`history`     | `string`     | The URL to the `history` [resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| └➔&nbsp;`failed`     | `string`     | The URL to the `failed` [resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`aborted`     | `string`     | The URL to the `aborted` [resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`paid`     | `string`     | The URL to the `paid` [resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`cancelled`     | `string`     | The URL to the `cancelled` [resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`financialTransactions`     | `string`     | The URL to the `financialTransactions` [resource]({{ features_url }}/technical-reference/resource-sub-models#financialTransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`failedAttempts`     | `string`     | The URL to the `failedAttempts` [resource]({{ features_url }}/technical-reference/resource-sub-models#failedAttempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| └➔&nbsp;`metadata`     | `string`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| └➔&nbsp;`operations`     | `array`      | The array of possible operations to perform, given the state of the payment order. As this is an initialized payment, the available operations are `abort`, `update-order` and `redirect-checkout` or `view-checkout`, depending on the integration. [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |

## Paid

The payment order response with status `Paid`, and the `Paid` resource
expanded.

{:.code-view-header}
**Response**

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
        "amount": 1500,
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
        "implementation": "PaymentsOnly", {% endif %} {% if documentation_section contains "checkout-v3/business" %}
        "implementation": "Business", {% endif %} {% if documentation_section contains "checkout-v3/starter" %}
        "implementation": "Starter", {% endif %} { {% if include.integration_mode=="seamless-view" %}
        "integration": "Seamless View", {% endif %} { {% if include.integration_mode=="redirect" %}
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
            "details": {}
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
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        }{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        }{% endif %}
    ]
}

```

Response fields not covered in the [`Initialized`]({{ features_url }}/technical-reference/status-models#initialized) redirect or seamless view
responses:

{:.table .table-striped}
| Field                    | Type         | Description    |
| :----------------------- | :----------- | :------------------------------ |
| └➔&nbsp;`remainingCaptureAmount`      | `integer`    | The remaining authorized amount that is still possible to capture.                                                                                                                                                                             |
| └➔&nbsp;`remainingCancellationAmount`      | `integer`    | The remaining authorized amount that is still possible to cancel.                                                                                                                                                                             |
| `paid`                | `object`     | The paid object.                     |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}  |
| └➔&nbsp;`instrument`             | `string`     | Payment instrument used in the cancelled payment. |
| └─➔&nbsp;`number`         | `string`  | The transaction number , useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where id should be used instead. |
| └─➔&nbsp;`payeeReference`          | `string(30)` | {% include field-description-payee-reference.md %} |
| └➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                                            |
| └➔&nbsp;`details`                   | `integer`    | Details connected to the payment. |
| └➔&nbsp;`operations`     | `array`      | The array of possible operations to perform, given the state of the payment order. As this is a paid payment, the available operations are `capture`, `cancel` and `redirect-checkout` or `view-checkout`, depending on the integration. [See Operations for details]({{ features_url }}/technical-reference/operations)

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

Response fields not covered in the [`Initialized`]({{ features_url }}/technical-reference/status-models#initialized) redirect or seamless view
responses:

{:.table .table-striped}
| Field                    | Type         | Description    |
| :----------------------- | :----------- | :------------------------------ |
| └➔&nbsp;`tokens`                   | `integer`    | A list of tokens connected to the payment.                                                   |
| └─➔&nbsp;`type`  | `string`   | `payment`, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| └─➔&nbsp;`token`  | `string`   | The token `guid`. |
| └─➔&nbsp;`name`  | `string`   | The name of the token. In the example, a masked version of a card number. |
| └─➔&nbsp;`expiryDate`  | `string`   | The expiry date of the token. |
