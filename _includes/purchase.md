{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}
{% assign seamless_view = include.seamless_view | default: false %}
{% assign full_reference = include.full_reference | default: false %}

## Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a `capture`, `cancellation` or `reversal`
transaction. An example of a request is provided below. Each individual field of
the JSON document is described in the following section.

### Purchase Operation

Posting a payment (operation `Purchase`) returns the options of aborting the
payment altogether or creating an authorization transaction through the
`redirect-authorization` hyperlink.

{:.code-view-header}
**Request**

```json
{
    "payment": {
        "operation": "Purchase"
    }
}
```

## Purchase Payment

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
        "description": "Test Purchase",{% if full_reference %}
        "generatePaymentToken": false,
        "generateRecurrenceToken": false,
        "generateUnscheduledToken": false,{% endif %}
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": { {% if seamless_view %}
            "hostUrls": ["https://example.com"],{% endif %}
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",{% if seamless_view %}
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

{:.table .table-striped}
|     Required     | Field                             | Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :--------------: | :-------------------------------- | :------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `payment`                         | `object`      | The payment object                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| {% icon check %} | └➔&nbsp;`operation`               | `string`      | Determines the initial operation, that defines the type card payment created.<br> <br> `Purchase`. Used to charge a card. It is followed up by a capture or cancel operation.<br> <br> `Recur`.Used to charge a card on a recurring basis. Is followed up by a capture or cancel operation (if not Autocapture is used, that is).<br> <br>`Payout`. Used to deposit funds directly to credit card. No more requests are necessary from the merchant side.<br> <br>`Verify`. Used when authorizing a card withouth reserveing any funds.  It is followed up by a verification transaction. |
| {% icon check %} | └➔&nbsp;`intent`                  | `string`      | `Authorization`. Reserves the amount, and is followed by a `Cancel` or `Capture` of funds.<br> <br> `AutoCapture`. A one phase option that enables the `Capture` of funds automatically after authorization.                                                                                                                                                                                                                                                                                                                                                              |
|                  | └➔&nbsp;`paymentToken`            | `string`      | If a `paymentToken` is included in the request, the card details stored in the `paymentToken` will be prefilled on the payment page. The payer still has to enter the `cvc` to complete the purchase. This is called a "One Click" purchase.                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`currency`                | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`prices`                  | `array`       | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`type`                   | `string`      | Use the generic type `CreditCard` if you want to enable all card brands supported by merchant contract. Use card brands like `Visa` (for card type Visa), `MasterCard` (for card type MasterCard) and others if you want to specify different amount for each card brand. If you want to use more than one amount you must have one instance in the prices node for each card brand. You will not be allowed to both specify card brands and CreditCard at the same time in this field. [See the Prices resource and prices object types for more information][price-resource].           |
| {% icon check %} | └─➔&nbsp;`amount`                 | `integer`     | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`vatAmount`              | `integer`     | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`description`             | `string(40)`  | {% include field-description-description.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | └➔&nbsp;`generatePaymentToken`    | `boolean`     | `true` or `false`. Set this to `true` if you want to create a paymentToken for future use as One Click.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | └➔&nbsp;`generateRecurrenceToken` | `boolean`     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|                  | └➔&nbsp;`generateUnscheduledToken`| `boolean`     | `true` or `false`. Set this to `true` if you want to create a unscheduledToken for future use Unscheduled purchases (merchant initiated transactions).                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`userAgent`               | `string`      | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`language`                | `string`      | {% include field-description-language.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %}︎ | └➔&nbsp;`urls`                    | `object`      | The object containing URLs relevant for the `payment`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |{% if seamless_view %}
| {% icon check %}︎ | └─➔&nbsp;`hostUrls`               | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |{% endif %}
| {% icon check %} | └─➔&nbsp;`completeUrl`            | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`][complete-url] for details.                                                                                                                                                                                                                                                                                         |
| {% icon check %} | └─➔&nbsp;`cancelUrl`              | `string`      | The URL to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | └─➔&nbsp;`paymentUrl`             | `string`      | The URL that Swedbank Pay will redirect back to when the view-operation needs to be loaded, to inspect and act on the current status of the payment. Only used in Seamless Views. If both `cancelUrl` and `paymentUrl` is sent, the `paymentUrl` will used. {% if documentation_section != 'mobile-pay' %} See [`paymentUrl`][paymenturl] for details.{% endif %}                                                                                                                                                                                                                                                                                                                                |
|                  | └─➔&nbsp;`callbackUrl`            | `string`      | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | └─➔&nbsp;`logoUrl`                | `string`      | {% include field-description-logourl.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | └─➔&nbsp;`termsOfServiceUrl`      | `string`      | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`payeeInfo`               | `string`      | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeId`                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`payeeReference`         | `string(50*)` | {% include field-description-payee-reference.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|                  | └─➔&nbsp;`payeeName`              | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | └─➔&nbsp;`productCategory`        | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                                            |
|                  | └─➔&nbsp;`orderReference`         | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | └─➔&nbsp;`subsite`                | `String(40)`  | The subsite field can be used to perform [split settlement][split-settlement] on the payment. The subsites must be resolved with Swedbank Pay [reconciliation][settlement-reconciliation] before being used.                                                                                                                                                                                                                                                                                                                                                                          |
|                  | └➔&nbsp;`payer`                   | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | └─➔&nbsp;`payerReference`         | `string`     | {% include field-description-payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | └➔&nbsp;`metadata`                | `object`      | {% include field-description-metadata.md documentation_section="card" %}                                                                                                                                                                                                                                                                                                                                                                                      |
|                  | └➔&nbsp;`cardholder`              | `object`      | Optional. Cardholder object that can hold information about a buyer (private or company). The information added increases the chance for frictionless flow and is related to {%- if include.documentation_section == 'card' -%}[3-D Secure 2.0][3ds2]{% else %} 3-D Secure 2.0{% endif %}..                                                                                                                                                                                                                                                                                                                                                                                      |
|                  | └─➔&nbsp;`firstName`              | `string`      | Optional (increased chance for frictionless flow if set). If buyer is a company, use only `firstName`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | └─➔&nbsp;`lastName`               | `string`      | Optional (increased chance for frictionless flow if set). If buyer is a company, use only `firstName`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | └─➔&nbsp;`email`                  | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └─➔&nbsp;`msisdn`                 | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └─➔&nbsp;`homePhoneNumber`        | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └─➔&nbsp;`workPhoneNumber`        | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └─➔&nbsp;`shippingAddress`        | `object`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`firstName`             | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`lastName`              | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`email`                 | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`msisdn`                | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`streetAddress`         | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`coAddress`             | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`city`                  | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`zipCode`               | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`countryCode`           | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └─➔&nbsp;`billingAddress`         | `object`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`firstName`             | `string`      | Optional (increased chance for frictionless flow if set). If buyer is a company, use only `firstName`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | └──➔&nbsp;`lastName`              | `string`      | Optional (increased chance for frictionless flow if set). If buyer is a company, use only `firstName`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | └──➔&nbsp;`email`                 | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`msisdn`                | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`streetAddress`         | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`coAddress`             | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`city`                  | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`zipCode`               | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                  | └──➔&nbsp;`countryCode`           | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
{% if full_reference -%}
|                  | └─➔&nbsp;`accountInfo`                    | `object`      | Optional (increased chance for frictionless flow if set).<br> <br>If cardholder is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                          |
|                  | └──➔&nbsp;`accountAgeIndicator`           | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.<br>`01` (No account, guest)<br>`02` (Created during transaction)<br>`03` (Less than 30 days)<br>`04` (30-60 days)<br>`05` (More than 60 days)                                                                                                                                                                                                                                                    |
|                  | └──➔&nbsp;`accountChangeIndicator`        | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Length of time since the cardholder's account information with the merchant was changed. Including billing etc.<br>`01` (Changed during transaction)<br>`02` (Less than 30 days)<br>`03` (30-60 days)<br>`04` (More than 60 days)                                                                                                                                                                                                                                                                               |
|                  | └──➔&nbsp;`accountPwdChangeIndicator`     | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.<br>`01` (No change)<br>`02` (Changed during transaction)<br>`03` (Less than 30 days)<br>`04` (30-60 days)<br>`05` (More than 60 days)                                                                                                                                                                                                                                                     |
|                  | └──➔&nbsp;`shippingAddressUsageIndicator` | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates when the shipping address used for this transaction was first used with the merchant.<br>`01` (This transaction)<br>`02` (Less than 30 days)<br>`03` (30-60 days)<br>`04` (More than 60 days)                                                                                                                                                                                                                                                                                                         |
|                  | └──➔&nbsp;`shippingNameIndicator`         | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.<br>`01` (Account name identical to shipping name)<br>`02` (Account name different than shipping name)<br>                                                                                                                                                                                                                                                                                          |
|                  | └──➔&nbsp;`suspiciousAccountActivity`     | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.<br>`01` (No suspicious activity has been observed)<br>`02` (Suspicious activity has been observed)<br>                                                                                                                                                                                                                                                                                     |
|                  | └──➔&nbsp;`addressMatchIndicator`         | `boolean`     | Optional (increased chance for frictionless flow if set)<br> <br> Allows the 3-D Secure Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                      |
|                  | └─➔&nbsp;`riskIndicator`                  | `object`      | This **optional** object consist of information that helps verifying the payer. Providing these fields decreases the likelyhood of having to prompt for {%- if include.documentation_section == 'card' -%}[3-D Secure 2.0 authentication][3ds2]{% else %} 3-D Secure 2.0 authentication{% endif %} of the payer when they are authenticating the purchase.                                                                                                                                                                                                                                                                                                                              |
{% endif -%}
{%- include risk-indicator-table.md -%}
{% if full_reference -%}
|                  | `creditCard`                              | `object`      | The credit card object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|                  | └➔&nbsp;`rejectDebitCards`                | `boolean`     | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|                  | └➔&nbsp;`rejectCreditCards`               | `boolean`     | `true` if credit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                |
|                  | └➔&nbsp;`rejectConsumerCards`             | `boolean`     | `true` if consumer cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                  | └➔&nbsp;`rejectCorporateCards`            | `boolean`     | `true` if corporate cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                  | └➔&nbsp;`no3DSecure`                      | `boolean`     | `true` if 3-D Secure should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                            |
|                  | └➔&nbsp;`noCvc`                           | `boolean`     | `true` if the CVC field should be disabled for this payment in case a stored card is used; otherwise `false` per default. This feature is commonly used when {%- if include.documentation_section == 'card' -%} [One-Click Payments][one-click-payments]{% else %} One-Click Payments{% endif %} is enabled. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                          |
{% endif %}

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
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
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
}
```

{:.table .table-striped}
| Field                             | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :-------------------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                         | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`id`                      | `string`     | {% include field-description-id.md %}                                                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`number`                  | `integer`    | The payment  number , useful when there's need to reference the payment in human communication. Not usable for programmatic identification of the payment, for that  id  should be used instead.                                                                                                                                                           |
| └➔&nbsp;`created`                 | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`updated`                 | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`state`                   | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| └➔&nbsp;`prices`                  | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`id`                     | `string`     | {% include field-description-id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| └➔&nbsp;`amount`                  | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                                                                  |
| └➔&nbsp;`remainingCaptureAmount`  | `integer`    | The available amount to capture.                                                                                                                                                                                                                                                                                                                           |
| └➔&nbsp;`remainingCancelAmount`   | `integer`    | The available amount to cancel.                                                                                                                                                                                                                                                                                                                            |
| └➔&nbsp;`remainingReversalAmount` | `integer`    | The available amount to reverse.                                                                                                                                                                                                                                                                                                                           |
| └➔&nbsp;`description`             | `string(40)` | {% include field-description-description.md %}                                                                                                                                                                                                                                                                                |
| └➔&nbsp;`userAgent`               | `string`     | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                                                                                                                       |
| └➔&nbsp;`language`                | `string`     | {% include field-description-language.md %}                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`urls`                    | `string`     | The URL to the  urls  resource where all URLs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| └➔&nbsp;`payeeInfo`               | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                 |
| └➔&nbsp;`payers`                  | `string`     | The URL to the `payer` resource where the information about the payer can be retrieved.                                                        |
| `operations`                       | `array`      | The array of possible operations to perform                                                                                                                                                                                                                                                                                                                |
| └─➔&nbsp;`method`                 | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`href`                   | `string`     | The target URL to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| └─➔&nbsp;`rel`                    | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |

[callback]: {{ features_url }}/technical-reference/callback
[complete-url]: {{ features_url }}/technical-reference/complete-url
[3ds2]: {{ features_url }}/core/3d-secure-2
[one-click-payments]: {{ features_url }}/optional/one-click-payments
[payee-reference]: {{ features_url }}/technical-reference/payee-reference
[paymenturl]: {{ features_url }}/technical-reference/payment-url
[price-resource]: {{ features_url }}/technical-reference/prices
[settlement-reconciliation]: {{ features_url }}/core/settlement-reconciliation
[split-settlement]: {{ features_url }}/core/settlement-reconciliation#split-settlement
[user-agent]: https://en.wikipedia.org/wiki/User_agent
