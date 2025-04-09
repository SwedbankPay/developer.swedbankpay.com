{% capture techref_url %}{% include utils/documentation-section-url.md href='/features/technical-reference' %}{% endcapture %}
{% assign transactions_url = '/transactions' | prepend: techref_url %}
{% assign operations_url = '/operations' | prepend: techref_url %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

{% if documentation_section contains "checkout-v3" %}

## Reversal

This transaction is used when a `Capture` or `Sale` payment needs to be
reversed.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
reversal. The payment will be locked after this, and you need to contact us for
another attempt.

## Create Reversal Transaction

If we want to reverse a previously captured amount, we need to perform
`reversal` against the accompanying `href` returned in the
`operations` list.

{% else %}

If we want to reverse a previously captured amount, we need to perform
`create-paymentorder-reversal` against the accompanying `href` returned in the
`operations` list.

{% endif %}

## Reversal Request

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

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

## Reversal Response

If the reversal request succeeds, the response should be similar to the example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0/2.0
api-supported-versions: 3.0/2.0{% endcapture %}

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
