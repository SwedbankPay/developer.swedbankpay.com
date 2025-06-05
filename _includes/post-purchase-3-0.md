---
card_list:
- title: Apple Pay
  description: |
    How to activate Apple Pay webflow or in-app
  url:  /checkout-v3/apple-pay-presentation
- title: Click to Pay
  description: Additional signup needed for Click to Pay
  url: /checkout-v3/click-to-pay-presentation
- title: Google Pay&trade;
  description: Additional signup needed for Google Pay&trade;
  url: /checkout-v3/google-pay-presentation
- title: Trustly
  description: Enable Trustly Express
  url: /checkout-v3/trustly-presentation
---


{% include alert.html type="informative" icon="info" body="If you hesitate which version to use, we recommend the version marked with *." %}

{: .h2 }

### Payment order v3.0

<div class="slab mb-5">
  <ul class="toc-list" role="navigation" aria-label="Article content">
    <li>
      <a href="#capture-v30">
        Capture
      </a>
      <ul>
        <li>
          <a href="#capture-request-v30">
            Capture Request
          </a>
        </li>
        <li>
          <a href="#capture-response-v30">
            Capture Response
          </a>
        </li>
        <li>
        <a href="#capture-sequence-diagram-v30">
            Capture Sequence Diagram
        </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#cancel-v30">
        Cancel
      </a>
      <ul>
        <li>
          <a href="#cancel-request-v30">
          Cancel Request
        </a>
        </li>
        <li>
          <a href="#cancel-response-v30">
          Cancel Response
          </a>
        </li>
        <li>
        <a href="#cancel-sequence-diagram-v30">
          Cancel Sequence Diagram
        </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#reversal-v30">
        Reversal
      </a>
      <ul>
        <li>
          <a href="#reversal-request-v30">
          Reversal Request
          </a>
        </li>
        <li>
          <a href="#reversal-response-v30">
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

### Capture v3.0

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
[Top of page](#payment-order-v30)

{: .h3 }

#### Capture Request v3.0

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0    // Version optional, can be set in `productName`{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Capturing the authorized payment",
        "amount": 1500,
        "vatAmount": 375,
        "payeeReference": "AB832",
        "receiptReference": "AB831",
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 4,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 200,
                "vatPercent": 2500,
                "amount": 1000,
                "vatAmount": 250
            },
            {
                "reference": "P2",
                "name": "Product2",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "description": "Product 2 description",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 500,
                "vatPercent": 2500,
                "amount": 500,
                "vatAmount": 125
            }
        ]
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
| {% icon check %} | {% f payeeReference %}       | `string(30)` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                  |
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

[Top of page](#payment-order-v30)

{: .h3 }

#### Capture Response v3.0

If the capture request succeeds, this should be the response:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0
api-supported-versions: 3.0{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "capture": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/captures/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2020-06-22T10:56:56.2927632Z",
            "updated": "2020-06-22T10:56:56.4035291Z",
            "type": "Capture",
            "state": "Completed",
            "amount": 1500,
            "vatAmount": 375,
            "description": "Capturing the authorized payment",
            "payeeReference": "AB832",
            "receiptReference": "AB831"
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

| Property                    | Type         | Description                                                                                                                                                                                                       |
| :-------------------------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                   | `string`     | The relative URL of the payment this capture transaction belongs to.                                                                                                                                              |
| {% f capture, 0 %}                   | `object`     | The capture object, containing the information about the capture transaction.                                                                                                                                     |
| {% f id %}                | `string`     | The relative URL of the created capture transaction.                                                                                                                                                              |
| {% f transaction %}       | `object`     | {% include fields/transaction.md %}                                                                                                                                     |
| {% f id, 2 %}               | `string`     | The relative URL of the current `transaction` resource.                                                                                                                                                           |
| {% f created, 2 %}          | `string`     | The ISO-8601 date and time of when the transaction was created.                                                                                                                                                   |
| {% f updated, 2 %}          | `string`     | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                                   |
| {% f type, 2 %}             | `string`     | Indicates the transaction type.                                                                                                                                                                                   |
| {% f state, 2 %}            | `string`     | {% include fields/state.md %}            |
| {% f number, 2 %}           | `integer`    | {% include fields/number.md %}      |
| {% f amount, 2 %}           | `integer`    | {% include fields/amount.md %}                                                                                                                                                                         |
| {% f vatAmount, 2 %}        | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                      |
| {% f description, 2 %}      | `string`     | {% include fields/description.md %}                                                                                                                                   |
| {% f payeeReference, 2 %}   | `string(30)`     | {% include fields/payee-reference.md describe_receipt=true %}                                                                                              |

| {% f receiptReference, 2 %} | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation.  It is used to supplement `payeeReference` as an additional receipt number. |
{% endcapture %}
{% include accordion-table.html content=table %}

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{: .h3 }

#### Capture Sequence Diagram v3.0

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
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>payment methods that support <br>Authorizations.
    end
```

The purchase should now be complete. But what if the purchase is cancelled or

the payer wants to return goods? For these instances, we have `cancel` and
`reversal`.

{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

{: .text-right}
[Top of page](#payment-order-v30)

{: .h2 }

### Cancel v3.0

The `cancellations` resource lists the cancellation transactions on a

specific payment.

{% if documentation_section contains "checkout-v3" %}

To cancel a previously created payment, you must perform the `cancel` operation
against the accompanying `href` returned in the `operations` list. You can only
cancel a payment - or part of a payment - which has not been captured yet. There
must be funds left that are only authorized. If you cancel before any capture
has been done, no captures can be performed later.

{% else %}

To cancel a previously created payment, you must perform the
`create-paymentorder-cancel` operation against the accompanying `href` returned
in the `operations` list. You can only cancel a payment - or part of a payment -
which has not been captured yet. If you cancel before any capture has been done,
no captures can be performed later.

{% endif %}

{: .text-right}
[Top of page](#payment-order-v30)

{: .h3 }

#### Cancel Request v3.0

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0     // Version optional, can be set in `productName`{% endcapture %}

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
| {% icon check %} | {% f payeeReference %} | `string(30)` | {% include fields/payee-reference.md %} |

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{: .h3 }

#### Cancel Response v3.0

If the cancel request succeeds, the response should be similar to the
example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0
api-supported-versions: 3.0{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "cancellation": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/cancellations/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
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
| {% f payeeReference, 2 %} | `string(30)`  | {% include fields/payee-reference.md describe_receipt=true %}                                                                                         |
{% endcapture %}
{% include accordion-table.html content=table %}

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{: .h3 }

#### Cancel Sequence Diagram v3.0

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
[Top of page](#payment-order-v30)

{: .h2 }

### Reversal v3.0

This transaction is used when a `Capture` or `Sale` payment needs to be
reversed.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
reversal. The payment will be locked after this, and you need to contact us for
another attempt.

If we want to reverse a previously captured amount, we need to perform
`reversal` against the accompanying `href` returned in the
`operations` list.

{: .text-right}
[Top of page](#payment-order-v30)

{: .h3 }

#### Reversal Request v3.0

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0     // Version optional, can be set in `productName`{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Reversal of captured transaction",
        "amount": 1500,
        "vatAmount": 375,
        "payeeReference": "ABC123",
        "receiptReference": "ABC122",
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 4,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 200,
                "vatPercent": 2500,
                "amount": 1000,
                "vatAmount": 250
            },
            {
                "reference": "P2",
                "name": "Product2",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "description": "Product 2 description",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 500,
                "vatPercent": 2500,
                "amount": 500,
                "vatAmount": 125
            }
        ]
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

| {% icon check %} | {% f payeeReference %}       | `string(30)` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                  |
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
[Top of page](#payment-order-v30)

{: .h3 }

#### Reversal Response v3.0

If the reversal request succeeds, the response should be similar to the example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0
api-supported-versions: 3.0{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_order_id }}",
    "reversal": {
        "id": "/psp/creditcard/payments/{{ page.payment_order_id }}/reversals/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/pcreditcard/payments/{{ page.payment_order_id }}/transactions/{{ page.transaction_id }}",
            "created": "2022-01-26T14:00:03.4725904Z",
            "updated": "2022-01-26T14:00:04.3851302Z",
            "type": "Reversal",
            "state": "Completed",
            "number": 71100730898,
            "amount": 1500,
            "vatAmount": 375,
            "description": "Reversing the capture amount",
            "payeeReference": "ABC123",
            "receiptReference": "ABC122"
            "isOperational": false,
            "reconciliationNumber": 738180,
            "operations": []
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

| Property                          | Type         | Description                                                                                                                                                                                                  |
| :-------------------------------- | :----------- | :-------------------------------------------------------------------------------- |
| {% f payment, 0 %}                | `string`     | The relative URL of the payment this reversal transaction belongs to.             |
| {% f reversals, 0 %}              | `object`     | The reversal object, containing information about the reversal transaction.       |
| {% f id %}                        | `string`     | The relative URL of the reversal transaction.                                     |
| {% f transaction %}               | `object`     | {% include fields/transaction.md %}                                               |
| {% f id, 2 %}                     | `string`     | The relative URL of the current `transaction` resource.                           |
| {% f created, 2 %}                | `string`     | The ISO-8601 date and time of when the transaction was created.                   |
| {% f updated, 2 %}                | `string`     | The ISO-8601 date and time of when the transaction was updated.                   |
| {% f type, 2 %}                   | `string`     | Indicates the transaction type.                                                   |
| {% f state, 2 %}                  | `string`     | {% include fields/state.md %}                                                     |
| {% f number, 2 %}                 | `integer`    | {% include fields/number.md %}                                                    |
| {% f amount, 2 %}                 | `integer`    | {% include fields/amount.md %}                                                    |
| {% f vatAmount, 2 %}              | `integer`    | {% include fields/vat-amount.md %}                                                |
| {% f description, 2 %}            | `string`     | A human readable description of maximum 40 characters of the transaction.         |
| {% f payeeReference, 2 %}         | `string(30)`     | {% include fields/payee-reference.md describe_receipt=true %}                     |
| {% f receiptReference %}          | `string(30)` | {% include fields/receipt-reference.md %}                                         |
| {% f isOperational, 2 %}          | `boolean`    | `true`  if the transaction is operational; otherwise  `false` .                   |
| {% f reconciliationNumber, 2 %}   | `string`     | The number of the reconciliation batch file where the transaction can be found.   |
| {% f operations, 2 %}             | `array`      | {% include fields/operations.md %}                                                |
{% endcapture %}
{% include accordion-table.html content=table %}

### Done With The Basics

You have reached the final step of the basic payment implementation and should
be able to validate that everything works as intended, or maybe it's time for
[acceptance tests][acceptance-test]?

Some of our payment methods require a few additional steps before they can
be activated and become available in your payment UI. Read more about them
and what you need to do by clicking the cards below.

There are other features and capabilities you can add to tailor the payment
requests in order to meet your business needs. See what else we can offer by
clicking **Additional Request Options**.

{% include card-list.html card_list=page.card_list col_class="col-lg-3" %}

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{% include iterator.html prev_href="/checkout-v3/get-started/validate-status"
                         prev_title="Back To Validate Status"
                         next_href="/checkout-v3/features/"
                         next_title="Additional Request Options" %}

[problems]: /checkout-v3/features/technical-reference/problems
[acceptance-test]: /checkout-v3/get-started/#get-ready-to-go-live
