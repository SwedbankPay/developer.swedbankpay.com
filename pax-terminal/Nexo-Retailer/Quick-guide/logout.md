---
title: Logout
permalink: /:path/logout/
description: Logout is needed to let the terminal update its parameters
menu_order: 80
---
## LogoutRequest

Logout request terminates the login session and makes it possible for parameter or program updates. The POS system may no cannot communicate with the terminal unless new `LoginRequest` is accepted.
If a logout is needed during business hours but updates are not desired, there is an attribute `MaintenanceAllowed` that may be set False.

{% include alert.html type="warning" icon="warning" header="warning"
body= "Make sure to have the terminal logged out with maintenance allowed at least one hour every day, to let it update parameters and possibly software."
%}

```xml
<SaleToPOIRequest>
 <MessageHeader ProtocolVersion="3.1" MessageClass="Service" MessageCategory="Logout" MessageType="Request" ServiceID="21" SaleID="1" POIID="A-POIID"/>
 <LogoutRequest MaintenanceAllowed="true"/>
</SaleToPOIRequest>
```

## Logout Response

```xml
<SaleToPOIResponse>
 <MessageHeader MessageClass="Service" MessageCategory="Logout" MessageType="Response" ServiceID="21" SaleID="1" POIID="A-POIID"/>
 <LogoutResponse>
  <Response Result="Success"/>
 </LogoutResponse>
</SaleToPOIResponse>
```
