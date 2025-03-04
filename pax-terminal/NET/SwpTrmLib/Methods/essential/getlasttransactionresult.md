---
title: GetLastTransactionResult
permalink: /:path/getlasttransactionresult/
description: |
    GetLastTransactionResult / GetLastTransactionResultAsync is useful if the original payment or refund response is lost
menu_order: 80
---
### Signatures

*   void GetLastTransactionResult()

*   Task\<TransactionStatusResult\> GetLastTransactionResultAsync()

### Description

Requests a copy of the result for the last transaction, which is useful if the original result has been lost for some reason.

### Returns

A **TransactionStatusResult**

```c#
public class TransactionStatusResult : PaymentRequestResult
{
    public TransactionStatusResult();

    public TransactionResults TransactionResult { get; }
    public override string ResponseContent { get; set; }

    public enum TransactionResults
    {
        PaymentApproved = 0,
        RefundApporved = 1,
        PaymentRejected = 2,
        RefundRejected = 3,
        ReversalMade = 4,
        ReversalRejected = 5
    }
}
```

```c#
public class PaymentRequestResult : NexoRequestResult
{
    public JObject CustomerReceiptData { get; set; }
    public JObject MerchantReceiptData { get; set; }
    public string FormattedReceipt { get; set; }
    public string ReceiptBlob { get; set; }
    public JObject SettlementData { get; set; }
    public XElement OriginalTransaction { get; set; }
    public string UICulture { get; set; }
    public override string ResponseContent { get; set; }
}
```
