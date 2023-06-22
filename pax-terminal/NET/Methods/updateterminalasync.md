---
title: UpdateTerminalAsync
description: Task\<UpdateTerminalRequestResult\> UpdateTerminalAsync()
---

The UpdateTerminalAsync method sends a status report to TMS to trigger possible program or parameter fetching.
The call should be made during a login session (after open and before close), but in order to actually change parameters Close must be called.

This is not a high priority function to implement. The same thing may be achieved by booting and a call to Open.

### Returns

A **UpdateTerminalRequestResult** -

```c#
    public class UpdateTerminalRequestResult : NexoRequestResult;
```

```c#
    public class NexoRequestResult
    {
        public string ResponseContent
        public NexoResponseResult ResponseResult { get; set; }
        public string ErrorCondition { get; set; }
        public string ResponseText { get; set; }
    };
```
