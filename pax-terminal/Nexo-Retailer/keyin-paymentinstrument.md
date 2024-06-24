---
title: Send Card Data
description: Possibility to send a non-PCI regulated "card number" to the terminal
permalink: /:path/keyin-paymentinstrument/
icon:
  content: keyboard
  outlined: true
menu_order: 80
---
## Manually Entered Card Data

There is a possibility to send card data for payment from the sale system to the terminal. This applies only to non PCI regulated cards and the prefix of the card must be set up correctly in the parameters of the terminal. This is all done in the Terminal Management System. When that is in place it is just a matter of including the element `PaymentInstrumentData` in the `PaymentRequest`. Required attributes are `PaymentInstrumentType` set to `Card` and `EntryMode` set to `Keyed`.

Typical use for this is financing where where the cashier receives a reference to be entered.

{:.code-view-header}
**Eg. PaymentRequest with manually entered card data**

```xml
<SaleToPOIRequest>
 <MessageHeader MessageCategory="Payment" MessageClass="Service" MessageType="Request" POIID="A-POIID" ProtocolVersion="3.1" SaleID="ECR1" ServiceID="2656977967"/>
 <PaymentRequest>
  <SaleData TokenRequestedType="Customer">
   <SaleTransactionID TimeStamp="2023-12-20T14:38:34.7001923+01:00" TransactionID="2656977968"/>
  </SaleData>
  <PaymentTransaction>
   <AmountsReq CashBackAmount="0" Currency="SEK" RequestedAmount="100"/>
  </PaymentTransaction>
  <PaymentData PaymentType="Normal">
   <PaymentInstrumentData PaymentInstrumentType="Card">
    <CardData EntryMode="Keyed">
     <SensitiveCardData PAN="<a payment instrument reference>" ExpiryDate="2401"/>
    </CardData>
   </PaymentInstrumentData>
  </PaymentData>
 </PaymentRequest>
</SaleToPOIRequest>
```
