{% assign instrument = include.payment_instrument | default: "paymentorder" %}

## PayeeInfo

The `payeeinfo` resource contains information about the payee (i.e. a merchant,
a corporation etc) related to a specific payment.

{:.code-header}
**Request**

```http
GET /psp/{{ instrument }}/payments/{{ page.payment_id }}/payeeInfo HTTP/1.1
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
    "payment": "/psp/{{ instrument }}/payments/{{ page.payment_id }}",
    "payeeInfo": {
        "id": "/psp/{{ instrument }}/payments/{{ page.payment_id }}/payeeInfo",
        "payeeId": "{{ page.merchant_id }}"
        "payeeReference": "EN1234",
        "payeeName": "TestMerchant1",
        "productCategory": "EF1234",
        "orderReference": "or-123456"
    }
}
```

{:.table .table-striped}
| Property                  | Type         | Description                                                                                                                                                                                                                                                                       |
| :------------------------ | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                 | `string`     | The URI of the payment which the  `payeeinfo`  belongs to.                                                                                                                                                                                                                        |
| └➔&nbsp;`id`              | `string`     | The URI of the current  `payeeinfo`  resource.                                                                                                                                                                                                                                    |
| └➔&nbsp;`payeeId`         | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay                                                                                                                                                                                              |
| └➔&nbsp;`payeeReference`  | `string(50)` | A unique reference set by the merchant system. See below for details                                                                                                                                                                                                              |
| └➔&nbsp;`payeeName`       | `string`     | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                           |
| └➔&nbsp;`productCategory` | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process. You therefore need to ensure that the value given here is valid in the settlement. |
| └➔&nbsp;`orderReference`  | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                           |

### PayeeReference

{% include payee-reference.md payment_instrument = instrument %}
