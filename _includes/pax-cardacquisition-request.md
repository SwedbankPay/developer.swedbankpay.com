{:.code-view-header }
**Request**

```xml
<SaleToPOIRequest>
 <MessageHeader ProtocolVersion="3.1" MessageClass="Service" MessageCategory="CardAcquisition" MessageType="Request" ServiceID="4" SaleID="1" POIID="A-POIID"/>
 <CardAcquisitionRequest>
  <SaleData TokenRequestedType="Customer">
   <SaleTransactionID TransactionID="1212203" TimeStamp="2023-10-18T12:12:20+02:00"/>
  </SaleData>
  <CardAcquisitionTransaction PaymentType="Normal" TotalAmount="0"/>
 </CardAcquisitionRequest>
</SaleToPOIRequest>
```

{:.table .table-striped}
| Name | Lev | Attribute | Description |
| :------------- | :---: | :-------------- |:--------------- |
| CardAcquisitionRequest | 1 | | |
| SaleData | 2 | TokenRequestedType | `Customer` only value available and will generate a CNA. |
| SaleTransactionID | 3 | TransactionID |ID of transaction provided by the sale system and may be seen in PosPay reports. Information will not be past to clearing and is not seen in Merchant Portal. |
|   | | TimeStamp | Request timestamp local time with offset from GMT. |
| CardAcquisitionTransaction | 2 | PaymentType | `Normal`-purchase or `Refund`. |
| | | TotalAmount | Normally set to zero. A value may affect behavior for a contactless card. |
