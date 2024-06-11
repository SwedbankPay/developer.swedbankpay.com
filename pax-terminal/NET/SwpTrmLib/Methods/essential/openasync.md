---
title: Open
permalink: /:path/openasync/
description: |
    This is the first method call that actually communicates with the terminal. It sends a LoginRequest which is needed before any other request.
icon:
    content: lock_open
    outlined: true
menu_order: 20
---
### Method Signatures

*   void Open(string POIID=null)
*   void OpenEx(string POIID=null, string OperatorID=null, string ShiftNumber=null)

*   async Task\<OpenResult\> OpenAsync(string POIID=null)
*   async Task\<OpenResult\> OpenExAsync(string POIID=null, string OperatorID=null, string ShiftNumber=null)

### Description

The Open/OpenAsync call is the first method call that actually communicates with the terminal. It uses the information passed in the `SaleApplInfo` to the Start call. This starts a login session with the terminal.

{% include alert.html type="warning" icon="warning" header="Warning"
body= "Even if the Open is successful, some action towards the host will occur and possibly cause the next method call to fail."
%}
{% include alert.html type="informative" icon="info" header="Reset terminal state"
body= "A LoginRequest that happens when calling any of the open functions, should reset states in the terminal. A login session lasts until next open, close or reboot."
%}
{% include alert.html type="informative" icon="info" header="POIID cannot change during login session"
body= "To change POIID for a terminal a Logout or terminal reboot needs to be performed"
%}

### Returns

An **OpenResult** object.

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

```c#
    public enum ResponseResult { Success, Failure };
```
