{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}

## Payment Order Request

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "productName": "Checkout3",
        "implementation": "PaymentsOnly",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ], //Seamless View only
            "paymentUrl": "https://example.com/perform-payment",
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png" //Redirect only
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "orderReference": "or-123456"
        }
    }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f operation %}                | `string`     | {% include fields/operation.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f currency %}                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f vatAmount %}                | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f description %}              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |
| {% icon check %} | {% f userAgent %}                | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f language %}                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f productName %}              | `string`     | Used to tag the payment as Digital Payments. Mandatory for Digital Payments, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                                                              |
|                  | {% f implementation %}           | `string`     | Indicates which implementation to use.                                                                                                                                                                                                                                                                         |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f hostUrls, 2 %}                | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                    |
|                  | {% f paymentUrl, 2 %}              | `string`     | {% include fields/payment-url.md %} |
| {% icon check %} | {% f completeUrl, 2 %}             | `string`     | {% include fields/complete-url.md %} |
| {% icon check %} | {% f cancelUrl, 2 %}               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% icon check %} | {% f callbackUrl, 2 %}             | `string`     | {% include fields/callback-url.md %}                                                                                                                                                                                              |
|                  | {% f logoUrl, 2 %}                 | `string`     | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f payeeInfo %}                | `string`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f payeeId, 2 %}                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | {% f payeeName, 2 %}               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f orderReference, 2 %}          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
{% endcapture %}
{% include accordion-table.html content=table %}

## Payment Order Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "vatAmount": 375,
        "amount": 1500,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
          "CreditCard",
          "Invoice-PayExFinancingSe",
          "Invoice-PayMonthlyInvoiceSe",
          "Swish",
          "CreditAccount",
          "Trustly" ],
        "implementation": "PaymentsOnly", {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect",
        {% endif %}
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
      "operations": [
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        },
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        },
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

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | `Purchase`                                                                                                                                                                                                                |
| {% f status %}          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. [See the `Paid` response]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in [the `Failed` response]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. [See the `Cancelled` response]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). [See the `Aborted` response]({{ features_url }}/technical-reference/status-models#aborted). |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of instruments available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Digital Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Digital Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment instrument available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |
| {% f payer %}         | `string`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                  |
| {% f orderItems %}     | `string`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f history %}     | `string`     | The URL to the [`history` resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `string`     | The URL to the [`failed` resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `string`     | The URL to the [`aborted` resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `string`     | The URL to the [`paid` resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `string`     | The URL to the [`cancelled` resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `string`     | The URL to the [`financialTransactions` resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `string`     | The URL to the [`failedAttempts` resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `string`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}     | `array`      | {% include fields/operations.md %}                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}
