---
title: Start
permalink: /:path/start/
description: |
    The Start method initializes the created instance and starts a listener if desired and if not already started.
icon:
    content: flag
    outlined: true
menu_order: 15
---
### Method Signature

*   void Start(SaleApplInfo appinfo=null)

### Description

The Start method initializes the created instance with, among other parameters, the very essential `POIID`.
The `POIID` is decided together with Swedbank Pay and is an identifier of the Point Of Interaction. Its value should stay the same at all time. Through this id the terminal knows what parameters to fetch from the TMS. This makes it easy to replace a terminal with another since it will retrieve the same parameters that were used by the replaced terminal.
With this call it is also decided whether to start a listener for terminal requests too, or if just running as a client. Leaving out the `SalesCapabilities` will use the default values and start a listener.

If using more than one terminal methods Create and Start must be called for each instance. However, there will only be one listener started.

{% include alert.html type="informative" icon="info" header="Note"
body="If several terminals are used, there is only one listener and all terminals call the same port."
%}

```c#
    PAX.Start(new SaleApplInfo()
    {
        ApplicationName = "Quick Demo",
        ProviderIdentification = "SwP",
        SoftwareVersion = "0.1",
        POIID = "A-POIID",
        SaleCapabilities = SaleCapabilitiesEnum.PrinterReceipt.ToString() // Client only mode!
    });
```
