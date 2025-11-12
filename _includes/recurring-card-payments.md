{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Recurring Payments

{% include jumbotron.html body="A recurring payment enables you to charge a card
without payer interaction. When an initial payment token is generated,
subsequent payments are made through server-to-server requests. " %}

## Prerequisites

Identify the recurring model and token type based on your needs. We support both
dynamic and static prices and intervals. Use the `RecurrenceToken` flow for
recurring payments with a constant price and interval, and the
`UnscheduledToken` flow for variable services or goods. We **highly** recommend
using the [unscheduled][unscheduled] option, as it gives you flexibility
regarding changes in amount and interval.

Prior to making any server-to-server requests, you need to supply the payment
method details and a payment token to Swedbank Pay by initial purchase.

*   Initiate a recurring payment flow and **charge the credit card**.
    This is done by creating a "Purchase Payment" and generating a
    recurrence token.

## Generate RecurrenceToken

*   When posting a `Purchase` payment, you need to make sure that the field
    `generateRecurrenceToken` is set to `true`.

{% capture request_content %}"generateRecurrenceToken": true{% endcapture %}

{% include code-example.html
    title='Field'
    header=request_header
    json= request_content
    %}

## Creating The Payment

*   You need to `POST` a [Purchase payment][card-payment-purchase] / and
    generate a recurrence token (safekeep for later recurring use).

## Retrieve The Recurrence Token

You can retrieve the recurrence token by doing a `GET` request against the
`payment`. You need to store this `recurrenceToken` in your system and keep
track of the corresponding `payerReference`.

## Delete The Recurrence Token

You can delete a created recurrence token. Please see technical reference for
details [here][card-payments-remove-payment-token].

## Recurring Purchases

When you have a Recurrence token stored away. You can use the same token in a
subsequent [`recurring payment`][card-payment-recur] `POST`. This will be a
server-to-server affair, as we have both payment method details and
recurrence token from the initial payment.

Please note that you need to do a capture after sending the recur request.
We have added a capture section at the end of this page for that reason.

## Recur Request

{% capture request_header %}POST /psp/{{ include.api_resource }}/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "payment": {
        "operation": "Recur",
        "intent": "Authorization",
        "recurrenceToken": "{{ page.payment_id }}",
        "currency": "NOK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Recurrence",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
            "callbackUrl": "https://example.com/payment-callback"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
        },
        "metadata": {
            "key1": "value1",
            "key2": 2,
            "key3": 3.1,
            "key4": false
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture intent_md %}{% include fields/intent.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture callback_url_md %}{% include fields/callback-url.md %}{% endcapture %}
{% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
{% capture metadata_md %}{% include fields/metadata.md %}{% endcapture %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Root: payment (function 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment object</div></div>

    <div class="api-children">
      <!-- operation (literal field name as given) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field"><code>operation</code><i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Recur</code>.</div></div>
      </details>

      <!-- intent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f intent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ intent_md | markdownify }}</div></div>
      </details>

      <!-- recurrenceToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f recurrenceToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The created <code>recurrenceToken</code>, if <code>operation: Verify</code>, <code>operation: Recur</code> or <code>generateRecurrenceToken: true</code> was used.</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. <code>DKK</code>, <code>EUR</code>, <code>NOK</code> or <code>SEK</code>). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- userAgent (level 2 as given) -->
      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f userAgent, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-2">The <a href="https://en.wikipedia.org/wiki/User_agent"><code>User-Agent</code> string</a> of the payer's web browser.</div>
        </div>
      </details>

      <!-- language (level 2) -->
      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f language, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- urls (level 2) -->
      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f urls, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <!-- callbackUrl (level 2) -->
      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f callbackUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">{{ callback_url_md | markdownify }}</div></div>
      </details>

      <!-- payeeInfo -->
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
            <div class="desc"><div class="indent-2">This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f receiptReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/receipt-reference.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f productCategory, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f subsite, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(40)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/subsite.md %}</div></div>
          </details>
        </div>
      </details>

      <!-- payer -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object, containing information about the payer.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/payer-reference.md %}</div></div>
          </details>
        </div>
      </details>

      <!-- metadata -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ metadata_md | markdownify }}</div></div>
      </details>
    </div>
  </details>
</div>

{% include alert.html type="informative" icon="info" body="
Please note that this `POST`request is made directly on the payment level,
and will not create a payment order." %}

#### Options after a payment

You have the following options after a server-to-server Recur payment `POST`.

##### Authorization (intent)

*   **Authorization (two-phase):** If you want the credit card to reserve the
    amount, you will have to specify that the intent of the purchase is
    Authorization.
    The amount will be reserved but not charged.
    You will later (i.e. when you are ready to ship the purchased products)
    have to make a [Capture][card-payment-capture] or
    [Cancel][card-payment-cancel] request.

##### Capture (intent)

*   **AutoCapture (one-phase)**: If you want the credit card to be charged right
    away, you will have to specify that the intent of the purchase is
    AutoCapture. This is only allowed if the payer purchases digital products.
    The card will be charged and you don't need to do any more financial
    operations to this purchase.​​​​​

##### General

*   **Defining CallbackURL**: When implementing a scenario,
    it is optional to set a [`CallbackURL`][technical-reference-callback]
    in the `POST` request.
    If callbackURL is set Swedbank Pay will send a postback request to this URL
    when the payer has fulfilled the payment.

### Verify

A [card verification][payment-verify] lets you post verifications to confirm the
validity of card information, without reserving or charging any amount. You can
use it for generating `paymentToken`s, but do **not** use it when generating
`recurrenceToken`s.

This is because banks are rejecting recurring transactions where the amount is
higher than the initial transaction. If the initial transaction `amount` is e.g.
1000, your subsequent recurring transaction `amount`s can be up to 1000 too, but
1001 will most likely be rejected. Since `Verify` transaction `amount`s are
always 0, this can cause issues for you in the future.

{% include alert.html type="informative" icon="info" body="
Please note that all boolean credit card attributes involving rejection of
certain card types are optional and set on contract level." %}

{% capture request_header %}POST /psp/creditcard/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "payment": {
        "operation": "Verify",
        "currency": "NOK",
        "description": "Test Verification",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "generatePaymentToken": true,
        "generateRecurrenceToken": false,
        "urls": {
            "hostUrls": [ "https://example.com" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "paymentUrl": "https://example.com/perform-payment",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.html"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
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

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "operation": "Verify",
        "state": "Ready",
        "currency": "NOK",
        "amount": 0,
        "description": "Test Verification",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "transactions": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions" },
        "verifications": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/verifications" },
        "urls" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/urls" },
        "payeeInfo" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payeeInfo" },
        "payers": {"id": "/psp/creditcard/payments/{{ page.payment_id }}/payers" },
        "settings": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/settings" }
    },
    "operations": [
        {
            "href": "{{ page.api_url }}/psp/creditcard/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort",
            "method": "PATCH",
            "contentType": "application/json"
        },
        {
            "href": "{{ page.front_end_url }}/creditcard/payments/verification/{{ page.payment_token }}",
            "rel": "redirect-verification",
            "method": "GET",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/creditcard/core/scripts/client/px.creditcard.client.js?token={{ page.payment_token }}",
            "rel": "view-verification",
            "contentType": "application/javascript"
        },
        {
            "method": "POST",
            "href": "{{ page.front_end_url }}/psp/creditcard/confined/payments/{{ page.payment_id }}/verifications",
            "rel": "direct-verification",
            "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% include capture.md %}

<!--lint disable final-definition -->

[payment-verify]: #verify
[card-payment-purchase]: /old-implementations/payment-instruments-v1/card/redirect#step-1-create-a-purchase
[card-payment-recur]: /old-implementations/payment-instruments-v1/card/features/optional/recur
[card-payment-capture]: /old-implementations/payment-instruments-v1/card/capture
[card-payment-cancel]: /old-implementations/payment-instruments-v1/card/after-payment#cancellations
[card-payments-remove-payment-token]: {{ features_url }}/optional/delete-token
[technical-reference-callback]: {{ features_url }}/core/callback
[unscheduled]: /old-implementations/payment-instruments-v1/card/features/optional/unscheduled
