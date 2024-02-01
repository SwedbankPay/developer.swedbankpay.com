---
title: UpdateTerminal
permalink: /:path/updateterminalasync/
description: |
    The UpdateTerminalAsync method sends a status report to TMS to trigger possible program or parameter fetching    
icon:
   content: update
   outlined: true
---
### Method Signatures

*   void UpdateTerminal()

*   Task\<UpdateTerminalRequestResult\> UpdateTerminalAsync()

### Description

The UpdateTerminalAsync method sends a status report to TMS to trigger possible program or parameter update.
The call should be made during a login session (after open and before close), but in order to actually change parameters `Close` must be called.

If default mode is used there will be an `EventNotification` indicating maintenance required. Then `Close` should be called to let the terminal update its parameters.
If client only mode is used calling UpdateTerminal and then Close, even though the `EventNotification` will not occur, is a good idea.

This is not a high priority function to implement. The same thing may be achieved by booting and a call to Open.

### Returns

An **UpdateTerminalRequestResult**

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
