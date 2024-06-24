{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign implementation = documentation_section | split: "/" | last | capitalize | remove: "-" %}

## MOTO

{% include alert-agreement-required.md %}

MOTO (Mail Order / Telephone Order) is a purchase where you, as a merchant,
enter the payer's card details in order to make a payment. The payer provides
the card details to the sales representative by telephone or in writing.
The sales representative will then enter the details into the payment interface.

Common use cases are travel or hotel bookings, where the payer calls the sales
representative to make a booking. This feature is only supported with the
`Purchase` operation. See the example below on how to implement MOTO
by setting the `generateMotoPayment` to `true`.

## MOTO Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "generateMotoPayment": true,
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ], {% if include.integration_mode=="seamless-view" %}
            "paymentUrl": "https://example.com/perform-payment", {% endif %}
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditions.pdf"{% if include.integration_mode=="redirect" %},
            "logoUrl": "https://example.com/logo.png" {% endif %}
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite",
            "siteId": "MySiteId"
        },
        "payer": {
            "digitalProducts": false,
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE"
            },
            "firstName": "Leia",
            "lastName": "Ahlström",
            "email": "leia@payex.com",
            "msisdn": "+46787654321",
            "shippingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "Helgestavägen 9",
                "coAddress": "",
                "city": "Solna",
                "zipCode": "17674",
                "countryCode": "SE"
            },
            "billingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "Helgestavägen 9",
                "coAddress": "",
                "city": "Solna",
                "zipCode": "17674",
                "countryCode": "SE"
            },
            "accountInfo": {
                "accountAgeIndicator": "04",
                "accountChangeIndicator": "04",
                "accountPwdChangeIndicator": "01",
                "shippingAddressUsageIndicator": "01",
                "shippingNameIndicator": "01",
                "suspiciousAccountActivity": "01",
            }
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
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

Request field not covered in the common Checkout redirect or seamless view
table:

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f generateMotoPayment %}     | `bool`      | Set to `true` if the payment order is a MOTO payment, `false` if not. |

{% if include.integration_mode=="redirect" %}

To authorize the payment, find the operation with `rel` equal to
`redirect-checkout` in the response, and redirect the merchant employee to the
provided `href` to fill out the payer’s card details. You will find an example
of the response provided below.

{% endif %}

{% if include.integration_mode=="seamless-view" %}

To authorize the payment, find the operation with `rel` equal to `view-checkout`
in the response, and display the the provided `href` to the merchant's employee
so they can fill out the payer’s card details. You will find an example of the
response provided below.

{% endif %}

## MOTO Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [ "CreditCard" ],
        "implementation": "PaymentsOnly", { {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} { {% if include.integration_mode=="redirect" %}
        "integration": "Redirect", {% endif %}
        "instrumentMode": false,
        "guestMode": false,
        "orderItems": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/orderitems"
        },
        "urls": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/payers"
        },
        "history": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/history"
        },
        "failed": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/metadata"
        }
    },
      "operations": [ {% if include.integration_mode=="redirect" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        },{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        },{% endif %}
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
        }
       ]
      }{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}
