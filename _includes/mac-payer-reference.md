## MAC PayerReference

If a merchant wishes to use the MAC implementation, but does not have the
payer's SSN or a secure login, they can add a `payerReference` in the payer
node of the payment request.

If the `payerReference` is present along with `email` and `msisdn`, the merchant
does not need to add a `nationalIdentifier`. Other than that, the integration
is the same as a normal MAC integration.

If a payerReference is not present, we will search for the information in the
`email` and `msisdn`.

This example leaves out the `nationalIdentifier`.

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
            "requireConsumerInfo": false,
            "digitalProducts": false,
            "firstName": "Leia"
            "lastName": "Ahlström"
            "email": "leia@payex.com",
            "msisdn": "+46787654321",
            "payerReference": "AB1234"
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|                  | └➔&nbsp;`payer`                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                     |
|   | └➔&nbsp;`requireConsumerInfo`                       | `bool` | Set to `true` if the merchant wants to receive profile information from Swedbank Pay. Applicable for when the merchant only needs `email` and/or `msisdn` for digital goods, or when the full shipping address is necessary. If set to `false`, Swedbank Pay will depend on the merchant to send `email` and/or `msisdn` for digital products and shipping address for physical orders. |
| | └➔&nbsp;`digitalProducts`                       | `bool` | Set to `true` for merchants who only sell digital goods and only require `email` and/or `msisdn` as shipping details. Set to `false` if the merchant also sells physical goods. |
| {% icon check %} | └─➔&nbsp;`firstName`                    | `string`     | The first name of the payer.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`lastName`                    | `string`     | The last name of the payer.                                                                                                                                                                                                                                                                              |
|                  | └─➔&nbsp;`email`                   | `string`     | The e-mail address of the payer. Increases the chance for [frictionless 3-D Secure 2 flow]({{ features_url }}/core/3d-secure-2).                                                                             |
|                  | └─➔&nbsp;`msisdn`                  | `string`     | The mobile phone number of the payer. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).            |
|                  | └─➔&nbsp;`payerReference`                     | `string`     | A reference used in MAC integrations to recognize the payer in the absence of SSN and/or a secure login.                                                                                                                                                                                                                               |
