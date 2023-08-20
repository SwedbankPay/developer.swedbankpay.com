---
title: Abort
description: |
    The Abort/AbortAsync method will send an AbortRequest for the last issued request to the terminal.
---
### Method Signatures

#### void Abort()

#### async Task\<AbortRequestResult\> AbortAsync()

### Description

The Abort/AbortAsync method will send an AbortRequest for the last issued request to the terminal. The Abort message itself is not responded to by the terminal, but the actual request being aborted is.

{% include alert.html type="warning" icon="warning" header="warning"
body="The result from AbortAsync will always have the ResponseResult \"Failure\"."
%}

### Returns

AbortRequestResult

*   `string` ErrorCondition;
*   `string` ResponseContent;
*   `NexoResponseResult` ResponseResult;
*   `string` ResponseText;
