---
title: Abort
permalink: /:path/abortasync/
description: |
    This method will send an AbortRequest for the last issued request to the terminal.
icon:
    content: cancel
    outlined: true
menu_order: 75
---

### Signatures

*   void Abort()

*   async Task\<AbortRequestResult\> AbortAsync()

### Description

The Abort/AbortAsync method will send an AbortRequest for the last issued request to the terminal. The Abort message itself is not responded to by the terminal, but the actual request being aborted is.

{% include alert.html type="warning" icon="warning" header="warning"
body="The result from AbortAsync will always have the ResponseResult \"Failure\"."
%}

### Returns

A **AbortRequestResult**

```c#
    public class AbortRequestResult : NexoRequestResult
    {
        public AbortRequestResult();
    }
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

*   `string` ErrorCondition;
*   `string` ResponseContent;
*   `NexoResponseResult` ResponseResult;
*   `string` ResponseText;
