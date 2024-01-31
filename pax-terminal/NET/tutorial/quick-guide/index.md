---
title: Quick Guide
description: Quick guide to get going from scratch making a transaction
permalink: /:path/
hide_from_sidebar: true
menu_order: 60
icon:
    content: play_circle
    outlined: true
---
## Create an instance of PAXTrmImp_1

PAXTrmImp_1 is the main class used and is created by calling the static method [create][create] which returns an interface, ISwpTrmIf_1, to the created instance. The create method requires a reference to an [`ISwpTrmCallbackInterface`][iswptrmcallbackinterface] which in this case is implemented in the PaxImplementation class.

{:.code-view-header}
**Simplest way of createing an instance using default values**

```c#
using SwpTrmLib;
using SwpTrmLib.Nexo;

// The PaxImplementation call implements the callback interface
public class PaxImplementation : ISwpTrmCallBackInterface
{
    public ISwpTrmIf_1 PAX = {get; internal set; } = null;
 
    // create an instance with default values
    void PaxImplementation() 
    {
        PAX = PAXTrmImp_1.Create(
            new SwpIfConfig(),
            this);

    }
.
.
.

```

{%include alert.html type="warning" header="Important!" icon="warning"
body="Remember that EventCallback and PrintRequestEventCallback must be implemented together with the ConfirmationHandler. They are needed in case a transaction need signature approval." %}

## Closer look at SwpIfConfig

{:.code-view-header}
**A peek at SwpIfConfig and the defaults**

```c#
namespace SwpTrmLib
{
    public class SwpIfConfig
    {
        public string LogPath { get; set; } = ".\\";
        public int TerminalRxPort { get; set; } = 11000;
        public LogLevel LogLevel { get; set; } = LogLevel.Debug;
        public string UICulture { get; set; } = CultureInfo.CurrentCulture.Name;
        public bool DraftCapture { get; set; } = false;
        public bool LogTerminalHandler { get; set; } = false;
    }
}
```

{% include iterator.html next_href="/pax-terminal/NET/tutorial/quick-guide/start" next_title="Next" %}
{%include iterator.html prev_href="/pax-terminal/NET/tutorial/" prev_title="Back"%}

[create]: /pax-terminal/NET/SwpTrmLib/Methods/essential/create
[iswptrmcallbackinterface]: /pax-terminal/NET/SwpTrmLib/ISwpTrmCallbackInterface/
