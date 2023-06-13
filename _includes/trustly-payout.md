## Trustly Payout

## Introduction

We offer two different ways of implementing Trustly Payout. **Select Account**
and **Register Account**. Both alternatives consist of two parts, a setup and a
server-to-server call which actually triggers the payout.

The setup procedures of the two options differ somewhat, so we will describe
them separately. The actual payout procedure is the same, and will be described
as one.

## Select Account

Select Account should be used for all consumers who will need to pick their
payout account. The initial setup handles the UI part where the payer chooses
their bank account. This endpoint will return a token that can be used to
represent that bank account for that payer. The second part is, as mentioned
before, a server-to-server endpoint where the actual payout is triggered. This
lets you reuse the token multiple times if that is desired.

## Select Account Setup

The initial setup can be done at an earlier time than the actual payout.

1.  The payer initiates the payout process on your site.
2.  You will have to initiate a `PaymentOrder` towards Swedbank Pay to start the
   payout process. It is important to set `“operation=Verify”,`
   `generateUnscheduledToken=true` and `restrictedToPayoutInstruments=true`.
3.  The response will include an operation with a `rel:redirect-paymentmenu`.
   This is where you need to redirect the payer to let them choose their bank
   account.
4.  Redirect payer’s browser to `redirect-paymentmenu`.
5.  The Swedbank Pay payment UI will be loaded in Payout mode.
6.  The only option for the payer is to choose Trustly, as this is the only
   available payout alternative to date.
7.  The payer’s browser will be redirected to Trustly.
8.  The payer will identify themselves by BankId and choose the bank account
   where they want to receive the money.
9.  The payer is then redirected back to Swedbank Pay.
10.  Swedbank Pay will validate that we have received the bank account
    information before showing the OK message.
11.  The payer is redirected back to the `completeUrl` provided in the initial
    call.
12.  The payer’s browser is connected to the `completeUrl`.
13.  You then need to do a `GET` to check the status of the payout.
14.  You will receive a `PaymentOrder` response model. You can check that the
    status is set to `Paid`. If the `PaymentOrder` is aborted or failed,
    something went wrong and the attempt was unsuccessful. You will get the
    `UnscheduledToken` in the model's paid node.
15.  Return status to the payer about the status.

## Register Account

**Register Account** should be used for payouts to other business entities. This
implementation requires that you already have all account information for the
receiving payout account. There is no interaction needed by the receiving part
in this flow.

## Register Account Setup

1.  You or the customer will trigger the payout process.
2.  You will have to initiate a `PaymentOrder` towards Swedbank Pay to start the
   payout process. It is important to set `operation=Verify`,
   `generateUnscheduledToken=true`, `restrictedToPayoutInstruments=true`.
3.  The response will include an operation with a `rel:verify-trustly`. This is
   where you need to do a call to register the bank account.
4.  Do a call to the `verify-trustly` endpoint to register the bank account
   details.
5.  The response will have `status=Paid` if everything is completed. The
   `unscheduledToken` will be provided in the response model's `Paid` node.
6.  If desired, you can notify the payer that the bank account is registered.

## The Server-To-Server Payout Call

1.  When it is time to do a payout, you must initiate a new payment order. This
   time there is no interaction with the payer, so it will be handled as a
   server-to-server call. You must set `operation=Payout` and
   `unscheduledToken=<token>`. It is also important to include a `callbackUrl`
   as this call is async and will use callbacks to communicate status changes.
2.  Swedbank Pay will initiate the payout process against Trustly.
3.  You will get a response that the `PaymentOrder` is initialized. The reason
   for this is that it takes some time before the payout is completed.
4.  If you wish, you can now communicate to the payer that the payout is
   registered, but not finished.

   It will take some time before a payout is either OK or Failed. There can also
   be edge cases where the payout will get the `Paid` status first, and changed
   to failed later. It is important to design the system to handle these
   scenarios. If the payout is complete the following flow will happen:

5.  You will get a callback.
6.  You will need to answer the callback with an acknowledge message.
7.  You need to do a `GET` on the `PaymentOrder` to check the status.
8.  It must have `status=Paid` if the payout was successful.
9.  You can now inform the payer that the payout was successful.

If something failed in the payout process this flow will happen. In
some rare cases, it can also happen after you have received a `Paid` status.

5.  If the payout failed, you will get a callback.
6.  You will need to answer the callback with an acknowledge message.
7.  You need to do a GET on the `PaymentOrder` to check the status.
8.  It will have `status=Aborted` or `status=Reversed` if the payout failed.
9.  You can now inform the payer that the payout has failed and that you will
    try to do the payout again.

## Verify Request

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
   "paymentorder": {
     "operation": "Verify",
     "productName": "Checkout3",
     "currency": "SEK",
     "restrictedToPayoutInstruments": true,
     "generateUnscheduledToken": true,
     "description": "Bank account verification",
     "userAgent": "{{clientUserAgent}}",
     "language": "sv-SE",
     "urls": {
       "hostUrls": ["http://testmerchant.url"],
       "completeUrl": "http://complete.url",
       "cancelUrl": "http://cancel.url"
     },
     "payeeInfo": {
       "payeeId": "{{merchantId}}",
       "payeeReference": "{{$timestamp}}",
       "payeeName": "Testmerchant"
     },
     "payer": {
       "payerReference": "{{payerReference}}",
       "firstName": "Example",
       "lastName": "Name",
       "nationalIdentifier": {
       "socialSecurityNumber": "197901311234"
       "countryCode": "SE"
     },
     "email": "test@payex.com",
     "msisdn": "+46709876543",
     "address": {
       "streetAddress": "Main Street 1",
       "coAddress": "Apartment 123, 2 stairs up",
       "city": "Stockholm",
       "zipCode": "SE-11253",
       "countryCode": "SE"
     }
   }
 }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f operation %}                | `string`     | Must be set to `Verify`    .                                                                                                                                                                                                                                     |
| {% icon check %} | {% f productName %}                | `string`     | Must be set to `Checkout3`    .                                                                                                                                                                                                                                     |
| {% icon check %} | {% f currency %}                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| | {% f restrictedToInstruments %}                       | `bool` | Set to `true` to only show Payout enabled instruments (Trustly). |
| | {% f generateUnscheduledToken %}                       | `bool` | Set to `true`. |
| {% icon check %} | {% f description %}              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |
| {% icon check %} | {% f userAgent %}                | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f language %}                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f hostUrls, 2 %}                | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views. Not needed to implement the Swedbank Pay redirect  flow.                                                                                                                                                                                                                                  |
| {% icon check %} | {% f completeUrl, 2 %}             | `string`     | {% include fields/complete-url.md %} |
| {% icon check %} | {% f cancelUrl, 2 %}               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% icon check %} | {% f payeeInfo %}                | `string`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f payeeId, 2 %}                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | {% f payeeName, 2 %}               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f payer %}                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
|                  | {% f payerReference, 2 %}                     | `string`     | The merchant’s unique reference to the payer.                                                                                                                |
| | {% f firstName, 2 %}                    | `string`     | The first name of the payer.                                                                                                                                                                                                                                                                              |
| | {% f lastName, 2 %}                    | `string`     | The last name of the payer.                                                                                                                                                                                                                                                                              |
|                  | {% f nationalIdentifier, 2 %}    | `object` | The national identifier object. This is required when using the `restrictedToSocialSecurityNumber` parameter.                                                                      |
| {% icon check %}            | {% f socialSecurityNumber, 2 %} | `string` | The payer's social security number. |
| | {% f countryCode, 2 %}                | `string` | Country code of the payer.                                                          |
|                  | {% f email %}                   | `string`     | The e-mail address of the payer.                                                       |
|                  | {% f msisdn %}                  | `string`     | The mobile phone number of the Payer. The mobile number must have a country code prefix and be 8 to 15 digits in length.             |
|  | {% f address %}              | `object`  | The address object containing information about the payer's address.                                                                            |
|  ︎ | {% f streetAddress, 1 %}        | `string`  | The street address of the payer. Maximum 50 characters long.                                                                                                   |
|    | {% f coAddress, 1 %}            | `string`  | The payer's CO-address (if used).                                                                                                                                         |
|  | {% f city, 1 %}                 | `string`  | The payer's city of residence.                                                                                                                                        |
|   | {% f zipCode, 1 %}              | `string`  | The postal number (ZIP code) of the payer.                                                                                                                    |
|  | {% f countryCode, 1 %}          | `string`  | Country code for country of residence, e.g. `SE`, `NO`, or `FI`.                                                                                                                                             |
{% endcapture %}
{% include accordion-table.html content=table %}

## Verify Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json


```

## Payout Request

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Payout",
    "productName": "Checkout3",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "unscheduledToken": {{unscheduledToken}},
    "description": "Bank account verification",
    "userAgent": "{{clientUserAgent}}",
    "language": "sv-SE",
    "urls": {
      "callbackUrl": "http://callback.url"
    },
    "payeeInfo": {
      "payeeId": "{{merchantId}}",
      "payeeReference": "{{$timestamp}}",
      "payeeName": "Testmerchant"
    },
    "payer": {
      "payerReference": "{{payerReference}}"
    }
  }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f operation %}                | `string`     | Must be set to `Payout`    .                                                                                                                                                                                                                                     |
| {% icon check %} | {% f productName %}                | `string`     | Must be set to `Checkout3`    .                                                                                                                                                                                                                                     |
| {% icon check %} | {% f currency %}                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f amount %}                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f vatAmount %}               | `integer`    | {% include fields/vat-amount.md %}                                                     |
| | {% f unscheduledToken %}                       | `string` | Must be provided to specify the consumer account to be the receiver of the payout. |
| {% icon check %} | {% f description %}              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |
| {% icon check %} | {% f userAgent %}                | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f language %}                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f callbackUrl, 2 %}             | `string`     | {% include fields/callback-url.md %}                                                                                                                                                                                              |
| {% icon check %} | {% f payeeInfo %}                | `string`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f payeeId, 2 %}                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}          | `string` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | {% f payeeName, 2 %}               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f payer %}                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
|                  | {% f payerReference, 2 %}                     | `string`     | The merchant’s unique reference to the payer.                                                                                                                |
{% endcapture %}
{% include accordion-table.html content=table %}

## Payout Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentOrder": {
        "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08",
        "created": "2023-06-09T07:35:35.1855792Z",
        "updated": "2023-06-09T07:35:35.6863019Z",
        "operation": "Payout",
        "status": "Initialized",
        "currency": "SEK",
        "amount": 2147483647,
        "vatAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/7.32.2",
        "language": "sv-SE",
        "availableInstruments": [],
        "implementation": "PaymentsOnly",
        "integration": "",
        "instrumentMode": false,
        "guestMode": true,
        "orderItems": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/orderitems",
            "orderItemList": [
                {
                    "reference": "P1",
                    "name": "Status-Declined",
                    "type": "PRODUCT",
                    "class": "ProductGroup1",
                    "quantity": 1.0,
                    "quantityUnit": "pcs",
                    "unitPrice": 500,
                    "discountPrice": 0,
                    "vatPercent": 2500,
                    "amount": 2147483647,
                    "vatAmount": 0,
                    "restrictedToInstruments": []
                }
            ]
        },
        "urls": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/payeeinfo"
        },
        "history": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/history"
        },
        "failed": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/metadata"
        }
    },
    "operations": []
}

```

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

{% endcapture %}
{% include accordion-table.html content=table %}

## GET Payment Order

A GET performed after the callback is recieved on a `paymentOrder` with status
`Paid`. A field called `trustlyOrderId` will appear among the `details` in the
`Paid` node. This can be used for support correspondance.

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentOrder": {
        "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08",
        "created": "2023-06-09T07:38:08.5041489Z",
        "updated": "2023-06-09T07:38:25.3627725Z",
        "operation": "Payout",
        "status": "Paid",
        "currency": "SEK",
        "amount": 1000,
        "vatAmount": 0,
        "remainingReversalAmount": 1000,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/7.32.2",
        "language": "sv-SE",
        "availableInstruments": [],
        "implementation": "PaymentsOnly",
        "integration": "",
        "instrumentMode": false,
        "guestMode": true,
        "orderItems": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/orderitems",
            "orderItemList": [
                {
                    "reference": "P1",
                    "name": "Status-Declined",
                    "type": "PRODUCT",
                    "class": "ProductGroup1",
                    "quantity": 1.0000,
                    "quantityUnit": "pcs",
                    "unitPrice": 500,
                    "discountPrice": 0,
                    "vatPercent": 2500,
                    "amount": 1000,
                    "vatAmount": 0,
                    "restrictedToInstruments": []
                }
            ]
        },
        "urls": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/urls",
            "callbackUrl": "http://test-dummy.net/payment-callback"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/payeeinfo"
        },
        "history": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/history"
        },
        "failed": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/metadata"
        }
    },
    "operations": [
        {
            "method": "POST",
            "href": "https://api.stage.payex.com/psp/paymentorders/3c265183-e7ee-438b-a5f4-08db68bc1d08/reversals",
            "rel": "reversal",
            "contentType": "application/json"
        }
    ]
}
```

## Select Account Flow

## Register Account Flow
