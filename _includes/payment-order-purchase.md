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
        "language": "sv-SE",{% if documentation_section contains "payment-menu" %}
        "instrument": null,
        "generatePaymentToken": {{ operation_status_bool }},{% endif %}
        "generateRecurrenceToken": {{ operation_status_bool }},
        "generateUnscheduledToken": {{ operation_status_bool }},
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditions.pdf",
            "logoUrl": "https://example.com/logo.png"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        },
        "payer": {  {% if documentation_section contains "checkout" %}
            "consumerProfileRef": "{{ page.payment_token }}"{% else %}
            "email": "olivia.nyhuus@payex.com",
            "msisdn": "+4798765432",
            "workPhoneNumber" : "+4787654321",
            "homePhoneNumber" : "+4776543210"{% endif %}
        },
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
                "quantity": 5,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 0,
                "vatPercent": 2500,
                "amount": 1500,
                "vatAmount": 375
            }
        ],
        "riskIndicator": {
            "deliveryEmailAddress": "olivia.nyhuus@payex.com",
            "deliveryTimeFrameIndicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
                "name": "Olivia Nyhus",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
            }
        }
    }
}
```

## Payment Order Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",{% if documentation_section contains "payment-menu" %}
        "instrument": "CreditCard",
        "paymentToken" : "{{ page.payment_token }}",{% endif %}
        "recurrenceToken": {{ page.recurrence_token }},
        "unscheduledToken": {{ page.unscheduled_token }},
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 10000,
        "vatAmount": 0,
        "orderItems": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        },
        "description": "test description",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/payeeInfo"
        },
        "payments": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/payments"
        },
        "currentPayment": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/currentpayment"
        },
        "items": [
            {
                "creditCard": {
                    "cardBrands": [
                        "Visa",
                        "MasterCard"
                    ]
                }
            }
        ]
    }
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.front_end_url }}/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.front_end_url }}/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-expandinstrument",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        }
    ]
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
| {% icon check %} | {% f instrument %}               | `string`     | The payment instrument used. Selected by using the {% if documentation_section contains "payment-menu" %}[Instrument Mode]({{ features_url }}/optional/instrument-mode){% else %}Instrument Mode{% endif %}.                                                                                                   |
{% if documentation_section contains "payment-menu" -%}
|                  | {% f generatePaymentToken %}     | `bool`       | Determines if a payment token should be generated. A payment token is used to enable future [one-click payments]({{ features_url }}/optional/one-click-payments) – with the same token. Default value is `false`.                                               |
{% endif -%}
|                  | {% f generateRecurrenceToken %}  | `bool`       | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable future [recurring payments]({{ features_url }}/optional/recur) – with the same token – through server-to-server calls. Default value is `false`.                                               |
|                  | {% f generateUnscheduledToken %} | `bool`       | Determines if an unscheduled token should be generated. An unscheduled token is primarily used to enable future [unscheduled payments]({{ features_url }}/optional/unscheduled) – with the same token – through server-to-server calls. Default value is `false`.                                                  |
| {% icon check %} | {% f userAgent %}                | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f language %}                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f hostUrls, 2 %}                | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                    |
| {% icon check %} | {% f completeUrl, 2 %}             | `string`     | {% include fields/complete-url.md %} |
|                  | {% f cancelUrl, 2 %}               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
|                  | {% f paymentUrl, 2 %}              | `string`     | {% include fields/payment-url.md %} |
| {% icon check %} | {% f callbackUrl, 2 %}             | `string`     | {% include fields/callback-url.md %}                                                                                                                                                                                              |
| {% icon check %} | {% f termsOfServiceUrl, 2 %}       | `string`     | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f logoUrl, 2 %}                 | `string`     | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f payeeInfo %}                | `string`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f payeeId, 2 %}                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | {% f payeeName, 2 %}               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f productCategory, 2 %}         | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                           |
|                  | {% f orderReference, 2 %}          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
|                  | {% f subsite, 2 %}                 | `string(40)` | {% include fields/subsite.md %} |
|                  | {% f payer %}                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
{% if documentation_section contains "checkout" -%}
|        ︎︎︎          | {% f consumerProfileRef, 2 %}       | `string`    | The consumer profile reference as obtained through [initiating a consumer session](/{{ documentation_section }}/checkin#step-1-initiate-session-for-consumer-identification).                                                                                                                                                                                            |
{% endif -%}
|                  | {% f email, 2 %}                   | `string`     | The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for [frictionless 3-D Secure 2 flow]({{ features_url }}/core/3d-secure-2).                                                                             |
|                  | {% f msisdn, 2 %}                  | `string`     | The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).            |
|                  | {% f workPhoneNumber, 2 %}         | `string`     | The work phone number of the payer. Optional (increased chance for frictionless flow if set) and is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).                                                                                                                                     |
|                  | {% f homePhoneNumber, 2 %}         | `string`     | The home phone number of the payer. Optional (increased chance for frictionless flow if set) and is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).                                                                                                                                     |
| {% icon check %} | {% f orderItems %}               | `array`      | {% include fields/order-items.md %}                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f reference, 2 %}               | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f name, 2 %}                    | `string`     | The name of the order item.                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f type, 2 %}                    | `string`     | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE` `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item. `PAYMENT_FEE` is the amount you are charged with when you are paying with invoice. The amount can be defined in the `amount` field below.                                           |
| {% icon check %} | {% f class, 2 %}                   | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics.                                |
|                  | {% f itemUrl, 2 %}                 | `string`     | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                                               |
|        ︎︎︎          | {% f imageUrl, 2 %}                | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                                    |
|                  | {% f description, 2 %}             | `string`     | {% include fields/description.md %}                                                                                                                                                                                                                                                           |
|                  | {% f discountDescription, 2 %}     | `string`     | The human readable description of the possible discount.                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f quantity, 2 %}                | `number`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                                         |
| {% icon check %} | {% f quantityUnit, 2 %}            | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                                                                                                                                                    |
| {% icon check %} | {% f unitPrice, 2 %}               | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                                         |
|                  | {% f discountPrice, 2 %}           | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                                               |
| {% icon check %} | {% f vatPercent, 2 %}              | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                                                 |
| {% icon check %} | {% f amount, 2 %}                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f vatAmount, 2 %}               | `integer`    | {% include fields/vat-amount.md %}                                                     |
{% include risk-indicator-table.md %}
{% endcapture %}
{% include accordion-table.html content=table %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |{% if documentation_section contains "payment-menu" %}
| {% f instrument %}     | `string`     | The payment instrument used. Selected by using the [Instrument Mode]({{ features_url }}/optional/instrument-mode).                                                                                                           |
| {% f paymentToken %}   | `string`     | The payment token created if `generatePaymentToken: true` was used. Enables future [one-click payments]({{ features_url }}/optional/one-click-payments) – with the same token.                                                                                                  | {% endif %}                                              |
| {% f recurrenceToken %}   | `string`     | The recurrence token created if `generateRecurrenceToken: true` was used. Enables future [recurring payments]({{ features_url }}/optional/recur) – with the same token.                                                                                                  |
| {% f unscheduledToken %}   | `string`     | The unscheduled token created if `generateUnscheduledToken: true` was used. Enables future [unscheduled payments]({{ features_url }}/optional/unscheduled) – with the same token.                                                                                                  |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | `Purchase`                                                                                                                                                                                                                |
| {% f state %}          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes. |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f userAgent %}      | `string`     | {% include fields/user-agent.md %}                                                                                                                                                            |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f urls %}           | `string`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f payeeInfo %}      | `string`     | {% include fields/payee-info.md %}                                                                                                          |
| {% f payers %}         | `string`     | The URL to the `payer` resource where information about the payer can be retrieved.                                                                                                                |
| {% f orderItems %}     | `string`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f metadata %}       | `string`     | {% include fields/metadata.md %}                                                                                                                      |
| {% f payments %}       | `string`     | The URL to the `payments` resource where information about all underlying payments can be retrieved.                                                                                                                      |
| {% f currentPayment %} | `string`     | The URL to the `currentPayment` resource where information about the current – and sole active – payment can be retrieved.                                                                                                |
| {% f operations %}     | `array`      | {% include fields/operations.md %}                                                                                               |
{% endcapture %}
{% include accordion-table.html content=table %}
