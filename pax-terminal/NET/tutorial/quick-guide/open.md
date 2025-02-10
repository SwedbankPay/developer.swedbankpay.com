---
title: Open
description: |
 Open is the first function that actually communicates with the terminal. 
 It sends a LoginRequest which is needed before sending any other message.
permalink: /:path/open/
hide_from_sidebar: true
menu_order: 20
---

### Open

The [Open][open] function have two variants and may be called asynchonously or synchronously. Both variants result in an `OpenResult` but for the synchronous it is returned in the `SyncRequestResult` callback. The POIID in the login is essential and will decide whether the terminal needs the parameters or software. A POIID was supplied in the call to Start in a `SaleApplInfo` object, but may be changed when calling Open.

Before call to Open make sure to provide the ip address and port of the terminal.

{:.code-view-header}
**Simple asynchronous Open call**

```c#

    class PaxImplementation : ISwpTrmCallbackInterface
    {
        public ISwpTrmIf_1 PAX = {get; internal set; } = null;
        public string Poiid = string.Empty;
        public string TerminalAddressAndPort {get; set; } // <ip>:<port>
        .
        .
        .
        public async Task OpenTerminalForUse()
        {
            if (TerminalAddressAndPort != string.Empty && PAX != null)
            {
                PAX.TerminalAddress = TerminalAddressAndPort;
                OpenResult result = await PAX.OpenAsync();
                if (result.Result == ResponseResult.Success)
                {
                    // A login session with the terminal has now been established
                    // and the terminal may be used. Serialnumber prefix may be 
                    // used to identify what type of terminal 171=A30/229=A35/185=A920
                    // 
                    
                }
                else
                {
                    // Login failed. 
                }
            }
        }
```

{:.code-view-header}
**Same simple functionality using synchronous Open call**

```c#
    class PaxImplementation : ISwpTrmCallbackInterface
    {
        public ISwpTrmIf_1 PAX = {get; internal set; } = null;
        public string TerminalAddressAndPort {get; set; } // <ip>:<port>
        .
        .
        .
        public void OpenTerminalForUse()
        {
            if (TerminalAddressAndPort != string.Empty && PAX != null)
            {
                PAX.TerminalAddress = TerminalAddressAndPort;
                PAX.Open();
            }
        }

        // Results for the synchronous calls are obtained here.
        public void SyncRequestResult(object result)
        {
            switch (Enum.Parse(typeof(RequestResultTypes), result.GetType().Name))
            {
                case RequestResultTypes.OpenResult:
                    OpenResult openresult = result as OpenResult;
                    if (openresult.Success) 
                    {
                    // Now a login session with the terminal is established and the terminal may be used.
                    // Serialnumber prefix may be used to identify what type of terminal 171=A30/229=A35/185=A920
                    }
                    else
                    {
                    // Login failed. 
                    }
                break;
            }
        }
```

{%include iterator.html next_href="/pax-terminal/NET/tutorial/quick-guide/payment" next_title="Next"%}
{%include iterator.html prev_href="/pax-terminal/NET/tutorial/quick-guide/start" prev_title="Back"%}

[open]: /pax-terminal/NET/SwpTrmLib/Methods/essential/openasync
