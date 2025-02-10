## Order Items

The `orderItems` field of the `paymentOrder` is an array containing information
about the items being purchased. **It is mandatory for v3.0 and older**
**implementations, but voluntary for payment order v3.1**, so feel free to
remove it from your requests if you want. If you offer invoice as a payment
option, the field is still recommended as it are used for the product details on
the customer's invoice. If they are not present, `orderItems` will be generated
by using the `description` and `amount` fields from the `paymentOrder`.

{% capture request_content %}"orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 5,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 0,
                "vatPercent": 2500,
                "amount": 1500,
                "vatAmount": 375
            }
        ]{% endcapture %}

{% include code-example.html
    title='Request Excerpt'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                 | Type      | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :-------------------- | :-------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | {% f orderItems %}               | `array`      | {% include fields/order-items.md %}                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f reference, 2 %}          | `string`  | A reference that identifies the order item.                                                                                                                                                                                                                                           |
| {% icon check %} | {% f name, 2 %}               | `string`  | The name of the order item.                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f type, 2 %}               | `enum`    | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `DISCOUNT`, `VALUE_CODE`, or `OTHER`. The type of the order item.                                                                                                                                                                               |
| {% icon check %} | {% f class, 2 %}              | `string`  | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics. |
|                  | {% f itemUrl, 2 %}           | `string`  | The URL to a page that can display the purchased item, such as a product page                                                                                                                                                                                                         |
|                  | {% f imageUrl, 2 %}          | `string`  | The URL to an image of the order item.                                                                                                                                                                                                                                                |
|                  | {% f description, 2 %}       | `string`  | The human readable description of the order item.                                                                                                                                                                                                                                     |
|                  | {% f discountDescription, 2 %}| `string`  | The human readable description of the possible discount.                                                                                                                                                                                                                              |
| {% icon check %} | {% f quantity, 2 %}         | `number` | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                      |
| {% icon check %} | {% f quantityUnit, 2 %}       | `string`  | The unit of the quantity, such as `pcs`, `grams`, or similar.                                                                                                                                                                                                                         |
| {% icon check %} | {% f unitPrice, 2 %}        | `integer` | The price per unit of order item, including VAT.                                                                                                                                                                                                                                      |
|                  | {% f discountPrice, 2 %}    | `integer` | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                            |
| {% icon check %} | {% f vatPercent, 2 %}        | `integer` | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                              |
| {% icon check %} | {% f amount, 2 %}            | `integer` | {% include fields/amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f vatAmount, 2 %}          | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                          |
{% endcapture %}
{% include accordion-table.html content=table %}
