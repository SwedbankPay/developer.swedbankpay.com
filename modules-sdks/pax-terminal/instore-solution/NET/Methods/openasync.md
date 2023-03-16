---
title: OpenAsync Method
---

The OpenAsync call is the first method call that actually communicates with the terminal. It uses the information passed in the `SaleApplInfo` to the Start call. This starts a login session with the terminal.

{% include alert.html type="warning" icon="warning" header="Warning"
body= "Even if the Open is successful some action towards host will occur and possibly cause next method call to fail." 
%}
{% include alert.html type="informative" icon="info" header="Reset terminal state"
body= "A LoginRequest, that happens when calling OpenAsync, should reset states in the terminal."
%}

##Returns

OpenResult object.

```c#
public class OpenResult
    {
        public OpenResult();

        public ResponseResult Result { get; set; }
        public string Text { get; set; }
        public string SoftwareVersion { get; set; }
        public string SerialNumber { get; set; }
        public TerminalEnvironment Environment { get; set; }
    } 
```
