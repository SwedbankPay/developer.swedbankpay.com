{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Create Payment

Within the {{ documentation_section }} part of the eCommerce API, you can create
the following kind of payments:

{% if documentation_section == 'card' %}

*   [Purchase][purchase]
*   [Payout][payout]
*   [Recurrence][recur]
*   [Verification][verify]
{% else %}
*   Purchase
{% endif %}

To create a {{ documentation_section }} payment, you perform an HTTP `POST`
against the `payments` resource. The kind of payment created is indicated with
the value of the `operation` field in the request.

## Payment Request

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "<operation>",
        "intent": "<intent>",
    }
}
```

{:.table .table-striped}
|     Required     | Field               | Type     | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :--------------: | ------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}  | `object` | The `payment` object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f operation %}   | `string` | {% include fields/operation.md resource="payment" %}  |
| {% icon check %} | {% f intent %}      | `string` | {% include fields/intent.md %} |

[purchase]: {{ features_url }}/core/purchase
[payout]: /payment-instruments/card/features/optional/payout
[recur]: /payment-instruments/card/features/optional/recur
[verify]: /payment-instruments/card/features//optional/verify
