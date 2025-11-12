{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
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

{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
{% capture complete_url_md %}{% include fields/complete-url.md %}{% endcapture %}
{% capture user_agent_md %}{% include fields/user-agent.md %}{% endcapture %}
{% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">
      <!-- operation (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }} Must be set to <code>Verify</code>.</div></div>
      </details>

      <!-- productName (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f productName, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Must be set to <code>Checkout3</code>. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.</div></div>
      </details>

      <!-- currency (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment.</div></div>
      </details>

      <!-- restrictedToPayoutInstruments (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f restrictedToPayoutInstruments, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> to only show Payout enabled payment methods (Trustly).</div></div>
      </details>

      <!-- generateUnscheduledToken (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generateUnscheduledToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code>.</div></div>
      </details>

      <!-- description (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the payment order.</div></div>
      </details>

      <!-- userAgent (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The language of the payer.</div></div>
      </details>

      <!-- urls (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>urls</code> object, containing the URLs relevant for the payment order.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hostUrls, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The array of valid URLs.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f completeUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ complete_url_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cancelUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
          </details>
        </div>
      </details>

      <!-- payeeInfo (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The ID of the payee, usually the merchant ID.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the payee, usually the name of the merchant.</div></div>
          </details>
        </div>
      </details>

      <!-- payer (opt) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The merchant’s unique reference to the payer.</div></div>
          </details>

          <!-- firstName (req) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The first name of the payer or the company name.</div></div>
          </details>

          <!-- lastName (opt) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f lastName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The last name of the payer.</div></div>
          </details>

          <!-- nationalIdentifier (opt, but required if restrictedToSocialSecurityNumber) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f nationalIdentifier, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The national identifier object. This is required when using the <code>restrictedToSocialSecurityNumber</code> parameter.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f socialSecurityNumber, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The payer's social security number.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code of the payer.</div></div>
              </details>
            </div>
          </details>

          <!-- email (opt) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The e-mail address of the payer.</div></div>
          </details>

          <!-- msisdn (opt) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The mobile phone number of the Payer. The mobile number must have a country code prefix and be 8 to 15 digits in length.</div></div>
          </details>

          <!-- address (opt) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f address, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The address object containing information about the payer's address.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The street address of the payer. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The payer's CO-address (if used).</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The payer's city of residence.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The postal number (ZIP code) of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code for country of residence, e.g. <code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
              </details>
            </div>
          </details>
        </div>
      </details>

    </div>
  </details>
</div>

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

{% capture paymentorder_id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture initiating_system_user_agent_md %}{% include fields/initiating-system-user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">
      <!-- id (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ paymentorder_id_md | markdownify }}</div></div>
      </details>

      <!-- created (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was created. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <!-- updated (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was updated. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <!-- operation (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- status (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing. The request example above has this status. <code>Paid</code> is returned when the payer has completed the payment successfully. See the <a href="{{ techref_url }}/technical-reference/status-models#paid">Paid response</a>. <code>Failed</code> is returned when a payment has failed. You will find an error message in <a href="{{ techref_url }}/technical-reference/status-models#failed">the Failed response</a>. <code>Cancelled</code> is returned when an authorized amount has been fully cancelled. See the <a href="{{ techref_url }}/technical-reference/status-models#cancelled">Cancelled response</a>. It will contain fields from both the cancelled description and paid section. <code>Aborted</code> is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the <a href="{{ techref_url }}/technical-reference/status-models#aborted">Aborted response</a>.</div></div>
      </details>

      <!-- currency (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. <code>DKK</code>, <code>EUR</code>, <code>NOK</code> or <code>SEK</code>). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- initiatingSystemUserAgent (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ initiating_system_user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- availableInstruments (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <!-- implementation (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.</div></div>
      </details>

      <!-- integration (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.</div></div>
      </details>

      <!-- instrumentMode (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment methods available.</div></div>
      </details>

      <!-- guestMode (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a <code>payerReference</code> in the original <code>paymentOrder</code> request.</div></div>
      </details>

      <!-- urls link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <!-- payeeInfo link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payeeInfo</code> resource where information related to the payee can be retrieved.</div></div>
      </details>

      <!-- payer link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a> where information about the payer can be retrieved.</div></div>
      </details>

      <!-- history link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#history"><code>history</code> resource</a> where information about the payment's history can be retrieved.</div></div>
      </details>

      <!-- failed link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failed"><code>failed</code> resource</a> where information about the failed transactions can be retrieved.</div></div>
      </details>

      <!-- aborted link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#aborted"><code>aborted</code> resource</a> where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <!-- paid link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#paid"><code>paid</code> resource</a> where information about the paid transactions can be retrieved.</div></div>
      </details>

      <!-- cancelled link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#cancelled"><code>cancelled</code> resource</a> where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <!-- financialTransactions link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#financialtransactions"><code>financialTransactions</code> resource</a> where information about the financial transactions can be retrieved.</div></div>
      </details>

      <!-- failedAttempts link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failedattempts"><code>failedAttempts</code> resource</a> where information about the failed attempts can be retrieved.</div></div>
      </details>

      <!-- metadata link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>
    </div>
  </details>
  <!-- operations (level 0) -->
  <details class="api-item" data-level="0">
      <summary>
        <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>array</code></span>
      </summary>
      <div class="desc"><div class="indent-0">{{ operations_md | markdownify }}</div></div>
  </details>
</div>

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

{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">
      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- clearingHouse -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f clearingHouse, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The clearing house of the recipient's bank account. Typically the name of a country in uppercase letters.</div></div>
      </details>

      <!-- bankNumber -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f bankNumber, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The bank number identifying the recipient's bank in the given clearing house. For bank accounts in IBAN format you should just provide an empty string (<code>""</code>). For non-IBAN, see the example in our request or <a href="https://eu.developers.trustly.com/doc/reference/registeraccount#accountnumber-format" target="_blank" rel="noopener">the bank number format table</a>.</div></div>
      </details>

      <!-- accountNumber -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f accountNumber, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The account number, identifying the recipient's account in the bank. Can be either IBAN or country-specific format. See <a href="https://eu.developers.trustly.com/doc/reference/registeraccount#accountnumber-format" target="_blank" rel="noopener">the account number format table</a> for further information.</div></div>
      </details>

    </div>
  </details>
</div>

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

{% capture paymentorder_id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture initiating_system_user_agent_md %}{% include fields/initiating-system-user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">
      <!-- id (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ paymentorder_id_md | markdownify }}</div></div>
      </details>

      <!-- created (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was created. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <!-- updated (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was updated. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <!-- operation (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- status (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing. The request example above has this status. <code>Paid</code> is returned when the payer has completed the payment successfully. See the <a href="{{ techref_url }}/technical-reference/status-models#paid">Paid response</a>. <code>Failed</code> is returned when a payment has failed. You will find an error message in <a href="{{ techref_url }}/technical-reference/status-models#failed">the Failed response</a>. <code>Cancelled</code> is returned when an authorized amount has been fully cancelled. See the <a href="{{ techref_url }}/technical-reference/status-models#cancelled">Cancelled response</a>. It will contain fields from both the cancelled description and paid section. <code>Aborted</code> is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the <a href="{{ techref_url }}/technical-reference/status-models#aborted">Aborted response</a>.</div></div>
      </details>

      <!-- currency (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. <code>DKK</code>, <code>EUR</code>, <code>NOK</code> or <code>SEK</code>). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- initiatingSystemUserAgent (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ initiating_system_user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- availableInstruments (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <!-- implementation (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.</div></div>
      </details>

      <!-- integration (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.</div></div>
      </details>

      <!-- instrumentMode (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment method available.</div></div>
      </details>

      <!-- guestMode (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a <code>payerReference</code> in the original <code>paymentOrder</code> request.</div></div>
      </details>

      <!-- urls link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <!-- payeeInfo link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payeeInfo</code> resource where information related to the payee can be retrieved.</div></div>
      </details>

      <!-- payer link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a> where information about the payer can be retrieved.</div></div>
      </details>

      <!-- history link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#history"><code>history</code> resource</a> where information about the payment's history can be retrieved.</div></div>
      </details>

      <!-- failed link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failed"><code>failed</code> resource</a> where information about the failed transactions can be retrieved.</div></div>
      </details>

      <!-- aborted link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#aborted"><code>aborted</code> resource</a> where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <!-- paid link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#paid"><code>paid</code> resource</a> where information about the paid transactions can be retrieved.</div></div>
      </details>

      <!-- cancelled link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#cancelled"><code>cancelled</code> resource</a> where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <!-- financialTransactions link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#financialtransactions"><code>financialTransactions</code> resource</a> where information about the financial transactions can be retrieved.</div></div>
      </details>

      <!-- failedAttempts link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failedattempts"><code>failedAttempts</code> resource</a> where information about the failed attempts can be retrieved.</div></div>
      </details>

      <!-- metadata link (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>
    </div>
  </details>

  <!-- operations (level 0) -->
    <details class="api-item" data-level="0">
        <summary>
            <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-0">{{ operations_md | markdownify }}</div></div>
    </details>
</div>

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

{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture user_agent_md %}{% include fields/user-agent.md %}{% endcapture %}
{% capture callback_url_md %}{% include fields/callback-url.md %}{% endcapture %}
{% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Root: paymentOrder (level 0, required) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">
      <!-- operation (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }} Must be set to <code>Payout</code>.</div></div>
      </details>

      <!-- productName (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f productName, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Must be set to <code>Checkout3</code>. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.</div></div>
      </details>

      <!-- currency (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment.</div></div>
      </details>

      <!-- amount (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- unscheduledToken (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f unscheduledToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Must be provided to specify the consumer account to be the receiver of the payout.</div></div>
      </details>

      <!-- description (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the payment order.</div></div>
      </details>

      <!-- userAgent (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The language of the payer.</div></div>
      </details>

      <!-- urls (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>urls</code> object, containing the URLs relevant for the payment order.</div></div>
        <div class="api-children">
          <!-- callbackUrl (required) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ callback_url_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- payeeInfo (required) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>
        <div class="api-children">
          <!-- payeeId (required) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The ID of the payee, usually the merchant ID.</div></div>
          </details>

          <!-- payeeReference (required) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <!-- payeeName (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the payee, usually the name of the merchant.</div></div>
          </details>
        </div>
      </details>

      <!-- payer (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>
        <div class="api-children">
          <!-- payerReference (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The merchant’s unique reference to the payer.</div></div>
          </details>
        </div>
      </details>

    </div>
  </details>
</div>

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

{% capture paymentorder_id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture initiating_system_user_agent_md %}{% include fields/initiating-system-user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">
      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ paymentorder_id_md | markdownify }}</div></div>
      </details>

      <!-- created -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was created. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <!-- updated -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was updated. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- status -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing. The request example above has this status. <code>Paid</code> is returned when the payer has completed the payment successfully. See the <a href="{{ techref_url }}/technical-reference/status-models#paid">Paid response</a>. <code>Failed</code> is returned when a payment has failed. You will find an error message in <a href="{{ techref_url }}/technical-reference/status-models#failed">the Failed response</a>. <code>Cancelled</code> is returned when an authorized amount has been fully cancelled. See the <a href="{{ techref_url }}/technical-reference/status-models#cancelled">Cancelled response</a>. It will contain fields from both the cancelled description and paid section. <code>Aborted</code> is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the <a href="{{ techref_url }}/technical-reference/status-models#aborted">Aborted response</a>.</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. <code>DKK</code>, <code>EUR</code>, <code>NOK</code> or <code>SEK</code>). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- initiatingSystemUserAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ initiating_system_user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- availableInstruments -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <!-- implementation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.</div></div>
      </details>

      <!-- integration -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.</div></div>
      </details>

      <!-- instrumentMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment method available.</div></div>
      </details>

      <!-- guestMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a <code>payerReference</code> in the original <code>paymentOrder</code> request.</div></div>
      </details>

      <!-- orderItems link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      <!-- urls link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <!-- payeeInfo link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payeeInfo</code> resource where information related to the payee can be retrieved.</div></div>
      </details>

      <!-- payer link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a> where information about the payer can be retrieved.</div></div>
      </details>

      <!-- history link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#history"><code>history</code> resource</a> where information about the payment's history can be retrieved.</div></div>
      </details>

      <!-- failed link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failed"><code>failed</code> resource</a> where information about the failed transactions can be retrieved.</div></div>
      </details>

      <!-- aborted link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#aborted"><code>aborted</code> resource</a> where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <!-- paid link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#paid"><code>paid</code> resource</a> where information about the paid transactions can be retrieved.</div></div>
      </details>

      <!-- cancelled link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#cancelled"><code>cancelled</code> resource</a> where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <!-- financialTransactions link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#financialtransactions"><code>financialTransactions</code> resource</a> where information about the financial transactions can be retrieved.</div></div>
      </details>

      <!-- failedAttempts link (note: type 'ic' kept as provided) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>ic</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failedattempts"><code>failedAttempts</code> resource</a> where information about the failed attempts can be retrieved.</div></div>
      </details>

      <!-- metadata link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>
    </div>
  </details>

    <!-- operations -->
    <details class="api-item" data-level="0">
        <summary>
            <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-0">{{ operations_md | markdownify }}</div></div>
    </details>
</div>

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

{% capture paymentorder_id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture initiating_system_user_agent_md %}{% include fields/initiating-system-user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture callback_url_md %}{% include fields/callback-url.md %}{% endcapture %}
{% capture number_md %}{% include fields/number.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">
      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ paymentorder_id_md | markdownify }}</div></div>
      </details>

      <!-- created -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was created. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <!-- updated -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was updated. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- status -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing. The request example above has this status. <code>Paid</code> is returned when the payer has completed the payment successfully. See the <a href="{{ techref_url }}/technical-reference/status-models#paid">Paid response</a>. <code>Failed</code> is returned when a payment has failed. You will find an error message in <a href="{{ techref_url }}/technical-reference/status-models#failed">the Failed response</a>. <code>Cancelled</code> is returned when an authorized amount has been fully cancelled. See the <a href="{{ techref_url }}/technical-reference/status-models#cancelled">Cancelled response</a>. It will contain fields from both the cancelled description and paid section. <code>Aborted</code> is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the <a href="{{ techref_url }}/technical-reference/status-models#aborted">Aborted response</a>.</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. <code>DKK</code>, <code>EUR</code>, <code>NOK</code> or <code>SEK</code>). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- initiatingSystemUserAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ initiating_system_user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- availableInstruments -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <!-- implementation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.</div></div>
      </details>

      <!-- integration -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.</div></div>
      </details>

      <!-- instrumentMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment method available.</div></div>
      </details>

      <!-- guestMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a <code>payerReference</code> in the original <code>paymentOrder</code> request.</div></div>
      </details>

      <!-- urls (string with children) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ paymentorder_id_md | markdownify }}</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ callback_url_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- payeeInfo (object, include text) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/payee-info.md %}</div></div>
      </details>

      <!-- payer link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a> where information about the payer can be retrieved.</div></div>
      </details>

      <!-- history link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#history"><code>history</code> resource</a> where information about the payment's history can be retrieved.</div></div>
      </details>

      <!-- failed link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failed"><code>failed</code> resource</a> where information about the failed transactions can be retrieved.</div></div>
      </details>

      <!-- aborted link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#aborted"><code>aborted</code> resource</a> where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <!-- paid link (with detailed children) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#paid"><code>paid</code> resource</a> where information about the paid transactions can be retrieved.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ paymentorder_id_md | markdownify }}</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f instrument, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a <code>capture</code> is needed, we recommend using <code>operations</code> or the <code>transactionType</code> field.</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f transactionType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">This will either be set to <code>Authorization</code> or <code>Sale</code>. Can be used to understand if there is a need for doing a capture on this payment order. Swedbank Pay recommends using the different operations to figure out if a capture is needed.</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f tokens, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A list of tokens connected to the payment.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f type, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">{% f payment, 0 %}, <code>recurrence</code>, <code>transactionOnFile</code> or <code>unscheduled</code>. The different types of available tokens.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f token, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The token <code>guid</code>.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f name, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The name of the token. In the example, a masked version of a card number.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f expiryDate, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The expiry date of the token.</div></div>
              </details>
            </div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f feeAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the payment method used had a unique fee, it will be displayed in this field.</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the payment method used had a unique discount, it will be displayed in this field.</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f details, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Details connected to the payment.</div></div>
          </details>
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f trustlyOrderId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A Trustly specific order id meant to be use if there is a support case.</div></div>
          </details>
        </div>
      </details>

      <!-- cancelled link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#cancelled"><code>cancelled</code> resource</a> where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <!-- financialTransactions link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#financialtransactions"><code>financialTransactions</code> resource</a> where information about the financial transactions can be retrieved.</div></div>
      </details>

      <!-- failedAttempts link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failedattempts"><code>failedAttempts</code> resource</a> where information about the failed attempts can be retrieved.</div></div>
      </details>

      <!-- metadata link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>

    </div>
  </details>

  <!-- Root sibling: operations (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc"><div class="indent-0">{{ operations_md | markdownify }}</div></div>
  </details>
</div>

## Select Account Flow

{:.text-center}
![Select account flow chart][select-flow]

## Register Account Flow

{:.text-center}
![Register account flow chart][register-flow]

[register-flow]: /assets/img/checkout/RegisterAccount-Flow.png
[select-flow]: /assets/img/checkout/SelectAccount-Flow.png

(https://eu.developers.trustly.com/doc/reference/registeraccount#accountnumber-format)
