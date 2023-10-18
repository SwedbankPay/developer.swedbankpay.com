---
title: Delete Token
description: How to delete tokens.
menu_order: 1500
icon:
  content: assignment
  outlined: true
---

{% include delete-payment-order-token.md token_field_name="recurrenceToken" %}

{% include delete-payment-order-token.md token_field_name="unscheduledToken" %}

{% include delete-payment-order-token.md token_field_name="paymentToken" %}

## Delete payerOwnedToken Request

{:.code-view-header}
**Request**

```http
PATCH /psp/paymentorders/payerownedtokens/<payerReference> HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "state": "Deleted",
  "comment": "Comment stating why this is being deleted"
}
```

## Delete payerownedToken Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payerOwnedTokens": {
        "id": "/psp/paymentorders/payerownedtokens/{payerReference}",
        "payerReference": "{payerReference}",
        "tokens": [
            {
                "tokenType": "Payment",
                "token": "{paymentToken}",
                "instrument": "Invoice-payexfinancingno",
                "instrumentDisplayName": "260267*****",
                "correlationId": "e2f06785-805d-4605-bf40-426a725d313d",
                "instrumentParameters": {
                    "email": "hei@hei.no",
                    "msisdn": "+4798765432",
                    "zipCode": "1642"
                }
            },
            {
                "tokenType": "Payment",
                "token": "{paymentToken}",
                "instrument": "CreditCard",
                "instrumentDisplayName": "492500******0004",
                "correlationId": "e2f06785-805d-4605-bf40-426a725d313d",
                "instrumentParameters": {
                    "expiryDate": "12/2020",
                    "cardBrand": "Visa"
                }
            }
        ]
    }
}
```
