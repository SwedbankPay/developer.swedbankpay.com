---
title: Migration Guide
description: |
  Migrating from _Checkout v2_, _Payment Menu_ and _Payment Instruments_ to
  _Pay_.
menu_order: 1600
---

Pay provides a more stream-lined, refined payment experience for both
the payer and the merchant. The response models have been reduced in size and
complexity to simplify integration.

## Request Fields

With an integration against our Checkout v2 API, there is very little you have
to do to make the integration Pay compliant. Both the URI and the request body
is the same `paymentorder` you know from Checkout v2.

## Response Fields

When you have created a Payment Order, the response will be different in
Pay compared to Checkout v2. You will no longer find the following
fields in the response:

```jsonc
{
    "paymentorder": {
        "currentPayment": /* Removed in Pay */,
        "instrument":  /* Removed in Pay */,
        "payers": /* Removed in Pay */,
        "payments": /* Removed in Pay */,
        "settings": /* Removed in Pay */,
        "state": /* Removed in Pay */,
        "nonPaymentToken": /* Moved into the `paid` resource in Pay */,
        "recurrenceToken": /* Moved into the `paid` resource in Pay */,
        "unscheduledToken": /* Moved into the `paid` resource in Pay */,
        "transactionsOnFileToken": /* Noved into the `paid` resource in Pay */,
        "nonPaymentToken": /* Moved into the `paid` resource in Pay */,
        "externalNonPaymentToken": /* Moved into the `paid` resource in Pay */,
    }
}
```

Instead, you'll find the following new fields in Pay:

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

TODO: fix the rest of this page
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
| `onPayerIdentified`           | `onShippingDetailsAvailable`      | {% include events/on-payer-identified.md %}                            |
| `onPayerUnidentified`         |                                   | **New in v3**. {% include events/on-payer-unidentified.md %}           |
|                               | `onPaymentCreated`                | **Deprecated**. {% include events/on-payment-created.md %}             |
|                               | `onPaymentFailed`                 | **Deprecated**. {% include events/on-payment-failed.md %}              |
|                               | `onPaymentPending`                | **Deprecated**. {% include events/on-payment-pending.md %}             |
|                               | `onPaymentTransactionFailed`      | **Deprecated**. {% include events/on-payment-transaction-failed.md %}  |
| `onTermsOfServiceRequested`   | `onPaymentToS`                    | {% include events/on-terms-of-service-requested.md %}                  |


## Pay

[Checkout v3 Payments Only][payments-only] is the package that should be used
when you want to handle both identification of the payer yourself. With
_Instrument Mode_ you also have the possibility to draw your own UI for the
Payment Menu.

If you are currently using the Checkout v2 _Payment Menu_ or have integrated
directly with the Payment Instruments APIs, _Payments Only_ is the package most
suited to your current needs.

### Pay – Payer

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

[enterprise]: /paymetnmenu/enterprise
[payments-only]: /paymetnmenu/payments-only
[starter]: /paymetnmenu/starter
