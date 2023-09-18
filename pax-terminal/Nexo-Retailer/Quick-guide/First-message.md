---
title: First Message
description: The first message to be sent to the terminal is the LoginRequest
menu_order: 30
---
## LoginRequest

LoginRequest is the first message towards the terminal and is required in order to start communicating.
It carries information such as POIID and SalesCapabilites which decides what parameters to use and how the terminal will behave.

A LoginRequest starts a so called `Login Session` in the terminal. A `Login Session` is active until a successful Logout or a new Login is made. There should always be a possibility to reset the terminal's state by sending a new Login. However, that way should only be used if all else fails. The `AbortRequest` should be used for aborting an ongoing request.

{:.code-view-header}
**sample LoginRequest message**

```xml
<SaleToPOIRequest>
    <MessageHeader MessageCategory="Login" MessageClass="Service" MessageType="Request" POIID="A-POIID" ProtocolVersion="3.1" SaleID="1" ServiceID="130129"/>
    <LoginRequest OperatorLanguage="sv">
        <DateTime>2023-09-08T11:22:48.5306355+02:00</DateTime>
        <SaleSoftware ApplicationName="Demo" ProviderIdentification="Fantastic POS Systems" SoftwareVersion="1.0.rc-1"/>
        <SaleTerminalData TerminalEnvironment="Attended">
            <SaleCapabilities>PrinterReceipt CashierStatus CashierError CashierDisplay CashierInput</SaleCapabilities>
            <SaleProfile/>
        </SaleTerminalData>
    </LoginRequest>
</SaleToPOIRequest>
```

{:.table .table-striped}
| Name | Attributes | Description |
| :------------- | :-------------- |:--------------- |
| LoginRequest | OperatorLanguage |  Language used in the POS system. Supported: `sv`,`no`,`fi`,`da` |
| SaleSoftware |    | Important information for SwedbankPay to be able to get an understanding of how different setups work |
|   | ApplicationName | Name of the POS application or the module communicating with the terminal |
|   | ProviderIdentification | POS producer name |
|   | SoftwareVersion | Important that this value changes if the software is updated. This helps us to track possible problem if they occur. |
| SaleTerminalData | TerminalEnvironment | Only supported value is `Attended` |
| SaleCapabilities | | The values in this field affects the behaviour of the terminal. If only `PrinterReceipt` is included the terminal won't send any request to the POS system. Your application will work as a client-only. |

{% include iterator.html next_href="make-payment" next_title="Next" %}
