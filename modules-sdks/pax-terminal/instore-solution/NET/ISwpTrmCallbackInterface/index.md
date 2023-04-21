---
title: ISwpTrmCallbackInterface
---

The callbacks are only used if running as a server. However the Create method requires a ISwpTrmCallbackInterface, so only implement them without code if you are not running server mode.
[Sample code running client only][clientonly].

## ConfirmationHandler

    void ConfirmationHandler(string text,IConfirmationResult callback);

## EventNotificationHandler

    void EventNotificationHandler(NexoTypes.EventToNotifyEnumeration type, string text);

### EventTiNotifyEnumeration

```c#
  public enum EventToNotifyEnumeration
  {
    BeginMaintenance, EndMaintenance, Shutdown, Initialised, OutOfOrder, Completed, Abort, SaleWakeUp, SaleAdmin, CustomerLanguage, KeyPressed,
    SecurityAlarm, StopAssistance, CardInserted, CardRemoved, Reject
  };
```

[clientonly]: ../CodeExamples/index/#as-client-only
