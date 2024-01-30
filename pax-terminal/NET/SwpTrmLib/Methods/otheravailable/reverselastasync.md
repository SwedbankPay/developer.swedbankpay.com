---
title: ReverseLast
permalink: /:path/reversalastasync/
description: |
    ReverseLast will reverse the last transaction made if it was approved.
icon:
    content: undo
    outlined: true
menu_order: 100
---
### Method Signatures

*   void ReversLast()

*   Task\<ReversalRequestResult\> ReverseLastAsync()

### Description

ReverseLast / ReverseLastAsync will reverse the last transaction made if it was approved.

### Returns

A **ReversalRequestResult**

```c#
public class NexoRequestResult
{
    public virtual string ResponseContent { get; set; }
    public NexoResponseResult ResponseResult { get; set; }
    public string ErrorCondition { get; set; }
    public string ResponseText { get; set; }
}
public class ReversalRequestResult : NexoRequestResult
{
    public JObject CustomerReceiptData { get; set; }
    public string FormattedReceipt { get; set; }
    public string ReceiptBlob { get; set; }
    public override string ResponseContent { get; set; }
}
```
