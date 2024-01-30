---
title: APM Refund
description: APM Refund works almost like a card refund.
permalink: /:path/apm-refund/
hide_from_sidebar: true
icon:
  content: credit_card_off
  outlined: true
menu_order: 80
---
The APM refund is almost like a card refund. When calling Refund/RefundAsync the APM-reference need to be supplied. The reference is received in the PaymentRequestResult as APMReference.

The Refund may be on partial amount and the same reference is used if several refunds as long as the total amount of the referenced transaction is above 0.

{:.code-view-header}
Refund of APMTransaction with reference from APM transaction result

```c#
  ISwpTrmIf_1 Pax;
  .
  .
  .
  public async Task MakePayment(decimal Amount)
  {
      var result = await Pax.PaymentAsync(Amount);
      if (result.ResponseResult == NexoResponseResult.Success) 
      {
        if (!String.IsNullOrEmpty(result.APMReference)) 
        {
          // this is an APM transaction, save reference in case of refund.
          SaveApmReferenceForRefund(result.APMReference);
          string type = result.APMType;
        }
        .
        .
        .
      }
      PrintReceipt(result.ReceiptBlob);
  }
  public async Task MakeRefund(decimal Amount, string apmReference)
  {
    var result = await Pax.RefundAsync(Amount, apmReference)
    if (result.ResponseResult == NexoRequestResult.Success) {
      . // refund was successful
      .
      .
    }
    else {
      .
      .
      .
    }
    PrintReceipt(result.ReceiptBlob);
  }
```
