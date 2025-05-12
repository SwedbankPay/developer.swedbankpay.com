{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}

{% include alert-agreement-required.md %}

## Introduction

At the moment, our payout offering consists of Trustly Payout only, but this
may be expanding going forward.

There are two alternatives for implementing Trustly Payout. **Select Account**
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
3.  The response will include an operation with a `rel:redirect-checkout` or a
   `rel:view-checkout`. This is where you need to redirect the payer, or display
    in your UI, to let them choose their bank account.
4.  Redirect payer’s browser to `redirect-paymentmenu` or display the
    `rel:view-checkout`.
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

If something failed in the payout process this flow will happen.

1.  If the payout failed, you will get a callback.
2.  You will need to answer the callback with an acknowledge message.
3.  You need to do a GET on the `PaymentOrder` to check the status.
4.  It will have `status=Aborted` if the payout failed.
5.  You can now inform the payer that the payout has failed and that you will
    try to do the payout again.

## Verify Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
   "paymentorder": {
     "restrictedToPayoutInstruments": true,
     "generateUnscheduledToken": true,
     "operation": "Verify",
     "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
     "currency": "SEK",
     "description": "Bank account verification",
     "userAgent": "Mozilla/5.0...",
     "language": "sv-SE",
     "urls": {
       "completeUrl": "http://complete.url",
       "hostUrls": ["http://testmerchant.url"],
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
            "socialSecurityNumber": "199710202392",
            "countryCode": "SE"
            },
     "email": "test@swedbankpay.com",
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
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f operation %}                | `string`     | Must be set to `Verify`    .                                                                                                                                                                                                                                     |
| {% icon check %} | {% f productName %}                | `string`     | Must be set to `Checkout3`. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                  |
| {% icon check %} | {% f currency %}                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f restrictedToPayoutInstruments %}                       | `bool` | Set to `true` to only show Payout enabled payment methods (Trustly). |
| {% icon check %} | {% f generateUnscheduledToken %}                       | `bool` | Set to `true`. |
| {% icon check %} | {% f description %}              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |
| {% icon check %} | {% f userAgent %}                | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f language %}                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f hostUrls, 2 %}                | `array`      | The array of valid URLs.                                                                                                                                                                                           |
| {% icon check %} | {% f completeUrl, 2 %}             | `string`     | {% include fields/complete-url.md %} |
| {% icon check %} | {% f cancelUrl, 2 %}               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% icon check %} | {% f payeeInfo %}                | `object`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f payeeId, 2 %}                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}          | `string(30)` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | {% f payeeName, 2 %}               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f payer %}                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
|                  | {% f payerReference, 2 %}                     | `string`     | The merchant’s unique reference to the payer.                                                                                                                |
| {% icon check %} | {% f firstName, 2 %}                    | `string`     | The first name of the payer or the company name.                                                                                                                                                                                                                                                                              |
| | {% f lastName, 2 %}                    | `string`     | The last name of the payer.                                                                                                                                                                                                                                                                              |
|                  | {% f nationalIdentifier, 2 %}    | `object` | The national identifier object. This is required when using the `restrictedToSocialSecurityNumber` parameter.                                                                      |
|          | {% f socialSecurityNumber, 2 %} | `string` | The payer's social security number. |
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

Note the new operation `verify-trustly`, which is available if it is activated
in the merchant's contract and the payer's first and last name is added in the
request.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644",
        "created": "2023-06-09T07:26:27.3013437Z",
        "updated": "2023-06-09T07:26:28.6979343Z",
        "operation": "Verify",
        "status": "Initialized",
        "currency": "SEK",
        "amount": 510,
        "vatAmount": 0,
        "description": "Test Verification",
        "initiatingSystemUserAgent": "PostmanRuntime/7.32.2",
        "language": "nb-NO",
        "availableInstruments": [
            "Trustly"
        ],
        "implementation": "PaymentsOnly",
        "integration": "",
        "instrumentMode": false,
        "guestMode": false,
        "urls": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/payers"
        },
        "history": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/history"
        },
        "failed": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644/metadata"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.stage.payex.com/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644",
            "rel": "update-order",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://api.stage.payex.com/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644",
            "rel": "abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.stage.payex.com/checkout/a8ff4fa9821b500dbb657bcba68422e20b9ba8dd2652bbc3f0f456b93774023f?_tc_tid=96f4d7cef4984a84b380e5478b7f6632",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.stage.payex.com/checkout/core/client/checkout/a8ff4fa9821b500dbb657bcba68422e20b9ba8dd2652bbc3f0f456b93774023f?culture=nb-NO&_tc_tid=96f4d7cef4984a84b380e5478b7f6632",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        },
        {
            "method": "PATCH",
            "href": "https://api.stage.payex.com/psp/paymentorders/b60d08b8-0509-4abf-a722-08db68bad644",
            "rel": "verify-trustly",
            "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | `Verify`                                                                                                                                                                                                                |
| {% f status %}          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. See the [`Paid` response]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in [the `Failed` response]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. See the [`Cancelled` response]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the [`Aborted` response]({{ features_url }}/technical-reference/status-models#aborted). |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Online Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Online Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment methods available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |
| {% f urls %}           | `id`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f payeeInfo %}      | `id`     | The URL to the `payeeInfo` resource where information related to the payee can be retrieved.                                                                                                                              |
| {% f payer %}         | `id`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                  |
| {% f history %}     | `id`     | The URL to the [`history` resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `id`     | The URL to the [`failed` resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `id`     | The URL to the [`aborted` resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `id`     | The URL to the [`paid` resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `id`     | The URL to the [`cancelled` resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the [`financialTransactions` resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `id`     | The URL to the [`failedAttempts` resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}     | `array`      | {% include fields/operations.md %}                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

## PATCH Verify Request

The PATCH request towards the `verify-trustly` operation, containing the bank
account details.

{% capture request_header %}PATCH /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "VerifyTrustly",
        "clearingHouse": "SWEDEN",
        "bankNumber": "6112",
        "accountNumber": "69706212"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f operation %}      | `string`     | {% include fields/operation.md %}                                                                                                                                                                                                                |
| {% f clearingHouse %}      | `string`     | The clearing house of the recipient's bank account. Typically the name of a country in uppercase letters.                                                                                                                                                                                                               |
| {% f bankNumber %}      | `string`     | The bank number identifying the recipient's bank in the given clearing house. For bank accounts in IBAN format you should just provide an empty string (""). For non-IBAN, see the example in our request or [the bank number format table](https://eu.developers.trustly.com/doc/reference/registeraccount#accountnumber-format).                                                                                                                                                                                                       |
| {% f accountNumber %}      | `string`     | The account number, identifying the recipient's account in the bank. Can be either IBAN or country-specific format. See [the account number format table](https://eu.developers.trustly.com/doc/reference/registeraccount#accountnumber-format) for further information.                                                                                                                                                                                        |
{% endcapture %}
{% include accordion-table.html content=table %}

## PATCH Verify Response

Note that the status in the response has changed to `Paid`, with the correlating
disappearance of `PATCH` operations.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/<id>",
        "created": "2023-07-06T05:42:07.7531238Z",
        "updated": "2023-07-06T05:42:14.6086749Z",
        "operation": "Verify",
        "status": "Paid",
        "currency": "SEK",
        "amount": 510,
        "vatAmount": 0,
        "description": "Test Verification",
        "initiatingSystemUserAgent": "PostmanRuntime/7.32.3",
        "language": "nb-NO",
        "availableInstruments": [
            "Trustly"
        ],
        "implementation": "PaymentsOnly",
        "integration": "",
        "instrumentMode": false,
        "guestMode": true,
        "urls": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/payers"
        },
        "history": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/history"
        },
        "failed": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/1e7e8e00-dc76-4ea5-0d7d-08db7c962a83/metadata"
        }
    },
    "operations":     "operations": [
        {
            "method": "GET",
            "href": "https://ecom.stage.payex.com/checkout/a8ff4fa9821b500dbb657bcba68422e20b9ba8dd2652bbc3f0f456b93774023f?_tc_tid=96f4d7cef4984a84b380e5478b7f6632",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.stage.payex.com/checkout/core/client/checkout/a8ff4fa9821b500dbb657bcba68422e20b9ba8dd2652bbc3f0f456b93774023f?culture=nb-NO&_tc_tid=96f4d7cef4984a84b380e5478b7f6632",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | `Verify`                                                                                                                                                                                                                |
| {% f status %}          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. See the [`Paid` response]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in [the `Failed` response]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. See the [`Cancelled` response]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the [`Aborted` response]({{ features_url }}/technical-reference/status-models#aborted). |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Online Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Online Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment method available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |
| {% f urls %}           | `id`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f payeeInfo %}      | `id`     | The URL to the `payeeInfo` resource where information related to the payee can be retrieved.                                                                                                                          |
| {% f payer %}         | `id`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                  |
| {% f history %}     | `id`     | The URL to the [`history` resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `id`     | The URL to the [`failed` resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `id`     | The URL to the [`aborted` resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `id`     | The URL to the [`paid` resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `id`     | The URL to the [`cancelled` resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the [`financialTransactions` resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `id`     | The URL to the [`failedAttempts` resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}     | `array`      | {% include fields/operations.md %}                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

## Payout Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
  "paymentorder": {
    "operation": "Payout",
    "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "unscheduledToken": "{{unscheduledToken}}",
    "description": "Bank account verification",
    "userAgent": "Mozilla/5.0...",
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
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f operation %}                | `string`     | Must be set to `Payout`.                                                                                                                                                                                                                                     |
| {% icon check %} | {% f productName %}                | `string`     | Must be set to `Checkout3`. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                 |
| {% icon check %} | {% f currency %}                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f amount %}                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f vatAmount %}               | `integer`    | {% include fields/vat-amount.md %}                                                     |
| | {% f unscheduledToken %}                       | `string` | Must be provided to specify the consumer account to be the receiver of the payout. |
| {% icon check %} | {% f description %}              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |
| {% icon check %} | {% f userAgent %}                | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f language %}                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f callbackUrl, 2 %}             | `string`     | {% include fields/callback-url.md %}                                                                                                                                                                                              |
| {% icon check %} | {% f payeeInfo %}                | `object`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f payeeId, 2 %}                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}          | `string(30)` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | {% f payeeName, 2 %}               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f payer %}                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
|                  | {% f payerReference, 2 %}                     | `string`     | The merchant’s unique reference to the payer.                                                                                                                |
{% endcapture %}
{% include accordion-table.html content=table %}

## Payout Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
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
            "id": "/psp/paymentorders/f4e47e61-37a5-4281-a5f3-08db68bc1d08/orderitems"
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
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | `Purchase`                                                                                                                                                                                                                |
| {% f status %}          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. See the [`Paid` response]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in [the `Failed` response]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. See the [`Cancelled` response]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the [`Aborted` response]({{ features_url }}/technical-reference/status-models#aborted). |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Online Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Online Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment methods available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |
| {% f orderItems %}     | `id`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f urls %}           | `id`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f payeeInfo %}      | `id`     | The URL to the `payeeInfo` resource where information related to the payee can be retrieved.                                                                                                                          |
| {% f history %}     | `id`     | The URL to the [`history` resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `id`     | The URL to the [`failed` resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `id`     | The URL to the [`aborted` resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `id`     | The URL to the [`paid` resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `id`     | The URL to the [`cancelled` resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the [`financialTransactions` resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `ic`     | The URL to the [`failedAttempts` resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}     | `array`      | {% include fields/operations.md %}                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

## GET Payment Order

A GET performed after the callback is received on a `paymentOrder` with status
`Paid`. A field called `trustlyOrderId` will appear among the `details` in the
`Paid` node. This can be used for support correspondance.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture response_content %}{
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
            "instrument": "Trustly",
            "number": 79100113652,
            "payeeReference": "1662373401",
            "orderReference": "orderReference",
            "transactionType": "Sale",
            "amount": 1500,
            "tokens": [
                {
                    "type": "Unscheduled",
                    "token": "6d495aac-cb2b-4d94-a5f1-577baa143f2c",
                    "name": "492500******0004",
                    "expiryDate": "02/2023"
                }
            ],
            "submittedAmount": 1500,
            "feeAmount": 0,
            "discountAmount": 0,
            "details": {
             "trustlyOrderId": 123456789
            }
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
    "operations": []
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | `Purchase`                                                                                                                                                                                                                |
| {% f status %}          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. See the [`Paid` response]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in [the `Failed` response]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. See the [`Cancelled` response]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the [`Aborted` response]({{ features_url }}/technical-reference/status-models#aborted). |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Online Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Online Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment method available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |
| {% f urls %}           | `string`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f id, 2 %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f callbackUrl, 2 %}             | `string`     | {% include fields/callback-url.md %}                                                                                                                                                                                              |
| {% f payeeInfo %}      | `object`     | {% include fields/payee-info.md %}                                                                                                          |
| {% f payer %}         | `string`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                  |
| {% f history %}     | `string`     | The URL to the [`history` resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `string`     | The URL to the [`failed` resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `string`     | The URL to the [`aborted` resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `string`     | The URL to the [`paid` resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f id, 2 %}             | `string`     | {% include fields/id.md resource="paymentorder" %}  |
| {% f instrument, 2 %}             | `string`     | The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a `capture` is needed, we recommend using `operations` or the `transactionType` field. |
| {% f number, 2 %}         | `integer` | {% include fields/number.md %} |
| {% f payeeReference, 2 %}          | `string(30)` | {% include fields/payee-reference.md %} |
| {% f transactionType, 2 %}          | `string` | This will either be set to `Authorization` or `Sale`. Can be used to understand if there is a need for doing a capture on this payment order. Swedbank Pay recommends using the different operations to figure out if a capture is needed. |
| {% f amount, 2 %}                   | `integer`    | {% include fields/amount.md %}                                            |
| {% f tokens, 2 %}                   | `integer`    | A list of tokens connected to the payment.                                                   |
| {% f type, 3 %}  | `string`   | {% f payment, 0 %}, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| {% f token, 3 %}  | `string`   | The token `guid`. |
| {% f name, 3 %}  | `string`   | The name of the token. In the example, a masked version of a card number. |
| {% f expiryDate, 3 %}  | `string`   | The expiry date of the token. |
| {% f feeAmount, 2 %}                   | `integer`    | If the payment method used had a unique fee, it will be displayed in this field.                                            |
| {% f discountAmount, 2 %}                   | `integer`    | If the payment method used had a unique discount, it will be displayed in this field.                                                |
| {% f details, 2 %}                   | `integer`    | Details connected to the payment. |
| {% f trustlyOrderId, 2 %}          | `string` | A Trustly specific order id meant to be use if there is a support case. |
| {% f cancelled %}     | `id`     | The URL to the [`cancelled` resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the [`financialTransactions` resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `id`     | The URL to the [`failedAttempts` resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations, 0 %}     | `array`      | {% include fields/operations.md %}                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

## Select Account Flow

{:.text-center}
![Select account flow chart][select-flow]

## Register Account Flow

{:.text-center}
![Register account flow chart][register-flow]

[register-flow]: /assets/img/checkout/RegisterAccount-Flow.png
[select-flow]: /assets/img/checkout/SelectAccount-Flow.png

(https://eu.developers.trustly.com/doc/reference/registeraccount#accountnumber-format)
