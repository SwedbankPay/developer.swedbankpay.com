{% assign api_resource = include.api_resource | default: "creditcard" %}
{% assign documentation_section = include.documentation_section %}
{% assign show_status_operations = include.show_status_operations | default:
false %}
{% case api_resource %}
{% when "vipps" %}
  {% assign language = "nb-NO" %}
  {% assign currency = "NOK" %}
{% when "mobilepay" %}
  {% assign language = "da-DK" %}
  {% assign currency = "DKK" %}
{% else %}
  {% assign language = "sv-SE" %}
  {% assign currency = "SEK" %}
{% endcase %}

## Payment Resource

The `payment` resource is central to all payment instruments. All operations
that target the payment resource directly produce a response similar to the
example seen below. The response given contains all operations that are
possible to perform in the current state of the payment.

{:.code-view-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": {% if documentation_section == "trustly" %}"Sale",{% else %}"Authorization", {% endif %}
        "currency": "{{ currency }}",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "{{ language }}",
        "prices": {
            "id": "/psp/{{ api_resource}}/payments/{{ page.payment_id }}/prices"
        },
        "payeeInfo": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payeeInfo"
        },
        "urls": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/urls"
        },
        "transactions": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions"
        }{% unless api_resource == "swish" or api_resource == "trustly" %},
        "authorizations": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations"
        }{% endunless %},{% unless api_resource == "trustly" %}
        "captures": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/captures"
        },{% endunless %}
        "reversals": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/reversals"
        },{% unless api_resource == "trustly" %}
        "cancellations": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/cancellations"
        }{% endunless %}
    },
    "operations": [ {%- case api_resource -%}
    {%- when "swish" -%}
        {% include api-operation.md api_resource=api_resource operation="create-sale" href_tail="sales" %},
        {% include api-operation.md api_resource=api_resource operation="redirect-sale" %},
        {% include api-operation.md api_resource=api_resource operation="view-sales" %},
        {% include api-operation.md api_resource=api_resource operation="view-payment" %},
        {%- when "trustly" -%}
        {% include api-operation.md api_resource=api_resource operation="create-sale" href_tail="sales" %},
        {% include api-operation.md api_resource=api_resource operation="redirect-sale" %},
        {% include api-operation.md api_resource=api_resource operation="view-sales" %},
        {% include api-operation.md api_resource=api_resource operation="update-payment-abort" %},
        {% include api-operation.md api_resource=api_resource operation="paid-payment" href_tail="paid" %},
        {% include api-operation.md api_resource=api_resource operation="failed-payment" href_tail="failed" %}
        {%- when "invoice" -%}
        {% include api-operation.md api_resource=api_resource operation="create-authorization" href_tail="operation=authorize" %},
        {% include api-operation.md api_resource=api_resource operation="view-authorization" href_tail="operation=authorize" %},
        {% include api-operation.md api_resource=api_resource operation="redirect-authorization" %},
        {% else %},
        {% include api-operation.md api_resource=api_resource operation="view-authorization" href_tail="operation=authorize" %},
        {% include api-operation.md api_resource=api_resource operation="redirect-authorization" %},
        {%- endcase -%}
        {% if show_status_operations %}
        {% include api-operation.md api_resource=api_resource operation="update-payment-abort" %},
        {% include api-operation.md api_resource=api_resource operation="create-capture" href_tail="captures" %},
        {% include api-operation.md api_resource=api_resource operation="paid-payment" href_tail="paid" %},
        {% include api-operation.md api_resource=api_resource operation="failed-payment" href_tail="failed" %}
        {% endif %}
    ]
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :----------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md %}                                                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`number`         | `integer`    | The payment  number , useful when there's need to reference the payment in human communication. Not usable for programmatic identification of the payment, for that  id  should be used instead.                                                                                                                                                           |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`state`          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| └➔&nbsp;`prices`         | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`prices.id`      | `string`     | {% include field-description-id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| └➔&nbsp;`description`    | `string` | {% include field-description-description.md documentation_section=documentation_section %}                                                                                                                                                                                                                                                                     |
| └➔&nbsp;`payerReference`    | `string(40)` | {% include field-description-payer-reference.md documentation_section=include.documentation_section %}                                                                                                                                                                                                         |
| └➔&nbsp;`userAgent`      | `string`     | The [user agent][user-agent] string of the payer's browser.                                                                                                                                                                                                                                                                                             |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md api_resource=api_resource %}                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`urls`           | `string`     | The URI to the  urls  resource where all URIs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| └➔&nbsp;`payeeInfo`      | `string`     | {% include field-description-payeeinfo.md documentation_section=include.documentation_section %}                                                                                                                                                                                                                                                 |
| `operations`             | `array`      | The array of possible operations to perform                                                                                                                                                                                                                                                                                                                |
| └─➔&nbsp;`method`        | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`href`          | `string`     | The target URI to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| └─➔&nbsp;`rel`           | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |

### Operations

The operations should be performed as described in each response and not as
described here in the documentation.
Always use the `href` and `method` as specified in the response by finding
the appropriate operation based on its `rel` value.
The only thing that should be hard coded in the client is the value of
the `rel` and the request that will be sent in the HTTP body of the request
for the given operation.

{% case api_resource %}

{% when "creditaccount" %}

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| `update-payment-abort`   | `abort`s the payment order before any financial transactions are performed.                                               |
| `redirect-authorization` | Contains the URI that is used to redirect the payer to the Swedbank Pay payment page containing the card authorization UI. |
| `create-capture`         | Creates a `capture` transaction in order to charge the reserved funds from the payer.                                  |
| `create-cancellation`    | Creates a `cancellation` transaction that cancels a created, but not yet captured, payment.                                |

{% when "swish" %}

{:.table .table-striped}
| Operation              | Description                                                                                                                                                               |
| :--------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `update-payment-abort` | `abort`s the payment order before any financial transactions are performed.                                                                                               |
| `create-sale`          | Creates a `sales` transaction without redirection to a payment page.                                                                                                      |
| `redirect-sale`        | Contains the redirect-URI that redirects the payer to a Swedbank Pay hosted payment page prior to creating a sales transaction.                                        |
| `view-sales`           | Contains the URI of the JavaScript used to create a Seamless View iframe directly for the `sale` transaction without redirecting the payer to a separate payment page. |
| `view-payment`         | Contains the URI of the JavaScript used to create a Seamless View iframe directly without redirecting the payer to separate payment page.                                |

{% when "trustly" %}

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| `update-payment-abort`   | `abort`s the payment order before any financial transactions are performed.                                               | 
| `paid-payment`           | Returns the information about a payment that has the status `paid`.                                                       |
| `failed-payment`         | Returns the information about a payment that has the status `failed`.                                                     |
| `view-sale`             | Contains the URI of the JavaScript used to create a Seamless View iframe directly for the `sale` transaction without redirecting the payer to a separate payment page. |

{% when "invoice" %}

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| `update-payment-abort`   | `abort`s the payment order before any financial transactions are performed.                                               |
| `redirect-authorization` | Contains the URI that is used to redirect the payer to the Swedbank Pay Payments containing the card authorization UI. |
| `view-authorization`     | Contains the JavaScript `href` that is used to embed the card authorization UI directly on the webshop/merchant site     |
| `create-capture`         | Creates a `capture` transaction in order to charge the reserved funds from the payer.                                  |
| `create-cancellation`    | Creates a `cancellation` transaction that cancels a created, but not yet captured payment.                                |
| `paid-payment`           | Returns the information about a payment that has the status `paid`.                                                       |
| `failed-payment`         | Returns the information about a payment that has the status `failed`.                                                     |

{% else %}

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| `update-payment-abort`   | `abort`s the payment order before any financial transactions are performed.                                               |
| `redirect-authorization` | Contains the URI that is used to redirect the payer to the Swedbank Pay Payments containing the card authorization UI. |
| `view-authorization`     | Contains the JavaScript `href` that is used to embed the card authorization UI directly on the webshop/merchant site     |
| `view-payment`           | Contains the URI of the JavaScript to create a Seamless view iframe directly without redirecting the payer to a separate payment page.     |
| `create-capture`         | Creates a `capture` transaction in order to charge the reserved funds from the payer.                                  |
| `create-cancellation`    | Creates a `cancellation` transaction that cancels a created, but not yet captured payment.                                |
| `paid-payment`           | Returns the information about a payment that has the status `paid`.                                                       |
| `failed-payment`         | Returns the information about a payment that has the status `failed`.                                                     |

{% endcase %}

[user-agent]: https://en.wikipedia.org/wiki/User_agent
