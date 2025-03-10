---
title: Make Payment Including Order Number
description: |
 A payment may include an order id that is forwarded to the acquirer host.
permalink: /:path/payment-with-orderid/
menu_order: 100
---
To include an order number in a payment the [TransactionSetup][transactionsetup] must be used. The following example shows how to make a payment for 120 SEK for order number 123456789.

```c#
using System.Text.Json;


class PaxImplementation : ISwpTrmCallbackInterface
{
    public ISwpTrmIf_1 Pax = {get; internal set; } = null;
  .
  .
  .

public async Task CreatePayment()
{
    var pr = await Pax.PaymentAsync(new TransactionSetup() {
        AcquirerData = JsonSerializer.Serialize(new { purchaseOrderNumber = "123456789"}),
        Amount = (decimal)120
    };
}
```

[transactionsetup]: /pax-terminal/NET/includes/transactionsetup
