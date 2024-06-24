---
title: Login
permalink: /:path/first-message/
description: The first message to be sent to the terminal is the LoginRequest
menu_order: 30
---
## LoginRequest

LoginRequest is the first message towards the terminal and is required in order to start communicating.
It carries information such as POIID and SalesCapabilites which decides what parameters to use and how the terminal will behave.

A LoginRequest starts a so called `Login Session` in the terminal. A `Login Session` is active until a successful Logout or a new Login is made. There should always be a possibility to reset the state of the terminal by sending a new Login. However, that way should only be used if all else fails. The `AbortRequest` should be used for aborting an ongoing request.

{:.code-view-header}
**sample LoginRequest message**

```xml
<SaleToPOIRequest>
 <MessageHeader ProtocolVersion="3.1" MessageClass="Service" MessageCategory="Login" MessageType="Request" ServiceID="5" SaleID="1" POIID="A-POIID"/>
 <LoginRequest OperatorLanguage="sv">
  <DateTime>2023-09-26T13:57:31+02:00</DateTime>
  <SaleSoftware ProviderIdentification="Demo" ApplicationName="Test SwpIf - SwpTrmLib.PAXTrmImp_1" SoftwareVersion="1.0 - 1.1.23264.1309"/>
  <SaleTerminalData TerminalEnvironment="Attended">
   <SaleCapabilities>CashierStatus CashierError CashierDisplay POIReplication CustomerAssistance CashierInput PrinterReceipt</SaleCapabilities>
   <SaleProfile GenericProfile="Extended">
    <ServiceProfiles>Loyalty PIN CardReader</ServiceProfiles>
   </SaleProfile>
  </SaleTerminalData>
 </LoginRequest>
</SaleToPOIRequest>
```

{:.table .table-striped}
| Name | Lev | Attribute | Description |
| :------------- | :---: | :-------------- |:--------------- |
| LoginRequest | 1 | OperatorLanguage |  Language used in the POS system. Supported: `sv`,`no`,`fi`,`da`. |
|   |   | OperatorID | This is not used as of now. |
| DateTime | 2 |  | Local time when request is made with time zone offset. |
| SaleSoftware | 3 |    | Important information for SwedbankPay to be able to get an understanding of how different setups work. |
|   | | ApplicationName | Name of the POS application or the module communicating with the terminal. |
|   | | ProviderIdentification | POS producer name. |
|   | | SoftwareVersion | Important that this value changes if the software is updated. This helps us to track possible problem if they occur. |
| SaleTerminalData | 2 | TerminalEnvironment | Only supported value is `Attended`. |
| SaleCapabilities | 3 |  | The values in this field affects the behavior of the terminal. If only `PrinterReceipt` is included the terminal won't send any request to the POS system. Your application will work as a client-only. |

## LoginResponse

Login response with result `Success` is needed before any other message may be sent to the terminal. A Login success indicates a login session has been established in the terminal. The next message may still get a `Failure` with ErrorCondition `Busy` which then means the terminal is busy communicating with its hosts. On busy, wait and try again.

```xml
<?xml version='1.0' encoding='UTF-8'?>
<SaleToPOIResponse>
 <MessageHeader ProtocolVersion="3.1" MessageClass="Service" MessageCategory="Login" MessageType="Response" ServiceID="5" SaleID="1" POIID="A-POIID"/>
 <LoginResponse>
  <Response Result="Success"/>
  <POISystemData>
   <DateTime>2023-09-26T11:57:31.408Z</DateTime>
   <POISoftware ProviderIdentification="Optomany" ApplicationName="axept® PRO" SoftwareVersion="1.2.17.0"/>
   <POITerminalData TerminalEnvironment="Attended" POISerialNumber="1710000520">
    <POICapabilities>CustomerDisplay CustomerError CustomerInput MagStripe ICC EMVContactless</POICapabilities>
   </POITerminalData>
   <POIStatus GlobalStatus="OK" SecurityOKFlag="true" PEDOKFlag="true" CardReaderOKFlag="true" CommunicationOKFlag="true"/>
  </POISystemData>
 </LoginResponse>
</SaleToPOIResponse>
```

{:.table .table-striped}
| Name | Lev | Attribute | Description |
| :------------- | :---: | :-------------- |:--------------- |
| LoginResponse | 1 | | |
| Response | 2 | Result | **Success** or **Failure** |
| | | ErrorCondition | Only present if Failure: Common values are `Busy`- wait and try again, `Refusal`- Request not accepted |
| AdditionalResponse| 3 | | Only present if Failure and should be a describing text |
| POISystemData | 2 |    | |
| DateTime  | 3 | ApplicationName | Name of the POS application or the module communicating with the terminal |
| POISoftware | 3 | ProviderIdentification | Payment application producer |
| POITerminalData | 3 | | |
| | | TerminalEnvironment | Only value `Attended` |
| | | POISerialNumber | Serial number of the terminal |
| POICapabilities | 4 | | Shows the capabilities of the terminal |
| POIStatus | 3 | | Different statuses |

{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/make-payment" next_title="Next" %}
