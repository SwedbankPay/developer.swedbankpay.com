By using the field `restrictedToInstruments`, you can customize in what order
the payment methods are listed in your payment UI, in addition to using it
to restrict which payment methods you want to display. This gives you, as a
merchant, the opportunity to promote selected payment methods, or tailor the
payment UI specifically for your customers.

If you detect that the customer is on a mobile, make their payment easier by
having the digital wallets on top. On an Android phone? Lead with Google Pay. On
an Apple device? Put Apple Pay first. Use the `Paid` resource to find what
payment method the customer used to pay, and let it be the first option next
time they visit you.

## Sort Or Restrict The Payment Menu Order

Choosing the order is very easy. You simply add the `array` field
`restrictedToInstruments`, and the order you enter the payment methods is
the order they will appear in the menu.

Please remember that `restrictedToInstruments` both sorts and restricts. Only
the payment methods included in the `array` will appear, so it is crucial
that you include all the payment methods you want to offer.

I.e. if you populate the field with ["Swish","CreditCard","Trustly"], Swish will
appear as the first option, card as the second and Trustly third. In this
example, only these three will be present in the payment UI, even if you have an
active contract for a fourth payment method.

If you do not include an `array` in your request, the payment UI will be
presented in the default order.

## Input Values

The complete list of possible values to include in `restrictedToInstruments` are
the following. You can find the payment methods activated for your merchant
under `availableInstruments` in the initial `paymentOrder` response.

{:.table .table-striped}
| Payment Method    | Input             |
| :------ | :--------------- |
| Apple Pay | "ApplePay" |
| Card     | "CreditCard"      |
| Click to Pay | "ClickToPay" |
| Google Pay | "GooglePay" |
| Installment Account Sweden    | "CreditAccount-CreditAccountSe"   |
| Invoice Norway    | "Invoice-PayExFinancingNo"   |
| Invoice Sweden | "Invoice-PayExFinancingSe" |
| MobilePay | "MobilePay" |
| Swish | "Swish" |
| Trustly | "Trustly" |
| Vipps | "Vipps" |

## Request Example

The request with `restrictedToInstruments` included should look like the example
below.

The field will not be visible in the **response**, so we will only include the
request here. The response will look like a basic `paymentOrder` response.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1,3.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "restrictedToInstruments": [
            "Swish",
            "CreditCard",
            "Trustly"
        ],
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
