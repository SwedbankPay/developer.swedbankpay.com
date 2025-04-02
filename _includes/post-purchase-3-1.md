
**Recommended version*

{: .h2 }

### Payment order v3.1

<div class="slab mb-5">
  <ul class="toc-list" role="navigation" aria-label="Article content">
    <li>
      <a href="#capture-v31">
        Capture
      </a>
      <ul role="list">
        <li>
          <a href="#capture-request-v31">
            Capture Request
          </a>
        </li>
        <li>
          <a href="#capture-response-v31">
            Capture Response
            </a>
        </li>
        <li>
        <a href="#capture-sequence-diagram-v31">
          Capture Sequence Diagram
        </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#cancel-v31">
        Cancel
      </a>
      <ul role="list">
        <li>
          <a href="#cancel-request-v31">
            Cancel Request
          </a>
        </li>
        <li>
          <a href="#cancel-response-v31">
            Cancel Response
          </a>
        </li>
        <li>
        <a href="#cancel-sequence-diagram-v31">
          Cancel Sequence Diagram
        </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#reversal-v31">
        Reversal
      </a>
      <ul role="list">
        <li>
          <a href="#reversal-request-v31">
            Reversal Request
          </a>
        </li>
        <li>
          <a href="#reversal-response-v31">
            Reversal Response
          </a>
        </li>
      </ul>
    </li>
  </ul>
</div>

{% include alert-two-phase-payments.md %}

{% include alert.html type="informative" icon="info" header="When something goes
wrong" body="When something fails during a post-purchase operation, you will get
an error message in the response in the form of a problem `json`." %}

See examples of the `jsons` in the [problems section][problems].

{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

{: .h2 }

### Capture v3.1

Captures are only possible when a payment has a successful `Authorization`
transaction, naturally excluding one-phase payment methods like Swish and
Trustly. They will be marked as a `Sale` transaction. Two-phase payment methods
like card and Vipps however, require a `Capture` to be completed.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
capture. The payment will be locked after the fifth, and you need to contact us
for further attempts.

In addition to full captures, it is possible to do partial captures of the
authorized amount. You can do more captures on the same payment later, up to the
total authorized amount. A useful tool for when you have to split orders into
several shipments.

First off, you must request the order information from the server to get the
request link. With this, you can request the capture with the amount to capture,
and get the status back.

To capture the authorized payment, we need to perform `capture` against the
accompanying `href` returned in the `operations` list. See the abbreviated
request and response below:

{: .text-right}
[Top of page](#payment-order-v31)

{: .h3 }

#### Capture Request v3.1

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Capturing the authorized payment",
        "amount": 1500,
        "vatAmount": 375,
        "payeeReference": "AB832",
        "receiptReference": "AB831"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}

|     Required     | Field                          | Type         | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :----------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `transaction`                  | `object`     | The transaction object.                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f description %}          | `string`     | The description of the capture transaction.                                                                                                                                                                                                                                           |
| {% icon check %} | {% f amount %}               | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f vatAmount %}            | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | {% f payeeReference %}       | `string` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                  |
|                  | {% f receiptReference %}     | `string(30)` | {% include fields/receipt-reference.md %}                                                                                                                                                               |
| {% icon check %} | {% f orderItems %}           | `array`      | {% include fields/order-items.md %}                                                                                                                                                                                                                                         |
| {% icon check %} | {% f reference, 2 %}           | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                           |
| {% icon check %} | {% f name, 2 %}                | `string`     | The name of the order item.                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f type, 2 %}                | `enum`       | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.                                                                                                                                                                 |
| {% icon check %} | {% f class, 2 %}               | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics. |
|                  | {% f itemUrl, 2 %}             | `string`     | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                            |
|        ︎︎︎         | {% f imageUrl, 2 %}            | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                |
|                  | {% f description, 2 %}         | `string`     | The human readable description of the order item.                                                                                                                                                                                                                                     |
|                  | {% f discountDescription, 2 %} | `string`     | The human readable description of the possible discount.                                                                                                                                                                                                                              |
| {% icon check %} | {% f quantity, 2 %}            | `number`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                      |
| {% icon check %} | {% f quantityUnit, 2 %}        | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                                                                                                        |
| {% icon check %} | {% f unitPrice, 2 %}           | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                      |
|                  | {% f discountPrice, 2 %}       | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                            |
| {% icon check %} | {% f vatPercent, 2 %}          | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                              |
| {% icon check %} | {% f amount, 2 %}              | `integer`    | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 SEK` and `5000` equals `50.00 SEK`.                                                                                 |
| {% icon check %} | {% f vatAmount, 2 %}           | `integer`    | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 SEK` and `5000` equals `50.00 SEK`.                                                                                        |
| {% icon check %} | {% f reference, 2 %}           | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                           |
| {% icon check %} | {% f name, 2 %}                | `string`     | The name of the order item.                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f type, 2 %}                | `enum`       | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.                                                                                                                                                                 |
| {% icon check %} | {% f class, 2 %}               | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics. |
|        ︎︎︎         | {% f itemUrl, 2 %}             | `string`     | The URL to a page that can display the purchased item, such as a product page                                                                                                                                                                                                         |
|        ︎︎︎         | {% f imageUrl, 2 %}            | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                |
|        ︎︎︎         | {% f description, 2 %}         | `string`     | The human readable description of the order item.                                                                                                                                                                                                                                     |
|        ︎︎︎         | {% f discountDescription, 2 %} | `string`     | The human readable description of the possible discount.                                                                                                                                                                                                                              |
| {% icon check %} | {% f quantity, 2 %}            | `number`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                      |
| {% icon check %} | {% f quantityUnit, 2 %}        | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar.                                                                                                                                                                                                                         |
| {% icon check %} | {% f unitPrice, 2 %}           | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                      |
|        ︎︎︎         | {% f discountPrice, 2 %}       | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                            |
| {% icon check %} | {% f vatPercent, 2 %}          | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                              |
| {% icon check %} | {% f amount, 2 %}              | `integer`    | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                                                                 |
| {% icon check %} | {% f vatAmount, 2 %}           | `integer`    | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                                                                        |
{% endcapture %}
{% include accordion-table.html content=table %}

{: .text-right .mt-3}

[Top of page](#payment-order-v31)

{: .h3 }

#### Capture Response v3.1

If the capture request succeeds, this should be the response:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1
api-supported-versions: 3.1{% endcapture %}

{% capture response_content %}{
  "paymentOrder": {
    "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d",
    "created": "2020-03-03T07:19:27.5636519Z",
    "updated": "2020-03-03T07:21:00.5605905Z",
    "operation": "Purchase",
    "status": "Paid",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 375,
    "remainingCaptureAmount": 0, // Only present after a partial capture
    "remainingCancellationAmount": 0, // Only present after a partial capture
    "remainingReversalAmount": 1500,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "<should be set by the system calling POST:/psp/paymentorders>",
    "language": "sv-SE",
    "availableInstruments": [ "CreditCard", "Invoice-PayExFinancingSe", "Invoice-PayMonthlyInvoiceSe", "Swish", "CreditAccount", "Trustly" ],
    "implementation": "PaymentsOnly",
    "integration": "HostedView|Redirect",
    "instrumentMode": false,
    "guestMode": true,
    "orderItems": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/orderitems"
    },
    "urls": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/urls"
    },
    "payeeInfo": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payeeInfo"
    },
    "payer": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
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
    "postPurchaseFailedAttempts": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/postpurchasefailedattempts"
    },
    "metadata": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/metadata"
    }
  },
  "operations": [
    {
      "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224/reversals",
      "rel": "reversal",
      "method": "POST",
      "contentType": "application/json"
    },
  ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}

| Property                    | Type         | Description                                                                                                                                                                                                       |
| :-------------------------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f paymentOrder, 0 %}                   | `string`     | The relative URL of the payment order this capture transaction belongs to.                                                                                                                                              |
| {% f id %}                | `string`     | The relative URL of the created capture transaction.                                                                                                                                                              |
| {% f created %}          | `string`     | The ISO-8601 date and time of when the transaction was created.                                                                                                                                                   |
| {% f updated %}          | `string`     | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                                   |
| {% f operation %}            | `string`     | {% include fields/operation.md %}            |
| {% f status %}            | `string`     | {% include fields/status.md %}            |
| {% f currency %}            | `string`     | The currency of the payment order.            |
| {% f amount %}           | `integer`    | {% include fields/amount.md %}                                                                                                                                                                         |
| {% f vatAmount %}        | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                      |
| {% f remainingCaptureAmount %}      | `integer`    | The remaining authorized amount that is still possible to capture.                                                                                                                                                                             |
| {% f remainingCancellationAmount %}      | `integer`    | The remaining authorized amount that is still possible to cancel.                                                                                                                                                                             |
| {% f remainingReversalAmount %}      | `integer`    | The remaining captured amount that is still available for reversal.                                                                                                                                                                             |
| {% f description %}      | `string`     | {% include fields/description.md %}                                                                                                                                   |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Online Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Online Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment method available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |
| {% f orderItems %}     | `id`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f urls %}           | `id`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f payeeInfo %}      | `id`     | The URL to the `payeeInfo` resource where information related to the payee can be retrieved.                                                                                                          |
| {% f payer %}         | `id`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                 |
| {% f history %}     | `id`     | The URL to the `history` resource where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `id`     | The URL to the `failed` resource where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `id`     | The URL to the `aborted` resource where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `id`     | The URL to the `paid` resource where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `id`     | The URL to the `cancelled` resource where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the `financialTransactions` resource where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `id`     | The URL to the `failedAttempts` resource where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f postPurchaseFailedAttempts %}     | `id`     | The URL to the `postPurchaseFailedAttempts` resource where information about the failed capture, cancel or reversal attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}     | `array`      | {% include fields/operations.md %} [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

{: .text-right .mt-3}
[Top of page](#payment-order-v31)

{: .h3 }

#### Capture Sequence Diagram v3.1

```mermaid
sequenceDiagram
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    rect rgba(81,43,43,0.1)
        activate Merchant
        note left of Payer: Capture
        Merchant ->>+ SwedbankPay: rel:capture
        deactivate Merchant
        SwedbankPay -->>- Merchant: Capture status
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>Payment Methods that support <br>Authorizations.
    end
```

<!--lint disable final-definition -->

The purchase should now be complete. But what if the purchase is cancelled or
the payer wants to return goods? For these instances, we have `cancel` and
`reversal`.

{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

{: .text-right}
[Top of page](#payment-order-v31)

{: .h3 }

### Cancel v3.1

The `cancellations` resource lists the cancellation transactions on a
specific payment.

To cancel a previously created payment, you must perform the `cancel` operation
against the accompanying `href` returned in the `operations` list. You can only
cancel a payment - or part of a payment - which has not been captured yet. There
must be funds left that are only authorized. If you cancel before any capture
has been done, no captures can be performed later.

{: .text-right}
[Top of page](#payment-order-v31)

{: .h3 }

#### Cancel Request v3.1

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Test Cancellation",
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{:.table .table-striped}

|     Required     | Field                    | Type         | Description                                                                                    |
| :--------------: | :----------------------- | :----------- | :--------------------------------------------------------------------------------------------- |
| {% icon check %} | `transaction`            | `object`     | The transaction object.                                                                        |

| {% icon check %} | {% f description %}    | `string`     | A textual description of why the transaction is cancelled.                                     |
| {% icon check %} | {% f payeeReference %} | `string` | {% include fields/payee-reference.md %} |

{: .text-right}
[Top of page](#payment-order-v31)

{: .h3 }

#### Cancel Response v3.1

If the cancel request succeeds, the response should be similar to the
example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1
api-supported-versions: 3.1{% endcapture %}

{% capture response_content %}{
  "paymentOrder": {
    "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d",
    "created": "2020-03-03T07:19:27.5636519Z",
    "updated": "2020-03-03T07:21:00.5605905Z",
    "operation": "Purchase",
    "status": "Cancelled",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 375,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "<should be set by the system calling POST:/psp/paymentorders>",
    "language": "sv-SE",
    "availableInstruments": [ "CreditCard", "Invoice-PayExFinancingSe", "Invoice-PayMonthlyInvoiceSe", "Swish", "CreditAccount", "Trustly" ],
    "implementation": "PaymentsOnly",
    "integration": "HostedView|Redirect",
    "instrumentMode": true,
    "guestMode": true,
    "orderItems": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/orderitems"
    },
    "urls": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/urls"
    },
    "payeeInfo": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payeeInfo"
    },
    "payer": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
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
    "postPurchaseFailedAttempts": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/postpurchasefailedattempts"
    },
    "metadata": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/metadata"
    }
  },
  "operations": [
  ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}

| Property                    | Type         | Description                                                                                                                                                                                                       |
| :-------------------------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f paymentOrder, 0 %}                   | `string`     | The relative URL of the payment order this capture transaction belongs to.                                                                                                                                              |
| {% f id %}                | `string`     | The relative URL of the created capture transaction.                                                                                                                                                              |
| {% f created %}          | `string`     | The ISO-8601 date and time of when the transaction was created.                                                                                                                                                   |
| {% f updated %}          | `string`     | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                                   |
| {% f operation %}            | `string`     | {% include fields/operation.md %}            |
| {% f status %}            | `string`     | {% include fields/status.md %}            |
| {% f currency %}            | `string`     | The currency of the payment order.            |
| {% f amount %}           | `integer`    | {% include fields/amount.md %}                                                                                                                                                                         |
| {% f vatAmount %}        | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                      |
| {% f remainingCaptureAmount %}      | `integer`    | The remaining authorized amount that is still possible to capture.                                                                                                                                                                             |
| {% f remainingCancellationAmount %}      | `integer`    | The remaining authorized amount that is still possible to cancel.                                                                                                                                                                             |
| {% f remainingReversalAmount %}      | `integer`    | The remaining captured amount that is still available for reversal.                                                                                                                                                                             |
| {% f description %}      | `string`     | {% include fields/description.md %}                                                                                                                                   |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Online Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Online Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment method available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |
| {% f orderItems %}     | `id`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f urls %}           | `id`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f payeeInfo %}      | `id`     | The URL to the `payeeInfo` resource where information related to the payee can be retrieved.                                                                                                            |
| {% f payer %}         | `id`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                 |
| {% f history %}     | `id`     | The URL to the `history` resource where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `id`     | The URL to the `failed` resource where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `id`     | The URL to the `aborted` resource where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `id`     | The URL to the `paid` resource where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `id`     | The URL to the `cancelled` resource where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the `financialTransactions` resource where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `id`     | The URL to the `failedAttempts` resource where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f postPurchaseFailedAttempts %}     | `id`     | The URL to the `postPurchaseFailedAttempts` resource where information about the failed capture, cancel or reversal attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |

| {% f operations %}     | `array`      | {% include fields/operations.md %} [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

{: .text-right .mt-3}
[Top of page](#payment-order-v31)

{: .h3 }

#### Cancel Sequence Diagram v3.1

Cancel can only be done on an authorized transaction. As a cancellation does not
have an amount associated with it, it will release the entire reserved amount.
If your intention is to make detailed handling, such as only capturing a partial
amount of the transaction, you must start with the capture of the desired amount
before performing a cancel for the remaining reserved funds.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    Merchant->>SwedbankPay: POST < {{ include.api_resource }} cancellation>
    activate Merchant
    activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    deactivate SwedbankPay
    deactivate Merchant
```

{% capture techref_url %}{% include utils/documentation-section-url.md href='/features/technical-reference' %}{% endcapture %}
{% assign transactions_url = '/transactions' | prepend: techref_url %}
{% assign operations_url = '/operations' | prepend: techref_url %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

{: .text-right}
[Top of page](#payment-order-v31)

{: .h2 }

### Reversal v3.1

This transaction is used when a `Capture` or `Sale` payment needs to be
reversed.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
reversal. The payment will be locked after this, and you need to contact us for
another attempt.

If the full amount of a sale transaction or a captured transaction is reversed,
The transaction will now have status `Reversed` instead of `Paid`.

If we want to reverse a previously captured amount, we need to perform
`reversal` against the accompanying `href` returned in the
`operations` list.

{: .text-right}
[Top of page](#payment-order-v31)

{: .h3 }

#### Reversal Request v3.1

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Reversal of captured transaction",
        "amount": 1500,
        "vatAmount": 375,
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}

|     Required     | Field                          | Type         | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :----------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `transaction`                  | `object`     | The transaction object.                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f amount %}               | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f vatAmount %}            | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | {% f payeeReference %}       | `string` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                  |
|                  | {% f receiptReference %}     | `string(30)` | {% include fields/receipt-reference.md %}                                                                                                                                                               |
| {% icon check %} | {% f description %}          | `string`     | Textual description of why the transaction is reversed.                                                                                                                                                                                                                               |
| {% icon check %} | {% f orderItems %}           | `array`      | {% include fields/order-items.md %}                                                                                                                                                                                                                                         |
| {% icon check %} | {% f reference, 2 %}           | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                           |
| {% icon check %} | {% f name, 2 %}                | `string`     | The name of the order item.                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f type, 2 %}                | `enum`       | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.                                                                                                                                                                 |
| {% icon check %} | {% f class, 2 %}               | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics. |
|                  | {% f itemUrl, 2 %}             | `string`     | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                            |
|                  | {% f imageUrl, 2 %}            | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                |
|                  | {% f description, 2 %}         | `string`     | The human readable description of the order item.                                                                                                                                                                                                                                     |
|                  | {% f discountDescription, 2 %} | `string`     | The human readable description of the possible discount.                                                                                                                                                                                                                              |
| {% icon check %} | {% f quantity, 2 %}            | `number`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                      |
| {% icon check %} | {% f quantityUnit, 2 %}        | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                                                                                                        |
| {% icon check %} | {% f unitPrice, 2 %}           | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                      |

|                  | {% f discountPrice, 2 %}       | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                            |
| {% icon check %} | {% f vatPercent, 2 %}          | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                              |
| {% icon check %} | {% f amount, 2 %}              | `integer`    | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 SEK` and `5000` equals `50.00 SEK`.                                                                                 |
| {% icon check %} | {% f vatAmount, 2 %}           | `integer`    | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 SEK` and `5000` equals `50.00 SEK`.                                                                                        |
{% endcapture %}
{% include accordion-table.html content=table %}

{: .text-right .mt-3}
[Top of page](#payment-order-v31)

{: .h3 }

#### Reversal Response v3.1

If the reversal request succeeds, the response should be similar to the example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1
api-supported-versions: 3.1{% endcapture %}

{% capture response_content %}{
  "paymentOrder": {
    "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d",
    "created": "2020-03-03T07:19:27.5636519Z",
    "updated": "2020-03-03T07:21:00.5605905Z",
    "operation": "Purchase",
    "status": "Reversed",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 375,
    "remainingCaptureAmount": 0, // Only present after a partial reversal
    "remainingReversalAmount": 0, // Only present after a partial reversal
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "<should be set by the system calling POST:/psp/paymentorders>",
    "language": "sv-SE",
    "availableInstruments": [ "CreditCard", "Invoice-PayExFinancingSe", "Invoice-PayMonthlyInvoiceSe", "Swish", "CreditAccount", "Trustly" ],
    "implementation": "PaymentsOnly",
    "integration": "HostedView|Redirect",
    "instrumentMode": true,
    "guestMode": true,
    "orderItems": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/orderitems"
    },
    "urls": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/urls"
    },
    "payeeInfo": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payeeInfo"
    },
    "payer": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
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
    "postPurchaseFailedAttempts": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/postpurchasefailedattempts"
    },
    "metadata": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/metadata"
    }
  },
  "operations": [
  ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}

| Property                    | Type         | Description                                                                                                                                                                                                       |
| :-------------------------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f paymentOrder, 0 %}                   | `string`     | The relative URL of the payment order this capture transaction belongs to.                                                                                                                                              |
| {% f id %}                | `string`     | The relative URL of the created capture transaction.                                                                                                                                                              |
| {% f created %}          | `string`     | The ISO-8601 date and time of when the transaction was created.                                                                                                                                                   |
| {% f updated %}          | `string`     | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                                   |
| {% f operation %}            | `string`     | {% include fields/operation.md %}            |
| {% f status %}            | `string`     | {% include fields/status.md %}            |
| {% f currency %}            | `string`     | The currency of the payment order.            |
| {% f amount %}           | `integer`    | {% include fields/amount.md %}                                                                                                                                                                         |
| {% f vatAmount %}        | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                      |
| {% f remainingCaptureAmount %}      | `integer`    | The remaining authorized amount that is still possible to capture. Only present after a partial reversal.                                                                                                                                                                             |
| {% f remainingCancellationAmount %}      | `integer`    | The remaining authorized amount that is still possible to cancel. Only present after a partial reversal.                                                                                                                                                                            |
| {% f remainingReversalAmount %}      | `integer`    | The remaining captured amount that is still available for reversal. This field will not appear in the initial response if the payment method used was Swish. It will first appear if and when you do a GET on the payment.                                                                                                                                                   |
| {% f description %}      | `string`     | {% include fields/description.md %}                                                                                                                                   |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Online Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Online Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment method available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |
| {% f orderItems %}     | `id`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f urls %}           | `id`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f payeeInfo %}      | `id`     | The URL to the `payeeInfo` resource where information related to the payee can be retrieved.                                                                                                                          |
| {% f payer %}         | `id`     | The URL to the `payer` resource where information about the payer can be retrieved.                                                                                                                 |
| {% f history %}     | `id`     | The URL to the `history` resource where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `id`     | The URL to the `failed` resource where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `id`     | The URL to the `aborted` resource where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `id`     | The URL to the `paid` resource where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `id`     | The URL to the `cancelled` resource where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the `financialTransactions` resource where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `id`     | The URL to the `failedAttempts` resource where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f postPurchaseFailedAttempts %}     | `id`     | The URL to the `postPurchaseFailedAttempts` resource where information about the failed capture, cancel or reversal attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}     | `array`      | {% include fields/operations.md %}                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

{: .text-right .mt-3}
[Top of page](#payment-order-v31)

{% include iterator.html next_href="/checkout-v3/features/"
                         next_title="Add To Your Payment Request" %}

[problems]: /checkout-v3/features/technical-reference/problems
