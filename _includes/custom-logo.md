{% capture documentation_section %}{% include documentation-section.md %}{%
endcapture %}

## Custom Logo

With permission and activation on your contract, it is possible to replace the
Swedbank Pay logo in the Payment Menu. See the abbreviated example
below with the added `logoUrl` in the Payment Order Purchase request.

*   If the configuration is activated and you send in a `logoUrl`, then the
    SwedbankPay logo is replaced with the logo sent in and the text is changed accordingly.

*   If the configuration is activated and you do not send in a `logoUrl`, then
    no logo and no text is shown.

*   If the configuration is deactivated, sending in a `logoUrl` has no effect.

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",{% if include.documentation_section == "payment-menu" %}
        "instrument": "CreditCard"{% endif %}
        "generateRecurrenceToken": {{ operation_status_bool }},{% if include.documentation_section == "payment-menu" %}
        "generatePaymentToken": {{ operation_status_bool }},{% endif %}
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditoons.pdf",
            "logoUrl": "https://example.com/logo.png"
        }
    }
}
```
