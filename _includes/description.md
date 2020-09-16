{% assign api_resource = include.api_resource | default: "creditcard" %}
{% assign documentation_section_title = documentation_section | capitalize %}
{% unless api_resource == "paymentorder" %}
  {% assign documentation_section_title = documentation_section_title | append: " Payments" %}
{% endunless %}

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

{% if api_resource == "creditcard" %}
    {% assign api_resource_field_name = "payment" %}
{% else %}
    {% assign api_resource_field_name = "paymentorder" %}
{% endif %}

## Description

The `description` field is a 40 character length textual summary of the
purchase. It is needed to specify what payer is actually purchasing. Below you
will find an abbreviated Card Payments `Purchase` request.

As you can see the `description` field is set to be `Test Description`
in the the code example.

{% include alert.html type="informative" icon="info" body="Notice that for Redirect,
the description will be shown as `Test - Reference1583419461`, as set
in the code example. For the Seamless View scenario, the description is not
shown in the payment window, but it is still required in the initial request."
%}

{:.code-view-header}
**Request**

```http
POST /psp/{{ api_resource }}/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
      "{{ api_resource_field_name }}": {
        "operation": "Purchase",
        "intent": {% if api_resource == "trustly" or api_resource == "swish" %} "Sale",{% else %} "Authorization", {% endif %}
        "currency": "{{ currency }}",{% if api_resource == "creditcard" %}
        "prices": [{
                "type": "CreditCard",
                "amount": 1500,
                "vatAmount": 0
            }
        ],{% endif %}
        "description": "Test Description",{% if include.documentation_section == "payment_menu" %}
        "generatePaymentToken": false,{% endif %}
        "generateRecurrenceToken": false,
        "userAgent": "Mozilla/5.0...",
        "language": "{{ language }}",
        "urls":
            "hostUrls": ["https://example.com"]
        }
}
```

{% if api_resource == "paymentorders" %}
{:.text-center}
![The description field as presented in the Payment Menu][description-paymentorders]{:width="475px"
:height="625px"}

{% else %}
{:.text-center}
![The description field as presented in {{ documentation_section_title }}][description-all-payments]{:width="475px"
:height="620px"}

{% endif %}

[description-all-payments]: /assets/screenshots/description-field/description-all-payments.png
[description-paymentorders]: /assets/screenshots/description-field/description-paymentorders.png
