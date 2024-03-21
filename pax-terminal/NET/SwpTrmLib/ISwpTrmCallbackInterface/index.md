---
title: ISwpTrmCallbackInterface
permalink: /:path/
description: Two callbacks are a must to implement in order to pass tests for a signature verified transaction.
menu_order: 20
icon:
  content: reply
  outlined: true
---

The callbacks are mostly used if running as a server or using the synchronous methods. There are however two callbacks that always need to be implemented and are used when the customer need to sign the receipt. Those two are `ConfirmationHandler` and `EventCallback` for the `PrintRequestEventCallback`.

[Sample code running client only][clientonly].

```c#
  public interface ISwpTrmCallbackInterface
    {
        void ConfirmationHandler(string text, IConfirmationResult callback);
        void EventCallback(EventCallbackObject eventObject);
        void EventNotificationHandler(EventToNotifyEnumeration type, string text);
        void SyncRequestResult(object result);
    }
```

## ConfirmationHandler

### void ConfirmationHandler(string text,IConfirmationResult callback);

This callback **must** be implemented and occurs when a transaction receipt needs to be signed by the cardholder.

```c#
  public void ConfirmationHandler(string text, IConfirmationResult callback)
  {
    bool response = ShowMessageAndGetResponseFromOperator(text);
    callback->Confirmation(response);
  }
```

```c#
  public interface IConfirmationResult
  {
    void Confirmation(bool flag);
  }
```

## EventCallback

The EventCallback replaces the events that may be subscribed to from the ISwpTrmIf_1 interface. If there is a subcription to an event this callback will not be used for that event. The EventCallback is essential if using more than one terminal where each terminal has its own instance.

{%include alert.html header="A MUST" type="warning" body="The `PrintRequestEventCallback` must be implemented since it occurs for a transaction that needs customer signing."%}

### void EventCallback(EventCallbackObject eventObject)

```c#
  public void EventCallback(EventCallbackObject eventObject)
    {
        switch (eventObject.type)
        {
            case EventCallbackTypes.DisplayEventCallback:
                var d = eventObject as DisplayEventCallback ;
                break;
            case EventCallbackTypes.NewStatusEventCallback:
                var s = eventObject as NewStatusEventCallback;
                // Do something useful
                break;
            case EventCallbackTypes.PrintRequestEventCallback:
                var p = eventObject as PrintRequestEventCallback;
                // print receipt
                break;

        }
    } 
```

```c#
public enum EventCallbackTypes
    {
        DisplayEventCallback = 0,
        NewStatusEventCallback = 1,
        TerminalAddressObtainedEventCallback = 2,
        PrintRequestEventCallback = 3
    }
```

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

e.g. A call to Payment() will eventually result in this callback method with [`PaymentRequestResult`][paymentrequestresult] as the result parameter.

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

[clientonly]: /pax-terminal/NET/CodeExamples/#as-client-only
[paymentrequestresult]: /pax-terminal/NET/includes/paymentrequestresult
