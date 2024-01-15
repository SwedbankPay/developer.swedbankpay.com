---
title: Start
description: Start is the first function to call after Create.
permalink: /:path/start
menu_order: 10
---

### Start

The start method initializes the PAXTrmImp_1 instance and starts the listener if **default mode** is desired. Whether default mode or client only mode is chosen depends on the `SaleCapabilities` string in the `SaleApplInfo` object. If default is desired the correct string is already there. For **client only mode** the SaleCapabilities string must only contain `SaleCapabilities.PrinterReceipt`.

```c#
    class PaxImplementation : ISwpTrmCallbackInterface
    {
        public ISwpTrmIf_1 PAX = {get; internal set; } = null;
        public bool ClientOnly {get; set} = false;
        .
        .
        .

            SaleApplInfo si = new SaleApplInfo() { 
                // provider identification is company or brand name
                ProviderIdentification = "The best",
                SoftwareVersion = "1.0",
                ApplicationName = "A Demo",
                POIID = POIID,
            };

            // If ClientOnly is desired, overwrite the default SaleCapabilities
            if (ClientOnly) {
                si.SaleCapabilities = SaleCapabilitiesEnum.PrinterReceipt.ToString();
            }

            // Initialize and start listener unless ClientOnly
            PAX.Start(si);
    .
    .
    .

```

### Closer look at SaleApplInfo

{:.code-view-header}
**The only default value in SaleApplInfo is SaleCapabilities for default integration**

```c#
namespace SwpTrmLib
{
    //
    // Summary:
    //     SaleApplInfo is information used in the LoginRequest towards the terminal.
    public class SaleApplInfo
    {
        private string saleCapabilities;
        public string ProviderIdentification { get; set; }
        public string ApplicationName { get; set; }
        public string SoftwareVersion { get; set; }
        public string POIID { get; set; }
        //
        // Summary:
        //     Default SaleCapabilities will implement and start a listener on configured port.
        //     To use Client Only Mode use onlye value PrinterReceipt.
        public string SaleCapabilities
        {
            get
            {
                return (saleCapabilities != null) ? saleCapabilities : ($"{SaleCapabilitiesEnum.CashierStatus} {SaleCapabilitiesEnum.CashierError} {SaleCapabilitiesEnum.CashierDisplay} " + $"{SaleCapabilitiesEnum.POIReplication} {SaleCapabilitiesEnum.CustomerAssistance} {SaleCapabilitiesEnum.CashierInput} {SaleCapabilitiesEnum.CustomerDisplay} " + $"{SaleCapabilitiesEnum.PrinterReceipt} {SaleCapabilitiesEnum.CustomerError}");
            }
            set
            {
                saleCapabilities = value;
            }
        }
        public SaleTerminalEnvironment SaleTerminalEnvironment { get; set; }
    }
}
```

{% include iterator.html next_href="/pax-terminal/NET/tutorial/Quick-guide/open" next_title="Next" %}
{% include iterator.html prev_href="/pax-terminal/NET/tutorial/Quick-guide/" prev_title="Back" %}
