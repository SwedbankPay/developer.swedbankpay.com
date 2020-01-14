{% assign instrument = include.payment-instrument | default: "paymentorder" %}

The `payeeinfo` resource contains information about the payee (i.e. a merchant,
a corporation etc) related to a specific payment.

{:.code-header}
**Request**

```http
GET /psp/{{ instrument }}/payments/{{ page.paymentId }}/payeeInfo HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/{{ instrument }}/payments/{{ page.paymentId }}",
    "payeeInfo": {
        "id": "/psp/{{ instrument }}/payments/{{ page.paymentId }}/payeeInfo",
        "payeeId": "{{ page.merchantId }}"
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

The `payeeReference` given when creating transactions and payments has some
specific processing rules depending on specifications in the contract.

* It must be unique for every operation, used to ensure exactly-once delivery of
a transactional operation from the merchant system.
* Its length and content validation is dependent on whether the
  `transaction.number` or the `payeeReference` is sent to the acquirer.
  * If you select Option A in the settlement process (Swedbank Pay will handle the
    settlement), Swedbank Pay will send the transaction.number to the acquirer and the
    `payeeReference` may have the format of string(30).
  * If you select Option B in the settlement process (you will handle the
    settlement yourself), Swedbank Pay will send the `payeeReference` to the acquirer
    and it will be limited to the format of string(12) and all characters must
    be digits.
