{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign seamless_view = include.seamless_view | default: false %}
{% assign full_reference = include.full_reference | default: false %}

## Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a `capture`, `cancellation` or `reversal`
transaction. An example of a request is provided below. Each individual field of
the JSON document is described in the following section.

### Purchase Operation

{% if seamless_view %}

Posting a payment (operation `Purchase`) returns the options of aborting the
payment altogether or creating an authorization transaction through the
`view-authorization` hyperlink, or `view-payment`.

{% else %}

Posting a payment (operation `Purchase`) returns the options of aborting the
payment altogether or creating an authorization transaction through the
`redirect-authorization` hyperlink.

{% endif %}

{% capture request_content %}{
    "payment": {
        "operation": "Purchase"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Card Payment Request

{% capture request_header %}POST /psp/creditcard/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
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
        "description": "Test Purchase",{% if full_reference %}
        "generatePaymentToken": false,
        "generateRecurrenceToken": false,{% endif %}
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
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
            "email": "olivia.nyhuus@swedbankpay.com",
            "msisdn": "+4798765432",
            "homePhoneNumber": "+4787654321",
            "workPhoneNumber": "+4776543210",
            "shippingAddress": {
                "firstName": "Olivia",
                "lastName": "Nyhuus",
                "email": "olivia.nyhuus@swedbankpay.com",
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
                "email": "olivia.nyhuus@swedbankpay.com",
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
            "deliveryEmailAddress": "olivia.nyhuus@swedbankpay.com",
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
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                             | Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :--------------: | :-------------------------------- | :------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}                         | `object`      | The payment object                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| {% icon check %} | {% f operation %}               | `string`      | {% include fields/operation.md %} |
| {% icon check %} | {% f intent %}                  | `string`      | `Authorization`. Reserves the amount, and is followed by a `Cancel` or `Capture` of funds.<br> <br> `AutoCapture`. A one phase option that enables the `Capture` of funds automatically after authorization.                                                                                                                                                                                                                                                                                                                                                              |
|                  | {% f paymentToken %}            | `string`      | If a `paymentToken` is included in the request, the card details stored in the `paymentToken` will be prefilled on the payment page. The payer still has to enter the `cvc` to complete the purchase. This is called a "One Click" purchase.                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f currency %}                | `enum(string)`      | The currency of the payment in the ISO 4217 format (e.g. `EUR`, `DKK`, `NOK` or `SEK`). Some payment methods are only available with selected currencies.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f prices %}                  | `array`       | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f type, 2 %}                   | `string`      | {% include fields/prices-type.md kind="CreditCard" %}          |
| {% icon check %} | {% f amount, 2 %}                 | `integer`     | {% include fields/amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f vatAmount, 2 %}              | `integer`     | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f description %}             | `string(40)`  | {% include fields/description.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | {% f generatePaymentToken %}    | `boolean`     | `true` or `false`. Set this to `true` if you want to create a paymentToken for future use as One Click.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f generateRecurrenceToken %} | `boolean`     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f userAgent %}               | `string`      | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | {% f language %}                | `string`      | {% include fields/language.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %}︎ | {% f urls %}                    | `object`      | The object containing URLs relevant for the `payment`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |{% if seamless_view %}
| {% icon check %}︎ | {% f hostUrls, 2 %}               | `array`       | The array of valid host URLs.                                                                                                                                                                                                                                                                                                                                                                                                                                             |{% endif %}
| {% icon check %} | {% f completeUrl, 2 %}            | `string`      | {% include fields/complete-url.md resource="payment" %}                                                                                                                                                                                                                                                                                         |
| {% icon check %} | {% f cancelUrl, 2 %}              | `string`      | The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f paymentUrl, 2 %}             | `string`      | {% include fields/payment-url.md %}                                                                                                                                                                                                                                                                                                                                |
|                  | {% f callbackUrl, 2 %}            | `string`      | {% include fields/callback-url.md resource="payment" %}                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f logoUrl, 2 %}                | `string`      | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | {% f termsOfServiceUrl, 2 %}      | `string`      | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | {% f payeeInfo %}               | `object`      | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f payeeId, 2 %}                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f payeeReference, 2 %}         | `string(30)` | {% include fields/payee-reference.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|                  | {% f payeeName, 2 %}              | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f productCategory, 2 %}        | `string(50)`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                                            |
|                  | {% f orderReference, 2 %}         | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f subsite, 2 %}                | `string(40)`  | {% include fields/subsite.md %} |
|                  | {% f payer %}                   | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}         | `string`     | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | {% f metadata %}                | `object`      | {% include fields/metadata.md documentation_section="card" %}                                                                                                                                                                                                                                                                                                                                                                                      |
|                  | {% f cardholder %}              | `object`      | Optional. Cardholder object that can hold information about a buyer (private or company). The information added increases the chance for frictionless flow and is related to 3-D Secure 2.0..                                                                                                                                                                                                                                                                                                                                                                                      |
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
|                  | {% f riskIndicator, 2 %}                  | `object`      | This **optional** object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure 2.0 authentication of the payer when they are authenticating the purchase.                                                                                                                                                                                                                                                                                                                              |
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

## Card Payment Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
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
        "language": "sv-SE",
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
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                           | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :------------------------------ | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}              | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| {% f id %}                      | `string`     | {% include fields/id.md %}                                                                                                                                                                                                                                                                                                                      |
| {% f number %}                  | `integer`    | {% include fields/number.md resource="payment" %}                                                                                                                                                           |
| {% f created %}                 | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                                                                                                                                                                                         |
| {% f updated %}                 | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| {% f state %}                   | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| {% f prices %}                  | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                      |
| {% f id, 2 %}                   | `string`     | {% include fields/id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| {% f amount %}                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                                                                  |
| {% f remainingCaptureAmount %}  | `integer`    | The available amount to capture.                                                                                                                                                                                                                                                                                                                           |
| {% f remainingCancelAmount %}   | `integer`    | The available amount to cancel.                                                                                                                                                                                                                                                                                                                            |
| {% f remainingReversalAmount %} | `integer`    | The available amount to reverse.                                                                                                                                                                                                                                                                                                                           |
| {% f description %}             | `string(40)` | {% include fields/description.md %}                                                                                                                                                                                                                                                                                |
| {% f userAgent %}               | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                       |
| {% f language %}                | `string`     | {% include fields/language.md %}                                                                                                                                                                                                                                                                                      |
| {% f urls %}                    | `string`     | The URL to the  urls  resource where all URLs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| {% f payeeInfo %}               | `object`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                 |
| {% f payers %}                  | `string`     | The URL to the `payer` resource where the information about the payer can be retrieved.                                                        |
| {% f operations, 0 %}           | `array`      | {% include fields/operations.md resource="payment" %}                                                                                                                                                                                                                                                                                                                |
| {% f method, 2 %}               | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| {% f href, 2 %}                 | `string`     | The target URL to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| {% f rel, 2 %}                  | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |
{% endcapture %}
{% include accordion-table.html content=table %}

[one-click-payments]: {{ features_url }}/optional/one-click-payments
