---
title: Create Method
---

## Create

Create is a static method that creates an instance and returns an `ISwpTrmIf` interface.
This is the first call to make. At the moment there is only one class available, PAXTrmImp_1.

## Parameters

* SwpIfConfig - instance of a config object.
* ISwpTrmCallbackInterface - reference to an instance that handles available callbacks

## Returns

A reference to an instance implementing the `ISwpTrmIf` interface.

## Example

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
}
```
