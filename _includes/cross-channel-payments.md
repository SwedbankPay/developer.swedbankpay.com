## Cross Channel Payments

Swedbank Pay's Checkout v3 API is built in a way that depends on that you, as a
merchant, is able to store the `paymentOrderId`. The `paymentOrderId` is a URL
which points to the specific instance of a payment order resource, but in some
cases it will be hard to use it as a payment reference.

To help you keep track of the transaction easier, we provide a unique
identification called `referenceCode` in all v3 implementations. The code can
then be printed and, for instance, used as a scannable barcode for future
tracking.

The `referenceCode` isn't available by default, but needs to be activated by us
to appear in your payment order responses.

## Reference Code Query

When enabled, the `referenceCode` will appear as a 16 digit code in the expanded
`paid` field when the payment is fully paid.

In addition to the regular `GET` method, you may obtain information about the
payment by doing a `QUERY` with the `referenceCode` in the JSON body as shown in
the below example.

Both `GET` and `QUERY` responses will look like the abbreviated `paid`
example below. The parts omitted from this example will look like the response
from a regular `GET` request.

## GET Request

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

## QUERY Request

{:.code-view-header}
**Request**

```http
QUERY /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "referenceCode": 1717224235360011
}
```

## GET And QUERY Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "Creditcard",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "referenceCode": "1717224235360011"
    "details": {}
  }
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| `paymentorder`           | `object`     | The payment order object.                      |
| `paid`                | `object`     | The paid object.                     |
| └➔&nbsp;`id`             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| └➔&nbsp;`instrument`             | `string`     | Payment instrument used in the cancelled payment. |
| └─➔&nbsp;`number`         | `string`  | The transaction number, useful when there's a need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where id should be used instead. |
| └─➔&nbsp;`payeeReference`          | `string` | {% include fields/payee-reference.md %} |
| └➔&nbsp;`amount`                   | `integer`    | {% include fields/amount.md %}                                            |
| └─➔&nbsp;`referenceCode`          | `string` | A 16 digit reference code which can be used for tracking payments.  |
| └➔&nbsp;`details`                   | `integer`    | Details connected to the payment. |
