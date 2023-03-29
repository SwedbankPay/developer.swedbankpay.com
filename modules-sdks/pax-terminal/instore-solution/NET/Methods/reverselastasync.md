---
title: ReverseLastAsync
description: Task\<ReverseRequestResult\> ReverseLastAsync
---

ReverseLastAsync will reverse last transaction made if it was approved.

### Returns

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
