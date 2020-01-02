{% assign instrument = include.payment-instrument | default: "paymentorder" %}
{% assign transaction = include.transaction | default: "capture" %}

{:.code-header}
**Request**

```http
GET /psp{{ instrument }}/payments/{{ page.paymentId }}/{{ transaction | append "s" }} HTTP/1.1
Host: api.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp{{ instrument }}/payments/{{ page.paymentId }}",
    "{{ transaction | append "s" }}": {
        "id": "/psp{{ instrument }}/payments/{{ page.paymentId }}/{{ transaction | append "s" }}",
        "captureList": [{
            "id": "/psp{{ instrument }}/payments/{{ page.paymentId }}/{{ transaction | append "s" }}/{{ page.transactionId }}",
            "transaction": {
                "id": "/psp{{ instrument }}/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
                "created": "2016-09-14T01:01:01.01Z",
                "updated": "2016-09-14T01:01:01.03Z",
                "type": "Capture",
                "state": "Completed",
                "number": 1234567890,
                "amount": 1000,
                "vatAmount": 250,
                "description": "Test transaction",
                "payeeReference": "AH123456",
                "failedReason": "",
                "isOperational": false,
                "operations": []
            }
        }]
    }
}
```

{:.table .table-striped}
| Property                          | Type     | Required                                                                     |
| :-------------------------------- | :------- | :--------------------------------------------------------------------------- |
| `payment`                         | `string` | The relative URI of the payment this list of capture transactions belong to. |
| `{{ transaction | append "s" }}`  | `object` | The current `{{ transaction | append "s" }}` resource.                       |
| └➔&nbsp;`id`                      | `string` | The relative URI of the current `{{ transaction | append "s" }}` resource.   |
| └➔&nbsp;`{{ transaction }}List`   | `array`  | The array of capture transaction objects.                                    |
| └➔&nbsp;`{{ transaction }}List[]` | `object` | The capture transaction object described in the `capture` resource below.    |
