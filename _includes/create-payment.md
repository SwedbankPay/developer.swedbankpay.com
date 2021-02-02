{% capture documentation_section %}{% include documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}

## Create Payment

Within the {{ documentation_section }} part of the eCommerce API, you can create
the following kinds of payments:

1.  [Purchase][purchase]
2.  [Recurrence][recur]
3.  [Verification][verify]
{%- if documentation_section != 'invoice' %}
4.  [Payout][payout]
{%- endif %}

To create a {{ documentation_section }} payment, you perform an HTTP `POST`
against the `payments` resource. The kind of payment created is indicated with
the value of the `operation` field in the request.

{:.code-view-header}
**Request**"

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
| {% icon check %} | `payment`           | `object` | The `payment` object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`operation` | `string` | Determines the initial operation, that defines the type card payment created.<br> <br> `Purchase`. Used to charge a card. It is followed up by a capture or cancel operation.<br> <br> `Recur`: Used to charge a card on a recurring basis. Is followed up by a capture or cancel operation (if not Autocapture is used, that is).<br> <br>`Payout`. Used to deposit funds directly to credit card. No more requests are necessary from the merchant side.<br> <br>`Verify`. Used when authorizing a card withouth reserveing any funds.  It is followed up by a verification transaction. |
| {% icon check %} | └➔&nbsp;`intent`    | `string` | The intent of the payment identifies how and when the charge will be effectuated. This determine the type transactions used during the payment process.<br> <br>`Authorization`: Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br>`AutoCapture`. A one phase-option that enable capture of funds automatically after authorization.                                                                                                                                                                                         |

[cancel]: {{ features_url }}/core/cancel
[capture]: {{ features_url }}/core/capture
[purchase]: {{ features_url }}/technical-reference/purchase
[payout]: {{ features_url }}/optional/payout
[recur]: {{ features_url }}/optional/recur
[verify]: {{ features_url }}/optional/verify
