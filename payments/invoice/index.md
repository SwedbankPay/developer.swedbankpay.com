---
title: Swedbank Pay Invoice Payments
sidebar:
  navigation:
  - title: Invoice Payments
    items:
    - url: /payments/invoice
      title: Introduction
    - url: /payments/invoice/direct
      title: Direct
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
                      body="This section of the Developer Portal is under construction and
                      should not be used to integrate against
                      Swedbank Pay's APIs yet." %}

{% include jumbotron.html body="**Invoice Payments** is one of the easiest
and safest payment services where Swedbank Pay helps improve cashflow by
purchasing merchant invoices.
Choose between our **Direct**, **Redirect** and **Seamless view**
integration options." %}

{% include alert.html type="neutral"
                      icon="cached"
                      body="**Direct** is a payment service where Swedbank Pay
                      helps improve cashflow by purchasing merchant invoices.
                      Swedbank Pay receives invoice data, which is used to
                      produce and distribute invoices to the consumer/end-use." %}

{% include alert.html type="neutral"
                      icon="cached"
                      body="**Redirect** is the easiest way to implement Invoice
                      Payments. Redirect will take the consumer to a Swedbank
                      Pay hosted payment page where they can perform a safe
                      transaction. The consumer will be redirected back to your
                      website after the completion of the payment." %}

{% include alert.html type="neutral"
                      icon="branding_watermark"
                      body="**Seamless View** is our solution for a payment
                      experience that is integrated directly on your website.
                      The payment process will be executed in an `iframe` on
                      your page." %}

### Important steps before you launch Swedbank Pay Faktura at your website

Prior to launching Swedbank Pay Faktura at your site, make sure that you
have done the following:  

1. Sent a merchant logo in .JPG format to [setup.ecom@payex.com][setup-mail].
    The logo will be displayed on all your invoices. Minimum accepted size is
    600x200 pixels, and at least 300 DPI.
2. Included a link to "Terms and Conditions" for Swedbank Pay Faktura.

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).
You can  with following `operation`
options:

* [Financing Consumer][other-features-financing-consumer]
* [Recur][recur]
* [Verify][verify]

Our `payment` example below uses the [`FinancingConsumer`]
[other-features-financing-consumer] value.

### Financing Consumer

{:.code-header}
**Request**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "operation": "FinancingConsumer",
        "intent": "Authorization",
        "currency": "SEK",
        "prices": [
            {
                "type": "Invoice",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "payerReference": "SomeReference",
        "generateRecurrenceToken": false,
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO|sv-SE|...",
        "urls": {
            "completeUrl": "http://test-dummy.net/payment-completed",
            "cancelUrl": "http://test-dummy.net/payment-canceled",
            "callbackUrl": "http://test-dummy.net/payment-callback",
            "logoUrl": "http://fakeservices.psp.dev.utvnet.net/logo.png",
            "termsOfServiceUrl": "http://fakeservices.psp.dev.utvnet.net/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "12345678-1234-1234-1234-123456789012",
            "payeeReference": "PR123",
            "payeeName": "Merchant1",
            "productCategory": "PC1234",
            "subsite": "MySubsite" //<-- Optional
        },
        "metadata": { //<-- Optional
            "key1": "value1",
            "key2": 2,
            "key3": 3.1,
            "key4": false

        },
        "billingAddress": {
                "firstName": "Leia",
                "lastName": "lastname",
                "email": "email",
                "msisdn": "msisdn",
                "streetAddress": "streetAddress",
                "coAddress": "coAddress",
                "city": "city",
                "zipCode": "zipCode",
                "countryCode": "countrycode"


    },
    "invoice": {
        "invoiceType": "PayExFinancingSe|PayExFinancingNo|PayExFinancingFi|CampaignInvoiceSe|PayMonthlyInvoiceSe|ScbFinancingSe",
    }
}
```

{:.table .table-striped}
| Required | Property                              | Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :------: | :------------------------------------ | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|  ✔︎︎︎︎︎  | `payment`                             | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`                           | `string`      | The operation that the `payment` is supposed to perform. The [`FinancingConsumer`][other-features-financing-consumer] operation is used in our example. Take a look at the ?? for a full examples of the following `operation` options: [FinancingConsumer][financing consumer], [Recur][recur], [Verify][verify]                                                                                                                                                                                                                                               |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`                              | `string`      | `PreAuthorization`. Holds the funds for a certain time in contrast to reserving the amount. A preauthoriation is always followed by the [finalize][finalize] operation. <br> <br> `Authorization`. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br> `AutoCapture`.                                                                                                                                            |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`                            | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`                      | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`                       | `string`      | Use the `Invoice` type here |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`                     | `integer`     | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 SEK 5000 = 50.00 SEK.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`                  | `integer`     | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                                                                                                                                                                                                                                                                                        |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`                 | `string(40)`  | A textual description max 40 characters of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └➔&nbsp;`payerReference`              | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └➔&nbsp;`generatePaymentToken`        | `boolean`     | `true` or `false`. Set this to `true` if you want to create a paymentToken for future use as One Click.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|          | └➔&nbsp;`generateRecurrenceToken`     | `boolean`     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|  ✔︎︎︎︎︎  | └➔&nbsp;`userAgent`                   | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-def]                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └➔&nbsp;`language`                    | `string`      | nb-NO, sv-SE or en-US.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`urls`                        | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | └─➔&nbsp;`hostUrl`                    | `array`       | The array of URLs valid for embedding of Swedbank Pay Hosted Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`                | `string`      | The URL that Swedbank Pay will redirect back to when the payment page is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`cancelUrl`                  | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`paymentUrl`                 | `string`      | The URI that Swedbank Pay will redirect back to when the view-operation needs to be loaded, to inspect and act on the current status of the payment. Only used in Seamless Views. If both `cancelUrl` and `paymentUrl` is sent, the `paymentUrl` will used.                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`callbackUrl`                | `string`      | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`logoUrl`                    | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`termsOfServiceUrl`          | `string`      | A URL that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeenfo`                    | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeId`                    | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeReference`             | `string(30*)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └─➔&nbsp;`payeeName`                  | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|          | └─➔&nbsp;`productCategory`            | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`orderReference`             | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|          | └─➔&nbsp;`subsite`                    | `String(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                                                                                                                                                                                 |
|          | └─➔&nbsp;`deliveryTimeFrameIndicator` | `string`      | Indicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`preOrderDate`               | `string`      | For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └─➔&nbsp;`preOrderPurchaseIndicator`  | `string`      | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability)                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`shipIndicator`              | `string`      | Indicates shipping method chosen for the transaction. <br>`01` (Ship to the billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than the billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service)          |
|          | └─➔&nbsp;`giftCardPurchase`           | `bool`        | `true` if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|          | └─➔&nbsp;`reOrderPurchaseIndicator`   | `string`      | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability)                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └➔&nbsp;`pickUpAddress`               | `object`      | If `shipIndicator` set to `04`, then prefill this with the payers `pickUpAddress` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`name`                       | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `name` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`streetAddress`              | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `streetAddress` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`coAddress`                  | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `coAddress` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                |
|          | └─➔&nbsp;`city`                       | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `city` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`zipCode`                    | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `zipCode` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └─➔&nbsp;`countryCode`                | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `countryCode` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                              |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": {
    "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "number": 1234567890,
    "instrument": "Invoice",
    "created": "YYYY-MM-DDThh:mm:ssZ",
    "updated": "YYYY-MM-DDThh:mm:ssZ",
    "state": "Ready|Pending|Failed|Aborted",
    "operation": "FinancingConsumer"
    "intent": "Authorization",
    "currency": "NOK|SEK|...",
    "amount": 1500,
    "remainingCaptureAmount": 1000,
    "remainingCancellationAmount": 1000,
    "remainingReversalAmount": 500,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",
    "language": "nb-NO",
    "prices": { "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices" },
    "transactions": { "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions" },
    "authorizations": { "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations" },
    "captures": { "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures" },
    "reversals": { "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals" },
    "cancellations": { "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations" },
    "payeeInfo" : { "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "urls" : { "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "settings": { "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "approvedLegalAddress": { "id": "/psp/invoice/payments/<paymentId>/approvedlegaladdress" },
    "maskedApprovedLegalAddress": { "id": "/psp/invoice/payments/<paymentId>/maskedapprovedlegaladdress" }
  },
  "operations": [
    {
      "href": "https://api.payex.com/psp/invoice/payments/<paymentId>",
      "rel": "update-payment-abort",
      "method": "PATCH"
    },
    {
      "href": "https://api.payex.com/psp/invoice/payments/<paymentId>/authorizations",
      "rel": "create-authorize",
      "method": "POST"
    },
    {
      "href": "https://api.payex.com/psp/invoice/payments/<paymentId>/approvedlegaladdress",
      "rel": "create-approved-legal-address",
      "method": "POST"
    }
  ]
}
```

[after-payment]: /payments/invoice/after-payment
[no-png]: /assets/img/no.png
[se-png]: /assets/img/se.png
[fi-png]: /assets/img/fi.png
[callback]: /payments/invoice/other-features#callback
[cancel]: /payments/invoice/after-payment#cancellations
[capture]: /payments/invoice/after-payment#captures
[other-features-financing-consumer]:/payments/invoice/other-features#create-authorization-transaction
[payout]: /payments/card/other-features/#payout
[purchase]: /payments/card/other-features/#purchase
[verify]: /payments/card/other-features/#verify
[recur]: /payments/card/other-features/#recur
[user-agent-def]: https://en.wikipedia.org/wiki/User_agent
[payee-reference]: /payments/invoice/other-features#payee-info
