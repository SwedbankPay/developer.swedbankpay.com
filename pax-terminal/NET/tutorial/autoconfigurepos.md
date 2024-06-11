---
title: Automatically Configure POS for Terminal
description: |
    Easier configuration of POS by picking up the terminal address from the configuration message 
permalink: /:path/autoconfigurepos/
icon:
    content: settings_suggest
    outlined: true
menu_order: 65
---
When implementing the default mode where both the POS and the terminal are running as severs, there is a way to simplify the configuration. Since the POS system needs to know the address of the terminal and the terminal needs to know the address of the POS, it is possible to just add the address to POS in the terminal. When exiting the terminal's admin menu by pressing Save button, a configuration message is sent to the just entered POS address and port. From the .Net SDK the `EventCallback` is called with event object `TerminalAddressObtainedEventCallback`.

{%include alert.html type="success" icon="lightbulb" body="Even if TerminalAddressObtainedEventCallback is not implemented, the SDK will pick up the address and use it, but it will not remember it."%}

{:.code-view-header}
**Picking up the configuration could look something like this**

```c#
    public class PaxImplementation : ISwpTrmCallbackInterface
    {
        private string terminalIPnPort;
        public string TerminalIPnPort { 
            get {return terminalIPnPort;}
            set {
                terminalIPnPort = value; 
                SaveConfiguration();
                }
            }
        
        public PaxImplementation()
        {
            ReadConfigration();

            PAX = PAXTrmImp_1.Create(
                new SwpIfConfig(),
                this);

            PAX.TerminalAddress = TerminalIPnPort;
        }

        public void EventCallback(EventCallbackObject eventObject)
        {
            switch (eventObject.type) 
            {
                .
                .
                .
                case EventCallbackTypes.TerminalAddressObtainedEventCallback: 
                    var ta = (TerminalAddressObtainedEventCallback)eventObject;
                    TerminalIPnPort = $"{ta.Ipv4}:{ta.Port}";
                    break;
            }
        }
    .
    .
    .
```

{%include alert.html type="informative" icon="info" header="DHCP"
body="If the terminal receives a new address a configuration message is sent automatically
to the configured ECR IP and Port. This works fine when using static IP for the POS and DHCP for the terminal."%}
