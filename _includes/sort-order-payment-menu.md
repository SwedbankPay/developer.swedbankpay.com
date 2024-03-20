By using the field `restrictedToInstruments`, you can customize in what order
the payment instruments are listed in your payment UI, in addition to using it
to restrict which instruments you want to display. This gives you, as a
merchant, the opportunity to promote selected payment instruments, or tailor the
payment UI specifically for your customers.

If you detect that the customer is on a mobile, make their payment easier by
having the digital wallets on top. On an Android phone? Lead with Google Pay. On
an Apple device? Put Apple Pay first. Use the `Paid` resource to find what
instrument the customer used to pay, and let it be the first option next time
they visit you.

## Sort And Restrict The Payment Menu Order

Choosing the order is very easy. You simply add the `array` field
`restrictedToInstruments`, and the order you enter the payment instruments is
the order they will appear in the menu.

Please remember that `restrictedToInstruments` both sorts and restricts. Only
the payment instruments included in the `array` will appear, so it is crucial
that you include all the instruments you want to offer.

I.e. if you populate the field with ["Swish","CreditCard","Trustly"], Swish will
appear as the first option, card as the second and Trustly third. In this
example, only these three will be present in the payment UI, even if you have an
active contract for a fourth payment instrument.

If you do not include an `array` in your request, the payment UI will be
presented in the default order.

## Input Values

The list of possible values to include in `restrictedToInstruments` are the
following, depending on which payments instruments you have active.

{:.table .table-striped}
| Payment Instrument    | Input             |
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

## Expand the First Instrument

A useful addition to sorting the order in the payment menu, is auto expanding
the first instrument. This is done by adding the `boolean` field
`expandFirstInstrument` and set it to `true`. The top instrument will be
expanded when the payment UI is loaded. This is not mandatory, and can also be
used as a stand-alone without sorting the order of the menu.

## Request Example

The request with both fields included should look like the example below.

Neither `expandFirstInstrument` or `restrictedToInstruments` will be visible in
the **response**, so we will not include it here. The response will look like
a basic `paymentOrder` response.

{:.code-view-header}
**Request**

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1,3.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "instrument": null,
        "expandFirstInstrument": true,
        "restrictedToInstruments": ["Swish", "CreditCard", "Trustly"]
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ], //Seamless View only
            "paymentUrl": "https://example.com/perform-payment", //Seamless View only
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled", //Redirect only
            "callbackUrl": "https://api.example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png" //Redirect only
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
