{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Recurring Payments

{% include jumbotron.html body="A recurring payment enables you to charge a card
without payer interaction. When an initial payment token is generated,
subsequent payments are made through server-to-server requests. " %}

## Prerequisites

Prior to making any server-to-server requests, you need to supply the payment
instrument details and a payment token to Swedbank Pay by initial purchase.

*   Initiate a recurring payment flow and **charge the credit card**.
    This is done by creating a "Purchase Payment" and generating a
    recurrence token.

## Generate RecurrenceToken

*   When posting a `Purchase` payment, you need to make sure that the field
    `generateRecurrenceToken` is set to `true`.

{:.code-view-header}
**Field**

```json
"generateRecurrenceToken": true
```

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
server-to-server affair, as we have both payment instrument details and
recurrence token from the initial payment.

## Recur Request

{:.code-view-header}
**Request**

```http
POST /psp/{{ include.api_resource }}/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
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
}
```

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                          | Type         | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :----------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | {% f payment, 0 %}                      | `object`     | The payment object.                                                                                                                                                                                                                                                                  |
| {% icon check %} | `operation`                    | `object`     | `Recur`.                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f intent %}                | `string` | {% include fields/intent.md %} |
| {% icon check %} | {% f recurrenceToken %}      | `string`     | The created recurrenceToken, if `operation: Verify`, `operation: Recur` or `generateRecurrenceToken: true` was used.                                                                                                                                                                  |
| {% icon check %} | {% f currency %}             | `string`     | The currency of the payment order.                                                                                                                                                                                                                                                    |
| {% icon check %} | {% f amount %}               | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f vatAmount %}            | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | {% f description %}          | `string`     | {% include fields/description.md %}                                                                                                                                                                                     |
| {% icon check %} | {% f userAgent, 2 %}           | `string`     | The [`User-Agent` string](https://en.wikipedia.org/wiki/User_agent) of the payer's web browser.                                                                                                                                                                                                                  |
| {% icon check %} | {% f language, 2 %}            | `string`     | {% include fields/language.md %}                                                                                                                                                                                                              |
| {% icon check %} | {% f urls, 2 %}                | `string`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                                                                                          |
| {% icon check %} | {% f callbackUrl, 2 %}         | `string`     | {% include fields/callback-url.md %}                                                                                                                              |
| {% icon check %} | {% f payeeInfo %}            | `string`     | {% include fields/payee-info.md %}                                                                                                                                                                                          |
| {% icon check %} | {% f payeeId, 2 %}             | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                 |
| {% icon check %} | {% f payeeReference %}       | `string` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                          |
|                  | {% f receiptReference %}     | `string(30)` | {% include fields/receipt-reference.md %}                                                                                                                                                               |
| {% icon check %} | {% f payeeName, 2 %}           | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                               |
| {% icon check %} | {% f productCategory, 2 %}     | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                        |
| {% icon check %} | {% f orderReference, 2 %}      | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                               |
| {% icon check %} | {% f subsite, 2 %}             | `string(40)` | {% include fields/subsite.md %} |
|                  | {% f payer %}                | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}      | `string`     | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | {% f metadata %}             | `object`     | {% include fields/metadata.md %}                                                                                                                                                 |
{% endcapture %}
{% include accordion-table.html content=table %}

{% include alert.html type="informative" icon="info" body="
Please note that this `POST`request is made directly on the payment level,
and will not create a payment order." %}

#### Options after a payment

You have the following options after a server-to-server Recur payment `POST`.

##### Autorization (intent)

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

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
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
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
}
```

<!--lint disable final-definition -->

[payment-verify]: #verify
[card-payment-purchase]: /old-implementations/payment-instruments-v1/card/redirect#step-1-create-a-purchase
[card-payment-recur]: /old-implementations/payment-instruments-v1/card/features/optional/recur
[card-payment-capture]: /old-implementations/payment-instruments-v1/card/capture
[card-payment-cancel]: /old-implementations/payment-instruments-v1/card/after-payment#cancellations
[card-payments-remove-payment-token]: {{ features_url }}/optional/delete-token
[settlement-reconciliation]: {{ features_url }}/core/settlement-reconciliation
[settlement-reconciliation-split]: {{ features_url }}/core/settlement-reconciliation#split-settlement
[technical-reference-callback]: {{ features_url }}/core/callback
