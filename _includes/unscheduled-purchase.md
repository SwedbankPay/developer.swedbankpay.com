{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign seamless_view = include.seamless_view | default: false %}
{% assign full_reference = include.full_reference | default: false %}

## Unscheduled Purchase

{% include alert-agreement-required.md %}

An `unscheduled purchase`, also called a Merchant Initiated Transaction (MIT),
is a payment which uses a `paymentToken` generated through a previous payment in
order to charge the same card at a later time. They are done by the merchant
without the cardholder being present.

`unscheduled purchase`s differ from `recur` as they are not meant to be
recurring, but occur as singular transactions. Examples of this can be car
rental companies charging the payer's card for toll road expenses after the
rental period.

## Generating The Token

First, you need an initial transaction where the `unscheduledToken` is generated
and connected. You do that by adding the field `generateUnscheduledToken` in the
request and set the value to `true`. The payer must complete the
purchase to activate the token. You can also use [Verify][verify] to activate
tokens.

(Read more about [deleting the unscheduled token][delete-token] here.)

## Initial Request

The initial request should look like this:

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "SEK",
        "prices": [{
                "type": "CreditCard",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase", {% if documentation_section contains "payment-menu" or documentation_section contains "checkout" %}
        "generateUnscheduledToken": true, {% else %}
        "generatePaymentToken": true, {% endif %}
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": { {% if seamless_view %}
            "hostUrls": ["https://example.com"],{% endif %}
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",{% if seamless_view %}
            "paymentUrl": "https://example.com/perform-payment",{% endif %}
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.pdf",
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or123",
            "subsite": "mySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
        },
        "cardholder": {
            "firstName": "Olivia",
            "lastName": "Nyhuus",
            "email": "olivia.nyhuus@payex.com",
            "msisdn": "+4798765432",
            "homePhoneNumber": "+4787654321",
            "workPhoneNumber": "+4776543210",
            "shippingAddress": {
                "firstName": "Olivia",
                "lastName": "Nyhuus",
                "email": "olivia.nyhuus@payex.com",
                "msisdn": "+4798765432",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
            }, {% if full_reference %}
            "billingAddress": {
                "firstName": "Olivia",
                "lastName": "Nyhuus",
                "email": "olivia.nyhuus@payex.com",
                "msisdn": "+4798765432",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
            },
            "accountInfo": {
                "accountAgeIndicator": "01",
                "accountChangeIndicator": "01",
                "accountPwdChangeIndicator": "01",
                "shippingAddressUsageIndicator": "01",
                "shippingNameIndicator": "01",
                "suspiciousAccountActivity": "01",
                "addressMatchIndicator": "false"
            }{% endif %}
        },
        "riskIndicator": {
            "deliveryEmailAddress": "olivia.nyhuus@payex.com",
            "deliveryTimeFrameIndicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
                "name": "Olivia Nyhuus",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
            }
        }{% if full_reference %},
        "metadata": {
            "key1": "value1",
            "key2": 2,
            "key3": 3.1,
            "key4": false
        }{% endif %}
    }{% if full_reference %},
    "creditCard": {
        "rejectCreditCards": false,
        "rejectDebitCards": false,
        "rejectConsumerCards": false,
        "rejectCorporateCards": false,
        "no3DSecure": false
    }{% endif %}
}
```

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                             | Type          | Description                     |
| :--------------: | :-------------------------------- | :------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}                         | `object`      | The payment object                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| {% icon check %} | {% f operation %}               | `string`      | {% include fields/operation.md %} |
| {% icon check %} | {% f intent %}                  | `string`      | `Authorization`. Reserves the amount, and is followed by a `Cancel` or `Capture` of funds.<br> <br> `AutoCapture`. A one phase option that enables the `Capture` of funds automatically after authorization.                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f currency %}                | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f prices %}                  | `array`       | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f type, 2 %}                   | `string`      | {% include fields/prices-type.md kind="CreditCard" %}           |
| {% icon check %} | {% f amount, 2 %}                 | `integer`     | {% include fields/amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f vatAmount, 2 %}              | `integer`     | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f description %}             | `string(40)`  | {% include fields/description.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | {% if documentation_section contains "payment-menu" or documentation_section contains "checkout" %}
|                  | {% f generateUnscheduledToken %}| `boolean`     | `true` or `false`. Set to `true` if you want to generate an `unscheduledToken` for future unscheduled purchases (Merchant Initiated Transactions).                                                                                                                                                                                                                                                                                                                                                                                                                                                 | {% else %}
|                  | {% f generatePaymentToken %}| `boolean`     | `true` or `false`. Set to `true` if you want to generate a `paymentToken` for future unscheduled purchases (Merchant Initiated Transactions).                                                                                                                                                                                                                                                                                                                                                                                                                                                 | {% endif %}
| {% icon check %} | {% f userAgent %}               | `string`      | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | {% f language %}                | `string`      | {% include fields/language.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %}︎ | {% f urls %}                    | `object`      | The object containing URLs relevant for the `payment`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |{% if seamless_view %}
| {% icon check %}︎ | {% f hostUrls, 2 %}               | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |{% endif %}
| {% icon check %} | {% f completeUrl, 2 %}            | `string`      | {% include fields/complete-url.md resource="payment" %}                                                                                                                                                                                                                                                                                         |
| {% icon check %} | {% f cancelUrl, 2 %}              | `string`      | The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f paymentUrl, 2 %}             | `string`      | {% include fields/payment-url.md %}                                                                                                                                                                                                                                                                                                                               |
|                  | {% f callbackUrl, 2 %}            | `string`      | {% include fields/callback-url.md resource="payment" %}                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f logoUrl, 2 %}                | `string`      | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | {% f termsOfServiceUrl, 2 %}      | `string`      | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | {% f payeeInfo %}               | `string`      | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f payeeId, 2 %}                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f payeeReference, 2 %}         | `string` | {% include fields/payee-reference.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|                  | {% f payeeName, 2 %}              | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f productCategory, 2 %}        | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                                            |
|                  | {% f orderReference, 2 %}         | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f subsite, 2 %}                | `string(40)`  | {% include fields/subsite.md %} |
|                  | {% f payer %}                   | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}         | `string`     | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | {% f metadata %}                | `object`      | {% include fields/metadata.md documentation_section="card" %}                                                                                                                                                                                                                                                                                                                                                                                      |
|                  | {% f cardholder %}              | `object`      | Optional. Cardholder object that can hold information about a buyer (private or company). The information added increases the chance for frictionless flow and is related to {%- if include.documentation_section == 'card' -%}[3-D Secure 2.0][3ds2]{% else %} 3-D Secure 2.0{% endif %}..                                                                                                                                                                                                                                                                                                                                                                                      |
|                  | {% f firstName, 2 %}              | `string`      | Optional (increased chance for frictionless flow if set). If buyer is a company, use only `firstName`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | {% f lastName, 2 %}               | `string`      | Optional (increased chance for frictionless flow if set). If buyer is a company, use only `firstName`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | {% f email, 2 %}                  | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f msisdn, 2 %}                 | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f homePhoneNumber, 2 %}        | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f workPhoneNumber, 2 %}        | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f shippingAddress, 2 %}        | `object`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f firstName, 3 %}             | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f lastName, 3 %}              | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f email, 3 %}                 | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f msisdn, 3 %}                | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f streetAddress, 3 %}         | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f coAddress, 3 %}             | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f city, 3 %}                  | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f zipCode, 3 %}               | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f countryCode, 3 %}           | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f billingAddress, 2 %}         | `object`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f firstName, 3 %}             | `string`      | Optional (increased chance for frictionless flow if set). If buyer is a company, use only `firstName`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | {% f lastName, 3 %}              | `string`      | Optional (increased chance for frictionless flow if set). If buyer is a company, use only `firstName`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | {% f email, 3 %}                 | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f msisdn, 3 %}                | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f streetAddress, 3 %}         | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f coAddress, 3 %}             | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f city, 3 %}                  | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f zipCode, 3 %}               | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | {% f countryCode, 3 %}           | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
{% if full_reference -%}
|                  | {% f accountInfo, 2 %}                    | `object`      | Optional (increased chance for frictionless flow if set).<br> <br>If cardholder is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                          |
|                  | {% f accountAgeIndicator, 3 %}           | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.<br>`01` (No account, guest)<br>`02` (Created during transaction)<br>`03` (Less than 30 days)<br>`04` (30-60 days)<br>`05` (More than 60 days)                                                                                                                                                                                                                                                    |
|                  | {% f accountChangeIndicator, 3 %}        | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Length of time since the cardholder's account information with the merchant was changed. Including billing etc.<br>`01` (Changed during transaction)<br>`02` (Less than 30 days)<br>`03` (30-60 days)<br>`04` (More than 60 days)                                                                                                                                                                                                                                                                               |
|                  | {% f accountPwdChangeIndicator, 3 %}     | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.<br>`01` (No change)<br>`02` (Changed during transaction)<br>`03` (Less than 30 days)<br>`04` (30-60 days)<br>`05` (More than 60 days)                                                                                                                                                                                                                                                     |
|                  | {% f shippingAddressUsageIndicator, 3 %} | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates when the shipping address used for this transaction was first used with the merchant.<br>`01` (This transaction)<br>`02` (Less than 30 days)<br>`03` (30-60 days)<br>`04` (More than 60 days)                                                                                                                                                                                                                                                                                                         |
|                  | {% f shippingNameIndicator, 3 %}         | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.<br>`01` (Account name identical to shipping name)<br>`02` (Account name different than shipping name)<br>                                                                                                                                                                                                                                                                                          |
|                  | {% f suspiciousAccountActivity, 3 %}     | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.<br>`01` (No suspicious activity has been observed)<br>`02` (Suspicious activity has been observed)<br>                                                                                                                                                                                                                                                                                     |
|                  | {% f addressMatchIndicator, 3 %}         | `boolean`     | Optional (increased chance for frictionless flow if set)<br> <br> Allows the 3-D Secure Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                      |
|                  | {% f riskIndicator, 2 %}                  | `object`      | This **optional** object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for {%- if include.documentation_section == 'card' -%}[3-D Secure 2.0 authentication][3ds2]{% else %} 3-D Secure 2.0 authentication{% endif %} of the payer when they are authenticating the purchase.                                                                                                                                                                                                                                                                                                                              |
{% endif -%}
{%- include risk-indicator-table.md -%}
{% if full_reference -%}
|                  | `creditCard`                              | `object`      | The credit card object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|                  | {% f rejectDebitCards %}                | `boolean`     | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|                  | {% f rejectCreditCards %}               | `boolean`     | `true` if credit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                |
|                  | {% f rejectConsumerCards %}             | `boolean`     | `true` if consumer cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                  | {% f rejectCorporateCards %}            | `boolean`     | `true` if corporate cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                  | {% f no3DSecure %}                      | `boolean`     | `true` if 3-D Secure should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                            |
|                  | {% f noCvc %}                           | `boolean`     | `true` if the CVC field should be disabled for this payment in case a stored card is used; otherwise `false` per default. This feature is commonly used when {%- if include.documentation_section == 'card' -%} [One-Click Payments][one-click-payments]{% else %} One-Click Payments{% endif %} is enabled. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                          |
{% endif %}
{% endcapture %}
{% include accordion-table.html content=table %}

## Initial Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "instrument": "CreditCard",
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "SEK",
        "amount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE", {% if documentation_section contains "payment-menu" or documentation_section contains "checkout" %}
        "unscheduledToken": "{{ page.payment_id }}", {% else %}
        "paymentToken": "{{ page.payment_id }}", {% endif %}
        "prices": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/prices" },
        "transactions": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions" },
        "authorizations": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/authorizations" },
        "captures": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/captures" },
        "reversals": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/reversals" },
        "cancellations": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/cancellations" },
        "urls": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/urls" },
        "payeeInfo": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payeeInfo" },
        "payers": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payers" },
        "settings": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/settings" }
    },
    "operations": [
        {
            "rel": "update-payment-abort",
            "href": "{{ page.api_url }}/psp/creditcard/payments/{{ page.payment_id }}",
            "method": "PATCH",
            "contentType": "application/json"
        },
        {
            "rel": "redirect-authorization",
            "href": "{{ page.front_end_url }}/creditcard/payments/authorize/{{ page.payment_token }}",
            "method": "GET",
            "contentType": "text/html"
        },
        {
            "rel": "view-authorization",
            "href": "{{ page.front_end_url }}/creditcard/core/scripts/client/px.creditcard.client.js?token={{ page.payment_token }}",
            "method": "GET",
            "contentType": "application/javascript"
        },
        {
            "rel": "view-payment",
            "href": "{{ page.front_end_url }}/creditcard/core/scripts/client/px.creditcard.client.js?token={{ page.payment_token }}",
            "method": "GET",
            "contentType": "application/javascript"
        },
        {
            "rel": "direct-authorization",
            "href": "{{ page.api_url }}/psp/creditcard/confined/payments/{{ page.payment_id }}/authorizations",
            "method": "POST",
            "contentType": "application/json"
        }
    ]
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                             | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :-------------------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                         | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| {% f id %}                      | `string`     | {% include fields/id.md %}                                                                                                                                                                                                                                                                                                                      |
| {% f number %}                  | `integer`    | {% include fields/number.md resource="payment" %}                                                                                                                                                           |
| {% f instrument %}     | `string`     | The payment instrument used in the payment.                                                                                                           |
| {% f created %}                 | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                                                                                                                                                                                         |
| {% f updated %}                 | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| {% f state %}                   | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| {% f operation %}      | `string`     | `Purchase`                                                                                                                                                                                                                |
|  {% f intent %}                | `string`     | `Authorization`                     |
| {% f currency %}                | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                        |
| {% f amount %}                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                                                                  |
| {% f remainingCaptureAmount %}  | `integer`    | The available amount to capture.                                                                                                                                                                                                                                                                                                                           |
| {% f remainingCancelAmount %}   | `integer`    | The available amount to cancel.                                                                                                                                                                                                                                                                                                                            |
| {% f remainingReversalAmount %} | `integer`    | The available amount to reverse.                                                                                                                                                                                                                                                                                                                           |
| {% f description %}             | `string(40)` | {% include fields/description.md %}                                                                                                                                                                                                                                                                                |
| {% f userAgent %}               | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                       |
| {% f language %}                | `string`     | {% include fields/language.md %}                                                                                                                                                                                                                                                                                      | {% if documentation_section contains "payment-menu" or documentation_section contains "checkout" %}
| {% f unscheduledToken %}     | `string`     | The generated unscheduled token, if `operation: Verify`, `operation: UnscheduledPurchase` or `generateUnscheduledToken: true` was used.                                                                                                                                                                  | {% else %}
| {% f paymentToken %}     | `string`     | The generated payment token, if `operation: Verify`, `operation: UnscheduledPurchase` or `generatePaymentToken: true` was used.                                                                                                                                                                  | {% endif %}
| {% f prices %}                  | `string`     | The URL to the `prices` resource where all URLs related to the payment can be retrieved.                                                               |
| {% f transactions %}                  | `string`     | The URL to the `transactions` resource where the information about the payer can be retrieved.                                                        |
| {% f authorizations %}                  | `string`     | The URL to the `authorizations` resource where the information about the payer can be retrieved.                                                        |
| {% f captures %}                  | `string`     | The URL to the `captures` resource where the information about the payer can be retrieved.                                                        |
| {% f reversals %}                  | `string`     | The URL to the `reversals` resource where the information about the payer can be retrieved.                                                        |
| {% f cancellations %}                  | `string`     | The URL to the `cancellations` resource where the information about the payer can be retrieved.                                                        |
| {% f urls %}                    | `string`     | The URL to the `urls` resource where all URLs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| {% f payeeInfo %}               | `string`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                 |
| {% f payers %}                  | `string`     | The URL to the `payer` resource where the information about the payer can be retrieved.                                                        |

| {% f settings %}                  | `string`     | The URL to the `settings` resource where the information about the payer can be retrieved.                                                        |
| {% f operations %}     | `array`      | {% include fields/operations.md resource="payment" %}                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

## GET The Token

{% if documentation_section contains "checkout-v3" %}

The token can be retrieved by performing a [`GET` towards
`paid`][paid-resource-model]. It will be visible under `tokens`in the `paid`
field.

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

As an alternative, you can also retrieve it by using the expand option when you
`GET` your payment. The `GET` request should look like the one below, with a
`?$expand=paid` after the `paymentOrderId`. The response should match the
initial payment response, but with an expanded `paid` field.

{% else %}

You can retrieve the token by using the expand option when you `GET` your
payment. The `GET` request should look like the one below, with a
`?$expand=paid` after the `paymentOrderId`. The response should match the
initial payment response, but with an expanded `paid` field.

{% endif %}

{:.code-view-header}
**Request**

```http
GET /psp/creditcard/payments/{{ page.payment_order_id }}/?$expand=paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

## Performing The Unscheduled Purchase

When you are ready to perform the unscheduled purchase, simply add the
`unscheduledToken` field and use the token as the value. Your request should
look like this:

## Unscheduled Request

{:.code-view-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "UnscheduledPurchase",
        "intent": "Authorization",
        "unscheduledToken": "{{ page.payment_id }}",
        "currency": "NOK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Unscheduled",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": { {% if seamless_view %}
            "hostUrls": ["https://example.com"],{% endif %}
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",{% if seamless_view %}
            "paymentUrl": "https://example.com/perform-payment",{% endif %}
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.pdf",
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
    }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                             | Type          | Description                     |
| :--------------: | :-------------------------------- | :------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}                         | `object`      | The payment object                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| {% icon check %} | {% f operation %}               | `string`      | For unscheduled purchases, this needs to be `unscheduledPurchase`. |
| {% icon check %} | {% f intent %}                  | `string`      | `Authorization`.|
| {% icon check %} | {% f unscheduledToken %}     | `string`     | The unscheduledToken generated in the initial purchase, if `operation: Verify` or `generateUnscheduledToken: true` was used.                                                                                                                                                                  |
| {% icon check %} | {% f currency %}                | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f amount, 2 %}                 | `integer`     | {% include fields/amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f vatAmount, 2 %}              | `integer`     | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f description %}             | `string(40)`  | {% include fields/description.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f userAgent %}               | `string`      | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | {% f language %}                | `string`      | {% include fields/language.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %}︎ | {% f urls %}                    | `object`      | The object containing URLs relevant for the `payment`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |{% if seamless_view %}
| {% icon check %}︎ | {% f hostUrls, 2 %}               | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |{% endif %}
| {% icon check %} | {% f completeUrl, 2 %}            | `string`      | {% include fields/complete-url.md resource="payment" %}                                                                                                                                                                                                                                                                                         |
| {% icon check %} | {% f cancelUrl, 2 %}              | `string`      | The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f paymentUrl, 2 %}             | `string`      | {% include fields/payment-url.md %}                                                                                                                                                                                                                                                                                                                                |
|                  | {% f callbackUrl, 2 %}            | `string`      | {% include fields/callback-url.md resource="payment" %}                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f logoUrl, 2 %}                | `string`      | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | {% f termsOfServiceUrl, 2 %}      | `string`      | {% include fields/terms-of-service-url.md %}                                                                                          |
| {% icon check %} | {% f payeeInfo %}               | `string`      | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f payeeId, 2 %}                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f payeeReference, 2 %}         | `string` | {% include fields/payee-reference.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|                  | {% f payeeName, 2 %}              | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f productCategory, 2 %}        | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                                            |
|                  | {% f orderReference, 2 %}         | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f subsite, 2 %}                | `string(40)`  | {% include fields/subsite.md %} |
|                  | {% f payer %}                   | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}         | `string`     | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
{% endcapture %}
{% include accordion-table.html content=table %}

## Unscheduled Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": {
    "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "number": 1234567890,
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "NOK",
    "amount": 1500,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Unscheduled",
    "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "nb-NO",
    "unscheduledToken": "{{ page.payment_id }}",
    "prices": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/prices" },
    "transactions": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions" },
    "authorizations": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/authorizations" },
    "captures": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/captures" },
    "reversals": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/reversals" },
    "cancellations": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/cancellations" },
    "urls" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/urls" },
    "payeeInfo" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payeeInfo" },
    "payers" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payers" }
  }
}
```

See the table in the initial purchase response for descriptions.

[delete-token]: {{ features_url }}/optional/delete-token
[paid-resource-model]: {{ features_url }}/technical-reference/resource-sub-models#paid
[3ds2]: {{ features_url }}/core/3d-secure-2
[one-click-payments]: {{ features_url }}/optional/one-click-payments
[verify]: {{ features_url }}/optional/verify
