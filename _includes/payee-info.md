{% assign documentation_section = include.documentation_section %}
{% assign api_resource = include.api_resource | default: "paymentorders" %}
{% assign length = 50 %}
{% case api_resource %}
{% when "paymentorders" %}
    {% assign length = 30 %}
{% when "swish" %}
    {% assign length = 35 %}
{% when "vipps" %}
    {% assign length = 30 %}
{% endcase %}

## PayeeInfo

The `payeeinfo` resource contains information about the payee (i.e. a merchant,
a corporation etc) related to a specific payment.

{:.code-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/payeeInfo HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "payeeInfo": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payeeInfo",
        "payeeId": "{{ page.merchant_id }}"
        "payeeReference": "EN1234",
        "payeeName": "TestMerchant1",
        "productCategory": "EF1234",
        "orderReference": "or-123456"
    }
}
```

{:.table .table-striped}
| Field                     | Type                 | Description                                                                                                                                                                                                                                                                       |
| :------------------------ | :------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                 | `string`             | {% include field-description-id.md sub_resource="payeeInfo" %}                                                                                                                                                                                                                    |
| └➔&nbsp;`id`              | `string`             | {% include field-description-id.md resource="payeeInfo" %}                                                                                                                                                                                                                        |
| └➔&nbsp;`payeeId`         | `string`             | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay                                                                                                                                                                                              |
| └➔&nbsp;`payeeReference`  | `string({{length}})` | {% include field-description-payee-reference.md documentation_section=documentation_section %}                                                                                                                                                                                    |
| └➔&nbsp;`payeeName`       | `string`             | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                           |
| └➔&nbsp;`productCategory` | `string`             | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process. You therefore need to ensure that the value given here is valid in the settlement. |
| └➔&nbsp;`orderReference`  | `string(50)`         | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                           |

{% include payee-reference.md api_resource = api_resource %}
