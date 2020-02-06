{% assign payment_instrument = include.payment_instrument | default: 'creditcard' %}

A payment contains sub-resources in the form of `transactions`. Most operations
performed on a payment ends up as a transaction. The different types of
operations that alter the state of the payment by creating a transaction is
described below.

The `transactions` resource will list the transactions (one or more) on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/transactions HTTP/1.1
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
    "payment": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}",
    "transactions": {
        "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/transactions",
        "transactionList": [{
            "id": "/psp/{{ payment_instrument }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",{% if payment_instrument == "swish" %}
            "type": "Sale",{% else %}
            "type": "Authorization",{% endif %}
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test authorization",
            "payeeReference": "PR1004",
            "failedReason": "",
            "isOperational": true,
            "operations": []
        }]
    }
}
```

{:.table .table-striped}
| Property                    | Type     | Description                                                             |
| :-------------------------- | :------- | :---------------------------------------------------------------------- |
| `payment`                   | `string` | The relative URI of the payment this list of transactions belong to.    |
| `transactions`              | `object` | The transactions object.                                                |
| └➔&nbsp;`id`                | `string` | The relative URI of the current `transactions` resource.                |
| └➔&nbsp;`transactionList`   | `array`  | The array of transaction objects.                                       |
| └➔&nbsp;`transactionList[]` | `object` | The transaction object (described in the `transaction` resource below). |
