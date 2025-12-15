{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
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

The `payment` resource is central to all payment methods. All operations
that target the payment resource directly produce a response similar to the
example seen below. The response given contains all operations that are
possible to perform in the current state of the payment.

## GET Payment Resource Request

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

## GET Payment Resource Response

{% capture response_header %}
HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
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
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "{{ language }}",
        "prices": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/prices"
        },
        "payeeInfo": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payeeInfo"
        },
        "payers": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payers"
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
        {% include utils/api-operation.md operation="create-sale" href_tail="sales" %},
        {% include utils/api-operation.md operation="redirect-sale" %},
        {% include utils/api-operation.md operation="view-sales" %},
        {% include utils/api-operation.md operation="view-payment" %},
    {%- when "trustly" -%}
        {% include utils/api-operation.md operation="create-sale" href_tail="sales" %},
        {% include utils/api-operation.md operation="redirect-sale" %},
        {% include utils/api-operation.md operation="view-sale" %},
        {% include utils/api-operation.md operation="update-payment-abort" %},
        {% include utils/api-operation.md operation="paid-payment" href_tail="paid" %},
        {% include utils/api-operation.md operation="failed-payment" href_tail="failed" %}
    {%- when "invoice" -%}
        {% include utils/api-operation.md operation="create-authorization" href_tail="operation=authorize" %},
        {% include utils/api-operation.md operation="view-authorization" href_tail="operation=authorize" %},
        {% include utils/api-operation.md operation="redirect-authorization" %},
        {% else %},
        {% include utils/api-operation.md operation="view-authorization" href_tail="operation=authorize" %},
        {% include utils/api-operation.md operation="redirect-authorization" %},
    {%- endcase -%}
    {% if show_status_operations %}
        {% include utils/api-operation.md operation="update-payment-abort" %},
        {% include utils/api-operation.md operation="create-capture" href_tail="captures" %},
        {% include utils/api-operation.md operation="paid-payment" href_tail="paid" %},
        {% include utils/api-operation.md operation="failed-payment" href_tail="failed" %}
    {% endif %}
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field                  | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :--------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}     | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| {% f id %}             | `string`     | {% include fields/id.md %}                                                                                                                                                                                                                                                                                                                      |
| {% f number %}         | `integer`    | {% include fields/number.md resource="payment" %}                                                                                                                                                           |
| {% f created %}        | `date(string)`     | The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the payment was created.                                                                                                                                                                                                                                                                                                       |
| {% f updated %}        | `date(string)`     | The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| {% f state %}          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| {% f prices %}         | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                      |
| {% f prices.id %}      | `string`     | {% include fields/id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| {% f description %}    | `string`     | {% include fields/description.md %}                                                                                                                                                                                                                                                                     |
| {% f userAgent %}      | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                             |
| {% f language %}       | `enum(string)`     | {% include fields/language.md %}                                                                                                                                                                                                                                                                                      |
| {% f urls %}           | `string`     | The URL to the  urls  resource where all URLs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| {% f payeeInfo %}      | `object`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                 |
| {% f payers %}         | `string`     | The URL to the `payer` resource where the information about the payer can be retrieved.                                                        |
| {% f operations, 0 %}  | `array`      | {% include fields/operations.md resource="payment" %}                                                                                                                                                                                                                                                                                                               |
| {% f method, 2 %}      | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| {% f href, 2 %}        | `string`     | The target URL to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| {% f rel, 2 %}         | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |

## Operations

The operations listed in this documentation are examples. Refer to your actual
response for the correct information. Always use the `href` and `method` as
specified in the response by finding the appropriate operation based on its
`rel` value. The only thing that should be hard coded in the client is the value
of the `rel` and the request that will be sent in the HTTP body of the request
for the given operation.

{% case api_resource %}

{% when "creditaccount" %}

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| {% f update-payment-abort, 0 %}   | `abort`s the payment order before any financial transactions are performed.                                               |
| {% f redirect-authorization, 0 %} | Contains the URL that is used to redirect the payer to the Swedbank Pay payment page containing the card authorization UI. |
| {% f create-capture, 0 %}         | Creates a `capture` transaction in order to charge the reserved funds from the payer.                                  |
| {% f create-cancellation, 0 %}    | Creates a `cancellation` transaction that cancels a created, but not yet captured, payment.                                |

{% when "swish" %}

{:.table .table-striped}
| Operation              | Description                                                                                                                                                               |
| :--------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f update-payment-abort, 0 %} | `abort`s the payment order before any financial transactions are performed.                                                                                               |
| {% f create-sale, 0 %}          | Creates a `sales` transaction without redirection to a payment page.                                                                                                      |
| {% f redirect-sale, 0 %}        | Contains the redirect-URL that redirects the payer to a Swedbank Pay hosted payment page prior to creating a sales transaction.                                        |
| {% f view-sales, 0 %}           | Contains the URL of the JavaScript used to create a Seamless View iframe directly for the `sale` transaction without redirecting the payer to a separate payment page. |
| {% f view-payment, 0 %}         | Contains the URL of the JavaScript used to create a Seamless View iframe directly without redirecting the payer to separate payment page.                                |

{% when "trustly" %}

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| {% f update-payment-abort, 0 %}   | `abort`s the payment order before any financial transactions are performed.                                               |
| {% f paid-payment, 0 %}           | Returns the information about a payment that has the status `paid`.                                                       |
| {% f failed-payment, 0 %}         | Returns the information about a payment that has the status `failed`.                                                     |
| {% f view-sale, 0 %}             | Contains the URL of the JavaScript used to create a Seamless View iframe directly for the `sale` transaction without redirecting the payer to a separate payment page. |

{% when "invoice" %}

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| {% f update-payment-abort, 0 %}   | `abort`s the payment order before any financial transactions are performed.                                               |
| {% f redirect-authorization, 0 %} | Contains the URL that is used to redirect the payer to the Swedbank Pay Payments containing the card authorization UI. |
| {% f view-authorization, 0 %}     | Contains the JavaScript `href` that is used to embed the card authorization UI directly on the webshop/merchant site     |
| {% f create-capture, 0 %}         | Creates a `capture` transaction in order to charge the reserved funds from the payer.                                  |
| {% f create-cancellation, 0 %}    | Creates a `cancellation` transaction that cancels a created, but not yet captured payment.                                |
| {% f paid-payment, 0 %}           | Returns the information about a payment that has the status `paid`.                                                       |
| {% f failed-payment, 0 %}         | Returns the information about a payment that has the status `failed`.                                                     |

{% else %}

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| {% f update-payment-abort, 0 %}   | `abort`s the payment order before any financial transactions are performed.                                               |
| {% f redirect-authorization, 0 %} | Contains the URL that is used to redirect the payer to the Swedbank Pay Payments containing the card authorization UI. |
| {% f view-authorization, 0 %}     | Contains the JavaScript `href` that is used to embed the card authorization UI directly on the webshop/merchant site     |
| {% f view-payment, 0 %}           | Contains the URL of the JavaScript to create a Seamless view iframe directly without redirecting the payer to a separate payment page.     |
| {% f create-capture, 0 %}         | Creates a `capture` transaction in order to charge the reserved funds from the payer.                                  |
| {% f create-cancellation, 0 %}    | Creates a `cancellation` transaction that cancels a created, but not yet captured payment.                                |
| {% f paid-payment, 0 %}           | Returns the information about a payment that has the status `paid`.                                                       |
| {% f failed-payment, 0 %}         | Returns the information about a payment that has the status `failed`.                                                     |

{% endcase %}
