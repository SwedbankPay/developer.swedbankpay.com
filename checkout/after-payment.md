---
title: Swedbank Pay Checkout After Payment
sidebar:
  navigation:
  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/payment
      title: Payment
    - url: /checkout/after-payment
      title: After Payment
    - url: /checkout/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

{% include jumbotron.html body="When the consumer has **completed** the entire
[Checkin and Payment flow](/checkout/payment), you need to implement the
relevant **after-payment operations** in your order system. Which these
operations are and how they are executed is described below." %}

## Operations

Most payment methods are two-phase payments –
in which a successful paymentorder will result in an authorized transaction –
that must be followed up by a capture or cancellation transaction in a later
stage. One-phase payments like Swish are settled directly without the option to
capture or cancel. For a full list of the available operations, see the
[techincal reference][payment-order-operations].

{:.table .table-striped}
| **Operation**                          | **Description**        |
| `update-paymentorder-updateorder`  | [Updates the order](#update-order) with a change in the `amount` and/or `vatAmount`.       |
| `create-paymentorder-capture`      | The second part of a two-phase transaction where the authorized amount is sent from the payer to the payee. It is possible to do a part-capture on a subset of the authorized amount. Several captures on the same payment are possible, up to the total authorization amount. |
| `create-paymentorder-cancellation` | Used to cancel authorized and not yet captured transactions. If a cancellation is performed after doing a part-capture, it will only affect the not yet captured authorization amount.                                                                                         |
| `create-paymentorder-reversal`     | Used to reverse a payment. It is only possible to reverse a payment that has been captured and not yet reversed.                                                                                                                                                               |

To identify the operations that are available we need to do a `GET` request against the URI of `paymentorder.id`:

{:.code-header}
**Request**

```http
GET /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4 HTTP/1.1
Authorization: Bearer <MerchantToken>
```

The (abbreviated) response containing an `updateorder`, `capture`,
`cancellation`, and `reversal` operation should look similar to the response
below:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentOrder": {
        "id": "/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4",
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/captures",
            "rel": "create-paymentorder-capture",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/cancellations",
            "rel": "create-paymentorder-cancellation",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/reversals",
            "rel": "create-paymentorder-reversal",
            "contentType": "application/json"
        }
    ]
}
```

{:.table .table-striped}
| **Property**       | **Type**     | **Description**               |
| `paymentorder` | `object` | The payment order object.                                                          |
| └➔&nbsp;`id`   | `string` | The relative URI to the payment order.                                             |
| `operations`   | `array`  | The array of possible operations to perform, given the state of the payment order. |

## Update Order

Change amount and vat amount on a payment order. If you implement `updateorder`
**you need to `refresh()`** the [Payment Menu front end][payment-menu-front-end]
so the new amount is shown to the end customer.

{:.code-header}
**Request**

```http
PATCH /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4 HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "UpdateOrder",
        "amount": 2500,
        "vatAmount": 120
    }
}
```

**Response**

The response given when changing a payment order is equivalent to a `POST`
or `GET` request towards the `paymentorders` resource,
[as displayed above][payment-menu-back-end]. Remember to call `.refresh()`
on the Payment Menu in JavaScript after updating the Payment Order.

## Capture

Capture can only be done on a payment with a successful authorized transaction.
It is possible to do a part-capture where you only capture a smaller amount
than the authorized amount. You can later do more captures on the same payment
up to the total authorization amount.

**Notice** that the `orderItems`property object is optional. If the `POST` request has `orderItems` in the `paymentorder`, remember to include `orderItems` in the `capture` operation.
If the `paymentorder` is without `orderItems`, remember to leave this out in the `capture` operation.

To capture the authorized payment, we need to perform
`create-paymentorder-capture` against the accompanying href returned in the
`operations` list. See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/captures HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "transaction": {
    "description": "Capturing the authorized payment",
    "amount": 15610,
    "vatAmount": 3122,
    "payeeReference": "AB832"
    "orderItems": [
        {
            "reference": "P1",
            "name": "Product1",
            "type": "PRODUCT",
            "class": "ProductGroup1",
            "itemUrl": "https://example.com/products/123",
            "imageUrl": "https://example.com/product123.jpg",
            "description": "Product 1 description", 
            "discountDescription": "Volume discount",
            "quantity": 4,
            "quantityUnit": "pcs",
            "unitPrice": 300,
            "discountPrice": 200,
            "vatPercent": 2500,
            "amount": 1000,
            "vatAmount": 250
        },
        {
            "reference": "P2",
            "name": "Product2",
            "type": "PRODUCT",
            "class": "ProductGroup1",
            "description": "Product 2 description",
            "quantity": 1,
            "quantityUnit": "pcs",
            "unitPrice": 500,
            "vatPercent": 2500,
            "amount": 500,
            "vatAmount": 125
        }
    ],
  }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | **Property**                       | **Type**         | **Description**                          |
| ✔︎︎︎︎︎ | `transaction`                  | `object`     | The transaction object.                                                                                                                                                                                                                    |
| ✔︎︎︎︎︎ | └➔&nbsp;`description`          | `string`     | The description of the capture transaction.                                                                                                                                                                                                |
| ✔︎︎︎︎︎ | └➔&nbsp;`amount`               | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                                                                          |
| ✔︎︎︎︎︎ | └➔&nbsp;`vatAmount`            | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                                                                                 |
| ✔︎︎︎︎︎ | └➔&nbsp;`payeeReference`       | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.                                                   |
|        | └➔&nbsp;`orderItems`           | `array`      | The array of items being purchased with the order. Used to print on invoices if the payer chooses to pay with invoice, among other things. Required in `capture` requests if already sent with the initial creation of the Payment Order.  |
| ✔︎︎︎︎︎ | └─➔&nbsp;`reference`           | `string`     | A reference that identifies the order item.                                                                                                                                                                                                |
| ✔︎︎︎︎︎ | └─➔&nbsp;`name`                | `string`     | The name of the order item.                                                                                                                                                                                                                |
| ✔︎︎︎︎︎ | └─➔&nbsp;`type`                | `string`     | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.                                                                                                                                     |
| ✔︎︎︎︎︎ | └─➔&nbsp;`class`               | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, for instance. Swedbank Pay has no use for this value itself, but it's useful for some payment instruments and integrations. |
|  ︎︎︎   | └─➔&nbsp;`itemUrl`             | `string`     | The URL to a page that contains a human readable description of the order item, or similar.                                                                                                                                                |
|  ︎︎︎   | └─➔&nbsp;`imageUrl`            | `string`     | The URL to an image of the order item.                                                                                                                                                                                                     |
|  ︎︎︎   | └─➔&nbsp;`description`         | `string`     | The human readable description of the order item.                                                                                                                                                                                          |
|  ︎︎︎   | └─➔&nbsp;`discountDescription` | `string`     | The human readable description of the possible discount.                                                                                                                                                                                   |
| ✔︎︎︎︎︎ | └─➔&nbsp;`quantity`            | `integer`    | The quantity of order items being purchased.                                                                                                                                                                                               |
| ✔︎︎︎︎︎ | └─➔&nbsp;`quantityUnit`        | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar.                                                                                                                                                                              |
| ✔︎︎︎︎︎ | └─➔&nbsp;`unitPrice`           | `integer`    | The price per unit of order item.                                                                                                                                                                                                          |
|  ︎︎︎   | └─➔&nbsp;`discountPrice`       | `integer`    | If the order item is purchased at a discounted price, this property should contain that price.                                                                                                                                             |
| ✔︎︎︎︎︎ | └─➔&nbsp;`vatPercent`          | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                   |
| ✔︎︎︎︎︎ | └─➔&nbsp;`amount`              | `integer`    | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                      |
| ✔︎︎︎︎︎ | └─➔&nbsp;`vatAmount`           | `integer`    | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                             |

If the capture succeeds, it should respond with something like the following:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "capture": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/captures/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Capture",
            "state": "Completed",
            "amount": 15610,
            "vatAmount": 3122,
            "description": "Capturing the authorized payment",
            "payeeReference": "AB832",
        }
    }
}
```

{:.table .table-striped}
| **Property**                  | **Type**      | **Description**      |
| `payment`                 | `string`  | The relative URI of the payment this capture transaction belongs to.                                                                                                                                         |
| `capture`                 | `object`  | The capture object, containing the information about the capture transaction.                                                                                                                                |
| └➔&nbsp;`id`              | `string`  | The relative URI of the created capture transaction.                                                                                                                                                         |
| └➔&nbsp;`transaction`     | `object`  | The transaction object, containing information about the current transaction.                                                                                                                                |
| └─➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └─➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └─➔&nbsp;`amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                     |
| └─➔&nbsp;`vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| └─➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └─➔&nbsp;`payeeReference` | `string`  | A unique reference for the transaction. See [`payeeReference`][payee-reference] for details.                                                                                                                 |

**Et voilà!** Checkout should now be complete, the payment should be secure and
everyone should be happy. But, sometimes you also need to implement the
cancellation and reversal operations described below.

## Cancel

If we want to cancel up to the total authorized (not captured) amount, we need
to perform `create-paymentorder-cancel` against the accompanying href returned
in the `operations` list. See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/cancellations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "transaction": {
        "payeeReference": "ABC123",
        "description": "Cancelling parts of the total amount"
    }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | **Property**                 | **Type**         | **Description**  |
| ✔︎︎︎︎︎ | `transaction`            | `object`     | The transaction object.    |
| ✔︎︎︎︎︎ | └➔&nbsp;`payeeReference` | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details. |
| ✔︎︎︎︎︎ | └➔&nbsp;`description`    | `string`     | A textual description of why the transaction is cancelled.                                                                                                                               |

If the cancellation request succeeds, the response should be similar to the
example below:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "cancellation": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/cancellations/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Cancel",
            "state": "Completed",
            "amount": 5610,
            "vatAmount": 1122,
            "description": "Cancelling parts of the authorized payment",
            "payeeReference": "AB832",
        }
    }
}
```

{:.table .table-striped}
| **Property**                  | **Type**      | **Description**           |
| `payment`                 | `string`  | The relative URI of the payment this cancellation transaction belongs to.                                                                                                                                    |
| `cancellation`            | `object`  | The cancellation object, containing information about the cancellation transaction.                                                                                                                          |
| └➔&nbsp;`id`              | `string`  | The relative URI of the cancellation transaction.                                                                                                                                                            |
| └➔&nbsp;`transaction`     | `object`  | The transaction object, containing information about the current transaction.                                                                                                                                |
| └─➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └─➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └─➔&nbsp;`amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                     |
| └─➔&nbsp;`vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| └─➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └─➔&nbsp;`payeeReference` | `string`  | A unique reference for the transaction. See [`payeeReference`][payee-reference] for details.                                                                                                                 |

## Reversal

If we want to reverse a previously captured amount, we need to perform
`create-paymentorder-reversal` against the accompanying href returned in the
`operations` list. See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/reversals HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 15610,
        "vatAmount": 3122,
        "payeeReference": "ABC123",
        "description": "description for transaction"
    }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | **Property**                 | **Type**         | **Description**  |
| ✔︎︎︎︎︎ | `transaction`            | `object`     | The transaction object.        |
| ✔︎︎︎︎︎ | └➔&nbsp;`amount`         | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                        |
| ✔︎︎︎︎︎ | └➔&nbsp;`vatAmount`      | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                               |
| ✔︎︎︎︎︎ | └➔&nbsp;`payeeReference` | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details. |
| ✔︎︎︎︎︎ | └➔&nbsp;`description`    | `string`     | Textual description of why the transaction is reversed.                                                                                                                                  |

If the reversal request succeeds, the response should be similar to the example below:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "reversals": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/cancellations/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Reversal",
            "state": "Completed",
            "amount": 5610,
            "vatAmount": 1122,
            "description": "Reversing the capture amount",
            "payeeReference": "ABC987",
        }
    }
}
```

{:.table .table-striped}
| **Property**                  | **Type**      | **Description**                   |
| `payment`                 | `string`  | The relative URI of the payment this reversal transaction belongs to.                                                                                                                                        |
| `reversals`               | `object`  | The reversal object, containing information about the reversal transaction.                                                                                                                                  |
| └➔&nbsp;`id`              | `string`  | The relative URI of the reversal transaction.                                                                                                                                                                |
| └➔&nbsp;`transaction`     | `object`  | The transaction object, containing information about the current transaction.                                                                                                                                |
| └─➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └─➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └─➔&nbsp;`amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                     |
| └─➔&nbsp;`vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| └─➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └─➔&nbsp;`payeeReference` | `string`  | A unique reference for the transaction. See [`payeeReference`][payee-reference] for details.                                                                                                                 |


## Best Practices

A completed integration against Swedbank Pay Checkout standard setup should
adhere to a set of best practice criteria in order to successfully go
through Swedbank Pay' integration validation procedure.

### Must Haves

* The Checkin and Payment Menu components (the two `<iframe>` elements) must be
  separate (one must not replace the other).
* The Checkin must be completed before any shipping details are finalized, as
  the Checkin component provides shipping address via the
  `onShippingDetailsAvailable` event.
* A button in the webshop or merchant web site needs to exist that allows the
  user to not perform Checkin ("Shop anonymously"). See
  [guest payments][guest-payments] for details.
* If a browser refresh is performed after the payer has checked in, the payment
  menu must be shown even though `onConsumerIdentified` is not invoked.
* The `consumerProfileRef` returned in the response from the `POST` request to
  the `consumers` resource must be included in the `POST` request to the
  `paymentorders` resource.
* When the contents of the shopping cart changes or anything else that affects
  the amount occurs, the `paymentorder` must be updated and the Payment Menu
  must be `refresh`ed.
* Features not described on this page must not be used, although they are
  available in the API. Flags that can be turned to `true` must be kept
  `false` as described in this standard setup documentation.
* When the payer is checked in, he or she must be identified appropriately in
  the Payment Menu (stored credit cards must be visible for the credit card
  payment instrument, for instance).
* `orderReference` must be sent as a part of the `POST` request to
  `paymentorders` and must represent the order ID of the webshop or merchant
  website.
* The integration needs to handle both one and two phase purchases correctly.
* All of the operations `Cancel`, `Capture` and `Reversal` must be implemented.
* The [transaction callback][callback] must be handled appropriately.
* [Problems][problems] that may occur in Swedbank Pay' API must be handled
  appropriately.
* Your integration must be resilient to change. Properties, operations,
  headers, etc., that aren't understood in any response **must be ignored**.
  Failing due to a something occurring in a response that your implementation
  haven't seen before is a major malfunction of your integration and must be
  fixed.

[https]: /#connection-and-protocol
[msisdn]: https://en.wikipedia.org/wiki/MSISDN
[payee-reference]: #
[payment-order-operations]: #
[guest-payments]: #
[callback]: #
[payment-menu-back-end]: #
[payment-menu-front-end]: #
[problems]: #
