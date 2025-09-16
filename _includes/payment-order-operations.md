{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

## Operations

When a payment order resource is created and during its lifetime, it will have a
set of operations that can be performed on it. The state of the payment order
resource, what the access token is authorized to do, the chosen payment method
and its transactional states, etc. determine the available operations before the
initial purchase. A list of possible operations and their explanation is given
below. Please note that these are the possible operations available in the
payment response, not what you set in the payment request.

{% if documentation_section contains "checkout-v3" %}

{% capture response_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-order",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "abort-paymentattempt",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}/cancellations",
            "rel": "cancel",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}/captures",
            "rel": "capture",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}/reversals",
            "rel": "reversal",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/073115b6226e834dd9b1665771bae76223b4488429729155587de689555c5539?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/core/js/px.checkout.client.js?token=073115b6226e834dd9b1665771bae76223b4488429729155587de689555c5539&culture=sv-SE&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        },
        {
            "method": "GET",
            "href": "https://api.externalintegration.payex.com/psp/paymentsessions/b0bb522437a5c9fa3783f7ba30680bef0c32b3de0fafe568bec6dbadfa7da8cf?_tc_tid=d49b520fa0314bcca78c75806dee8a17",
            "rel": "view-paymentsession",
            "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Operations'
    header=response_header
    json= response_content
    %}

{% else %}

{% capture response_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
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
        },
        {
            "method": "GET",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}/paid",
            "rel": "paid-paymentorder",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}/failed",
            "rel": "failed-paymentorder",
            "contentType": "application/problem+json"
        },
        {
            // Deprecated operation. Do not use!
            "method": "POST",
            "href": "{{ page.api_url }}/psp/creditcard/{{ page.payment_id }}/captures",
            "rel": "create-capture",
            "contentType": "application/json"
        },
        {
            // Deprecated operation. Do not use!
            "method": "POST",
            "href": "{{ page.api_url }}/psp/creditcard/{{ page.payment_id }}/cancellations",
            "rel": "create-cancel",
            "contentType": "application/json"
        },
        {
            // Deprecated operation. Do not use!
            "method": "POST",
            "href": "{{ page.api_url }}/psp/creditcard/{{ page.payment_id }}/reversals",
            "rel": "create-reversal",
            "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Operations'
    header=response_header
    json= response_content
    %}

{% endif %}

{:.table .table-striped}
| Field         | Type     | Description |
| :------------ | :------- | :---------- |
| `method`      | `string` | `GET`, `PATCH`, `POST`, etc. The HTTP method to use when performing the operation. |
| `href`        | `string` | The target URL to perform the operation against.                                   |
| `rel`         | `string` | The name of the relation the operation has to the current resource.                |
| `contentType` | `string` | The HTTP content type of the resource referenced in the `href` field.              |

The operations should be performed as described in each response and not as
described here in the documentation. Always use the `href` and `method` as
specified in the response by finding the appropriate operation based on its
`rel` value. The only thing that should be hard coded in the client is the value
of the `rel` and the request that will be sent in the HTTP body of the request
for the given operation.

{% if documentation_section contains "checkout-v3" %}

{:.table .table-striped}
| Operation  | Description   |
| :--------- | :------------ |
| `update-order` | Updates the order with a change in `orderItems`, `amount` and/or `vatAmount`.                                                                             |
| `abort`       | Aborts the payment order before any financial transactions are performed.                                                                              |
| `abort-paymentattempt`       | Aborts the payment attempt, but not the order as a whole, before any financial transactions are performed.                                                                              |
| `cancel`      | Used to cancel authorized and not yet captured transactions. If a cancellation is performed after doing a part-capture, it will only affect the not yet captured authorization amount.                                                                                     |
| `capture`     | The second part of a two-phase transaction where the authorized amount is sent from the payer to the payee. It is possible to do a part-capture on a subset of the authorized amount. Several captures on the same payment are possible, up to the total authorization amount. |
| `reversal`    | Used to reverse a payment. It is only possible to reverse a payment that has been captured and not yet reversed.                                                     |
| `redirect-checkout`           | Contains the URL used to redirect the payer to the Swedbank Pay Payments containing the Payment Menu.                                                      |
| `view-checkout`               | Contains the JavaScript `href` that is used to embed the Payment Menu UI directly on the webshop/merchant site.                                                                                                                                                                |
| `view-paymentsession`               | Contains the `href` used by merchants to launch our new SDK.                                                                                                                                                             |

{% else %}

{:.table .table-striped}
| Operation  | Description  |
| :----------| :----------- |
| `update-paymentorder-abort`       | Aborts the payment order before any financial transactions are performed.                                                                                                                                                                                        |
| `update-paymentorder-updateorder` | Updates the order with a change in the `amount` and/or `vatAmount`.                                                                                                                                                                                       |
| `redirect-paymentorder`           | Contains the URL used to redirect the payer to the Swedbank Pay Payments containing the Payment Menu.                                                                                                                                                               |
| `view-paymentorder`               | Contains the JavaScript `href` that is used to embed the Payment Menu UI directly on the webshop/merchant site.                                                                                                                                                                |
| `create-paymentorder-capture`     | The second part of a two-phase transaction where the authorized amount is sent from the payer to the payee. It is possible to do a part-capture on a subset of the authorized amount. Several captures on the same payment are possible, up to the total authorization amount. |
| `create-paymentorder-cancel`      | Used to cancel authorized and not yet captured transactions. If a cancellation is performed after doing a part-capture, it will only affect the not yet captured authorization amount.                                                                                         |
| `create-paymentorder-reversal`    | Used to reverse a payment. It is only possible to reverse a payment that has been captured and not yet reversed.                                                                                                                                                               |
| `paid-paymentorder`               | Returns the information about a paymentorder that has the status `paid`.                                                                                                                                                                                                       |
| `failed-paymentorder`             | Returns the information about a paymentorder that has the status `failed`.                                                                                                                                                                                                     |
| `create-capture`                  | **Deprecated operation. Do not use!**                                                                                                                                                                                                                                                     |
| `create-cancel`                   | **Deprecated operation. Do not use!**                                                                                                                                                                                                                                                     |
| `create-cancel`                   | **Deprecated operation. Do not use!**                                                                                                                                                                                                                                                     |

{% endif %}
