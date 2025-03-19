---
title: Include Purchase Order Number
description: |
 A Purchase Order Number may be included in the PaymentRequest and will be forwarded to the aquirer host.
permalink: /:path/submit-purchse-order-number/
menu_order: 65
---
There is a possibility to forward information to the host by using the `SaleToAquirerData` of `PaymentRequest` - `SaleData`. The data must be a JSON object that is Base64 encoded.

{:.code-view-header}

Eg. PurchaseRequest with purchase order in SaleToAquirerData

```xml
<SaleToPOIRequest>
 <MessageHeader ProtocolVersion="3.1" MessageClass="Service" MessageCategory="Payment" MessageType="Request" ServiceID="5" SaleID="1"       POIID="A-POIID"/>
 <PaymentRequest>
  <SaleData TokenRequestedType="Customer">
   <SaleTransactionID TransactionID="202402060950219170" TimeStamp="2024-02-06T09:50:21+01:00"/>
   <SaleToAcquirerData>ewogICAgInB1cmNoYXNlT3JkZXJOdW1iZXIiOiAiMTIzNDU2Nzg5Igp9</SaleToAcquirerData>
  </SaleData>
  <PaymentTransaction>
   <AmountsReq RequestedAmount="60" CashBackAmount="0" Currency="SEK"/>
  </PaymentTransaction>
 </PaymentRequest>
</SaleToPOIRequest>
```

{:.code-view-header}
Eg. SaleToAquirerData Base64 decoded JSON

```xml
<SaleToAcquirerData>{
    "purchaseOrderNumber": "123456789"
    }</SaleToAcquirerData>
```
