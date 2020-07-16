{% assign api_resource = include.api_resource | default: 'creditcard' %}
{% assign documentation_section = include.documentation_section %}

{% if documentation_section == "checkout" or documentation_section == "payment-menu" %}
{% assign this_documentation_url = documentation_section %}
{% else %}
{% assign this_documentation_url = "payments/" | append: documentation_section %}
{% endif %}

The `transaction` resource contains the generic details of a transaction on a
specific payment.

When a transaction is created it will have one of three states:

*   `Initialized` - if there is some error where the source is undeterminable
    (network failure, etc), the transaction will remain Initialized. The
    corresponding state of the payment order will in this case be set to
    pending.
    No further transactions can be created.
*   `Completed` - if everything went ok the transaction will follow through to
    completion.
*   `Failed` - if the transaction has failed (i.e. a denial from the acquiring
    bank) it is possible to retry (i.e the consumer tries using another credit
    card) up to a maximum amount of retries (in that case which the payment
    order gets the state `failed` as well).

{:.code-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions HTTP/1.1
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
    "transaction": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
        "created": "2016-09-14T01:01:01.01Z",
        "updated": "2016-09-14T01:01:01.03Z",
        "type": "Capture",
        "state": "Initialized",
        "number": 1234567890,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction",
        "payeeReference": "AH123456",
        "failedReason": "",
        "isOperational": true,
        "operations": []
    }
}
```

In the event that a transaction is `failed`, the `transaction` response will contain
a `problem` property as seen in the example below. To view all the problems that
can occur due to an unsuccesful transaction, head over to the [problems section](/{{ this_documentation_url }}/other-features#problems).

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "transaction": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
        "created": "2016-09-14T01:01:01.01Z",
        "updated": "2016-09-14T01:01:01.03Z",
        "type": "Capture",
        "state": "Failed",
        "number": 1234567890,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction",
        "payeeReference": "AH123456",
        "isOperational": true,
        "activities": { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}/activities" },
        "problem": {
          "type": "https://api.payex.com/psp/errordetail/{{ api_resource }}/3DSECUREERROR",
          "title": "Error when complete authorization",
          "status": 400,
          "detail": "Unable to complete 3DSecure verification!",
          "problems": [
          ]
    }
    "operations": [
    ]
  }
}
```

{:.table .table-striped}
| Property                 | Type      | Description                                                                                                                                                                                                  |
| :----------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                | `string`  | The relative URI of the payment this transaction belongs to.                                                                                                                                                 |
| `transaction`            | `object`  | The transaction object.                                                                                                                                                                                      |
| └➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| └➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └➔&nbsp;`amount`         | `integer` | {% include field-description-amount.md %}                                                                                                                                                                    |
| └➔&nbsp;`vatAmount`      | `integer` | {% include field-description-vatamount.md %}                                                                                                                                                                 |
| └➔&nbsp;`description`    | `string`  | {% include field-description-description.md documentation_section=documentation_section %}                                                                                                                   |
| └➔&nbsp;`payeeReference` | `string`  | {% include field-description-payee-reference.md documentation_section=documentation_section describe_receipt=true %}                                                                                         |
| └➔&nbsp;`failedReason`   | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| └➔&nbsp;`isOperational`  | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| └➔&nbsp;`operations`     | `array`   | The array of operations that are possible to perform on the transaction in its current state.                                                                                                                |
