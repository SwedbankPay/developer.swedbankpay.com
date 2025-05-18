
**Recommended version*

{: .h2 }

### Payment order v3.1

<div class="slab mb-5">
  <ul class="toc-list" role="navigation" aria-label="Article content">
    <li>
      <a href="#create-payment-order-v31">
        Create Payment Order
      </a>
      <ul role="list">
        <li>
          <a href="#payment-order-request-v31">
          Payment Order Request
          </a>
        </li>
        <li>
          <a href="#payment-order-response-v31">
          Payment Order Response
          </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#adding-to-your-request-v31">
        Adding To Your Request
      </a>
    </li>
  </ul>
</div>

The integration consists of four main steps. **Creating** the payment order,
**displaying** the payment menu, **validating** the status and **capturing** the
funds. In addition, there are other post-purchase options you need. We get to
them later on.

{: .h3 }

#### Before You Start

Depending on what you plan to include in your offering, we recommend stopping
by the pages specific to each payment method.

Some of them – like the digital wallets [Apple Pay][apple-pay]{:target="_blank"},
[Click to Pay][c2p]{:target="_blank"} and [Google Pay][google-pay]{:target="_blank"} –
have steps which must be completed before the payment method can be activated.

For [Swish][swish]{:target="_blank"} and [Trustly][trustly]{:target="_blank"},
we provide useful integration recommendations.

{: .h2 }

### Create Payment Order v3.1

When your customer has initiated a purchase, you need to create a payment order.
Start by performing a `POST` request towards the `paymentorder` resource with
payer information and a `completeUrl`.

`POST`, `PATCH`, `GET` and `PUT` requests use this header for v3.1:

`Content-Type: application/json;version=3.1`

`GET` requests can also use this header:

`Accept: application/json;version=3.1`

The `productName` field has been removed in v3.1, so the only way of specifying
that you are using v3.1 is through the header.

To accompany the new version, we have also added a
[v3.1 post-purchase section][post-31], [v3.1 callback][callback-31], a new
resource model for [`failedPostPurchaseAttempts`][fppa] and additions to the
[`history`][history] resource model.

Supported features for this integration are subscriptions (`recur`, `one-click`
and `unscheduled MIT`), `MOTO`, instrument mode, split settlement (`subsite`)
and the possibility to use your own `logo`.

There is also a guest mode option for the payers who don't wish to store their
information. The way to trigger this is to not include the `payerReference`
field in your `paymentOrder` request. If the `payer` field is included in your
request, you can find the `payerReference` there.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [payment operations][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`. If the payer is performing an action at a 3rd party, like the MobilePay,
Swish or Vipps apps, `abort` is unavailable.

To avoid unnecessary calls, we recommend doing a `GET` on your `paymentOrder` to
check if `abort` is an available operation before performing it.

### GDPR

When adding information to the `Payer` object for the purpose of pre-filling or
storing any data connected to the payer, you must first obtain their **explicit**
**consent**. In general, this consent can be collected when the payer provides
their delivery information, such as during the checkout or registration process.

Examples of such fields include:

*   `firstName`
*   `lastName`
*   `email`
*   `MSISDN`

If you are linking payer information to a profile (`payerReference`) or using
stored credentials for express checkouts, **do not use sensitive identifiers** —
such as email addresses, phone numbers, or social security numbers—in fields
like `payerReference`. These fields are **not intended to hold personal data**,
and therefore **do not offer the same level of protection or processing**
**safeguards** as fields explicitly designed for sensitive information under
GDPR.

If the use of sensitive data is absolutely necessary, it must be **hashed**
before being sent in any request to Swedbank Pay. The hash must be meaningful
only to you, the merchant or integrator, and **does not need to be reversible by**
**Swedbank Pay**. This means you are solely responsible for generating the hash
and, if needed, securely mapping it back to the original data on your side. The
responsibility for ensuring the **lawful processing, protection, and handling**
**of personal data** — both during and after the transaction — **rests entirely**
**with you**.

{% include alert-risk-indicator.md %}

{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}

{: .text-right}

[Top of page](#payment-order-v31)

{: .h3 }

#### Payment Order Request v3.1

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "paymentUrl": "https://example.com/perform-payment", //Seamless View only
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled", //Redirect only
            "callbackUrl": "https://api.example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/termsandconditoons.pdf"
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

{% capture table %}
{:.table .table-striped .mb-5}

|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f operation %}                | `string`     | {% include fields/operation.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f currency %}                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f vatAmount %}                | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f description %}              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |
| {% icon check %} | {% f userAgent %}                | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f language %}                 | `string`     | {% include fields/language.md %}                                                                                                                                                                                                                                                                                |
|                  | {% f implementation %}           | `string`     | Indicates which implementation to use.                                                                                                                                                                                                                                                                         |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f hostUrls, 2 %}                | `array`      | The array of valid host URLs.                                                                                                                                                                                                                                    |
|                  | {% f paymentUrl, 2 %}              | `string`     | {% include fields/payment-url-paymentorder.md %} |
| {% icon check %} | {% f completeUrl, 2 %}             | `string`     | {% include fields/complete-url.md %} |
| {% icon check %} | {% f cancelUrl, 2 %}               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% icon check %} | {% f callbackUrl, 2 %}             | `string`     | {% include fields/callback-url.md %}                                                                                                                                                                                              |
|                  | {% f logoUrl, 2 %}                 | `string`     | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                               |
|                  | {% f termsOfServiceUrl, 2 %}                 | `string`     | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f payeeInfo %}                | `object`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f payeeId, 2 %}                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}          | `string(30)` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | {% f payeeName, 2 %}               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f orderReference, 2 %}          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
{% endcapture %}
{% include accordion-table.html content=table %}

{: .text-right .mt-3}
[Top of page](#payment-order-v31)

{: .h3 }

#### Payment Order Response v3.1

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "vatAmount": 375,
        "amount": 1500,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
          "CreditCard",
          "Invoice-PayExFinancingSe",
          "Invoice-PayMonthlyInvoiceSe",
          "Swish",
          "CreditAccount",
          "Trustly" ],
        "implementation": "PaymentsOnly", {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect",
        {% endif %}
        "instrumentMode": false,
        "guestMode": false,
        "orderItems": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        },
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
        "reversed": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/reversed"
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
          "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
          "rel":"update-order",
          "method":"PATCH",
          "contentType":"application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
          "rel": "abort",
          "method": "PATCH",
          "contentType": "application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
          "rel": "abort-paymentattempt",
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
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with Instrument Mode (only one payment method available).                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |
| {% f orderItems %}     | `id`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f urls %}           | `id`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f payeeInfo %}      | `id`     | The URL to the `payeeInfo` resource where information related to the payee can be retrieved.                                                                                                          |
| {% f payer %}         | `id`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                  |
| {% f history %}     | `id`     | The URL to the [`history` resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `id`     | The URL to the [`failed` resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `id`     | The URL to the [`aborted` resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `id`     | The URL to the [`paid` resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `id`     | The URL to the [`cancelled` resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f reversed %}     | `id`     | The URL to the `reversed` resource where information about the reversed transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the [`financialTransactions` resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `id`     | The URL to the [`failedAttempts` resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f postPurchaseFailedAttempts %}     | `id`     | The URL to the `postPurchaseFailedAttempts` resource where information about the failed capture, cancel or reversal attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations, 0 %}     | `array`      | {% include fields/operations.md %}                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

{: .text-right .mt-3}
[Top of page](#payment-order-v31)

{: .h2 }

### Adding To Your Request v3.1

The request shown above includes what you need to create the payment, but you
can add more sections if you need or want.

Examples can be to include [order items][order-items] by adding a separate node,
or provide risk indicators and information about the payer to
[make the payment process as frictionless as possible][frictionless].

Read more about possible additions to the request in our
[feature section][features].

{: .text-right}
[Top of page](#payment-order-v31)

{% include iterator.html prev_href="/checkout-v3/get-started"
                         prev_title="Back To Get Started"
                         next_href="/checkout-v3/get-started/display-payment-ui"
                         next_title="Display Payment UI" %}

[abort-feature]: /checkout-v3/features/payment-operations/abort
[callback-31]: /checkout-v3/features/payment-operations/callback
[features]: /checkout-v3/features/
[fppa]: /checkout-v3/features/technical-reference/resource-sub-models#failedpostpurchaseattempts
[frictionless]: /checkout-v3/features/customize-payments/frictionless-payments
[history]: /checkout-v3/features/technical-reference/resource-sub-models#history
[order-items]: /checkout-v3/features/optional/order-items
[post-31]: /checkout-v3/get-started/post-purchase/
[trustly]: /checkout-v3/trustly-presentation
[swish]: /checkout-v3/swish-presentation
[apple-pay]: /checkout-v3/apple-pay-presentation
[c2p]: /checkout-v3/click-to-pay-presentation
[google-pay]: /checkout-v3/google-pay-presentation
