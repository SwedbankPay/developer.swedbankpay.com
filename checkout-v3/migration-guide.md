---
title: Migration Guide
hide_from_sidebar: false
description: |
  Migrating from _Checkout v2_, _Payment Menu_ and _Payment Instruments_ to
  _Checkout v3_.
hide_from_sidebar: true
menu_order: 900
---

Checkout v3 provides a more stream-lined, refined checkout experience for both
the payer and the merchant. The response models have been reduced in size and
complexity to simplify integration.

Where Checkout v2 and Payment Instruments v1 were offered more as a mix and
match package, Checkout v3 is more conveniently divided into four distinct
packages: _Starter_, _Business_, _Enterprise_, and _Payments Only_.

Which v3 package you should choose when migrating from Checkout v2 and Payment
Instruments to Checkout v3 depends on which legacy features you are using. A
mapping between various legacy features and the recommended corresponding v3
packages is provided in the table below.

{:.table .table-striped}
| Legacy feature or product   | Recommended v3 package                                         |
| --------------------------: | :------------------------------------------------------------- |
| Regular Checkout v2         | [Checkout v3 _Enterprise_][enterprise]                         |
| MAC, SCA                    | [Checkout v3 _Enterprise_][enterprise]                         |
| Payment Menu v2             | [Checkout v3 _Payments Only_][payments-only]                   |
| Checkout v2 without Checkin | [Checkout v3 _Payments Only_][payments-only]                   |
| Payment Instruments v1      | [Checkout v3 _Payments Only_][payments-only] (Instrument Mode) |

## Request Fields

With an integration against our Checkout v2 API, there is very little you have
to do to make the integration v3 compliant. Both the URI and the request body
is the same `paymentorder` you know from Checkout v2.

The only required change is to add the two fields `productName` and
`implementation` for all packages except _Payments Only_, where `implementation`
is not applicable.

```json
{
    "paymentorder": {
        "productName": "Checkout3",
        "implementation": "Enterprise"
    }
}
```

{:.table .table-striped}
| Required         | Field                    | Type     | Description                            |
| :--------------: | :----------------------- | :--------| :------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}           | `object` | The payment order object.              |
| {% icon check %} | {% f productName %}    | `string` | {% include fields/product-name.md %}    |
| {% icon check %} | {% f implementation %} | `string` | {% include fields/implementation.md %} |

## Response Fields

When you have created a Payment Order, the response will be different in
Checkout v3 compared to Checkout v2. You will no longer find the following
fields in the response:

```jsonc
{
    "paymentorder": {
        "currentPayment": /* Removed in Checkout v3 */,
        "instrument":  /* Removed in Checkout v3 */,
        "payers": /* Removed in Checkout v3 */,
        "payments": /* Removed in Checkout v3 */,
        "settings": /* Removed in Checkout v3 */,
        "state": /* Removed in Checkout v3 */,
        "nonPaymentToken": /* Moved into the `paid` resource in Checkout v3 */,
        "recurrenceToken": /* Moved into the `paid` resource in Checkout v3 */,
        "unscheduledToken": /* Moved into the `paid` resource in Checkout v3 */,
        "transactionsOnFileToken": /* Noved into the `paid` resource in Checkout v3 */,
        "nonPaymentToken": /* Moved into the `paid` resource in Checkout v3 */,
        "externalNonPaymentToken": /* Moved into the `paid` resource in Checkout v3 */,
    }
}
```

Instead, you'll find the following new fields in Checkout v3:

```json
{
    "paymentorder": {
        "aborted": { "id": "/psp/paymentorders/{{ page.payment_id }}/aborted" },
        "cancelled": { "id": "/psp/paymentorders/{{ page.payment_id }}/cancelled" },
        "failed": { "id": "/psp/paymentorders/{{ page.payment_id }}/failed" },
        "failedAttempts": { "id": "/psp/paymentorders/{{ page.payment_id }}/failedattempts" },
        "financialTransactions": { "id": "/psp/paymentorders/{{ page.payment_id }}/financialtransactions" },
        "guestMode": true,
        "history": { "id": "/psp/paymentorders/{{ page.payment_id }}/history" },
        "implementation": "Starter",
        "paid": { "id": "/psp/paymentorders/{{ page.payment_id }}/paid" },
        "payer": { "id": "/psp/paymentorders/{{ page.payment_id }}/payers" },
        "status": "Paid",
    }
}
```

{:.table .table-striped}
| Field                            | Type     | Description                                    |
| :------------------------------- | :--------| :--------------------------------------------- |
| {% f paymentOrder, 0 %}                   | `object` | The payment order object.                      |
| {% f aborted %}                | `id`     | {% include fields/aborted.md %}                |
| {% f cancelled %}              | `id`     | {% include fields/implementation.md %}         |
| {% f failed %}                 | `id`     | {% include fields/failed.md %}                 |
| {% f failedAttempts %}         | `id`     | {% include fields/failed-attempts.md %}        |
| {% f financialTransactions %}  | `id`     | {% include fields/financial-transactions.md %} |
| {% f guestMode %}              | `bool`   | {% include fields/guest-mode.md %}             |
| {% f history %}                | `id`     | {% include fields/history.md %}                |
| {% f paid %}                   | `id`     | {% include fields/paid.md %}                   |
| {% f payer %}                  | `id`     | {% include fields/payer.md %}                  |
| {% f status %}                 | `string` | {% include fields/status.md %}                 |

## Payer

As the different packages of Checkout v3 in essence revolves around whether, or
how the payer is identified, the `payer` field will vary depending on which
package you choose. How the `payer` field differs will be explained in the
sections below.

## Events

With the changes in how the Seamless Views are sewn together in Checkout v3, the
JavaScript events that are triggered by the Seamless Views have changed. The
details of these changes will be explained in the below table.

{:.table .table-striped}
| v3 Event Name                 | Corresponding v2 Event            | Description                                                            |
| ----------------------------: | :-------------------------------- | :--------------------------------------------------------------------- |
| `onAborted`                   | `onPaymentCanceled`               | {% include events/on-aborted.md %}                                     |
| `onCheckoutLoaded`            | `onApplicationConfigured`         | {% include events/on-checkout-loaded.md %}                             |
| `onCheckoutResized`           | `onApplicationConfigured`         | {% include events/on-checkout-resized.md %}                            |
| `onError`                     | `onError`                         | {% include events/on-error.md %}                                       |
| `onEventNotification`         | `onEventNotification`             | {% include events/on-event-notification.md %}                          |
| `onInstrumentSelected`        | `onPaymentMenuInstrumentSelected` | {% include events/on-instrument-selected.md %}                         |
| `onOutOfViewOpen`             | `onExternalRedirect`              | {% include events/on-out-of-view-open.md %}                            |
| `onOutOfViewRedirect`         | `onExternalRedirect`              | {% include events/on-out-of-view-redirect.md %}                        |
| `onPaid`                      | `onPaymentCompleted`              | {% include events/on-paid.md %}                                        |
|                               | `onPaymentCreated`                | **Deprecated**. {% include events/on-payment-created.md %}             |
|                               | `onPaymentFailed`                 | **Deprecated**. {% include events/on-payment-failed.md %}              |
|                               | `onPaymentPending`                | **Deprecated**. {% include events/on-payment-pending.md %}             |
|                               | `onPaymentTransactionFailed`      | **Deprecated**. {% include events/on-payment-transaction-failed.md %}  |
| `onTermsOfServiceRequested`   | `onPaymentToS`                    | {% include events/on-terms-of-service-requested.md %}                  |

## Checkout v3 Starter

Checkout v3 Starter should be the default choice for most merchants coming from
v2.

The most significant difference between Checkout v2 and _Checkout v3 Starter_ is
that we have sewn the Seamless Views better together so the communication
between _Checkin_ and _Payment Menu_ is handled automatically. This means we can
now offer **Remember Me** and a simplified integration flow.

### Checkout v3 Starter – Payer

For _Checkout v3 Starter_, the `payer` field is required. Which fields within it
are available depends on whether `digitalProducts` is set to `true` or `false`.
When `digitalProducts` is set to `false`, the field
`shippingAddressRestrictedToCountryCodes` can be set to an array of country
codes that will restrict shipping to the specified country-codes.

```json
"payer": {
  "digitalProducts": false,
  "shippingAddressRestrictedToCountryCodes": [ "NO", "US" ]
}
```

### Checkout v3 Starter – Events

The full list of available [events](#events) can be viewed above. The only
special events for _Checkout v3 Starter_ are `onPayerIdentified` and
`onPayerUnidentified` which are mandatory to implement and a part of the
acceptance criteria for the integration. These events are required for the
Remember Me feature to work.

## Checkout v3 Payments Only

[Checkout v3 Payments Only][payments-only] is the package that should be used
when you want to handle both identification of the payer yourself. With
_Instrument Mode_ you also have the possibility to draw your own UI for the
Payment Menu.

If you are currently using the Checkout v2 _Payment Menu_ or have integrated
directly with the Payment Instruments v1 APIs, _Payments Only_ is the package
most suited to your current needs.

### Checkout v3 Payments Only – Payer

For _Checkout v3 Payments Only_, the `payer` field is optional. If it is
provided in the request, its children depends on whether `digitalProducts` is
set to `true` or `false`, plus whether the payer is identified or not.
Unidentified payers will go through the payment process in a so-called _Guest
Mode_.

```json
"payer": {
  "digitalProducts": false,
  "payerReference": "anything",
  "email": "karl.anderssson@example.com",
  "msisdn": "+4659123456",
  "authentication": {},
  "firstName": "Karl",
  "lastName": "Andersson",
  "shippingAddress": {},
  "billingAddress": {},
  "accountInfo": {}
}
```

{:.table .table-striped}
| Required         | Field            | Type     | Description                            |
| :--------------: | :--------------- | :--------| :------------------------------------- |
|                  | `payer`          | `object` | The payment order object.              |
| {% icon check %} | {% f email %}  | `string` | {% include fields/product-name.md %}   |
| {% icon check %} | {% f msisdn %} | `string` | {% include fields/implementation.md %} |

*[TRA]: Transaction Risk Analysis
*[MAC]: Merchant-Authenticated Consumer
*[SCA]: Strong Customer Authentication

[enterprise]: /checkout-v3/enterprise
[payments-only]: /checkout-v3/payments-only
