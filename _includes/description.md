{% assign api_resource = include.api_resource | default: "creditcard" %}
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

## Description

The `description` field is a 40 character length textual summary of the
purchase. It is needed to specify what payer is actually purchasing. Below you
will find an abbreviated Card Payments `Purchase` request.

As you can see the `description` field is set to be `test purchase -
orderNumber28749347` in the the code example. The images below will show you the
payment UI for the Redirect and Seamless View scenario.

{% include alert.html type="informative" icon="info" body="Notice that for Redirect,
the description will be shown as `test purchase - orderNumber28749347`, as set
in the code example. For the Seamless View scenario, the description is not
shown in the payment window, but it is still required in the initial request."
%}

{:.code-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "{{ currency }}",
        "prices": [{
                "type": "CreditCard",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "test purchase - orderNumber28749347",
        "generatePaymentToken": false,
        "generateRecurrenceToken": false,
        "userAgent": "Mozilla/5.0...",
        "language": "{{ language }}",
        "urls":
            "hostUrls": ["https://example.com"],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.pdf",
        }
}
```

![description field in redirect view][description-field-redirect]{:width="1200px"
:height="500px"}

![description field in seamless-view][description-field-seamless]{:width="1200px"
:height="500px"}

[description-field-redirect]: /assets/screenshots/description-field/description-field-redirect.png
[description-field-seamless]: /assets/screenshots/description-field/description-field-seamless.png
