---
title: Swedbank Pay Payments Invoice Other Features
sidebar:
  navigation:
  - title: Invoice Payments
    items:
    - url: /payments/invoice
      title: Introduction
    - url: /payments/invoice/redirect
      title: Redirect
    - url: /payments/invoice/seamless-view
      title: Seamless View
    - url: /payments/invoice/after-payment
      title: After Payment
    - url: /payments/invoice/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="This section of the Developer Portal is under
                      construction and should not be used to integrate against
                      Swedbank Pay's APIs yet." %}

## API requests

The API requests are displayed in the [invoice flow][invoice-flow].
The options you can choose from when creating a payment with key operation
set to value `FinancingConsumer` are listed below.

### Options before posting a payment

{:.table .table-striped}
|                 | Sweden ![Swedish flag][se-png] | Norway ![Norwegian flag][no-png] | FInland ![Finish flag][fi-png] |
| :-------------- | :----------------------------- | :------------------------------- | :----------------------------- |
| **Operation**   | `FinancingConsumer`            | `FinancingConsumer`              | `FinancingConsumer`            |
| **Intent**      | `Authorization`                | `Authorization`                  | `Authorization`                |
| **Currency**    | SEK                            | NOK                              | EUR                            |
| **InvoiceType** | `PayExFinancingSE`             | `PayExFinancingNO`               | `PayExFinancingFI`             |

* An invoice payment is always two-phased based -  you create an Authorize
  transaction, that is followed by a Capture or Cancel request.
* **Defining CallbackURL**: When implementing a scenario, it is optional
  to set a [CallbackURL][callback-api] in the request.
  If callbackURL is set PayEx will send a postback request to this URL when
  the consumer has fulfilled the payment.
  [See the Callback API description here.][callback-api]

### Authorizations

The `authorizations` resource will list the authorization transactions
made on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/invoice/payments/<payment-id>/authorizations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": "/psp/invoice/payments/<payment-id>",
  "authorizations": {
    "id": "/psp/invoice/payments/<payment-id>/authorizations",
    "authorizationList": [
      {
        "id": "/psp/invoice/payments/<payment-id>/authorizations/<transaction-id>",
        "consumer": {
          "id": "/psp/invoice/payments/<payment-id>/consumer"
        },
        "legalAddress": {
          "id": "/psp/invoice/payments/<payment-id>/legaladdress"
        },
        "billingAddress": {
          "id": "/psp/invoice/payments/<payment-id>/billingaddress"
        },
        "transaction": {
          "id": "/psp/invoice/payments/<payment-id>/transactions/<transaction-id>",
          "created": "2016-09-14T01:01:01.01Z",
          "updated": "2016-09-14T01:01:01.03Z",
          "type": "Authorization",
          "state": "Initialized|Completed|Failed",
          "number": 1234567890,
          "amount": 1000,
          "vatAmount": 250,
          "description": "Test transaction",
          "payeeReference": "AH123456",
          "failedReason": "",
          "isOperational": false,
          "operations": [
            {
              "href": "https://api.externalintegration.payex.com/psp/invoice/payments/<payment-id>",
              "rel": "edit-authorization",
              "method": "PATCH"
            }
          ]
        }
      }
    ]
  }
}
```

#### Create Authorization transaction

To create an `authorization` transaction, perform the `create-authorization`
operation as returned in a previously created invoice payment.

{:.code-header}
**Request**

```http
POST /psp/invoice/payments/<payment-id>/authorizations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "transaction": {
    "activity": "FinancingConsumer"
  },
  "consumer": {
    "socialSecurityNumber": "socialSecurityNumber",
    "customerNumber": "customerNumber",
    "name": "consumer name",
    "email": "email",
    "msisdn": "msisdn",
    "ip": "consumer ip address"
  },
  "legalAddress": {
    "addressee": "firstName + lastName",
    "coAddress": "coAddress",
    "streetAddress": "streetAddress",
    "zipCode": "zipCode",
    "city": "city",
    "countryCode": "countryCode"
  },
  "billingAddress": {
    "addressee": "firstName + lastName",
    "coAddress": "coAddress",
    "streetAddress": "streetAddress",
    "zipCode": "zipCode",
    "city": "city",
    "countryCode": "countryCode"
  }
}
```

{:.table .table-striped}
| Required | Property                        | Data type | Description                                                                                                                                                      |
| :------- | :------------------------------ | :-------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✔︎︎︎︎︎   | `transaction.activity`          | `string`  | `FinancingConsumer`                                                                                                                                              |
| ✔︎︎︎︎︎   | `consumer.socialSecurityNumber` | `string`  | The social security number (national identity number) of the consumer. Format Sweden: `YYMMDD-NNNN`. Format Norway: `DDMMYYNNNNN`. Format Finland: `DDMMYYNNNNN` |
|          | `consumer.customerNumber`       | `string`  | The customer number in the merchant system.                                                                                                                      |
|          | `consumer.email`                | `string`  | The e-mail address of the consumer.                                                                                                                              |
| ✔︎︎︎︎︎   | `consumer.msisdn`               | `string`  | The mobile phone number of the consumer. Format Sweden: `+46707777777`. Format Norway: `+4799999999`. Format Finland: `+358501234567`                            |
| ✔︎︎︎︎︎   | `consumer.ip`                   | `string`  | The IP address of the consumer.                                                                                                                                  |
| ✔︎︎︎︎︎   | `legalAddress.addressee`        | `string`  | The full (first and last) name of the consumer.                                                                                                                  |
|          | `legalAddress.coAddress`        | `string`  | The CO-address (if used)                                                                                                                                         |
|          | `legalAddress.streetAddress`    | `string`  | The street address of the consumer.                                                                                                                              |
| ✔︎︎︎︎︎   | `legalAddress.zipCode`          | `string`  | The postal code (ZIP code) of the consumer.                                                                                                                      |
| ✔︎︎︎︎︎   | `legalAddress.city`             | `string`  | The city to the consumer.                                                                                                                                        |
| ✔︎︎︎︎︎   | `legalAddress.countryCode`      | `string`  | `SE`, `NO`, or `FI`. The country code of the consumer.                                                                                                           |
| ✔︎︎︎︎︎   | `billingAddress.addressee`      | `string`  | The full (first and last) name of the consumer.                                                                                                                  |
|          | `billingAddress.coAddress`      | `string`  | The CO-address (if used)                                                                                                                                         |
| ✔︎︎︎︎ ︎  | `billingAddress.streetAddress`  | `string`  | The street address to the consumer.                                                                                                                              |
| ✔︎︎︎︎︎   | `billingAddress.zipCode`        | `string`  | The postal number (ZIP code) to the consumer.                                                                                                                    |
| ✔︎︎︎︎︎   | `billingAddress.city`           | `string`  | The city to the consumer.                                                                                                                                        |
| ✔︎︎︎︎︎   | `billingAddress.countryCode`    | `string`  | `SE`, `NO`, or `FI`.                                                                                                                                             |

{% include alert.html type="neutral" icon="info" body="
Note: The legal address must be the registered address of the consumer." %}

The `authorization` resource will be returned, containing information about
the newly created authorization transaction.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": "/psp/invoice/payments/<payment-id>",
  "authorization": {
    "id": "/psp/invoice/payments/<payment-id>/authorizations/<transaction-id>",
    "consumer": {
      "id": "/psp/invoice/payments/<payment-id>/consumer"
    },
    "legalAddress": {
      "id": "/psp/invoice/payments/<payment-id>/legaladdress"
    },
    "billingAddress": {
      "id": "/psp/invoice/payments/<payment-id>/billingaddress"
    },
    "transaction": {
      "id": "/psp/invoice/payments/<payment-id>/transactions/<transaction-id>",
      "created": "2016-09-14T01:01:01.01Z",
      "updated": "2016-09-14T01:01:01.03Z",
      "type": "Authorization",
      "state": "Initialized|Completed|Failed",
      "number": 1234567890,
      "amount": 1000,
      "vatAmount": 250,
      "description": "Test transaction",
      "payeeReference": "AH123456",
      "failedReason": "",
      "isOperational": "TRUE|FALSE",
      "operations": [
        {
          "href": "https://api.externalintegration.payex.com/psp/invoice/payments/<payment-id>",
          "rel": "edit-authorization",
          "method": "PATCH"
        }
      ]
    }
  }
}
```

## Payment Resource

{% include payment-resource.md %}

## Create Payment

Within the invoice payments part of the eCommerce API, you can create four kinds
of payments ([purchase][purchase], [recurrence][recurrence], [payout][payout]
and [verification][verify]) and you can inspect and alter the details of the
individual transactions within the payment.

To create a invoice payment, you perform an HTTP `POST` against the `payments`
resource.

There are four different kinds of payment that can be created. These are
identified with the value of the `operation` property. Each kind are documented
in their own section below.

{:.code-header}
**Request**"

```http
POST /psp/invoice/payments HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "payment": {
    "operation": "<operation>",
    "intent": "<intent>",
  }
}
```

{:.table .table-striped}
| Required | Property            | Type     | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| :------: | ------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `payment`           | `object` | The `payment` object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation` | `string` | Determines the initial operation, that defines the type invoice payment created.<br> <br> `Purchase`. Used to charge a card. It is followed up by a capture or cancel operation.<br> <br> `Recur`. Used to charge a card on a recurring basis. Is followed up by a capture or cancel operation (if not Autocapture is used, that is).<br> <br>`Payout`. Used to deposit funds directly to credit card. No more requests are necessary from the merchant side.<br> <br>`Verify`. Used when authorizing a card withouth reserveing any funds.  It is followed up by a verification transaction. |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`    | `string` | The intent of the payment identifies how and when the charge will be effectuated. This determine the type transactions used during the payment process.<br> <br>`Authorization`. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br>`AutoCapture`. A one phase-option that enable capture of funds automatically after authorization.                                                                                                                                                                                                   |

## Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a `capture`, `cancellation` or `reversal`
transaction.

An example of a request is provided below. Each individual Property of the JSON
document is described in the following section.

{% include risk-indicator.md %}

{:.code-header}
**Request**

```http
POST /psp/invoice/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "payment": {
    "operation": "Purchase",
    "intent": "Authorization",
    "paymentToken": "",
    "currency": "SEK",
    "prices": [
      {
        "type": "CreditCard",
        "amount": 1500,
        "vatAmount": 0
      },
      {
        "type": "Visa",
        "amount": 1500,
        "vatAmount": 0
      },
      {
        "type": "MasterCard",
        "amount": 1500,
        "vatAmount": 0
      }
    ],
    "description": "Test Purchase",
    "payerReference": "AB1234",
    "generatePaymentToken": false,
    "generateRecurrenceToken": false,
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls": {
      "hostUrls": [
        "https://example.com"
      ],
      "completeUrl": "https://example.com/payment-completed",
      "cancelUrl": "https://example.com/payment-canceled",
      "paymentUrl": "http://example.com/perform-payment",
      "callbackUrl": "https://example.com/payment-callback",
      "logoUrl": "https://example.com/payment-logo.png",
      "termsOfServiceUrl": "https://example.com/payment-terms.pdf"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",
      "productCategory": "A123",
      "orderReference": "or123",
      "subsite": "MySubsite"
    },
    "metadata": {
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "cardholder": {
      "firstName": "firstname/companyname",
      "lastName": "lastname",
      "email": "leia.ahlstrom@swedbankpay.com",
      "msisdn": "+4673900000",
      "homePhoneNumber": "homePhoneNumber",
      "workPhoneNumber": "workPhoneNumber",
      "shippingAddress": {
        "firstName": "Leia",
        "lastName": "Ahlstrom",
        "email": "leia.ahlstrom@swedbankpay.com",
        "msisdn": "+46739000001",
        "streetAddress": "Helgestavägen 9",
        "coAddress": "coAddress",
        "city": "19792 Bro",
        "zipCode": "XXXXX",
        "countryCode": "countryCode"
      },
      "billingAddress": {
        "firstName": "firstname/companyname",
        "lastName": "lastname",
        "email": "email",
        "msisdn": "msisdn",
        "streetAddress": "streetAddress",
        "coAddress": "coAddress",
        "city": "city",
        "zipCode": "zipCode",
        "countryCode": "countrycode"
      },
      "accountInfo": {
        "accountAgeIndicator": "01",
        "accountChangeIndicator": "01",
        "accountPwdChangeIndicator": "01",
        "shippingAddressUsageIndicator": "01",
        "shippingNameIndicator": "01",
        "suspiciousAccountActivity": "01",
        "addressMatchIndicator": false
      }
    },
    "riskIndicator": {
      "deliveryEmailAddress": "string",
      "deliveryTimeFrameindicator": "01",
      "preOrderDate": "YYYYMMDD",
      "preOrderPurchaseIndicator": "01",
      "shipIndicator": "01",
      "giftCardPurchase": false,
      "reOrderPurchaseIndicator": "01",
      "pickUpAddress": {
        "name": "companyname",
        "streetAddress": "streetAddress",
        "coAddress": "coAddress",
        "city": "city",
        "zipCode": "zipCode",
        "countryCode": "countrycode"
      }
    }
  },
  "creditCard": {
    "rejectCreditCards": false,
    "rejectDebitCards": false,
    "rejectConsumerCards": false,
    "rejectCorporateCards": false,
    "no3DSecure": false,
    "noCvc": false
  }
}
```

{:.table .table-striped}
| Required | Property                                 | Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| :------: | :--------------------------------------- | :------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `payment`                                | `object`      | The payment object                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`                      | `string`      | Determines the initial operation, that defines the type invoice payment created.<br> <br> `Purchase`. Used to charge a card. It is followed up by a capture or cancel operation.<br> <br> `Recur`.Used to charge a card on a recurring basis. Is followed up by a capture or cancel operation (if not Autocapture is used, that is).<br> <br>`Payout`. Used to deposit funds directly to credit card. No more requests are necessary from the merchant side.<br> <br>`Verify`. Used when authorizing a card withouth reserveing any funds.  It is followed up by a verification transaction.                      |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`                         | `string`      | `Authorization`. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br> `AutoCapture`. A one phase option that enable capture of funds automatically after authorization.                                                                                                                                                                                                                                                                                                                                                                                      |
|          | └➔&nbsp;`paymentToken`                   | `string`      | If you put in a paymentToken here, the payment page will preload the stored payment data related to the `paymentToken` and let the consumer make a purchase without having to enter all card data. This is called a "One Click" purchase.                                                                                                                                                                                                                                                                                                                                                                         |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`                       | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`                         | `array`       | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`                          | `string`      | Use the generic type CreditCard if you want to enable all card brands supported by merchant contract. Use card brands like Visa (for card type Visa), MasterCard (for card type Mastercard) and others if you want to specify different amount for each card brand. If you want to use more than one amount you must have one instance in the prices node for each card brand. You will not be allowed to both specify card brands and CreditCard at the same time in this field. [See the Prices resource and prices object types for more information][price-resource].                                         |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`                        | `integer`     | Amount is entered in the lowest monetary units of the selected currency. E.g. 10000 = 100.00 NOK, 5000 = 50.00 SEK.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`                     | `integer`     | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`                    | `string(40)`  | A textual description max 40 characters of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └➔&nbsp;`payerReference`                 | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └➔&nbsp;`generatePaymentToken`           | `boolean`     | `true` or `false`. Set this to `true` if you want to create a paymentToken for future use as One Click.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | └➔&nbsp;`generateRecurrenceToken`        | `boolean`     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|  ✔︎︎︎︎︎  | └➔&nbsp;`userAgent`                      | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-definition]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | └➔&nbsp;`language`                       | `string`      | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|    ✔︎    | └➔&nbsp;`urls`                           | `object`      | The object containing URLs relevant for the `payment`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`hostUrls`                      | `array`       | The array of URLs valid for embedding of Swedbank Pay Hosted Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`                   | `string`      | The URL that Swedbank Pay will redirect back to when the payment page is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`cancelUrl`                     | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | └─➔&nbsp;`paymentUrl`                    | `string`      | The URI that Swedbank Pay will redirect back to when the view-operation needs to be loaded, to inspect and act on the current status of the payment. Only used in Seamless Views. If both `cancelUrl` and `paymentUrl` is sent, the `paymentUrl` will used.                                                                                                                                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`callbackUrl`                   | `string`      | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | └─➔&nbsp;`logoUrl`                       | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`termsOfServiceUrl`             | `string`      | A URL that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeInfo`                      | `string`      | The `payeeInfo` object, containing information about the payee.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeId`                       | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeReference`                | `string(30*)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`payeeName`                     | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | └─➔&nbsp;`productCategory`               | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | └─➔&nbsp;`orderReference`                | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | └─➔&nbsp;`subsite`                       | `String(40)`  | The subsite field can be used to perform [split settlement][split-settlement] on the payment. The subsites must be resolved with Swedbank Pay [reconciliation][settlement-and-reconciliation] before being used.                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └➔&nbsp;`metadata`                       | `object`      | The keys and values that should be associated with the payment. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | └➔&nbsp;`cardholder`                     | `object`      | Optional. Cardholder object that can hold information about a buyer (private or company). The information added increases the chance for frictionless flow.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`firstName`                     | `string`      | Optional (increased chance for frictionless flow if set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`lastName`                      | `string`      | Optional (increased chance for frictionless flow if set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`email`                         | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`msisdn`                        | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`homePhoneNumber`               | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`workPhoneNumber`               | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └➔&nbsp;`shippingAddress`                | `object`      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Optional (increased chance for frictionless flow if set) |
|          | └─➔&nbsp;`firstName`                     | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`lastName`                      | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`email`                         | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`msisdn`                        | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`streetAddress`                 | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`coAddress`                     | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`city`                          | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`zipCode`                       | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`countryCode`                   | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └➔&nbsp;`billingAddress`                 | `object`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`firstName`                     | `string`      | Optional (increased chance for frictionless flow if set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`lastName`                      | `string`      | Optional (increased chance for frictionless flow if set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`email`                         | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`msisdn`                        | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`streetAddress`                 | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`coAddress`                     | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`city`                          | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`zipCode`                       | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`countryCode`                   | `string`      | Optional (increased chance for frictionless flow if set)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └➔&nbsp;`accountInfo`                    | `object`      | Optional (increased chance for frictionless flow if set).<br> <br>If cardholder is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`accountAgeIndicator`           | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.<br>01 (No account, guest)<br>02 (Created during transaction)<br>03 (Less than 30 days)<br>04 (30-60 days)<br>05 (More than 60 days)                                                                                                                                                                                                                                                                                              |
|          | └─➔&nbsp;`accountChangeIndicator`        | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Length of time since the cardholder's account information with the merchant was changed. Including billing etc.<br>01 (Changed during transaction)<br>02 (Less than 30 days)<br>03 (30-60 days)<br>04 (More than 60 days)                                                                                                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`accountPwdChangeIndicator`     | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.<br>01 (No change)<br>02 (Changed during transaction)<br>03 (Less than 30 days)<br>04 (30-60 days)<br>05 (More than 60 days)                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`shippingAddressUsageIndicator` | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates when the shipping address used for this transaction was first used with the merchant.<br>01 (This transaction)<br>02 (Less than 30 days)<br>03 (30-60 days)<br>04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                                 |
|          | └─➔&nbsp;`shippingNameIndicator`         | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.<br>01 (Account name identical to shipping name)<br>02 (Account name different than shipping name)<br>                                                                                                                                                                                                                                                                                                                              |
|          | └─➔&nbsp;`suspiciousAccountActivity`     | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.<br>01 (No suspicious activity has been observed)<br>02 (Suspicious activity has been observed)<br>                                                                                                                                                                                                                                                                                                                         |
|          | └─➔&nbsp;`addressMatchIndicator`         | `boolean`     | Optional (increased chance for frictionless flow if set)<br> <br> Allows the 3-D Secure Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | └➔&nbsp;`riskIndicator`                  | `array`       | This **optional** array consist of information that helps verifying the payer. Providing these fields decreases the likelyhood of having to promt for 3-D Secure authenticaiton of the payer when they are authenticating the purchacse.                                                                                                                                                                                                                                                                                                                                                                          |
|          | └─➔&nbsp;`deliveryEmailAddress`          | `string`      | Optional (increased chance for frictionless flow if set).<br> <br> For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | └─➔&nbsp;`deliveryTimeFrameIndicator`    | `string`      | Optional (increased chance for frictionless flow if set).<br> <br> Indicates the merchandise delivery timeframe.<br>01 (Electronic Delivery)<br>02 (Same day shipping)<br>03 (Overnight shipping)<br>04 (Two-day or more shipping)<br>                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`preOrderDate`                  | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>For a pre-ordered purchase. The expected date that the merchandise will be available.<br>FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`preOrderPurchaseIndicator`     | `string`      | Optional (increased chance for frictionless flow if set).<br> <br> Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.<br>01 (Merchandise available)<br>02 (Future availability)                                                                                                                                                                                                                                                                                                                                                                         |
|          | └─➔&nbsp;`shipIndicator`                 | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates shipping method chosen for the transaction.<br> 01 (Ship to cardholder's billing address)<br>02 (Ship to another verified address on file with merchant)<br>03 (Ship to address that is different than cardholder's billing address)<br>04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br>05 (Digital goods, includes online services, electronic giftcards and redemption codes)<br>06 (Travel and Event tickets, not shipped)<br>07 (Other, e.g. gaming, digital service) |
|          | └─➔&nbsp;`giftCardPurchase`              | `boolean`     | Optional (increased chance for frictionless flow if set).<br> <br>`true` if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | └─➔&nbsp;`reOrderPurchaseIndicator`      | `string`      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.<br>01 (Merchandise available)<br>02 (Future availability)                                                                                                                                                                                                                                                                                                                                                                          |
|          | └➔&nbsp;`pickUpAddress`                  | `object`      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | └─➔&nbsp;`name`                          | `string`      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | └─➔&nbsp;`streetAddress`                 | `string`      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | └─➔&nbsp;`coAddress`                     | `string`      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | └─➔&nbsp;`city`                          | `string`      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | └─➔&nbsp;`zipCode`                       | `string`      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | └─➔&nbsp;`countryCode`                   | `string`      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | `creditCard`                             | `object`      | The credit card object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | └➔&nbsp;`rejectDebitCards`               | `boolean`     | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|          | └➔&nbsp;`rejectCreditCards`              | `boolean`     | `true` if credit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|          | └➔&nbsp;`rejectConsumerCards`            | `boolean`     | `true` if consumer cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|          | └➔&nbsp;`rejectCorporateCards`           | `boolean`     | `true` if corporate cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | └➔&nbsp;`no3DSecure`                     | `boolean`     | `true` if 3-D Secure should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | └➔&nbsp;`noCvc`                          | `boolean`     | `true` if the CVC field should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                         |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": {
    "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "number": 1234567890,
    "instrument": "CreditCard",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "payerReference": "AB1234",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "prices": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices"
    },
    "transactions": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions"
    },
    "authorizations": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations"
    },
    "captures": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures"
    },
    "reversals": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals"
    },
    "cancellations": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations"
    },
    "urls": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls"
    },
    "payeeInfo": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo"
    },
    "settings": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings"
    }
  },
  "operations": [
    {
      "href": "https://api.externalintegration.payex.com/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
      "rel": "update-payment-abort",
      "method": "PATCH",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.payex.com/invoice/payments/authorize/123456123412341234123456789012",
      "rel": "redirect-authorization",
      "method": "GET",
      "contentType": "text/html"
    },
    {
      "method": "GET",
      "href": "https://ecom.dev.payex.com/invoice/core/scripts/client/px.creditcard.client.js?token=123456123412341234123456789012",
      "rel": "view-authorization",
      "contentType": "application/javascript"
    }
  ]
}
```

## Recur

A `recur` payment is a payment that references a `recurrenceToken` created
through a previous payment in order to charge the same card.

{:.code-header}
**Request**

```http
POST /psp/invoice/payments HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "payment": {
    "operation": "Recur",
    "intent": "Authorization|AutoCapture",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
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
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",
      "productCategory": "A123",
      "orderReference": "or-12456",
      "subsite": "MySubsite"
    }
  }
}
```

## Verify

{% include alert.html type="neutral" icon="info" body="The `Verify` operation
lets you post verification payments, which are used to confirm validity of card
information without reserving or charging any amount." %}

### Introduction to Verify

This option is commonly used when initiating a subsequent
[One-click invoice payment][one-click-payments] or a
[recurring invoice payment][recurrence] flow - where you do not want
to charge the consumer right away.

{% include alert.html type="neutral" icon="info" body="Please note that all
boolean credit card attributes involving rejection of certain card types are
optional and requires enabling on the contract with Swedbank Pay." %}

### Verification through Swedbank Pay Payments

* When properly set up in your merchant/webshop site and the payer initiates a
  verification operation, you make a `POST` request towards Swedbank Pay with
  your Verify information. This will generate a payment object with a unique
  `paymentID`. You either receive a Redirect URL to a hosted page or a
  JavaScript source in response.
* You need to [redirect][redirect] the payer's browser to that specified URL, or
  embed the script source on your site to create a [Hosted View][hosted-view] in
  an `iframe`; so that she can enter the credit card details in a secure
  Swedbank Pay hosted environment.
* Swedbank Pay will handle 3-D Secure authentication when this is required.
* Swedbank Pay will redirect the payer's browser to - or display directly in the
  `iframe` - one of two specified URLs, depending on whether the payment session
  is followed through completely or cancelled beforehand. Please note that both
  a successful and rejected payment reach completion, in contrast to a cancelled
  payment.
* When you detect that the payer reach your completeUrl , you need to do a `GET`
  request to receive the state of the transaction.
* Finally you will make a `GET` request towards Swedbank Pay with the
  `paymentID` received in the first step, which will return the payment result
  and a `paymentToken` that can be used for subsequent [One-Click
  Payments][one-click-payments] and [recurring server-to-server based
  payments][recurrence].

### Screenshots

You will redirect the consumer/end-user to Swedbank Pay hosted pages to collect
the credit card information.

![screenshot of the redirect invoice payment page][card-payment]{:height="500px" width="425px"}

### API Requests

The API requests are displayed in the [Verification flow]. The options you can
choose from when creating a payment with key operation set to Value Verify are
listed below.

{:.code-header}
**Request**

```http
POST /psp/invoice/payments HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "payment": {
    "operation": "Verify",
    "currency": "NOK",
    "description": "Test Verification",
    "payerReference": "AB1234",
    "userAgent": "Mozilla/5.0...",
    "language": "nb-NO",
    "generatePaymentToken": true,
    "generateRecurrenceToken": false,
    "urls": {
      "hostUrls": ["https://example.com"],
      "completeUrl": "https://example.com/payment-completed",
      "cancelUrl": "https://example.com/payment-canceled",
      "paymentUrl": "http://example.com/perform-payment",
      "logoUrl": "https://example.com/payment-logo.png",
      "termsOfServiceUrl": "https://example.com/payment-terms.html"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",
      "productCategory": "A123",
      "orderReference": "or-12456",
      "subsite": "MySubsite"
    }
  },
  "invoice": {
    "invoiceType": "PayExFinancingNo"
  }
}
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": {
    "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "number": 1234567890,
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "operation": "Verify",
    "state": "Ready",
    "currency": "NOK",
    "amount": 0,
    "description": "Test Verification",
    "payerReference": "AB1234",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0",
    "language": "nb-NO",
    "transactions": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions"
    },
    "verifications": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/verifications"
    },
    "urls": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls"
    },
    "payeeInfo": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo"
    },
    "settings": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings"
    }
  },
  "operations": [
    {
      "method": "POST",
      "href": "https://api.externalintegration.payex.com/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/approvedlegaladdress",
      "rel": "create-approved-legal-address",
      "contentType": "application/json"
    },
    {
      "method": "POST",
      "href": "https://api.externalintegration.payex.com/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations",
      "rel": "create-authorization",
      "contentType": "application/json"
    },
    {
      "method": "PATCH",
      "href": "https://api.externalintegration.payex.com/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
      "rel": "update-payment-abort",
      "contentType": "application/json"
    },
    {
      "method": "GET",
      "href": "https://ecom.externalintegration.payex.com/invoice/payments/authorize/2f9b51a821d40dd015332f14460f91393856725a19e9fb5a834d460af91c9ce2",
      "rel": "redirect-authorization",
      "contentType": "text/html"
    }
]
}
```

### Verification flow

The sequence diagram below shows the two requests you have to send to Swedbank
Pay to make a purchase. The links will take you directly to the API description
for the specific request. The diagram also shows in high level, the sequence of
the process of a complete purchase.
When dealing with credit invoice payments, 3-D Secure authentication of the
cardholder is an essential topic. There are three alternative outcome of a
credit invoice payment:

* 3-D Secure enabled - by default, 3-D Secure should be enabled, and Swedbank
  Pay will check if the card is enrolled with 3-D Secure. This depends on the
  issuer of the card. If the card is not enrolled with 3-D Secure, no
  authentication of the cardholder is done.
* Card supports 3-D Secure - if the card is enrolled with 3-D Secure, Swedbank
  Pay will redirect the cardholder to the autentication mechanism that is
  decided by the issuing bank. Normally this will be done using BankID or Mobile
  BankID.

```mermaid
sequenceDiagram
  participant Payer
  participant Merchant
  participant SwedbankPay as Swedbank Pay
  participant IssuingBank

  activate Payer
  Payer->>+Merchant: start verification
  deactivate Payer
  Merchant->>+SwedbankPay: POST /psp/invoice/payments(operation=VERIFY)
  deactivate Merchant
  note left of Payer: First API request
  SwedbankPay-->+Merchant: payment resource
  deactivate SwedbankPay
  Merchant-->>+Payer: redirect to verification page
  deactivate Merchant
  Payer->>+SwedbankPay: access verification page
  deactivate Payer
  note left of Payer: redirect to SwedbankPay<br>(If Redirect scenario)
  SwedbankPay-->>+Payer: display purchase information
  deactivate SwedbankPay

  Payer->>Payer: input creditcard information
  Payer->>+SwedbankPay: submit creditcard information
  deactivate Payer
  opt Card supports 3-D Secure
    SwedbankPay-->>Payer: redirect to IssuingBank
    deactivate SwedbankPay
    Payer->>IssuingBank: 3-D Secure authentication process
    Payer->>+SwedbankPay: access authentication page
    deactivate Payer
  end

  SwedbankPay-->>+Payer: redirect to merchant
  deactivate SwedbankPay
  note left of Payer: redirect back to merchant<br>(If Redirect scenario)

  Payer->>+Merchant: access merchant page
  Merchant->>+SwedbankPay: GET /psp/invoice/payments/<paymentorder.id>
  deactivate Merchant
  note left of Merchant: Second API request
  SwedbankPay-->>+Merchant: rel: redirect-authorization
  deactivate SwedbankPay
  Merchant-->>Payer: display purchase result
  deactivate Merchant

  opt Callback is set
    activate SwedbankPay
    SwedbankPay->>SwedbankPay: Payment is updated
    SwedbankPay->>Merchant: POST Payment Callback
    deactivate SwedbankPay
  end
```

### Create authorization transaction

The `redirect-authorization` operation redirects the consumer to
Swedbank Pay Payments where the payment is authorized.

{code-header}
**Request**

```http
POST /psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "transaction": {
    "activity": "FinancingConsumer"
  },
  "consumer": {
    "socialSecurityNumber": "socialSecurityNumber",
    "customerNumber": "customerNumber",
    "email": "email",
    "msisdn": "msisdn",
    "ip": "consumer ip address"
  },
  "legalAddress": {
    "addressee": "firstName + lastName",
    "coAddress": "coAddress",
    "streetAddress": "streetAddress",
    "zipCode": "zipCode",
    "city": "city",
    "countryCode": "countryCode"
  },
  "billingAddress": {
    "addressee": "firstName + lastName",
    "coAddress": "coAddress",
    "streetAddress": "streetAddress",
    "zipCode": "zipCode",
    "city": "city",
    "countryCode": "countryCode"
  }
}
```

{:.table .table-striped}
| Required | Property                       | Type     | Description                                                            |
| :------: | :----------------------------- | :------- | :--------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `transaction`                  | `object` | The transaction object.                                                |
|          | └➔&nbsp;`activity`             | `string` | Only the value `"FinancingConsumer"` or `"AccountsReceivableConsumer"` |
|          | `consumer`                     | `object` | The consumer object.                                                   |
|          | └➔&nbsp;`socialSecurityNumber` | `string` | The social security number of the consumer.                            |
|          | └➔&nbsp;`customerNumber`       | `string` | Customer number of the consumer.                                       |
|          | └➔&nbsp;`email`                | `string` | The customer email address.                                            |
|          | └➔&nbsp;`msisdn`               | `string` | The MSISDN of the consumer.                                            |
|          | └➔&nbsp;`ip`                   | `string` | The IP address of the consumer.                                        |
|          | `legalAddress`                 | `object` | The Address object.                                                    |
|          | └➔&nbsp;`addressee`            | `string` | The full name of the addressee of this invoice                         |
|          | └➔&nbsp;`coAddress`            | `string` | The co Address of the addressee.                                       |
|          | └➔&nbsp;`streetAddress`        | `string` | The street address of the addresse.                                    |
|          | └➔&nbsp;`zipCode`              | `string` | The zip code of the addresse.                                          |
|          | └➔&nbsp;`city`                 | `string` | The city name  of the addresse.                                        |
|          | └➔&nbsp;`countryCode`          | `string` | The country code of the addresse.                                      |
|          | `billingAddress`               | `object` | The BillingAddress object for the billing address of the addresse.     |
|          | └➔&nbsp;`addressee`            | `string` | The full name of the billing address adressee.                         |
|          | └➔&nbsp;`coAddress`            | `string` | The co address of the billing address adressee.                        |
|          | └➔&nbsp;`streetAddress`        | `string` | The street address of the billing address adressee.                    |
|          | └➔&nbsp;`zipCode`              | `string` | The zip code of the billing address adressee.                          |
|          | └➔&nbsp;`city`                 | `string` | The city name of the billing address adressee.                         |
|          | └➔&nbsp;`countryCode`          | `string` | The country code of the billing address adressee.                      |

{code-header}
**Response**

```json
{
  "payment": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "authorization": {
    "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations/12345678-1234-1234-1234-123456789012",
    "consumer": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/consumer"
    },
    "legalAddress": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/legaladdress"
    },
    "billingAddress": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/billingaddress"
    },
    "transaction": {
      "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions/12345678-1234-1234-1234-123456789012",
      "created": "2016-09-14T01:01:01.01Z",
      "updated": "2016-09-14T01:01:01.03Z",
      "type": "Authorization",
      "state": "Initialized|Completed|Failed",
      "number": 1234567890,
      "amount": 1000,
      "vatAmount": 250,
      "description": "Test transaction",
      "payeeReference": "AH123456",
      "failedReason": "ExternalResponseError",
      "failedActivityName": "Authorize",
      "failedErrorCode": "ThirdPartyErrorCode",
      "failedErrorDescription": "ThirdPartyErrorMessage",
      "isOperational": "TRUE|FALSE",
      "activities": {
        "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions/12345678-1234-1234-1234-123456789012/activities"
      },
      "operations": [
        {
          "href": "https://api.payex.com/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
          "rel": "edit-authorization",
          "method": "PATCH"
        }
      ]
    }
  }
}
```

{:.table .table-striped}
| Property                 | Type      | Description                                                                                                                                                                                                  |
| :----------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                | `string`  | The relative URI of the payment this transaction belongs to.                                                                                                                                                 |
| `authorization`          | `object`  | The transaction object.                                                                                                                                                                                      |
| └➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └➔&nbsp;`amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                     |
| └➔&nbsp;`vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| └➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └➔&nbsp;`payeeReference` | `string`  | A unique reference for the transaction.                                                                                                                                                                      |
| └➔&nbsp;`failedReason`   | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| └➔&nbsp;`isOperational`  | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| └➔&nbsp;`operations`     | `array`   | The array of operations that are possible to perform on the transaction in its current state.                                                                                                                |

The `authorization` resource contains information about an authorization
transaction made towards a payment, as previously described.

{% include one-click-payments.md %}

{% include callback-reference.md %}

{% include payment-link.md %}

{% include subsite.md %}

## PayeeReference

{% include payeeinfo.md %}

## Prices

{% include prices.md %}

{% include settlement-reconciliation.md %}

## Problems

When performing unsuccessful operations, the eCommerce API will respond with a
problem message. We generally use the problem message `type` and `status` code
to identify the nature of the problem. The problem `name` and `description` will
often help narrow down the specifics of the problem.

### Error types from Swedbank Pay Invoice and third parties

All invoice error types will have the following URI in front of type:
`https://api.payex.com/psp/errordetail/invoice/<errorType>`

{:.table .table-striped}
| Type            | Status |                               |
| :-------------- | :----- | :---------------------------- |
| *externalerror* | 500    | No error code                 |
| *inputerror*    | 400    | 10 - ValidationWarning        |
| *inputerror*    | 400    | 30 - ValidationError          |
| *inputerror*    | 400    | 3010 - ClientRequestInvalid   |
| *externalerror* | 502    | 40 - Error                    |
| *externalerror* | 502    | 60 - SystemError              |
| *externalerror* | 502    | 50 - SystemConfigurationError |
| *externalerror* | 502    | 9999 - ServerOtherServer      |
| *forbidden*     | 403    | Any other error code          |

### Acquirer and 3-D Secure Problem Types

All acquirer error types will have the following URI in front of type:
`https://api.payex.com/psp/errordetail/invoice/<errorType>`

{:.table .table-striped}
| Type                           | Status | Description                                                                                   |
| :----------------------------- | :----: | :-------------------------------------------------------------------------------------------- |
| `3dsecureerror`                | `400`  | 3D Secure not working, try again some time later                                              |
| `cardblacklisted`              | `400`  | Card blacklisted, Consumer need to contact their Card-issuing bank                            |
| `paymenttokenerror`            | `403`  | There was an error with the payment token.                                                    |
| `carddeclined`                 | `403`  | The card was declined.                                                                        |
| `acquirererror`                | `403`  | The acquirer responded with a generic error.                                                  |
| `acquirercardblacklisted`      | `403`  | Card blacklisted, Consumer need to contact their Card-issuing bank                            |
| `acquirercardexpired`          | `403`  | Wrong expire date or Card has expired and consumer need to contact their Card-issuing bank    |
| `acquirercardstolen`           | `403`  | Card blacklisted, Consumer need to contact their Card-issuing bank                            |
| `acquirerinsufficientfunds`    | `403`  | Card does not have sufficient funds, consumer need to contact their Card-issuing bank.        |
| `acquirerinvalidamount`        | `403`  | Amount not valid by aquirer, contact support.ecom@payex.com                                   |
| `acquirerpossiblefraud`        | `403`  | Transaction declined due to possible fraud, consumer need to contact their Card-issuing bank. |
| `3dsecureusercanceled`         | `403`  | Transaction was Cancelled during 3DSecure verification                                        |
| `3dsecuredeclined`             | `403`  | Transaction was declined during 3DSecure verification                                         |
| `frauddetected`                | `403`  | Fraud detected. Consumer need to contact their Card-issuing bank.                             |
| `badrequest`                   | `500`  | Bad request, try again after some time                                                        |
| `internalservererror`          | `500`  | Server error, try again after some time                                                       |
| `3dsecureacquirergatewayerror` | `502`  | Problems reaching 3DSecure verification, try again after some time.                           |
| `badgateway`                   | `502`  | Problems reaching the gateway, try again after some time                                      |
| `acquirergatewayerror`         | `502`  | Problems reaching acquirers gateway, try again after some time                                |
| `acquirergatewaytimeout`       | `504`  | Problems reaching acquirers gateway, try again after some time                                |

{% include iterator.html prev_href="./" prev_title="Back: Introduction"
next_href="after-payment" next_title="Next: After Payment" %}

[fi-png]: /assets/img/fi.png
[no-png]: /assets/img/no.png
[se-png]: /assets/img/se.png
[card-payment]: /assets/img/payments/card-payment.png
[callback-api]: #callback
[callback]: /payments/invoice/other-features/#callback
[cancel]: /payments/invoice/after-payment/#cancellations
[capture]: /payments/invoice/after-payment/#Capture
[hosted-view]: /payments/invoice/seamless-view
[invoice-flow]: /payments/invoice/index/#invoice-flow
[mcc]: https://en.wikipedia.org/wiki/Merchant_category_code
[one-click-payments]: #one-click-payments
[payment-order]: #payment-orders
[payout]: #payout
[price-resource]: /payments/invoice/other-features/#prices
[purchase]: #purchase
[recurrence]: #recur
[redirect]: /payments/invoice/redirect
[settlement-and-reconciliation]: #settlement-and-reconciliation
[split-settlement]: #split-settlement
[user-agent-definition]: https://en.wikipedia.org/wiki/User_agent
[verify]: #verify
