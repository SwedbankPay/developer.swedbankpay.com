---
title: Payment
permalink: /:path/paymentasync/
description: |
  The Payment method is called to make a purchase transaction when the amount is known.
icon:
    content: credit_card
    outlined: true
menu_order: 60
---
### Method Signatures

Synchronous versions

*   void Payment(decimal totalamount,decimal cashback=0, string currency="")
*   void Payment([`TransactionSetup`][transactionsetup] setup)

Asynchronous versions

*   async Task\<PaymentRequestResult\> PaymentAsync(decimal totalamount,decimal cashback=0, string currency="")
*   async Task\<PaymentRequestResult\> PaymentAsync([`TransactionSetup`][transactionsetup] setup)

### Description

The PaymentAsync should be called when the amount is known. It opens all available readers and waits for a payment instrument. If Alternative Payment Methods are activated it will open for that too.

Use parameter of type `TransactionSetup` if a reference need to be set to track the transaction or if fuel functionality is implemented and product codes and other details need to be sent to the terminal.

### Parameters

{:.table .table-striped}
|:-------- |:-------------- |:--------------- |
| decimal |**totalamount**|Includes possible cashback amount.|
| decimal |**cashback**|Part of total amount that will be handed to customer.|
| string |**currency**|Currency code as a string representing ISO-4217 3 letter code. Has to be available in the terminal setup. The default is the currency of the UICulture specified in call to [`Create`][create] method".|
| **Alternatively**| |
|[TransactionSetup][transactionsetup]|**setup**| Object holding several parameters to be used for transaction. Default values for all members. Only populate what is relevant.|

{:.code-view-header}
**Example calling async function with a TransactionSetup object as parameter**

```c#
  var r = await Pax?.PaymentAsync(new TransactionSetup() {
    Amount = total,
    CashBack = cashBack,
    TransactionID = IdForThisTransaction
    });
  if (r.ResponseResult == NexoResponseResult.Success)
    { textBox1.AppendText("Approved" + Environment.NewLine); }
  else { textBox1.AppendText("Not Approved" + Environment.NewLine); }
```

### Returns

A **PaymentRequestResult**

A `PayementRequestResult.ResponseResult` of value `Success` means transaction approved.
If `ResponseResult` is `Failure` there is an `ErrorCondition`. If `ErrorCondition` is `Busy`, wait awhile and try again.

Make sure to always print the customer's receipt when available. For an aborted PaymentAsync there might not be one available.

{% include alert.html type="informative" icon="info" header="Note"
body="The SDK will automatically make three retries when the terminal responds busy."
%}

{% include pax-paymentrequestresult.md %}

{% include alert.html type="warning" icon="warning" header="Client Only Mode" body="If Login was made without SaleCapabilites `CashierInput`, the cashier receipt json object indicates
 if a receipt need to be signed by customer. Make sure to check if IsCVMSignature is true, then customer needs to sign the receipt." %}

### ResponseContent - The Complete nexo Response Message

ResponseContent contains the complete nexo response message from the terminal and looks as follows.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SaleToPOIResponse>
 <MessageHeader MessageClass="Service" MessageCategory="Payment" MessageType="Response" ServiceID="3" SaleID="1" POIID="A-POIID"/>
 <PaymentResponse>
  <Response Result="Success"/>
  <SaleData>
   <SaleTransactionID TransactionID="0839247" TimeStamp="2023-08-23T08:39:24+02:00"/>
  </SaleData>
  <POIData>
   <POITransactionID TransactionID="8778880003" TimeStamp="2023-08-23T06:39:26.382Z"/>
  </POIData>
  <PaymentResult PaymentType="Normal">
   <PaymentInstrumentData PaymentInstrumentType="Card">
    <CardData PaymentBrand="01,Mastercard Debit" MaskedPAN="516815******9659" EntryMode="Contactless">
     <PaymentToken TokenRequestedType="Customer" TokenValue="6FD955C23A48A041D881003CDBF836DC59F89CE0ECA8288129696CDF9BB8B8DD67F233"/>
    </CardData>
   </PaymentInstrumentData>
   <AmountsResp Currency="SEK" AuthorizedAmount="125" CashBackAmount="0.00"/>
   <PaymentAcquirerData MerchantID="10020001" AcquirerPOIID="877888">
    <ApprovalCode>902428</ApprovalCode>
   </PaymentAcquirerData>
  </PaymentResult>
  <PaymentReceipt DocumentQualifier="CashierReceipt">
   <OutputContent OutputFormat="Text">
    <OutputText>eyJNZXJjaGFudCI6eyJNYW5kYXRvcnkiOnsiQWNxdWlyZXIiOnsiQ2FyZEFjY2VwdG9yTnVtYmVyIjoiMTAwMjAwMDEiLCJUZXJtaW5hbElEIjoiODc3ODg4In0sIkNhcmRBY2NlcHRvciI6eyJBZGRyZXNzMSI6IkjDpGxsZXNrw6VyYW4gMjkiLCJCYW5rQWdlbnROYW1lIjoiYmFua3ktYmFuayIsIk5hbWUiOiJUZXN0IHNob3AiLCJPcmdhbmlzYXRpb25OdW1iZXIiOiI1NTY1NjcxLTYxNjUiLCJQb3N0WmlwQ29kZSI6IjUwNTAiLCJUb3duQ2l0eSI6Im1lcmNoYW50LUJhc2UyNC1DaXR5In0sIkNhcmREZXRhaWxzIjp7IkFwcGxpY2F0aW9uSWRlbnRpZmllciI6IkEwMDAwMDAwMDQxMDEwIiwiQ2FyZFNjaGVtZU5hbWUiOnsiQXBwbGljYXRpb25MYWJlbCI6Ik1hc3RlcmNhcmQifSwiUHJpbWFyeUFjY291bnROdW1iZXIiOiI1MTY4MTUqKioqKio5NjU5IiwiVGVybWluYWxWZXJpZmljYXRpb25SZXN1bHQiOiIwMDAwMDA4MDAxIiwiVHJhbnNhY3Rpb25TdGF0dXNJbmZvcm1hdGlvbiI6IjAwMDAifSwiT3V0Y29tZSI6eyJBcHByb3ZhbENvZGUiOiI5MDI0MjgiLCJBdXRob3Jpc2F0aW9uUmVzcG9uZGVyIjoiMyIsIkF1dGhvcmlzYXRpb25SZXNwb25zZUNvZGUiOiIwMCIsIkRlYml0U3RhdHVzIjoiMDAifSwiUGF5bWVudCI6eyJBdXRob3Jpc2F0aW9uQ2hhbm5lbCI6IjEiLCJDYXJkaG9sZGVyVmVyaWZpY2F0aW9uTWV0aG9kIjoiLyIsIkN1cnJlbmN5IjoiU0VLIiwiRmluYW5jaWFsSW5zdGl0dXRpb24iOiJTV0UiLCJQYXltZW50QW1vdW50IjoiMTI1LDAwIiwiUmVjZWlwdE51bWJlciI6Ijg3Nzg4ODAwMDMiLCJTaWduYXR1cmVCbG9jayI6ZmFsc2UsIlRvdGFsQW1vdW50IjoiMTI1LDAwIiwiVHJhbnNhY3Rpb25Tb3VyY2UiOiJLIiwiVHJhbnNhY3Rpb25UeXBlIjoiMDAifSwiVGltZVN0YW1wIjp7IkRhdGVPZlBheW1lbnQiOiIyMDIzLTA4LTIzIiwiVGltZU9mUGF5bWVudCI6IjA4OjM5In19LCJPcHRpb25hbCI6eyJDYXJkQWNjZXB0b3IiOnsiQ291bnRyeU5hbWUiOiI3NTIiLCJQaG9uZU51bWJlciI6Iis0Njg0MDUxMDAwIn0sIkNhcmREZXRhaWxzIjp7IkNhcmRTY2hlbWVOYW1lIjp7IkFwcGxpY2F0aW9uTGFiZWwiOiJNYXN0ZXJjYXJkIn19LCJQYXltZW50Ijp7IlJlZmVyZW5jZSI6IjA4MzkyNDcifSwiUmVjZWlwdFN0cmluZyI6WyJUZXN0IHNob3AiLCJIw6RsbGVza8OlcmFuIDI5IiwiNTA1MCBtZXJjaGFudC1CYXNlMjQtQ2l0eSIsIjIwMjMtMDgtMjMgMDg6MzkiLCIiLCJNYXN0ZXJjYXJkIiwiQ29udGFjdGxlc3MiLCI1MTY4MTUqKioqKio5NjU5IiwiIiwiSy8xIDMgMDAgU1dFIiwiQUlEOiBBMDAwMDAwMDA0MTAxMCIsIlRWUjogMDAwMDAwODAwMSIsIlRTSTogMDAwMCIsIlJSTjogODc3ODg4MDAwMyIsIkF1dGggY29kZTogOTAyNDI4IiwiQVJDOiAwMCIsIiIsIkvDllA6ICAgICAgICAxMjUsMDAgU0VLIiwiR29ka8OkbmQiLCIiLCIiLCIiLCJGw7Zyc8OkbGphcmVucyBrdml0dG8iXX19fQ==</OutputText>
   </OutputContent>
  </PaymentReceipt>
  <PaymentReceipt DocumentQualifier="CustomerReceipt">
   <OutputContent OutputFormat="Text">
    <OutputText>eyJDYXJkaG9sZGVyIjp7Ik1hbmRhdG9yeSI6eyJBY3F1aXJlciI6eyJDYXJkQWNjZXB0b3JOdW1iZXIiOiIxMDAyMDAwMSIsIlRlcm1pbmFsSUQiOiI4Nzc4ODgifSwiQ2FyZEFjY2VwdG9yIjp7IkFkZHJlc3MxIjoiSMOkbGxlc2vDpXJhbiAyOSIsIkJhbmtBZ2VudE5hbWUiOiJiYW5reS1iYW5rIiwiTmFtZSI6IlRlc3Qgc2hvcCIsIk9yZ2FuaXNhdGlvbk51bWJlciI6IjU1NjU2NzEtNjE2NSIsIlBvc3RaaXBDb2RlIjoiNTA1MCIsIlRvd25DaXR5IjoibWVyY2hhbnQtQmFzZTI0LUNpdHkifSwiQ2FyZERldGFpbHMiOnsiQXBwbGljYXRpb25JZGVudGlmaWVyIjoiQTAwMDAwMDAwNDEwMTAiLCJDYXJkU2NoZW1lTmFtZSI6eyJBcHBsaWNhdGlvbkxhYmVsIjoiTWFzdGVyY2FyZCJ9LCJQcmltYXJ5QWNjb3VudE51bWJlciI6IioqKioqKioqKioqKjk2NTkiLCJUZXJtaW5hbFZlcmlmaWNhdGlvblJlc3VsdCI6IjAwMDAwMDgwMDEiLCJUcmFuc2FjdGlvblN0YXR1c0luZm9ybWF0aW9uIjoiMDAwMCJ9LCJPdXRjb21lIjp7IkFwcHJvdmFsQ29kZSI6IjkwMjQyOCIsIkF1dGhvcmlzYXRpb25SZXNwb25kZXIiOiIzIiwiQXV0aG9yaXNhdGlvblJlc3BvbnNlQ29kZSI6IjAwIiwiRGViaXRTdGF0dXMiOiIwMCJ9LCJQYXltZW50Ijp7IkF1dGhvcmlzYXRpb25DaGFubmVsIjoiMSIsIkNhcmRob2xkZXJWZXJpZmljYXRpb25NZXRob2QiOiIvIiwiQ3VycmVuY3kiOiJTRUsiLCJGaW5hbmNpYWxJbnN0aXR1dGlvbiI6IlNXRSIsIlBheW1lbnRBbW91bnQiOiIxMjUsMDAiLCJSZWNlaXB0TnVtYmVyIjoiODc3ODg4MDAwMyIsIlNpZ25hdHVyZUJsb2NrIjpmYWxzZSwiVG90YWxBbW91bnQiOiIxMjUsMDAiLCJUcmFuc2FjdGlvblNvdXJjZSI6IksiLCJUcmFuc2FjdGlvblR5cGUiOiIwMCJ9LCJUaW1lU3RhbXAiOnsiRGF0ZU9mUGF5bWVudCI6IjIwMjMtMDgtMjMiLCJUaW1lT2ZQYXltZW50IjoiMDg6MzkifX0sIk9wdGlvbmFsIjp7IkNhcmRBY2NlcHRvciI6eyJDb3VudHJ5TmFtZSI6Ijc1MiIsIlBob25lTnVtYmVyIjoiKzQ2ODQwNTEwMDAifSwiQ2FyZERldGFpbHMiOnsiQ2FyZFNjaGVtZU5hbWUiOnsiQXBwbGljYXRpb25MYWJlbCI6Ik1hc3RlcmNhcmQifX0sIlBheW1lbnQiOnsiUmVmZXJlbmNlIjoiMDgzOTI0NyJ9LCJSZWNlaXB0U3RyaW5nIjpbIlRlc3Qgc2hvcCIsIkjDpGxsZXNrw6VyYW4gMjkiLCI1MDUwIG1lcmNoYW50LUJhc2UyNC1DaXR5IiwiMjAyMy0wOC0yMyAwODozOSIsIiIsIk1hc3RlcmNhcmQiLCJDb250YWN0bGVzcyIsIioqKioqKioqKioqKjk2NTkiLCIiLCJLLzEgMyAwMCBTV0UiLCJBSUQ6IEEwMDAwMDAwMDQxMDEwIiwiVFZSOiAwMDAwMDA4MDAxIiwiVFNJOiAwMDAwIiwiUlJOOiA4Nzc4ODgwMDAzIiwiQXV0aCBjb2RlOiA5MDI0MjgiLCJBUkM6IDAwIiwiIiwiS8OWUDogICAgICAgIDEyNSwwMCBTRUsiLCJHb2Rrw6RuZCIsIiIsIiIsIiIsIktvcnRpbm5laGF2YXJlbnMga3ZpdHRvIl19fX0=</OutputText>
   </OutputContent>
  </PaymentReceipt>
 </PaymentResponse>
</SaleToPOIResponse>
```

### CustomerReceiptData - Json object

The following is a sample of the CustomerReceiptData member of the result. This is the content of the Base64 encoded CustomerReceipt in `ResponseContent`.

{% include alert.html type="informative" icon="info" header="Note"
body="Use the ReceiptBlob of the result rather than the ReceiptString of the JSON. They will eventually be the same in later versions of the SDK." %}

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
    "PrimaryAccountNumber": "************5828",
    "TerminalVerificationResult": "0000008001",
    "TransactionStatusInformation": "0000"
   },
   "Outcome": {
    "ApprovalCode": "708376",
    "AuthorisationResponder": "3",
    "AuthorisationResponseCode": "00",
    "DebitStatus": "00"
   },
   "Payment": {
    "AuthorisationChannel": "1",
    "CardholderVerificationMethod": "/",
    "Currency": "SEK",
    "FinancialInstitution": "SWE",
    "PaymentAmount": "25,00",
    "ReceiptNumber": "8778880180",
    "SignatureBlock": false,
    "TotalAmount": "25,00",
    "TransactionSource": "K",
    "TransactionType": "00"
   },
   "TimeStamp": {
    "DateOfPayment": "2023-08-22",
    "TimeOfPayment": "14:45"
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
    "Reference": "1445280"
   },
   "ReceiptString": [
    "Test shop",
    "Hälleskåran 29",
    "5050 merchant-Base24-City",
    "2023-08-22 14:45",
    "",
    "Mastercard",
    "Contactless",
    "************5828",
    "",
    "K/1 3 00 SWE",
    "AID: A0000000041010",
    "TVR: 0000008001",
    "TSI: 0000",
    "RRN: 8778880180",
    "Auth code: 708376",
    "ARC: 00",
    "",
    "KÖP:         25,00 SEK",
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

### FromattedRececipt - array of lines

The following shows the content of the FormattedReceipt array of the same result as above.

```text
[{"Text":"Test shop               "},{"Text":"Hälleskåran 29          "},{"Text":"5050 merchant-Base24-City"},{"Text":"Org nr: 5565671-6165    "},{"Text":"                        "},{"Text":"Butiksnr.:      10020001"},{"Text":"Termid:           877888"},{"Text":"2023-08-23         08:39"},{"Text":"                        "},{"Text":"          KÖP           "},{"Text":"                        "},{"Text":"SEK               125,00"},{"Text":"Total:            125,00"},{"Text":"                        "},{"Text":"************9659        "},{"Text":"Mastercard              "},{"Text":"Kontaktlös              "},{"Text":"                        "},{"Text":"                        "},{"Text":"K/1 3 00 902428         "},{"Text":"                        "},{"Text":"Ref.nr:       8778880003"},{"Text":"AID:      A0000000041010"},{"Text":"TVR:          0000008001"},{"Text":"TSI:                0000"},{"Text":"                        "},{"Text":"     SPARA KVITTOT      "},{"Text":"      KUNDENS EX.       "}
```

### ReceiptBlob - Fast forward to well formatted approved receipt information

```text
Test shop
Hälleskåran 29
5050
 merchant-Base24-City
Org nr: 5565671-6165

Butiksnr.:      10020001
2023-12-06         08:39

KÖP            125,00SEK

************9659
Mastercard
Kontaktlös
K/1 3 00 902428
Ref.nr:       8778880003
AID:      A0000000041010
TVR:          0000008001

     SPARA KVITTOT
      KUNDENS EX.

```

### ReceiptBlobNoHeader - ReceiptBlob but no header

```text

Butiksnr.:      10020001
2023-12-06         08:39

KÖP            125,00SEK

************9659
Mastercard
Kontaktlös
K/1 3 00 902428
Ref.nr:       8778880003
AID:      A0000000041010
TVR:          0000008001

     SPARA KVITTOT
      KUNDENS EX.
```

[transactionsetup]: /pax-terminal/NET/includes/transactionsetup
[create]: /pax-terminal/NET/SwpTrmLib/Methods/essential/create
