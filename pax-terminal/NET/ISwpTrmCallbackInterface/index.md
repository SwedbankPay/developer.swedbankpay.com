---
title: ISwpTrmCallbackInterface
---

The callbacks are used if running as a server or using the synchronous methods.
[Sample code running client only][clientonly].

## ConfirmationHandler

### void ConfirmationHandler(string text,IConfirmationResult callback);

This callback occurs only if when running as a server to receive requests from the terminal and happens when a transaction needs to be signed by the cardholder.

## EventNotificationHandler

### void EventNotificationHandler(NexoTypes.EventToNotifyEnumeration type, string text);

The EventNotificationHandler callback occurs when running as a server and the terminal sends an event notification such as card insterted, card removed or a message to the operator about updates and such.

### EventTiNotifyEnumeration

```c#

  public enum EventToNotifyEnumeration
  {
    BeginMaintenance, EndMaintenance, Shutdown, Initialised, OutOfOrder, Completed, Abort, SaleWakeUp, SaleAdmin, CustomerLanguage, KeyPressed,
    SecurityAlarm, StopAssistance, CardInserted, CardRemoved, Reject
  };

```

## SyncRequestResult

### void SyncRequestResult(object result)

This callback occurs when a synchronous method call has been used and that call has resulted in a response from the terminal.

e.g. A call to Payment() will eventually result in this callback method with `PaymentRequestResult` as the result parameter.

```c#
public void SyncRequestResult(object result)
{
    switch (Enum.Parse(typeof(RequestResultTypes), result.GetType().Name))
    {
        case RequestResultTypes.OpenResult:
          HandleOpenResult(result as OpenResult);
          break;
        case RequestResultTypes.PaymentRequestResult:
          HandlePaymentResult(result as PaymentRequestResult);
          break;
        case RequestResultTypes.CustomerConfirmationResult:
          HandleCustomerConfirmationResult(result as  CustomerConfirmationResult);
          break;
        case RequestResultTypes.ReversalRequestResult:
          HandleReversalResult(result as ReversalRequestResult);
          break;
          .
          .
          .
```

```c#
public enum RequestResultTypes
    {
        OpenResult = 0,
        PaymentRequestResult = 1,
        CustomerConfirmationResult = 2,
        GetPaymentInstrumentResult = 3,
        AbortRequestResult = 4,
        NexoResponseResult = 5,
        UpdateTerminalRequestResult = 6,
        ClearSnFRequestResult = 7,
        ReversalRequestResult = 8,
        TransactionStatusResult = 9,
        CustomerDigitStringResult = 10,
        NexoRequestResult = 11,
        PaymentInstrumentResult = 12
    }
```

[clientonly]: ../CodeExamples/#as-client-only
