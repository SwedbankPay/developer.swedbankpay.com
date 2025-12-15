---
title: Validate Status
permalink: /:path/validate-status/
hide_from_sidebar: false
description: |
  How to validate the status of a payment
menu_order: 6
---

After the payer has completed their payment and returned to the `CompleteUrl`,
you need to validate that the payment has the status `Paid` so you are able to
capture funds.

First of all, you need to find out if the transaction type needs to be captured
or not. An `Authorization` needs to be [captured][pp-capture] (most payment
methods generate these type of transactions), a `Sale` does not (Trustly and
Swish transactions where the funds are captured instantly and automatically).

## Perform the GET

You can do this by perfoming a `GET` on your payment. Remember that adding the
version is optional for v3.0 and v2.0, but needed if you are using v3.1.

The status field should simply have the status `Paid`. As long as this is the
case, you are good to go and proceed to doing the [capture][pp-capture].

We also recommend adding an expansion of the `paid` node. Do this by adding
`?$expand=paid` after the `paymentOrderId`. This way, you can retrieve more
information about the payment while limiting the amount of calls you have to do
towards the API.

Not adding the expansion will result in the same response, apart from the paid
node being collapsed.

{% capture request_header %}GET /psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140?$expand=paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% include code-example.html
    title='GET Request with expanded paid node'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140",
        "created": "2024-03-13T12:39:58.0608661Z",
        "updated": "2024-03-13T12:40:16.1887572Z",
        "operation": "Purchase",
        "status": "Paid",
        "currency": "SEK",
        "amount": 100,
        "vatAmount": 0,
        "remainingCaptureAmount": 100,
        "remainingCancellationAmount": 100,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/7.37.0",
        "language": "sv-SE",
        "availableInstruments": [
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "Swish",
            "CreditAccount-CreditAccountSe",
            "Trustly",
            "MobilePay",
            "GooglePay",
            "ClickToPay"
        ],
        "implementation": "PaymentsOnly",
        "integration": "Redirect",
        "instrumentMode": false,
        "guestMode": false,
        "orderItems": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/orderitems"
        },
        "urls": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/payers"
        },
        "history": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/history"
        },
        "failed": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/paid",
            "number": 40129782830,
            "instrument": "CreditCard",
            "payeeReference": "1710333598",
            "transactionType": "Authorization",
            "amount": 100,
            "submittedAmount": 100,
            "feeAmount": 0,
            "discountAmount": 0,
            "paymentTokenGenerated": false,
            "details": {
                "externalNonPaymentToken": "91dd1ea0eeafc2ac397d24e80abdc",
                "cardBrand": "MasterCard",
                "cardType": "Credit",
                "maskedPan": "522661******3406",
                "expiryDate": "12/2033",
                "issuerAuthorizationApprovalCode": "L00003",
                "acquirerTransactionType": "3DSECURE",
                "acquirerStan": "3",
                "acquirerTerminalId": "40129782830",
                "acquirerTransactionTime": "2024-03-13T12:40:30.361Z",
                "transactionInitiator": "CARDHOLDER",
                "bin": "522661",
                "paymentAccountReference": "91dd1ea0eeafc2ac397d24e80abdc"
            }
        },
        "cancelled": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/cancelled",
            "paymentTokenGenerated": false
        },
        "reversed": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/reversed",
            "paymentTokenGenerated": false
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/failedattempts"
        },
        "postPurchaseFailedAttempts": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/postpurchasefailedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/metadata"
        }
    },
    "operations": [
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/cancellations",
            "rel": "cancel",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/34761895-d1e4-412a-0a30-08dc43423140/captures",
            "rel": "capture",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/19bd2693ba9f42c700c41eac68a26749987600be3d4757fcccef570754a671a6?_tc_tid=ea84679ddcfc4f879e3d972c62a09028",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/client/19bd2693ba9f42c700c41eac68a26749987600be3d4757fcccef570754a671a6?culture=sv-SE&_tc_tid=ea84679ddcfc4f879e3d972c62a09028",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='GET Response with expanded paid node'
    header=response_header
    json= response_content
    %}

An alternative option to expanding the paid node is performing a
[`GET` towards the `paid` resource][paid-resource-model].

{% capture request_header %}GET /psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% include code-example.html
    title='GET Request directly towards the paid resource'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paid": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/paid",
    "instrument": "Creditcard",
    "number": 1234567890,
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "paymentTokenGenerated": false,
    "details": {
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "expiryDate": "12/2022",
      "issuerAuthorizationApprovalCode": "L00302",
      "acquirerTransactionType": "STANDARD",
      "acquirerStan": "302",
      "acquirerTerminalId": "70101301389",
      "acquirerTransactionTime": "2022-06-15T14:12:55.029Z",
      "transactionInitiator": "CARDHOLDER",
      "bin": "492500"
    }
  }{% endcapture %}

{% include code-example.html
    title='GET Response directly towards the paid resource'
    header=response_header
    json= response_content
    %}

## Other Statuses

There are several statuses the payment might have in addition to `Paid` once the
payer has reached the `completeURL`. If any of these appear, no capture is
available. You can get more information by doing a `GET` with the field expanded
or directly towards the resource, just like we showed above. The other statuses
are:

*   `Failed`

Returned when a payment has failed. You will find an error message in
[the `Failed` response][failed].

*   `Cancelled`

Returned when an authorized amount has been fully cancelled. It will contain
fields from both the cancelled description and paid section.
See the [`Cancelled` response][cancelled].

*   `Aborted`

Returned when the merchant has aborted the payment, or if the payer cancelled
the payment in the redirect integration. See the [`Aborted` response][aborted].

### Next Steps

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.

{% include iterator.html prev_href="/checkout-v3/get-started/display-ui"
                         prev_title="Back to Display Payment UI"
                         next_href="/checkout-v3/get-started/post-purchase"
                         next_title="Post-Purchase" %}

[aborted]: /checkout-v3/technical-reference/resource-sub-models/#failed
[cancelled]: /checkout-v3/technical-reference/resource-sub-models/#cancelled
[failed]: /checkout-v3/technical-reference/resource-sub-models/#failed
[paid-resource-model]: /checkout-v3/technical-reference/resource-sub-models/#paid
[pp-capture]: /checkout-v3/get-started/post-purchase/#capture-v31
