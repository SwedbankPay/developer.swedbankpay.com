{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

## Instrument Mode

{% unless documentation_section contains "checkout-v3/payments-only" %}

{% include alert-agreement-required.md %}

{% endunless %}

With "Instrument Mode", the Payment Menu will display only one specific payment
instrument instead of all those configured on your merchant account. The
`PaymentOrder` resource works just like it otherwise would, allowing you to
remain largely indifferent to the payment instrument in use. To use the feature
you need to add the `instrument` field in the request as shown in the example
below.

It is important to only create one `paymentOrder` for each purchase, even if the
payer changes their mind and wants to use another payment instrument. This is
because we don't allow creating multiple `paymentOrder`s with the same
`payeeReference`. If this happens, you should use the `PATCH` request below to
reflect what the payer has chosen instead of creating a new `paymentOrder`. This
way, you can still use the same `payeeReference`.

If you don't want to use Swedbank Pay's Payment Menu (e.g. building your own
payment menu), or have multiple payment providers on your site, we strongly
recommend that you implement this functionality. In this case you should use the
`instrument` field to enforce which payment instrument to show. If you have an
agreement with Swedbank Pay for both Card and Swish/Vipps processing, and the
payer chooses either of these instruments, you should add the `instrument`
parameter with the specific payment instrument.

{% if documentation_section contains "checkout-v3" %}

## Eligibility Check

If you want to **build your own menu** and display **at least** one wallet like
**Apple Pay**, **Click to Pay** or **Google Pay&trade;**, you need to do an
eligibility check. This is to ensure that the wallet is supported on the payer's
device or browser.

Swedbank Pay provides a script to do this check, with the URL
`ecom.<environment>.payex.com/checkout/core/integration.` Environments
available for you are `externalintegration` and `production`, and you can switch
integration between `checkout` and `paymentmenu`. Follow these links for [test
environment][test-env] and [production environment][prod-env] **Checkout**
scripts.

Add the script tag to your website and do an `await payex.getAcceptedWallets()`.
We will return a string array with the wallets eligible for that purchase. The
format will e.g. be `["applepay"]`.

If you are not building your own menu or don't offer these wallets, there is no
need to run the script to do the check.

{% endif %}

## Instrument Mode Request

An example with invoice as the instrument of choice.

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
        "language": "sv-SE",
        "instrument": "Invoice-PayExFinancingSe", {% if documentation_section contains "checkout-v3" %}
        "productName": "Checkout3",
        "implementation": "{{implementation}}", {% endif %}
        "urls":
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "paymentUrl": "https://example.com/perform-payment",
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditions.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite", {% if documentation_section contains "checkout-v3" %}
            "siteId": "MySiteId", {% endif %}
        },
        "payer": {
            "requireConsumerInfo": true,
            "digitalProducts": false,
            "shippingAddressRestrictedToCountryCodes": [ "NO", "US" ]
        },
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 5,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 0,
                "vatPercent": 2500,
                "amount": 1500,
                "vatAmount": 375
            },
            {
                "reference": "I1",
                "name": "InvoiceFee",
                "type": "PAYMENT_FEE",
                "class": "Fees",
                "description": "Fee for paying with Invoice",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 1900,
                "vatPercent": 0,
                "amount": 1900,
                "vatAmount": 0,
                "restrictedToInstruments": [
                    "Invoice-PayExFinancingSe"
                ]
            }
        ],
        "riskIndicator": {
            "deliveryEmailAddress": "olivia.nyhuus@payex.com",
            "deliveryTimeFrameIndicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
                "name": "Olivia Nyhus",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
            }
        }
    }
}
```

## Instrument Mode Response

{% if documentation_section contains "checkout-v3" %}

Note the implementation options **Seamless View** and **Redirect** (`HostedView`
or `Redirect` in the response's implementation field). Depending on which it is,
either `view-checkout` (Seamless View) or `redirect-checkout` will appear in the
response. Never both at the same time.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentOrder": {
        "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd",
        "created": "2022-01-24T10:54:05.6243371Z",
        "updated": "2022-01-24T10:54:19.2679591Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
            "Invoice-PayExFinancingSe"
        ], {% if documentation_section contains "checkout-v3/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %}
        "integration": "HostedView|Redirect",
        "instrumentMode": false,
        "guestMode": false,
        "orderItems": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/orderitems"
        },
        "urls": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/payers"
        },
        "history": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/history"
        },
        "failed": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/metadata"
        }
    },
      "operations": [
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        },
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel":"update-order",
          "method":"PATCH",
          "contentType":"application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel": "abort",
          "method": "PATCH",
          "contentType": "application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel": "set-instrument",
          "method": "PATCH",
          "contentType": "application/json"
        }
    ]
}
```

{% else %}

Depending on which implementation you are using, either `view-paymentorder`
(Seamless View) or `redirect-paymentorder` will appear in the response. Never
both at the same time.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentOrder": {
        "id": "/psp/paymentorders/4dec0b0f-a385-452a-cc38-08d9f53bb7a8",
        "created": "2022-02-23T12:59:10.9600933Z",
        "updated": "2022-02-23T12:59:11.77654Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Testing - Stage",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0",
        "language": "sv-SE",
        "instrument": "CreditCard",
        "availableInstruments": [
            "Invoice-PayExFinancingSe",
        ],
        "integration": "",
        "urls": {
            "id": "/psp/paymentorders/4dec0b0f-a385-452a-cc38-08d9f53bb7a8/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/4dec0b0f-a385-452a-cc38-08d9f53bb7a8/payeeInfo"
        },
        "payer": {
            "id": "/psp/paymentorders/4dec0b0f-a385-452a-cc38-08d9f53bb7a8/payers"
        },
        "payments": {
            "id": "/psp/paymentorders/4dec0b0f-a385-452a-cc38-08d9f53bb7a8/payments"
        },
        "currentPayment": {
            "id": "/psp/paymentorders/4dec0b0f-a385-452a-cc38-08d9f53bb7a8/currentpayment"
        },
        "items": [{
            "creditCard": {
                "cardBrands": ["Visa", "MasterCard", "Amex", "Dankort", "Diners", "Finax", "Forbrugsforeningen", "Jcb", "IkanoFinansDk", "Lindex", "Maestro", "Ica"]
            }
        }]
    },
    "operations": [
        {
        "method": "PATCH",
        "href": "https://api.stage.payex.com/psp/paymentorders/4dec0b0f-a385-452a-cc38-08d9f53bb7a8",
        "rel": "update-paymentorder-updateorder",
        "contentType": "application/json"
        },
        {
        "method": "PATCH",
        "href": "https://api.stage.payex.com/psp/paymentorders/4dec0b0f-a385-452a-cc38-08d9f53bb7a8",
        "rel": "update-paymentorder-abort",
        "contentType": "application/json"
        },
        {
        "method": "PATCH",
        "href": "https://api.stage.payex.com/psp/paymentorders/4dec0b0f-a385-452a-cc38-08d9f53bb7a8",
        "rel": "update-paymentorder-setinstrument",
        "contentType": "application/json"
        },
        {
        "method": "GET",
        "href": "https://ecom.stage.payex.com/paymentmenu/23ef8b8f5088711f6f2cdbc55ad4dad673fee24a70c7788a5dc8f50c6c7ba835?_tc_tid=30f2168171e142d38bcd4af2c3721959",
        "rel": "redirect-paymentorder",
        "contentType": "text/html"
        }
        {
        "method": "GET",
        "href": "https://ecom.stage.payex.com/paymentmenu/core/client/paymentmenu/23ef8b8f5088711f6f2cdbc55ad4dad673fee24a70c7788a5dc8f50c6c7ba835?culture=sv-SE&_tc_tid=30f2168171e142d38bcd4af2c3721959",
        "rel": "view-paymentorder",
        "contentType": "application/javascript"
        }
    ]
}
```

{% endif %}

## PATCH Instrument Selection

{% if documentation_section contains "checkout-v3" %}

Note the `rel` named `set-instrument`, which appears among the available
operations in the `paymentOrder` response when instrument mode is applied.

{% else %}

Note the `rel` named `update-paymentorder-setinstrument`, which appears among
the available operations in the `paymentOrder` response when instrument mode is
applied.

{% endif %}

To switch instrument after the `paymentOrder` has been created, you can use the
following `PATCH` request, here with Swish as an example.

```http
PATCH /psp/{{ include.api_resource }}/paymentorders/{{ page.payment_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "SetInstrument",
    "instrument": "Swish"
  }
}
```

## Available Instruments

The valid instruments for the `paymentOrder` can be retrieved from the
`availableInstruments` parameter in the `paymentOrder` response. Using a
merchant set up with contracts for `Creditcard`, `Swish` and `Invoice`,
`availableInstruments` will look like this:

```json
        "availableInstruments": [
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "Swish"
        ]
```

[prod-env]: https://ecom.payex.com/checkout/core/integration
[test-env]: https://ecom.externalintegration.payex.com/checkout/core/integration
