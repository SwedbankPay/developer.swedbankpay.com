{% assign seamless_view = include.seamless_view | default: false %}

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
        "currency": "SEK",
        "prices": [{
                "type": "CreditCard",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "generatePaymentToken": false,
        "generateRecurrenceToken": false,
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": { {% if seamless_view %}
            "hostUrls": ["http://example.com"],{% endif %}
            "completeUrl": "http://example.com/payment-completed",
            "cancelUrl": "http://example.com/payment-canceled",{% if seamless_view %}
            "paymentUrl": "http://example.com/perform-payment",{% endif %}
            "callbackUrl": "http://example.com/payment-callback",
            "logoUrl": "http://example.com/payment-logo.png",
            "termsOfServiceUrl": "http://example.com/payment-terms.pdf",
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchantId }}"
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or123",
        },
        "riskIndicator": {
            "deliveryEmailAddress": "test@example.com",
            "deliveryTimeFrameindicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
                "name": "Leo",
                "streetAddress": "Gata 535",
                "coAddress": "street 55",
                "city": "Stockholm",
                "zipCode": "55560",
                "countryCode": "SE"
            }
        },
        "metadata": {
            "key1": "value1",
            "key2": 2,
            "key3": 3.1,
            "key4": false
        },
    },
    "creditCard": {
        "rejectCreditCards": false,
        "rejectDebitCards": false,
        "rejectConsumerCards": false,
        "rejectCorporateCards": false,
        "no3DSecure": false,
    }
}
```
