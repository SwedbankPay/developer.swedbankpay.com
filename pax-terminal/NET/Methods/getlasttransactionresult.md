---
title: GetLastTransactionResult
description: |
    GetLastTransactionResult / GetLastTransactionResultAsync is useful if the original payment or refund response is lost
---
### Signatures

*   void GetLastTransactionResult()
*   Task\<TransactionStatusResult\> GetLastTransactionResultAsync()

### Returns

A **TransactionStatusResult**

*   `NexoResponseResult` - **ResponseResult**. `Success` or `Failure`
*   `string` **ResponseContent** - Complete response message from terminal.
*   `string` **ErrorCondition** - Valid if ResponseResult is failure
*   `string` **ResponseText** - Valid if ResponseResult is failure.
*   `JObject` [**CustomerReceiptData**][samplecustomerreceiptdata] - Raw JSON object with receiptinformation delivered from the terminal.
*   `JObject` **MerchantReceiptData** - Raw JSON object with receiptinformation delivered from the terminal.
*   `string` **FormattedReceipt** - An array of formatted receipt rows.
*   `string` [**ReceiptBlob**][samplereceiptblob] - A well formatted receipt to be printed.
*   `JObject` **SettlementData** - Obsolete
*   `XElement` **OriginalTransaction** - Used internally.
*   `string` **UICulture**
*   `decimal` **TipAmount** - Tip given by the customer
*   `string` **APMReference** - If alternatice payment, this is a reference to the transaction and is used when making a refund.
*   `string` **APMType** - If alternative payment, this is an indicater of which type of APM that was used.
*   `string` **ResponseContent** - The complete XML response message from the terminal.
*   `TransactionResults` **TransactionResult** - Transaction outcome.

```c#
public enum TransactionResults { 
            PaymentApproved, RefundApporved, PaymentRejected, RefundRejected, 
            ReversalMade, ReversalRejected 
        };
```

[samplecustomerreceiptdata]: ./paymentasync/#customerreceiptdata---json-object
[samplereceiptblob]: ./paymentasync/#receiptblob---fast-forward-to-well-formatted-receipt-information
