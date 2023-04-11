---
section: Events
redirect_from: /modules-sdks/pax-terminal/instore-solution/NET/Events
title: Events of ISwpTrmIf_1
permalink: /:path/
description: Events are mainly when the terminal sends request to the sale system. 
---

## OnTerminalDisplay

OnTerminalDisplay occurs when the terminal sends a display request to the sale system. The event is only relevant if running as a server.
DisplayRequest are simply the a message indicating what is showing in the terminal display with purpose of helping the oparator to understand what is happening.

`delegate void TerminalDisplayEventHandler(string message)`

## OnNewStatus

OnNewStatus occurs when status changes according to **TrmStatus** shown below or if a **CardInsterted** or **CardRemoved** event notification is sent from terminal. When using Async calls these statuses are not really needed.
Event notifications from terminal is only relevant if running as a server.

`delegate void NewStatusEventHandler(**TrmStatus** status)`

```c#
enum TrmStatus { Initialized, Open, WaitForPaymentInstrument, CustomerKnown, PaymentStarted, CardInserted, CardRemoved, Closed };
```

## OnTerminalAddressObtained

OnTerminalAddressObtained occurs when the save button has been pressed in the terminals's admin menu. The purpose is to inform the sale system of the terminal's IP address and port. This way it is possible to configure the address to the terminal without logging in to the sale system.
The event is only relevant when runnign as a server.

`delegate void TerminalAddressEventHandler(string ip4, int port)`
