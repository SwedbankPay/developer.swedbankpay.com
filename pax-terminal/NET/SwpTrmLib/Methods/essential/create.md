---
title: Create
permalink: /:path/create/
description: |
    Create is a static method that creates an instance and returns an **ISwpTrmIf_1** interface
menu_order: 1
---
### Method Signature

*   ISwpTrmIf_1 Create(SwpIfConfig)

### Description

Create is a static method that creates an instance and returns an `ISwpTrmIf_1` interface.
This is the first call to make. At the moment there is only one class available, PAXTrmImp_1. If more than one terminal will be used create one instance per terminal.

### Parameters

*   [SwpIfConfig][swpifconfig] - instance of a config object.
*   [ISwpTrmCallbackInterface][iswptrmcallbackinterface] - reference to an instance that handles available callbacks.

### Returns

A reference to an instance implementing the `ISwpTrmIf_1` interface.

### Example

{:.code-view-header}
Create an instance to get an interface

```c#
using SwpTrmLib;

public class MyImplementation : ISwpTrmCallbackInterface
{
 ISwPTrmIf_1 Pax;

 public MyInit()
 {
    Pax = PAXTrmImp_1.Create(
    new SwpIfConfig()
    {
        LogPath = @"C:\myLogPath"
    },
    this );
 }

 // ConfirmationHandler is used when the terminal asks the operator for
 // a confirmation. Eg. signature sales (rarely used).
 // Requires the implementation to run as a server.
 void ConfirmationHandler(string text, IConfirmationResult callback)
 {}
 // EventNotificationHandler occurs for some events that may be useful to
 // act upon
 // Requires the implementation to run as a server.
 void EventNotificationHandler(EventToNotifyEnumeration type, string text)
 {}
 // SyncRequestResult is called when a synchronous method has been called and
 // the terminal has responded.
 void SyncRequestResult(object result)
 {}
}
```

## SwpIfConfig

SwpIfConfig is only used when calling the Create method. There are default values and the most relevant to change is possibly LogPath and TerminalRxPort. TerminalRxPort is only used in server mode.
The `DraftCapture` implies other changes that are not documented here as well, and should therefore be left as is.

```c#
public class SwpIfConfig
{
    public string LogPath { get; set; } = ".\\";
    public int TerminalRxPort { get; set; } = 11000;
    public NLog.LogLevel LogLevel { get; set; } = NLog.LogLevel.Debug;
    public string UICulture { get; set; } = CultureInfo.CurrentCulture.Name;
    public bool DraftCapture { get; set; } = false;
    public bool LogTerminalHandler { get; set; } = false;
}
```

[swpifconfig]: #swpifconfig
[iswptrmcallbackinterface]: /pax-terminal/NET/SwpTrmLib/ISwpTrmCallbackInterface
