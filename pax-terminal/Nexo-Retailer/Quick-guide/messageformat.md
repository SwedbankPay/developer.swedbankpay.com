---
title: Message Format
menu_order: 10
---
### Message Format

All messages are wrapped in either `SaleToPOIRequest` or `SaleToPOIResponse`.
Each of thoose contain two major elements. A `MessageHeader` and the element carrying the actual request or response.

### Message Header

All messages have a `MessageHeader` element with the following attributes:

{:.table .table-striped .mb-5}
| Attributes | Description |
| :------------- | :-------------- |
|   ProtocolVersion | Text string "3.1"  |
|   MessageClass | Enumeration: `Service`, `Device` or `Event`           |
|   MessageCategory | Enumeration: `Event`, `Login`, `Logout`, `Payment`, `Abort`, `EnableService`, `CardAcquisition`, `TransactionStatus`,`Reversal`, `Input`, `Display`, `Admin` |
|   MessageType | Enumeration: `Request`, `Response` or `Notification`  |
|   ServiceID   |  Unique per terminal for each `Service` message within a login session and identifies the request response message pair. Echoed back in the response. Make it simple. Use hours, minute and second for the Login and then increment by one for each message.  |
|   DeviceID    |  Unique per terminal for each `Device` message within a login session and identifies the request response message pair. Echoed back in the response |
|   POIID   | A unique ID of the Point of Interaction within an organization, that is known and registered in TMS. This id decides the configuration of the terminal. Prefere to use the same id as for the actual POS. This is decided by the POS and makes sure the correct configuration is used by the terminal. The POIID is also used in communication with the supporting staff.|
|   SaleID  | An ID of less interest but should be the same through out a login session  |

Concatenate the `MessageCategory` with the `MessageType` to find the actual message element. The following has `Login` and `Response` and the essential element is `LoginResponse`.

{:.code-view-header}
**Sample message LoginResponse**

```xml
<?xml version='1.0' encoding='UTF-8'?>
<SaleToPOIResponse>
 <MessageHeader ProtocolVersion="3.1" MessageClass="Service" MessageCategory="Login" MessageType="Response" ServiceID="533" SaleID="1" POIID="A-POIID"/>
 <LoginResponse>
  <Response Result="Success"/>
  <POISystemData>
   <DateTime>2023-09-06T07:48:52.02Z</DateTime>
   <POISoftware ProviderIdentification="Optomany" ApplicationName="axept® PRO" SoftwareVersion="1.2.17.0"/>
   <POITerminalData TerminalEnvironment="Attended" POISerialNumber="1710000520">
    <POICapabilities>CustomerDisplay CustomerError CustomerInput MagStripe ICC EMVContactless</POICapabilities>
   </POITerminalData>
   <POIStatus GlobalStatus="OK" SecurityOKFlag="true" PEDOKFlag="true" CardReaderOKFlag="true" CommunicationOKFlag="true"/>
  </POISystemData>
 </LoginResponse>
</SaleToPOIResponse>
```

### Message Responses

All Nexo message responses carry a `Response` element with the attribute `Result` which contain the value `Success` or `Failure`.
If **Failure**, the the Response element will also have the attribute `ErrorCondition` and a child element, `AdditionalResponse` with a somewhat describing text of the failure.

{:.code-view-header}
**Sample message response with Failure**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SaleToPOIResponse>
    <MessageHeader ProtocolVersion="3.1" MessageClass="Service" MessageCategory="Login" MessageType="Response" ServiceID="2" SaleID="1" POIID="SthlmBA"/>
    <LoginResponse>
        <Response Result="Failure" ErrorCondition="Busy">
            <AdditionalResponse>POI Terminal Temporarily Unavailable: New Poi ID detected, updating parameters</AdditionalResponse>
        </Response>
    </LoginResponse>
</SaleToPOIResponse>
```

## Consideration when implementing a listener

Some messages optionally require a response. E.g a display request from the terminal has a `ResponseRequired` boolean flag, a `PrintRequest` has a `ResponseMode` attribute and there may be other messages as well. Make sure to consider those values from the beginning so that the implementation stays robust even if the value may change in the future.

{% include iterator.html next_href="messagetransportation" next_title="Next" %}
