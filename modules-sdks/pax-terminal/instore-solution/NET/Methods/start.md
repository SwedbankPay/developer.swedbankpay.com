---
title: Start Method
---
The Start method is initializes the created instance with, among other parameters, the very essential `POIID`.
The `POIID` is received from Swedbank Pay and is an identifier of the Point Of Interaction. Its value should stay the same at all time. Through this id the terminal knows what parameters to fetch from the TMS. This makes it easy to replace a terminal with another since it will retrieve the same parameters that were used by the replaced terminal.
With this call it is also decided whether to start a listener for terminal requests too, or if just running as a client. Leaving out the `SalesCapabilities` will use the default values and start a listener.

```c#
    PAX.Start(new SaleApplInfo()
    {
        ApplicationName = "Quick Demo",
        ProviderIdentification = "SwP",
        SoftwareVersion = "0.1",
        POIID = "AJACQH28",
        SaleCapabilities = SaleCapabilitiesEnum.PrinterReceipt.ToString() // Client only mode!
    });
```
