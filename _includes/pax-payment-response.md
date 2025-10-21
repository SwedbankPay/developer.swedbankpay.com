{:.code-view-header }
**Sample Payment Response for approved payment with physical payment card**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SaleToPOIResponse>
 <MessageHeader MessageClass="Service" MessageCategory="Payment" MessageType="Response" ServiceID="3" SaleID="1" POIID="A-POIID"/>
 <PaymentResponse>
  <Response Result="Success"/>
  <SaleData>
   <SaleTransactionID TransactionID="1703372" TimeStamp="2023-08-24T17:03:37+02:00"/>
  </SaleData>
  <POIData>
   <POITransactionID TransactionID="8778880185" TimeStamp="2023-08-24T15:04:00.498Z"/>
  </POIData>
  <PaymentResult PaymentType="Normal">
   <PaymentInstrumentData PaymentInstrumentType="Card">
     <CardData PaymentBrand="01,Mastercard Debit" MaskedPAN="516815******9659" PaymentAccountRef="5c0e2bdfe30fb6e3d7dd1eee887de" EntryMode="Contactless">
       <PaymentToken TokenRequestedType="Customer" TokenValue="6FD9550491A5EA28850181E76297295740E2F3781A3FB9D0561343179D6AA3017A6CAB"/>
     </CardData>
    </PaymentInstrumentData>
   <AmountsResp Currency="SEK" AuthorizedAmount="56" CashBackAmount="0.00"/>
   <PaymentAcquirerData MerchantID="10020001" AcquirerPOIID="877888">
    <ApprovalCode>611506</ApprovalCode>
   </PaymentAcquirerData>
  </PaymentResult>
  <PaymentReceipt DocumentQualifier="CashierReceipt">
   <OutputContent OutputFormat="Text">
    <OutputText>eyJNZXJjaGFudCI6eyJNYW5kYXRvcnkiOnsiQWNxdWlyZXIiOnsiQ2FyZEFjY2VwdG9yTnVtYmVyIjoiMTAwMjAwMDEiLCJUZXJtaW5hbElEIjoiODc3ODg4In0sIkNhcmRBY2NlcHRvciI6eyJBZGRyZXNzMSI6IkjDpGxsZXNrw6VyYW4gMjkiLCJCYW5rQWdlbnROYW1lIjoiYmFua3ktYmFuayIsIk5hbWUiOiJUZXN0IHNob3AiLCJPcmdhbmlzYXRpb25OdW1iZXIiOiI1NTY1NjcxLTYxNjUiLCJQb3N0WmlwQ29kZSI6IjUwNTAiLCJUb3duQ2l0eSI6Im1lcmNoYW50LUJhc2UyNC1DaXR5In0sIkNhcmREZXRhaWxzIjp7IkFwcGxpY2F0aW9uSWRlbnRpZmllciI6IkEwMDAwMDAwMDQxMDEwIiwiQ2FyZFNjaGVtZU5hbWUiOnsiQXBwbGljYXRpb25MYWJlbCI6Ik1hc3RlcmNhcmQifSwiUHJpbWFyeUFjY291bnROdW1iZXIiOiI1MTY4MTUqKioqKio5NjU5IiwiVGVybWluYWxWZXJpZmljYXRpb25SZXN1bHQiOiIwMDAwMDA4MDAxIiwiVHJhbnNhY3Rpb25TdGF0dXNJbmZvcm1hdGlvbiI6IjAwMDAifSwiT3V0Y29tZSI6eyJBcHByb3ZhbENvZGUiOiI2MTE1MDYiLCJBdXRob3Jpc2F0aW9uUmVzcG9uZGVyIjoiMyIsIkF1dGhvcmlzYXRpb25SZXNwb25zZUNvZGUiOiIwMCIsIkRlYml0U3RhdHVzIjoiMDAifSwiUGF5bWVudCI6eyJBdXRob3Jpc2F0aW9uQ2hhbm5lbCI6IjEiLCJDYXJkaG9sZGVyVmVyaWZpY2F0aW9uTWV0aG9kIjoiLyIsIkN1cnJlbmN5IjoiU0VLIiwiRmluYW5jaWFsSW5zdGl0dXRpb24iOiJTV0UiLCJQYXltZW50QW1vdW50IjoiNTYsMDAiLCJSZWNlaXB0TnVtYmVyIjoiODc3ODg4MDE4NSIsIlNpZ25hdHVyZUJsb2NrIjpmYWxzZSwiVG90YWxBbW91bnQiOiI1NiwwMCIsIlRyYW5zYWN0aW9uU291cmNlIjoiSyIsIlRyYW5zYWN0aW9uVHlwZSI6IjAwIn0sIlRpbWVTdGFtcCI6eyJEYXRlT2ZQYXltZW50IjoiMjAyMy0wOC0yNCIsIlRpbWVPZlBheW1lbnQiOiIxNzowNiJ9fSwiT3B0aW9uYWwiOnsiQ2FyZEFjY2VwdG9yIjp7IkNvdW50cnlOYW1lIjoiNzUyIiwiUGhvbmVOdW1iZXIiOiIrNDY4NDA1MTAwMCJ9LCJDYXJkRGV0YWlscyI6eyJDYXJkU2NoZW1lTmFtZSI6eyJBcHBsaWNhdGlvbkxhYmVsIjoiTWFzdGVyY2FyZCJ9fSwiUGF5bWVudCI6eyJSZWZlcmVuY2UiOiIxNzAzMzcyIn0sIlJlY2VpcHRTdHJpbmciOlsiVGVzdCBzaG9wIiwiSMOkbGxlc2vDpXJhbiAyOSIsIjUwNTAgbWVyY2hhbnQtQmFzZTI0LUNpdHkiLCIyMDIzLTA4LTI0IDE3OjA2IiwiIiwiTWFzdGVyY2FyZCIsIkNvbnRhY3RsZXNzIiwiNTE2ODE1KioqKioqOTY1OSIsIiIsIksvMSAzIDAwIFNXRSIsIkFJRDogQTAwMDAwMDAwNDEwMTAiLCJUVlI6IDAwMDAwMDgwMDEiLCJUU0k6IDAwMDAiLCJSUk46IDg3Nzg4ODAxODUiLCJBdXRoIGNvZGU6IDYxMTUwNiIsIkFSQzogMDAiLCIiLCJLw5ZQOiAgICAgICAgIDU2LDAwIFNFSyIsIkdvZGvDpG5kIiwiIiwiIiwiIiwiRsO2cnPDpGxqYXJlbnMga3ZpdHRvIl19fX0=</OutputText>
   </OutputContent>
  </PaymentReceipt>
  <PaymentReceipt DocumentQualifier="CustomerReceipt">
   <OutputContent OutputFormat="Text">
    <OutputText>eyJDYXJkaG9sZGVyIjp7Ik1hbmRhdG9yeSI6eyJBY3F1aXJlciI6eyJDYXJkQWNjZXB0b3JOdW1iZXIiOiIxMDAyMDAwMSIsIlRlcm1pbmFsSUQiOiI4Nzc4ODgifSwiQ2FyZEFjY2VwdG9yIjp7IkFkZHJlc3MxIjoiSMOkbGxlc2vDpXJhbiAyOSIsIkJhbmtBZ2VudE5hbWUiOiJiYW5reS1iYW5rIiwiTmFtZSI6IlRlc3Qgc2hvcCIsIk9yZ2FuaXNhdGlvbk51bWJlciI6IjU1NjU2NzEtNjE2NSIsIlBvc3RaaXBDb2RlIjoiNTA1MCIsIlRvd25DaXR5IjoibWVyY2hhbnQtQmFzZTI0LUNpdHkifSwiQ2FyZERldGFpbHMiOnsiQXBwbGljYXRpb25JZGVudGlmaWVyIjoiQTAwMDAwMDAwNDEwMTAiLCJDYXJkU2NoZW1lTmFtZSI6eyJBcHBsaWNhdGlvbkxhYmVsIjoiTWFzdGVyY2FyZCJ9LCJQcmltYXJ5QWNjb3VudE51bWJlciI6IioqKioqKioqKioqKjk2NTkiLCJUZXJtaW5hbFZlcmlmaWNhdGlvblJlc3VsdCI6IjAwMDAwMDgwMDEiLCJUcmFuc2FjdGlvblN0YXR1c0luZm9ybWF0aW9uIjoiMDAwMCJ9LCJPdXRjb21lIjp7IkFwcHJvdmFsQ29kZSI6IjYxMTUwNiIsIkF1dGhvcmlzYXRpb25SZXNwb25kZXIiOiIzIiwiQXV0aG9yaXNhdGlvblJlc3BvbnNlQ29kZSI6IjAwIiwiRGViaXRTdGF0dXMiOiIwMCJ9LCJQYXltZW50Ijp7IkF1dGhvcmlzYXRpb25DaGFubmVsIjoiMSIsIkNhcmRob2xkZXJWZXJpZmljYXRpb25NZXRob2QiOiIvIiwiQ3VycmVuY3kiOiJTRUsiLCJGaW5hbmNpYWxJbnN0aXR1dGlvbiI6IlNXRSIsIlBheW1lbnRBbW91bnQiOiI1NiwwMCIsIlJlY2VpcHROdW1iZXIiOiI4Nzc4ODgwMTg1IiwiU2lnbmF0dXJlQmxvY2siOmZhbHNlLCJUb3RhbEFtb3VudCI6IjU2LDAwIiwiVHJhbnNhY3Rpb25Tb3VyY2UiOiJLIiwiVHJhbnNhY3Rpb25UeXBlIjoiMDAifSwiVGltZVN0YW1wIjp7IkRhdGVPZlBheW1lbnQiOiIyMDIzLTA4LTI0IiwiVGltZU9mUGF5bWVudCI6IjE3OjA2In19LCJPcHRpb25hbCI6eyJDYXJkQWNjZXB0b3IiOnsiQ291bnRyeU5hbWUiOiI3NTIiLCJQaG9uZU51bWJlciI6Iis0Njg0MDUxMDAwIn0sIkNhcmREZXRhaWxzIjp7IkNhcmRTY2hlbWVOYW1lIjp7IkFwcGxpY2F0aW9uTGFiZWwiOiJNYXN0ZXJjYXJkIn19LCJQYXltZW50Ijp7IlJlZmVyZW5jZSI6IjE3MDMzNzIifSwiUmVjZWlwdFN0cmluZyI6WyJUZXN0IHNob3AiLCJIw6RsbGVza8OlcmFuIDI5IiwiNTA1MCBtZXJjaGFudC1CYXNlMjQtQ2l0eSIsIjIwMjMtMDgtMjQgMTc6MDYiLCIiLCJNYXN0ZXJjYXJkIiwiQ29udGFjdGxlc3MiLCIqKioqKioqKioqKio5NjU5IiwiIiwiSy8xIDMgMDAgU1dFIiwiQUlEOiBBMDAwMDAwMDA0MTAxMCIsIlRWUjogMDAwMDAwODAwMSIsIlRTSTogMDAwMCIsIlJSTjogODc3ODg4MDE4NSIsIkF1dGggY29kZTogNjExNTA2IiwiQVJDOiAwMCIsIiIsIkvDllA6ICAgICAgICAgNTYsMDAgU0VLIiwiR29ka8OkbmQiLCIiLCIiLCIiLCJLb3J0aW5uZWhhdmFyZW5zIGt2aXR0byJdfX19</OutputText>
   </OutputContent>
  </PaymentReceipt>
 </PaymentResponse>
</SaleToPOIResponse>
```

### Loyalty Result

If `nonPaymentToken` is activated for merchant or if loyalty is handled via our host the response may include a `LoyaltyResult` as well.

The xml element `LoyaltyResult` may contain more than one `LoyaltyAccount` element or none. The `LoyaltyResult` appears on the same level as `PaymentResult`.

{:.code-view-header }
**LoyaltyResult from a PaymentResponse with a nonPaymentToken for a card**

```xml
  <LoyaltyResult>
    <LoyaltyAccount LoyaltyBrand="nonPaymentToken">
      <LoyaltyAccountID EntryMode="File" IdentificationSupport="LinkedCard" IdentificationType="AccountNumber">d9b53d79-c677-4468-b4c2-7d85d675457e</LoyaltyAccountID>
    </LoyaltyAccount>
  </LoyaltyResult>
```

{:.code-view-header }
**LoyaltyResult from a PaymentResponse for a loyalty brand name**

```xml
  <LoyaltyResult>
    <LoyaltyAccount LoyaltyBrand="<LOYALTY_BRAND_NAME>">
      <LoyaltyAccountID EntryMode="File" IdentificationSupport="LinkedCard" IdentificationType="AccountNumber">86dd8f2e005be7c4512d7af9dae89dd228689365</LoyaltyAccountID>
    </LoyaltyAccount>
  </LoyaltyResult>
```

### PaymentResponse in Detail

{:.table .table-striped}

| Name | Lev | Attributes | Description |
| :------------- | :---: | :-------------- |:--------------- |
| PaymentResponse | 1 | | |
| Response | 2 | Result | **Success** or **Failure**. |
| | | ErrorCondition | Only present if Failure: Common values are `Busy`- wait and try again, `Refusal`- Request not accepted. |
| AdditionalResponse| 3 | | Only present if Failure and should be a describing text. |
| SaleData | 2 | | |
| SaleTransactionID | 3 | TransactionID | ID of transaction provided by the sale system and may be seen in PosPay reports. Information will not be past to clearing and is not seen in Merchant Portal. |
| | | TimeStamp | Timestamp set by sale system for when the transaction is started. Note that the format is local time. |
| POIData | 2 | | |
| POITransactionID | 3 | TransactionID | ID of transaction set by the terminal. This is seen in PosPay reports as well as on Merchant Portal. The complete element is needed if the transaction needs to be reversed. |
| | | TimeStamp | Timestamp set by terminal when the transaction is started. Note that the format is UTC. |
| PaymentResult | 2 | PaymentType | Values: `Normal` for purchase and `Refund` for refund. |
| PaymentInstrumentData | 3 | PaymentInstrumentType | Values: `Card` for any transaction made by the terminal with a card or any consumer device. `Mobile` for an alternative payment instrument made via the terminal. |
| CardData | 4 | PaymentBrand | Comma separated string where the first part is card type. `01`-payment card. `02`-Combined payment and Loyalty, `03`-Loyalty, `04`-Neither. May be used instead of 03 for controlling the dialog in the terminal. Second part is the product name. |
| | | MaskedPAN | |
| | | PaymentAccountRef | PAR - token delivered from card issuer |
| | | EntryMode | `ICC`, `Contactless`, `Magstripe`. |
| PaymentToken | 5 | TokenRequestedType | `Customer`. |
| | | TokenValue | An irreversible 70 byte hash computed locally in the terminal. A specific card will get the same CNA in all SwedbankPay PAX terminals. |
| AmountsResp | 3 | Currency | Needs to be configured in the terminal. Available `DKK`, `EUR`, `NOK`, `SEK`. |
| | | AuthorizedAmount | Total amount for transaction. |
| | | CashBackAmount | Amount included in AuthorizedAmount. |
| | | TipAmount | Tip included in AuthorizedAmount. |
| PaymentAquirerData | 3 | MerchantID | Id of merchant set by Swedbank Pay. |
| | | AquirerPOIID | A terminal id within Swedbank Pay. |
| ApprovalCode | 4 | | Authorization approval code. Only present if Result is Success. |
| PaymentReceipt | 2 | DocumentQualifier | `CashierReceipt`- Merchant copy. `CustomerReceipt`- receipt information for customer. Note! This element appears twice. |
| OutputContent | 3 | OutputFormat | Only value `Text`. |
| OutputText | 4 | | A Base64 encoded JSON structure with information for the receipt. |

### PaymentReceipt in Detail

```json
{
    "Cardholder": {
        "Mandatory": {
            "Acquirer": {
                "CardAcceptorNumber": "10020001",
                "TerminalID": "877888"
            },
            "CardAcceptor": {
                "Address1": "Hälleskåran 29",
                "BankAgentName": "banky-bank",
                "Name": "Test shop",
                "OrganisationNumber": "5565671-6165",
                "PostZipCode": "5050",
                "TownCity": "merchant-Base24-City"
            },
            "CardDetails": {
                "ApplicationIdentifier": "A0000000041010",
                "CardSchemeName": {
                    "ApplicationLabel": "Mastercard"
                },
                "PrimaryAccountNumber": "************9659",
                "TerminalVerificationResult": "0000008001",
                "TransactionStatusInformation": "0000"
            },
            "Outcome": {
                "ApprovalCode": "611506",
                "AuthorisationResponder": "3",
                "AuthorisationResponseCode": "00",
                "DebitStatus": "00"
            },
            "Payment": {
                "AuthorisationChannel": "1",
                "CardholderVerificationMethod": "/",
                "Currency": "SEK",
                "FinancialInstitution": "SWE",
                "PaymentAmount": "56,00",
                "ReceiptNumber": "8778880185",
                "SignatureBlock": false,
                "TotalAmount": "56,00",
                "TransactionSource": "K",
                "TransactionType": "00"
            },
            "TimeStamp": {
                "DateOfPayment": "2023-08-24",
                "TimeOfPayment": "17:06"
            }
        },
        "Optional": {
            "CardAcceptor": {
                "CountryName": "752",
                "PhoneNumber": "+4684051000"
            },
            "CardDetails": {
                "CardSchemeName": {
                    "ApplicationLabel": "Mastercard"
                }
            },
            "Payment": {
                "Reference": "1703372"
            },
            "ReceiptString": [
                "Test shop",
                "Hälleskåran 29",
                "5050 merchant-Base24-City",
                "2023-08-24 17:06",
                "",
                "Mastercard",
                "Contactless",
                "************9659",
                "",
                "K/1 3 00 SWE",
                "AID: A0000000041010",
                "TVR: 0000008001",
                "TSI: 0000",
                "RRN: 8778880185",
                "Auth code: 611506",
                "ARC: 00",
                "",
                "KÖP:         56,00 SEK",
                "Godkänd",
                "",
                "",
                "",
                "Kortinnehavarens kvitto"
            ]
        }
    }
}
```
