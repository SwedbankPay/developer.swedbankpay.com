Different transaction scenarios calls for different calls to action, for example
asking the end-user to deposit instead of paying. That is why we have introduced
a new field which changes the text acompanying the amount on the payment button.

The field is named `CallToActionType` and can be included in the main
`paymentOrder` node. It is only available when the `operation` is `Purchase`,
and the two values you can select from is `Pay` and `Deposit`. This will
generate "Pay [amount]" or "Deposit [amount]" on the payment button
respectively. Adding anything else than these two values will result in an error
message. If you include the field, but leave the value empty, or not include the
field at all, the value will default to "Pay".

Please note that the value you enter in this field is **not** the text you want
to appear, but the action. The text and action name just happen to correspond in
English. If you use `Deposit` but have Swedish as the default payment UI
language, it will appear translated to Swedish.

## Code Example

This field will not result in any changes in the default response, but it will
be visible if you expand the settings node.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "callToActionType": "Deposit", //Operation: "Purchase" only
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
