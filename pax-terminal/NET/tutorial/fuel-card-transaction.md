---
title: Fuel Functionality
description: |
  Fuel functionality is about handling cards that has various restrictions. Product codes and prices need to be sent to the terminal, and allowed products are returned if any is not accepted.
permalink: /:path/fuel-card-functionality/
hide_from_sidebar: true
icon:
    content: local_gas_station
    outlined: true
menu_order: 100
---
To use Swedbank Pay PAX terminal for handling cards with certain product restrictions, such as fuel cards, only affects the implementation regarding the call to [`Payment`][paymentasync] and handling the response.

When calling [`PaymentAsync`][paymentasync] or the synchronous version [`Payment`][paymentasync] the version using a `TransactionSetup` as parameter must be used in order to pass a list of products for the purchase.

If the result has `ResponseResult` set to failure and the `ErrorCondition` is `PaymentRestriction` the list of `AllowedProducts` will indicate if any product may be purchase with the card.

## Product List

The list of products that is passed in the `TransactionSetup` consists of one or more `SaleItem` objects.

{% include pax-saleitem.md %}

## Start Payment

Starting a payment would be done similar to the following:

{%include pax-start-fuel-card-payment.md%}

## When Failure

If the [`PaymentRequestResult.ResponseResult`][paymentrequestresult] is `Failure` the transaction has failed either for a normal reason or, if `ErrorCondition` is `PaymentRestriction`, due to the restriction for the card used. The [`PaymentRequestResult`][paymentrequestresult] has a property named `AllowedProducts` that is a list of product codes from the request that may be purchased using the same card. If the list is empty none of the products can be purchased with the card used.

Let's say the above example failed and the `AllowedProducts` has one item with value "24601", then the customer may either change card or just buy that product. A new Payment must be issued with a new list of SaleItem with just that one product and the amount 25.5.

[paymentasync]: /pax-terminal/NET/SwpTrmLib/Methods/essential/paymentasync
[paymentrequestresult]: /pax-terminal/NET/includes/paymentrequestresult
