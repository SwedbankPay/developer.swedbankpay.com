---
title: Address of Terminal Sent To POS
permalink: /:path/auto-configure-ecr-2-terminal/
description: |
    Easier configuration of POS by picking up the terminal address from the configuration message sent from the terminal when pressing **Save** in terminal's admin menu.
menu_order: 15
---
When implementing the default mode where both the POS and the terminal are running as severs, there is a way to simplify the configuration. Since the POS system needs to know the address of the terminal and the terminal needs to know the address of the POS, it is possible to just add the address to POS in the terminal. When exiting the terminal's admin menu by pressing Save button, a configuration message is sent to the just entered POS address and port.

{:.code-view-header}
**TransmitRequest sent from terminal's Admin menu**

```xml
<SaleToPOIRequest>
  <MessageHeader MessageCategory="Transmit" MessageClass="Device" MessageType="Request" POIID="A-POIID" SaleID="" />
  <TransmitRequest DestinationAddress="127.0.0.1:15022" MaximumTransmitTime="30">
    <Message>ewogICAgInNhbGVUZXJtaW5hbGNvbmZpZ3VyYXRpb24iOiB7CiAgICAgICAgIm1lc3NhZ2VWZXJzaW9uIjogIjEuMC4wIiwKICAgICAgICAiaXBFbmRQb2ludCI6IHsKICAgICAgICAgICAgImlwVjRBZGRyZXNzIjogIjE5Mi4xNjguNzguMTUiLAogICAgICAgICAgICAiaXBQb3J0IjogIjExMDAwIgogICAgICAgIH0KICAgIH0KfQ==</Message>
  </TransmitRequest>
```

The DestinationAddress and port 15022 indicates it is a configuration message and really has nothing to do with any IP or port.

{:.code-view-header}
**The base64 decoded Message element with IP and port to the terminal**

```xml
<Message>{
    "saleTerminalconfiguration": {
        "messageVersion": "1.0.0",
        "ipEndPoint": {
            "ipV4Address": "192.168.78.15",
            "ipPort": "11000"
        }
    }
}</Message>
```

Pick up ipV4Address and ipPort and use it for connecting the terminal.

{%include alert.html type="informative" icon="info" header="DHCP"
body="If the terminal receives a new address a configuration message is sent automatically
to the configured ECR IP and Port. This works fine when using static IP for the POS and DHCP for the terminal."%}
