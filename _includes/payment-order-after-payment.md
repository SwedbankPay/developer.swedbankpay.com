{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Operations

Most payment instruments are two-phase payments –
in which a successful payment order will result in an authorized transaction –
that must be followed up by a capture or cancellation transaction in a later
stage. One-phase payments like Swish are settled directly without the option to
capture or cancel. For a full list of the available operations, see the
[techincal reference][operations].

{:.table .table-striped}
| Operation                      | Description                                                                                                                                                                                                                                                                    |
| :----------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `create-paymentorder-capture`  | The second part of a two-phase transaction where the authorized amount is sent from the payer to the payee. It is possible to do a part-capture on a subset of the authorized amount. Several captures on the same payment are possible, up to the total authorization amount. |
| `create-paymentorder-cancel`   | Used to cancel authorized and not yet captured transactions. If a cancellation is performed after doing a part-capture, it will only affect the not yet captured authorization amount.                                                                                         |
| `create-paymentorder-reversal` | Used to reverse a payment. It is only possible to reverse a payment that has been captured and not yet reversed.                                                                                                                                                               |

## GET Request

To identify the operations that are available we need to do a `GET` request
against the URL of `paymentorder.id`:

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1/3.0/2.0      // Version optional for 3.0 and 2.0
```

## GET Response

The (abbreviated) response containing an `updateorder`, `capture`,
`cancellation`, and `reversal` operation should look similar to the response
below:

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1/3.0/2.0
api-supported-versions: 3.1/3.0/2.0

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}"
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}/captures",
            "rel": "create-paymentorder-capture",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}/cancellations",
            "rel": "create-paymentorder-cancel",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}/reversals",
            "rel": "create-paymentorder-reversal",
            "contentType": "application/json"
        }
    ]
}
```

{:.table .table-striped}
| Field          | Type     | Description                                                                        |
| :------------- | :------- | :--------------------------------------------------------------------------------- |
| {% f paymentOrder, 0 %} | `object` | The payment order object.                                                          |
| {% f id %}   | `string` | {% include fields/id.md resource="paymentorder" %}                      |
| {% f operations, 0 %}   | `array`  | {% include fields/operations.md %} |

## Cancel

{% include payment-order-cancel.md %}

## Reversal

{% include payment-order-reversal.md %}

{% include alert.html type="informative" icon="info" body=" Note that all of the
operations `Cancel`, `Capture` and `Reversal` must be implemented." %}

[operations]: {{ features_url }}/technical-reference/operations
