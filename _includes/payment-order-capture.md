{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

{% if documentation_section contains "checkout-v2" %}

## Step 5: Capture

{% else %}

## Capture

{% endif %}

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

{% if documentation_section contains "checkout-v2" %}

To capture the authorized payment, we need to perform
`create-paymentorder-capture` against the accompanying `href` returned in the
`operations` list. See the abbreviated request and response below:

{% else %}

To capture the authorized payment, we need to perform `capture` against the
accompanying `href` returned in the `operations` list. See the abbreviated
request and response below:

{% endif %}

## Capture Request

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0/2.0      // Version optional{% endcapture %}

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

## Capture Response

If the capture request succeeds, this should be the response:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0/2.0
api-supported-versions: 3.0/2.0{% endcapture %}

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
| {% f payeeReference, 2 %}   | `string`     | {% include fields/payee-reference.md describe_receipt=true %}                                                                                              |
| {% f receiptReference, 2 %} | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation.  It is used to supplement `payeeReference` as an additional receipt number. |
{% endcapture %}
{% include accordion-table.html content=table %}

## Capture Sequence Diagram

{% if documentation_section contains "checkout-v2" %}

```mermaid
sequenceDiagram
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    rect rgba(81,43,43,0.1)
        activate Merchant
        note left of Payer: Capture
        Merchant ->>+ SwedbankPay: rel:create-paymentorder-capture
        deactivate Merchant
        SwedbankPay -->>- Merchant: Capture status
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>payment methods that support <br>Authorizations.
    end
```

{% else %}

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

{% endif %}

<!--lint disable final-definition -->
