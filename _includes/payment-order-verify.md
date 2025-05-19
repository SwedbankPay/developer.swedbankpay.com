{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% capture documentation_section_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{%- unless documentation_section contains 'checkout' or documentation_section contains 'payment-menu' or documentation_section contains 'enterprise' or documentation_section == 'invoice' %}
    {% assign has_one_click = true %}
{%- endunless %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

The `Verify` operation lets you post verification payments, which confirm the
validity of card information without reserving or charging any amount.

## Introduction To Verify

This option is commonly used when initiating a subsequent
{%- if has_one_click %}
[One-click payment][one-click-payments] or an
{%- endif %}
[unscheduled purchase][unscheduled-mit] flow - where you do not want
to charge the payer right away.

{% include alert.html type="informative" icon="info" body="
Please note that all boolean card attributes involving the rejection of certain
card types are optional and require enabling in the contract with Swedbank
Pay." %}

## Verification Through Swedbank Pay Payments

*   When properly set up in your merchant/webshop site, and the payer initiates
    a verification operation, you make a `POST` request towards Swedbank Pay
    with your Verify information. This will create a payment resource with a
    unique `id`. You either receive a Redirect URL to a hosted page or a
    JavaScript source in response.
*   You need to
    {%- unless documentation_section contains 'checkout' or documentation_section contains 'payment-menu' %}
    [redirect][redirect] the payer's browser to that specified URL, or
    {%- endunless %}
    embed the script source on your site to create a
    {%- unless documentation_section contains 'checkout' or documentation_section contains 'payment-menu' %}
    [Seamless View][seamless-view]
    {%- else -%}
    Seamless View
    {%- endunless %}
    in an `iframe`; so that the payer can enter the
    card details in a secure Swedbank Pay hosted environment.
*   Swedbank Pay will handle 3-D Secure authentication when this is required.
*   Swedbank Pay will redirect the payer's browser to - or display directly in
    the `iframe` - one of two specified URLs, depending on whether the payment
    session is followed through completely or cancelled beforehand.
    Please note that both a successful and rejected payment reach completion,
    in contrast to a cancelled payment.
*   When you detect that the payer reach your completeUrl, you need to do a
    `GET` request to receive the state of the transaction.
*   Finally you will make a `GET` request towards Swedbank Pay with the
    `id` of the payment received in the first step, which will return the
    payment result and
    {%- if has_one_click %}
    a `paymentToken` that can be used for subsequent
    [One-Click Payments][one-click-payments] or
    {%- endif %}
    a `unscheduledToken` that can be used for subsequent
    [unscheduled server-to-server based payments][unscheduled-mit].

## API Requests

The API requests are displayed in the Verification flow below. The options you
can choose from when creating a payment with key operation set to Value Verify
are listed below.

Please note that not including `paymentUrl` in the request will generate a
`redirect-verification` operation in the response, meant to be used in the
Redirect flow. Adding `paymentUrl` input will generate the response meant for
Seamless View, which does not include the `redirect-verification`. The request
below is the Redirect option.

## How It Looks

You will redirect the payer to Swedbank Pay hosted pages to collect the card
information.

{:.text-center}
![screenshot of the swedish card verification page][po-verify]

## Verify Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Verify",
        "currency": "NOK",
        "description": "Test Verification",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",  {% if documentation_section contains "checkout-v3" %}
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header{% endif %}
        "generateUnscheduledToken": true,
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.html"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite", {% if documentation_section contains "checkout-v3" %}
            "siteId": "MySiteId", {% endif %}
        },
        "payer": {
            "payerReference": "AB1234",
        }
    },
    "creditCard": {
        "rejectCreditCards": false,
        "rejectDebitCards": false,
        "rejectConsumerCards": false,
        "rejectCorporateCards": false
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Verify Response

{% if documentation_section contains "checkout-v3" %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777",
        "created": "2024-05-02T11:07:26.8110851Z",
        "updated": "2024-05-02T11:07:26.8270296Z",
        "operation": "Verify",
        "status": "Initialized",
        "currency": "NOK",
        "amount": 0,
        "vatAmount": 0,
        "description": "Test Verification",
        "initiatingSystemUserAgent": "PostmanRuntime/7.37.3",
        "language": "nb-NO",
        "availableInstruments": [
            "CreditCard"
        ],
        "implementation": "PaymentsOnly",
        "integration": "",
        "instrumentMode": false,
        "guestMode": true,
        "urls": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/payers"
        },
        "history": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/history"
        },
        "failed": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/paid",
            "paymentTokenGenerated": false
        },
        "cancelled": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/cancelled",
            "paymentTokenGenerated": false
        },
        "reversed": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/reversed",
            "paymentTokenGenerated": false
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/failedattempts"
        },
        "postPurchaseFailedAttempts": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/postpurchasefailedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777/metadata"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777",
            "rel": "update-order",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/793dbd59-2b80-4acb-97bf-08dc64fc1777",
            "rel": "abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/09d057c9e3c9e8e81c226254ce4ab4996215ed9623836922874023b4aa142962?_tc_tid=45523942b84943299b594bd08f9c46e7",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/client/09d057c9e3c9e8e81c226254ce4ab4996215ed9623836922874023b4aa142962?culture=nb-NO&_tc_tid=45523942b84943299b594bd08f9c46e7",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        }
    ]
}
  {% endcapture %}

{% else %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/14e9908e-1107-4181-a9fb-08dc64fc1777",
        "created": "2024-05-03T09:04:48.8351546Z",
        "updated": "2024-05-03T09:04:48.8534539Z",
        "operation": "Verify",
        "state": "Ready",
        "currency": "NOK",
        "amount": 0,
        "vatAmount": 0,
        "description": "Test Verification",
        "initiatingSystemUserAgent": "PostmanRuntime/7.37.3",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "availableInstruments": [
            "CreditCard"
        ],
        "integration": "",
        "urls": {
            "id": "/psp/paymentorders/14e9908e-1107-4181-a9fb-08dc64fc1777/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/14e9908e-1107-4181-a9fb-08dc64fc1777/payeeInfo"
        },
        "payer": {
            "id": "/psp/paymentorders/14e9908e-1107-4181-a9fb-08dc64fc1777/payers"
        },
        "payments": {
            "id": "/psp/paymentorders/14e9908e-1107-4181-a9fb-08dc64fc1777/payments"
        },
        "currentPayment": {
            "id": "/psp/paymentorders/14e9908e-1107-4181-a9fb-08dc64fc1777/currentpayment"
        },
        "items": [
            {
                "creditCard": {
                    "cardBrands": [
                        "CoopMatkonto",
                        "Ica",
                        "MasterCard",
                        "Visa",
                        "Amex",
                        "Dankort",
                        "Maestro"
                    ]
                }
            }
        ]
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/14e9908e-1107-4181-a9fb-08dc64fc1777",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/14e9908e-1107-4181-a9fb-08dc64fc1777",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/9b9a0db077d065719f9e05c3ff583783fc474bb3cd712bfa3cfb4759145ba1b8?_tc_tid=dd40b8e24cb0429c823f64111b9a9ba8",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/client/9b9a0db077d065719f9e05c3ff583783fc474bb3cd712bfa3cfb4759145ba1b8?culture=nb-NO&_tc_tid=dd40b8e24cb0429c823f64111b9a9ba8",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        }
    ]
}
  {% endcapture %}

{% endif %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## Verification Flow

The sequence diagram below shows the two requests you have to send to Swedbank
Pay to make a purchase. The links will take you directly to the API description
for the specific request. The diagram also shows in high level, the sequence of
the process of a complete purchase.
When dealing with credit card payments, 3-D Secure authentication of the
cardholder is an essential topic. There are three alternative outcome of a
credit card payment:

*   3-D Secure enabled - by default, 3-D Secure should be enabled, and Swedbank
    Pay will check if the card is enrolled with 3-D Secure. This depends on the
    issuer of the card. If the card is not enrolled with 3-D Secure, no
    authentication of the cardholder is done.
*   Card supports 3-D Secure - if the card is enrolled with 3-D Secure, Swedbank
    Pay will redirect the cardholder to the autentication mechanism that is
    decided by the issuing bank. Normally this will be done using BankID or
    Mobile BankID.

[seamless-view]: /checkout-v3/get-started/display-payment-ui/seamless-view
[one-click-payments]: /checkout-v3/features/optional/one-click-payments
[unscheduled-mit]: /checkout-v3/features/optional/unscheduled
[redirect]: /checkout-v3/get-started/display-payment-ui/redirect
[po-verify]: /assets/img/po-verify.jpg
