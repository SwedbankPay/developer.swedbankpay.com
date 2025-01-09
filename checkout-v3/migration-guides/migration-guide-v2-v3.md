---
title: Migration Guide
permalink: /:path/migration-guide-v2-v3/
description: |
  How to migrate from Checkout v2 to Digital Payments v3.1
menu_order: 5
---

## Introduction to v3.1

With our latest API version, v3.1, we have significantly improved the checkout
experience for both merchants and payers. This version simplifies the
integration process by reducing the size and complexity of response models,
addressing gaps identified in v2. Instead of segregating integrations based on
configurations or product packages, v3.1 provides a unified solution where
features are controlled through parameters in your requests. This design
promotes reusability and ease of integration without requiring major changes or
concessions when adding new features, as the base API remains consistent.

## Upgrade Process

If you have already integrated with our Checkout v2 API, transitioning to v3.1
is a straightforward process. The URI and request body remain unchanged from
Checkout v2, with the only required modification being the addition of
`;version=3.1` in the HTTP request headers (see the request example below). This
adjustment ensures that your payment order requests generate the new response
scheme and functionality seamlessly.

The upgrade has backwards compatibility, allowing you to generate v3.1 responses
for transactions conducted through your v2 implementation. Instead of making a
new integration each time, this eliminates the need to maintain legacy code,
streamlining your system for a seamless transition. Additionally, this approach
establishes a foundation for future versions, enabling you - as the merchant -
to designate the desired version and make adjustments to response processing as
needed when newer versions are released.

## Request Headers v3.1

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: api.payex.com
Authorization: Bearer {{ your_token }}
Content-Type: application/json;version=3.1{% endcapture %}

{% include code-example.html
    title='New Request Headers'
    header=request_header
    json= request_content
    %}

## Order Items

Sending `orderItems` is no longer mandatory for your requests. If you prefer not
to include this information in your transactions, feel free to omit them from
your requests.

However, if your selection of offering includes an invoice, it is highly
recommended to provide `orderItems`. These fields are utilized to specify
details about the purchased products.

In the absence of this information, we will create the necessary order line
using the details provided in the `description` parameter along with the value
in the `amount` parameter.

## Response Fields Changes

In Digital Payments v3.1, response fields have been restructured.

Fields removed since v2 include: `currentPayment`,`instrument`, `payments` and
`state`.

{% capture response_content %}
    "paymentorder": {
        "currentPayment": //Removed in Checkout v3.1
        "instrument":  //Removed in Checkout v3.1
        "payments": //Removed in Checkout v3.1
        "settings": //Removed in Checkout v3.1
        "state": //Removed in Checkout v3.1
        "nonPaymentToken": //Moved to `paid` resource in Checkout v3.1
        "recurrenceToken": //Moved to `paid` resource in Checkout v3.1
        "unscheduledToken": //Moved to `paid` resource in Checkout v3.1
        "paymentToken": //Moved to `paid` resource in Checkout v3.1
        "externalNonPaymentToken": //Moved to `paid` resource in Checkout v3.1
        "transactionsOnFileToken": //Moved to `paid` resource in Checkout v3.1
 {% endcapture %}

 {% include code-example.html
    title='Response Fields Changes'
    header=response_header
    json= response_content
    %}

Instead, new fields including `history`, `failed`, `aborted`, `paid`, and
others, have been introduced. An example of the complete array of selections is
provided below.

 {% capture response_content %}{
    "urls": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/urls"
    },
    "payeeInfo": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/payeeinfo"
    },
    "payer": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/payers"
    },
    "history": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/history"
    },
    "failed": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/failed"
    },
    "aborted": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/aborted"
    },
    "paid": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/paid"
    },
    "cancelled": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/cancelled"
    },
    "financialTransactions": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/financialtransactions"
    },
    "failedAttempts": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/failedattempts"
    },
    "postPurchaseFailedAttempts": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/failedattempts"
    },
    "metadata": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/metadata"
    }
 } {% endcapture %}

 {% include code-example.html
    title='New Response Fields'
    header=response_header
    json= response_content
    %}

### Endpoints

{:.table .table-striped}
| Name    | Description             |
| :------ | :--------------- |
| Urls     | This will provide a report indicating the URLs you have supplied for this `paymentOrder`.      |
| PayeeInfo    | This will provide a report detailing the account and Merchant references that were utilized.  |
| Payers | If you have provided us with Payer data, it will be attached and stored here. |
| History | Here, you can track every aspect of the transaction lifecycle. This includes all actions initiated by the Payer within our UI and your management of the transaction (Capture, Cancel, Reversal, etc.), from its initiation to completion. |
| Failed    | MIT transactions, denoting "Merchant Initiated Transactions," are exclusively presented here if they result in a `Failed` status, along with the corresponding failure reason.     |
| Aborted    | If the transaction is aborted on your end, you can find the details submitted with the request in this section. |
| Paid    | In the event of a successful transaction, details about the utilized method, its associated references, and related information will be available here. As a point of reference, this serves as the replacement for `currentPayment`.     |
| Cancelled    | Information will be available under this node exclusively when a PaymentOrder has been completely canceled and has received the status `Canceled`. |
| FinancialTransactions    | All post-purchase actions and their references, such as captures and reversals, can be accessed here. This section also serves as the replacement for `currentPayment`.     |
| FailedAttempts    | All instances of `PaymentOrder`s marked as `Failed` will be in this section. Currently, this pertains specifically to transactions utilizing S2S (server-to-server) functionality, with subscriptions (Recur & Unscheduled Purchase) serving as an example.    |
| PostPurchaseFailedAttempts    | All failed attempts made by the `Payer` at a third-party will be documented in this section. For instance, if the Payer is denied due to reasons like "Insufficient funds," such instances will be recorded here.     |
| Metadata    | If you provide us with information in this object, the details will be reported back to you in this section.     |

## Status Parameter

In v3.1, we have updated the parameter formerly named `state` from v2 to
`status`, also expanding the range of values that are given to reflect more
accurately what stage the transaction is in.

**Initialized**

This status is returned upon the initial creation of the `paymentOrder` and
remains applicable throughout the active period when the `paymentOrder` is open
for conversion into a payment by the payer.

**Paid**

The `Paid` status is granted in response only when an actual amount has been
charged and processed. This information becomes visible in the subsequent `GET`
call on the `paymentOrder` after receipt of either the `CompleteUrl` or our
Callback, providing you with the opportunity to verify the transaction details.
Additionally, `Paid` will be directly returned in the response when conducting
post-purchase actions and if there is an associated amount that has been paid.

**Aborted**

This value becomes accessible only following the execution of an `abort`
operation by either you, the merchant, or if the payer opts for "Cancel payment"
within our domain. The latter scenario is applicable solely if you have
implemented a redirect integration.

**Failed**

Currently, the value in this field will be returned exclusively for MIT
(Merchant Initiated Transactions) transactions and other server-to-server
requests. Please note that this condition may evolve in the future.

**Reversed**

When a `paymentOrder` has been entirely refunded, the corresponding value will
be `Reversed`. In the case of partial refunds, the returned value will persist
as `Paid`.

**Cancelled**

If you initiate a cancellation for the entire authorized amount (reserved
funds), the returned value will be `Cancelled`. However, if you have conducted
any captures on the authorized funds before releasing the remaining amount, the
returned value will be `Paid`.

## Cosmetic Response Changes

You will find the following fields present in your new response. They have been
introduced to enhance our tracking and obtain more precise data regarding the
integration types or implementation styles adopted by our customers. They do not
directly affect your responsibilities as an integrator and can be disregarded.

{% capture response_content %}{
"implementation": "PaymentsOnly",
"integration": "",
"instrumentMode": false,
"guestMode": false,
}{% endcapture %}

{% include code-example.html
    title='Response Fields Excerpt'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field    | Description & Value           |
| :------ | :--------------- |
| "implementation"    | `PaymentsOnly` will be the default returned value.          |
| "integration"    | The value will be either `Redirect` or `HostedView` and will be revealed after the initial attempt.        |
| "instrumentMode"    | The value displayed here will be either `true` or `false`, depending on whether the feature was utilized. It is important to note that this is a distinct feature from the regular menu, and in most cases, it will be returned as `false`.         |
| "guestMode"    | By default, this value will be set to `true`. However, if you have implemented our "Payer Aware Menu" feature, the value will be returned as `false` for returning customers who have stored payment details with you.        |

## Events available in v3.1

Further reading available in the [Events section][sv-events].

{:.table .table-striped}
| Event    | Description     |
| :------ | :--------------- |
| `onCheckoutLoaded`    | This event will trigger the first time the Checkout is loaded. Subscribe to this event if you need total control over the height of Swedbank Pay’s payment frame. This is the initial height of the frame when loaded.     |
| `onCheckoutResized`    | This event will trigger every time a UI element changes size.Subscribe to this event if you need total control over the height of Swedbank Pay’s payment frame. The payment methods require individual heights when rendering their content.     |
| `onError`    | This event will be triggered during terminal errors or if the configuration fails validation. Subscribe to this event if you want some action to occur on your site when an error happens during the payment.     |
| `onOutOfViewRedirect`    | Triggered when a user is redirected to a separate web page, like 3-D Secure or BankID signing. Subscribe to this event if it is not possible to redirect the payer directly from within Swedbank Pay’s payment frame.     |
| `onAborted`    | This will be triggered when the payer clicks the "Abort" button. This is only present in the Redirect-implementation and if you have integrated Seamless View (menu embedded), you will need to supply this button/action. When the payer presses your cancel button, we recommend sending an API request aborting the payment so it can’t be completed at a later time. When we receive the request, an abort event will be raised the next time the UI fetches information from the server. Because of that, you should also refresh the script after aborting, as this will trigger the event.     |
| `onPaymentAttemptAborted`    | This event will trigger when an attempt has been aborted from an external party. One of these examples is from a card-issuers ACS service (3D-Secure verification). This does not mean the transaction in its entirety has failed. It is just the singular attempt that was aborted. More attempts are available to the payer.     |
| `onPaymentAttemptStarted`    | Triggered when the payer has selected a payment method and actively attempts to perform a payment.     |
| `onPaid`    | This event triggers when the payer successfully completes their interaction with us. Subscribe to this event if actions are needed on you side other than the default handling of redirecting the payer to your `completeUrl`. Call GET on the paymentOrder to receive the actual payment status and take appropriate actions according to the information displayed here. |
| `onPaymentAttemptFailed`  | Triggered when a payment has failed, disabling further attempts to perform a payment. |
| `onInstrumentSelected`    | Triggered when a user actively changes payment method in the Payment Menu. |
| `onTermsOfServiceRequested`    | Triggered when the user clicks on the “Display terms and conditions” link. Subscribe to this event if you do not want the default handling of the `termsOfServiceUrl`. Swedbank Pay will open the `termsOfServiceUrl` in a new tab within the same browser by default.     |
| `onEventNotification` | Triggered whenever any other public event is called. It does not prevent their handling. Subscribe to this event in order to log actions that are happening in the payment flow at Swedbank Pay.     |

### Events no longer needed and/or supported

*   `onBillingDetailsAvailable` (Starter/Business)
*   `onShippingDetailsAvailable` (Starter/Business)
*   `Payer identification` (Checkin)

`Checkin` is no longer supported in its previous form. Payer identification now
falls under the merchant's responsibility and is executed through the Payer
Aware Payment Menu feature. While this feature retains the functionality of
storing payment details for various payment methods, the primary responsibility
for the identification process lies with you as the merchant.

This identification is accomplished by assigning a value within the
`payerReference` parameter, serving as a pseudo-"profile" unique to your
account. It is crucial to ensure that each reference is distinct for every
consumer. Failure to correctly identify and provide the appropriate reference
for a consumer may lead to the display of another customer's details or trigger
the creation of a new profile, activating `guestMode`.

For more detailed information, see the [payer aware payment menu section][papm].

## Post-Purchase Changes

`Captures`, `Reversals`, and `Cancellations` will now be returned with the
intended response template provided by us. The information structure remains
identical to the initial PaymentOrder request you already receive when creating
the Purchase request. This means you are already familiar with the structure,
but the difference now is that it also applies to the response for post-purchase
actions.

The new response will not naturally include the same method data as it did
with v2. However, you can extend the information by adding
`?$expand=financialtransactions` to the request path (URL). If you require even
more data in your responses, you can continue extending the output by adding a
`,` followed by the node you desire to be included. As an example,
`?$expand=financialtransactions,paid` would give you both the node for the
initial `Purchase` and the node for the Capture/Reversal operation.

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/b2409f06-4944-4b2b-78d8-08dbf7d4b7e9",
    "capture": {
        "id": "/psp/creditcard/payments/b2409f06-4944-4b2b-78d8-08dbf7d4b7e9/captures/b15c1f9c-ad6b-4193-dabe-08dbf7d4b80a",
        "transaction": {
            "id": "/psp/creditcard/payments/b2409f06-4944-4b2b-78d8-08dbf7d4b7e9/transactions/b15c1f9c-ad6b-4193-dabe-08dbf7d4b80a",
            "created": "2023-12-08T11:53:08.8102555Z",
            "updated": "2023-12-08T11:53:08.8810258Z",
            "type": "Capture",
            "state": "Completed",
            "number": 40128369639,
            "amount": 100,
            "vatAmount": 0,
            "description": "Capturing the authorized payment",
            "payeeReference": "1702036388",
            "isOperational": false,
            "operations": []
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response example from existing versions'
    header=response_header
    json= response_content
    %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c",
        "created": "2023-12-08T13:42:08.1297502Z",
        "updated": "2023-12-08T13:43:10.8951496Z",
        "operation": "Purchase",
        "status": "Paid",
        "currency": "SEK",
        "amount": 100,
        "vatAmount": 0,
        "remainingReversalAmount": 100,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/7.35.0",
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
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/orderitems"
        },
        "urls": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/payers"
        },
        "history": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/history"
        },
        "failed": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/cancelled"
        },
        "reversed": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/reversed"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/failedattempts"
        },
        "postPurchaseFailedAttempts": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/postpurchasefailedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/metadata"
        }
    },
    "operations": [
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/a8d963ee-4749-4b3c-9f31-08dbf62d5f1c/reversals",
            "rel": "reversal",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/16e2b575fb662a7864d5fac28f9e9dd7e264fb8d934850c6dc38ea2be18cc973?_tc_tid=9401c5a368e04ffe9361a604eca15652",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/client/16e2b575fb662a7864d5fac28f9e9dd7e264fb8d934850c6dc38ea2be18cc973?culture=sv-SE&_tc_tid=9401c5a368e04ffe9361a604eca15652",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Response Example from v3.1 (Capture with no expansions)'
    header=response_header
    json= response_content
    %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407",
        "created": "2023-12-08T14:06:29.0250114Z",
        "updated": "2023-12-08T14:07:48.9872240Z",
        "operation": "Purchase",
        "status": "Paid",
        "currency": "SEK",
        "amount": 100,
        "vatAmount": 0,
        "remainingReversalAmount": 100,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/7.35.0",
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
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/orderitems"
        },
        "urls": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/payers"
        },
        "history": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/history"
        },
        "failed": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/paid",
            "number": 40128372054,
            "instrument": "CreditCard",
            "payeeReference": "1702044389",
            "transactionType": "Authorization",
            "amount": 100,
            "submittedAmount": 100,
            "feeAmount": 0,
            "discountAmount": 0,
            "details": {
                "nonPaymentToken": "6e7f3a0b-3d4d-46a7-8d13-6b15180896a2",
                "externalNonPaymentToken": "91dd1ea0eeafc2ac397d24e80abdc",
                "cardBrand": "MasterCard",
                "cardType": "Credit",
                "maskedPan": "522661******3406",
                "expiryDate": "12/2033",
                "issuerAuthorizationApprovalCode": "L25647",
                "acquirerTransactionType": "3DSECURE",
                "acquirerStan": "25647",
                "acquirerTerminalId": "40128372054",
                "acquirerTransactionTime": "2023-12-08T14:06:46.536Z",
                "transactionInitiator": "CARDHOLDER",
                "bin": "522661"
            }
        },
        "cancelled": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/cancelled"
        },
        "reversed": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/reversed"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/financialtransactions",
            "financialTransactionsList": [
                {
                    "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/financialtransactions/3477dfdc-097f-4a1f-de15-08dbf7d5c914",
                    "created": "2023-12-08T14:07:48.889224Z",
                    "updated": "2023-12-08T14:07:48.971819Z",
                    "type": "Capture",
                    "number": 40128372069,
                    "amount": 100,
                    "vatAmount": 0,
                    "description": "Capturing the authorized payment",
                    "payeeReference": "1702044467",
                    "orderItems": {
                        "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/financialtransactions/3477dfdc-097f-4a1f-de15-08dbf7d5c914/orderitems"
                    }
                }
            ]
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/failedattempts"
        },
        "postPurchaseFailedAttempts": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/postpurchasefailedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/metadata"
        }
    },
    "operations": [
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/d4c5684f-c2dc-4c18-680d-08dbf62de407/reversals",
            "rel": "reversal",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/8a18154cd0eb695537d871ab9936bd16f2a05cdaf42b84b4d027bdd843de4d09?_tc_tid=05f06eeeb05e4d188dc9a8a22bad1a3d",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/checkout/client/8a18154cd0eb695537d871ab9936bd16f2a05cdaf42b84b4d027bdd843de4d09?culture=sv-SE&_tc_tid=05f06eeeb05e4d188dc9a8a22bad1a3d",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Response Example from v3.1 (Capture with Paid and FinancialTransactions expanded)'
    header=response_header
    json= response_content
    %}

## Callback Information

Starting from v3.1 and in future API versions, we will no longer expose the
underlying URLs for individual API methods. Consequently, you will rely solely
on the `paymentOrderId` provided. If information has been included in the
`orderReference` field in the initial purchase request, this value will still be
reported, allowing you to easily identify the transaction associated with a
Callback. Note that the `payment` and `transaction` fields have been removed.

{% capture response_content %}{
   "orderReference":"PO-638423890947905216",
   "paymentOrder":{
      "id":"/psp/paymentorders/a9bd5ea2-d2b0-48d1-59c8-08dc230b04ba",
      "instrument":"CreditCard",
      "number":40129161258
   }
}{% endcapture %}

{% include code-example.html
    title='Callback Example v3.1'
    header=response_header
    json= response_content
    %}

{% capture response_content %}{
    "orderReference":"ABC123",
    "paymentOrder": {
        "id": "/psp/paymentorders/c3ac1392-35b0-43a6-8f27-08dbce43b47c",
        "instrument": "paymentorders"
    },
    "payment": {
        "id": "/psp/swish/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1",
        "number": 222222222
    },
    "transaction": {
        "id": "/psp/swish/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/sale/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
        "number": 333333333
    }
}{% endcapture %}

{% include code-example.html
    title='Callback Example Previous Versions'
    header=response_header
    json= response_content
    %}

## Sources

For a more in-depth understanding of each specific instance, we have compiled
relevant documentation below.

[Standard v3.1 documentation][3-1]

[Post-purchase documentation][post-purchase]

[Callback (asynchronous update)][callback]

[Payer identification (Payer Aware Menu)][papm]

[Seamless view events (Embedded menu)][sv-events]

[3-1]: https://developer.swedbankpay.com/checkout-v3/get-started/payment-request-3-1
[callback]: https://developer.swedbankpay.com/checkout-v3/features/payment-operations/callback
[papm]: https://developer.swedbankpay.com/checkout-v3/features/optional/payer-aware-payment-menu
[post-purchase]: https://developer.swedbankpay.com/checkout-v3/get-started/post-purchase-3-1
[sv-events]: https://developer.swedbankpay.com/checkout-v3/features/technical-reference/seamless-view-events
