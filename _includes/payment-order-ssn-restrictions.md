{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include documentation-section.md %}{%
endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}

## Restrict Payments To A Social Security Number

Swedbank Pay provides the possibility to restrict payments to a Social Security
Number for payment instruments which support this. This can be used when you
want to make sure you only accept payments from an already identified
individual.

You do this by adding the field `restrictedToSocialSecurityNumber` in the `payer`
node, in your payment order request, and setting it to `true`. This will leave out
all instruments which do not support this feature.

It will then use the `socialSecurityNumber` located in the `nationalIdentifier`
node (found within the `payer` node). The `nationalIdentifier` must be included
to use this feature. Instruments supporting the feature will reject payments
that do not match the restriction.

{% if documentation_section contains "checkout-v3/enterprise" %} If you want to
use the Social Security Number just for payment restrictions, and not do a
checkout profile lookup, add the parameter `guestMode` in the
`nationalIdentifier` node and set it to `true`. {% endif %}

You are currently only able to restrict Swish and Trustly payments to a Social
Security Number, but we will add support for more payment instruments going
forward. No changes are required at your (the merchant’s) end to be able to
offer more instruments at a later time.

## Restrict To Social Security Number Request

The field itself is a `bool` which must be added in the `payer` node of the
request. Below is a shortened example of a payment order request. Apart from the
new field, the payment request is similar to a standard payment order request.
For an example of a payment order request, {% if documentation_section contains
"checkout-v3/enterprise" %} [click
here.](/checkout-v3/enterprise/redirect#payment-order-request) {% endif %} {% if
documentation_section contains "checkout-v3/payments-only" %} [click
here.](/checkout-v3/payments-only/redirect#payment-order-request) {% endif %}

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
    "payer": {
            "digitalProducts": false,
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE",
                "guestMode": true
             },
            "restrictedToSocialSecurityNumber": true,
            "firstName": "Leia",
            "lastName": "Ahlström",
            "email": "leia@payex.com",
            "msisdn": "+46787654321",
            "payerReference": "AB1234"
        }
    }
}
```

{:.table .table-striped}
| Required         | Field     | Type         | Description   |
| :--------------: | :-------- | :----------- | :------------ |
|                  | └➔&nbsp;`payer`                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
| | └➔&nbsp;`digitalProducts`                       | `bool` | Set to `true` for merchants who only sell digital goods and only require `email` and/or `msisdn` as shipping details. Set to `false` if the merchant also sells physical goods. | {% if documentation_section contains "checkout-v3/enterprise" %}
|                  | └─➔&nbsp;`nationalIdentifier`    | `object` | The national identifier object.                                                                      |
|                  | └──➔&nbsp;`socialSecurityNumber` | `string` | The payer's social security number. |
|                  | └──➔&nbsp;`countryCode`          | `string` | The country code of the payer.                                                                     |
|                  | └──➔&nbsp;`guestMode`          | `bool` | Set to `true` if you do not want to do a lookup to checkout profile, and only want to use the Social Security Number to restrict a payment.                                                                     | {% endif %}
|                  | └─➔&nbsp;`restrictedToSocialSecurityNumber`                    | `bool`     | Set to `true` if you want to restrict your payment to a Social Security Number.                                                                                                |
| {% icon check %} | └─➔&nbsp;`firstName`                    | `string`     | The first name of the payer.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`lastName`                    | `string`     | The last name of the payer.                                                                                                                                                                                                                                                                              |
|                  | └─➔&nbsp;`email`                   | `string`     | The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for [frictionless 3-D Secure 2 flow]({{ features_url }}/core/3d-secure-2).                                                                             |
|                  | └─➔&nbsp;`msisdn`                  | `string`     | The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).            |
|                  | └─➔&nbsp;`payerReference`                     | `string`     | A reference used in Enterprise integrations to recognize the payer in the absence of SSN and/or a secure login. Read more about this in the [payerReference](/checkout-v3/enterprise/features/optional/enterprise-payer-reference) feature section.                                                                                                                                                                                                                       |
