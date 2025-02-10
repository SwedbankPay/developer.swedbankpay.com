{:.code-view-header }
**Response**

```xml
<SaleToPOIResponse>
 <MessageHeader MessageClass="Service" MessageCategory="CardAcquisition" MessageType="Response" ServiceID="4" SaleID="1" POIID="A-POIID"/>
 <CardAcquisitionResponse>
  <Response Result="Success"/>
  <SaleData>
   <SaleTransactionID TransactionID="1212203" TimeStamp="2023-10-18T12:12:20+02:00"/>
  </SaleData>
  <POIData>
   <POITransactionID TransactionID="8778880092" TimeStamp="2023-10-18T10:12:26.625Z"/>
  </POIData>
  <PaymentInstrumentData PaymentInstrumentType="Card">
   <CardData PaymentBrand="01,Mastercard Debit" MaskedPAN="516815******9659" EntryMode="Contactless">
    <PaymentToken TokenRequestedType="Customer" TokenValue="6FD955C23A48A041D881003CDBF836DC59F89CE0ECA8288129696CDF9BB8B8DD67F233"/>
   </CardData>
  </PaymentInstrumentData>
  <LoyaltyAccount LoyaltyBrand="01,Mastercard Debit">
   <LoyaltyAccountID EntryMode="Contactless" IdentificationType="ISOTrack2" IdentificationSupport="LoyaltyCard"/>
  </LoyaltyAccount>
 </CardAcquisitionResponse>
</SaleToPOIResponse>
```

{:.table .table-striped}
| Name | Lev | Attribute | Description |
| :------------- | :---: | :-------------- |:--------------- |
| CardAcquisitionResponse | 1 | | |
| Response | 2 | Result | `Success` or `Failure`. |
| SaleData | 2 | | Echoed from request. |
| POIData | 2 | | |
| POITransactionID | 3 | TransactionID | ID of transaction set by the terminal. This is seen in PosPay reports as well as on Merchant Portal. The complete element is needed if the transaction needs to be reversed. |
| | | TimeStamp | Timestamp set by terminal when the transaction is started. Note that the format is UTC. |
| PaymentInstrumentData | 2 | PaymentInstrumentType | Values: `Card` for any transaction made by the terminal with a card or any consumer device. `Mobile` for an alternative payment instrument made via the terminal. |
| CardData | 3 | PaymentBrand | Comma separated string where the first part is card type. `01`-payment card. `02`-Combined payment and Loyalty, `03`-Loyalty, `04`-Neither. May be used instead of 03 for controlling the dialog in the terminal. Second part is the product name. |
| | | MaskedPAN | |
| | | EntryMode | `ICC`, `Contactless`, `Magstripe`. |
| PaymentToken | 4 | TokenRequestedType | `Customer`. |
| | | TokenValue | An irreversible 70 byte hash computed locally in the terminal. A specific card will get the same CNA in all SwedbankPay PAX terminals. |
| LoyaltyAccount | 2 | | Should only be present for card type 03. |
