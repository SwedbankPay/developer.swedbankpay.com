---
title: Loyalty The Easy Way
permalink: /:path/simple-loyalty/
description: The simplest form of loyalty implementation using CNA from PaymentResponse
icon:
  content: card_membership
  outlined: true
menu_order: 20
---

## CNA - Card Number Alias

The PAX terminal has a key for generating a one-way hash for the used PAN. The same PAN will give the same generated hash in all terminals and is therefore an easy way to use in a loyalty solution. This way of implementation will only collect "points" and discounts will be received elsewhere. The token is obtained by requesting it in the payment request in the `SaleData` element.

```xml
<SaleData TokenRequestedType="Customer">
```

[See payment request for detailed information][payment-request]

The generated token is rececived in the payment response and with that you may store information in a loyalty solution.

{% include alert.html type="warning" icon="warning" header="Heads up! " body="The token is generated locally in the terminal and if the customer is using phone or any IoT wearable or is using the physical card, there will be three different tokens."  %}

{% include alert.html type="informative" icon="info" header="Note" body="Allow more than one token as a reference to a customer. Later the centrally generated PAR token will be available and to have possibly more than one token makes a smooth transition"%}

## PaymentResponse

The following shows a payment response with a 70-byte long token

{% include pax-payment-response.md %}

[payment-request]: /pax-terminal/Nexo-Retailer/Quick-guide/make-payment
