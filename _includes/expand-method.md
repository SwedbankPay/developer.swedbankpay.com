## Expand the First Payment Method

A useful feature when customizing your payment UI, is auto-expanding the first
payment method in the menu. By doing this you can guide the payer towards a
specific payment method. This is done by adding the `boolean` field
`expandFirstInstrument` and set it to `true`. The first payment method will be
expanded when the payment UI is loaded. This can be used as a stand-alone
feature, but can favourably be paired with [customizing the order of the
menu][cust-menu].

## Request Example

The request with `expandFirstInstrument` set to `true` should look like the
example below.

The field will not be visible in the **response**, so we will only include the
request here. The response will look like a basic `paymentOrder` response.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "expandFirstInstrument": true,
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "paymentUrl": "https://example.com/perform-payment",
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "orderReference": "or-123456"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

[cust-menu]: /checkout-v3/features/customize-ui/sort-order-payment-menu/
