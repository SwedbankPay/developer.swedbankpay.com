{% capture documentation_section %}{% include documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}

## Create Payment

Within the {{ documentation_section }} part of the eCommerce API, you can create
the following kind of payments:

*  [Purchase][purchase]
{%- if documentation_section == 'card' %}
*  [Payout][payout]
{%- endif %}
{%- if documentation_section == 'card' or documentation_section == 'invoice' %}
*  [Recurrence][recur]
*  [Verification][verify]
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
| {% icon check %} | └➔&nbsp;`operation` | `string` | Determines the initial operation, that defines the type of payment created.<br> <br> `Purchase`: Used to charge a card, an app or invoice the payer. It is followed by a `Capture` or `Cancel` operation.<br> <br> `Recur`: Used to charge a card or invoice on a recurring basis. Is followed by a `Capture` or `Cancel` operation.<br> <br>`Payout`: Used to deposit funds directly to the payer's card. No more requests are necessary from the merchant side.<br> <br>`Verify`. Used when verifying a card or invoice details without reserving funds. It is followed by a verification transaction. |
| {% icon check %} | └➔&nbsp;`intent`    | `string` | The intent of the payment identifies how and when the charge will be effectuated. This determine the type transactions used during the payment process.<br> <br>`Authorization`: Reserves the amount, and is followed by a `Cancel` or `Capture` of funds.<br> <br>`AutoCapture`: A one phase-option which `Capture`s funds automatically after authorization, or `Sale`, where the funds are drawn from an app or a bank account immediately upon completion.                                                                                                                                                                                          |

[purchase]: {{ features_url }}/technical-reference/purchase
[payout]: {{ features_url }}/optional/payout
[recur]: {{ features_url }}/optional/recur
[verify]: {{ features_url }}/optional/verify
