---
title: Refund
permalink: /:path/refundasync/
description: |
    The Refund method sends a PaymentRequest for refund and should be called when the amount is known.
icon:
    content: credit_card
    outlined: true
menu_order: 70
---
### Method Signatures

Synchronous

*   void Refund(decimal amount,string apmreference="", string currency="")
*   void Refund(`TransactionSetup` setup)

Asynchronous

*   async Task\<PaymentRequestResult\> RefundAsync(decimal amount,string apmreference="", string currency="SEK")
*   async Task\<PaymentRequestResult\> RefundAsync(`TransactionSetup` setup)

### Description

The Refund / RefundAsync should be called when the amount is known. It opens all available readers and waits for a payment instrument. If Alternative Payment Methods are activated it will open for that too.

### Parameters

{:.table .table-striped}
|:-------- |:-------------- |:--------------- |
| decimal |**amount**|Amount to refund.|
| string |**apmreference**|A reference if the transaction was made using APM. When this reference is not null, APM is assumed.|
| string |**currency**|Currency code as a string representing ISO-4217 3 letter code. Has to be available in the terminal setup. The default is the currency of the UICulture specified in call to [`Create`][create] method".
| or | |
|[TransactionSetup][transactionsetup]|**setup**| Object holding several parameters to be used for transaction. Default values for all members. Only populate what is relevant.|

{:.code-view-header}
**Example calling async function with a TransactionSetup object as parameter**

```c#
  var r = await Pax?.RefundAsync(new TransactionSetup() { 
    Amount = total,
    TransactionID = IdForThisTransaction
    });
  if (r.ResponseResult == NexoResponseResult.Success) 
    { textBox1.AppendText("Approved" + Environment.NewLine); }
  else { textBox1.AppendText("Not Approved" + Environment.NewLine); }
```

### Returns

A **PaymentRequestResult** - [Detailed description][paymentrequestresult]

A `PayementRequestResult.ResponseResult` of value `Success` means transaction approved.
If `ResponseResult` is `Failure` there is an `ErrorCondition`. If `ErrorCondition` is `Busy` wait awhile and try again.

{% include alert.html type="informative" icon="info" header="Note"
body="The SDK will automatically make three retries when the terminal responds busy."
%}

[transactionsetup]: /pax-terminal/NET/includes/transactionsetup
[paymentrequestresult]: /pax-terminal/NET/includes/paymentrequestresult
[create]: /pax-terminal/NET/SwpTrmLib/Methods/essential/create
