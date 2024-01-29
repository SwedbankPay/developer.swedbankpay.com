{:.code-view-header}
PaymentRequestResult class returned for any payment.

```c#
namespace SwpTrmLib {
    public class PaymentRequestResult
    {
        List<string> AllowedProducts { get; }
        decimal Amount { get; }
        string APMReference { get; set; }
        string APMType { get; set; }
        string ApprovalCode { get; }
        string CNA { get; }
        JObject CustomerReceiptData { get; set; }
        string ErrorCondition { get; set; }
        string FormattedReceipt { get; set; }
        bool IsCVMSignature { get; }
        JObject MerchantReceiptData { get; set; }
        XElement OriginalTransaction { get; set; }
        string PAN { get; }
        PaymentRequestResultTypes PaymentType { get; }
        string ProductName { get; }
        string ReceiptBlob { get; }
        string ReceiptBlobNoHeader { get; }
        string ReceiptNumber { get; }
        string Reference { get; }
        string ResponseContent { get; set; }
        NexoResponseResult ResponseResult { get; set; }
        string ResponseText { get; set; }
        JObject SettlementData { get; }
        string TimeStamp { get; }
        decimal TipAmount { get; }
        string UICulture { get; set; }
    }
}
```

{:.table .table-striped .mb-5}
| Name | Description |
| :------------- | :-------------- |
| AllowedProducts | a list of strings with product codes. Only used for a fuel card solution. |
| Amount | The authorized amount. |
| APMReference | A reference to the APM (Alternative Payment Method) transaction. If present, the reference must be printed on the receipt. Preferably as a bar code or QR code. It is needed for refund of the transaction. |
| APMType | Name of APM that was chosen. |
| ApprovalCode | Approval code for the card authorisation. |
| CNA | Card Number Alias - a one way hash of the card number. Always the same for a specific card number. May be used for loyalty and digital receipts or such to identify and store a card. |
| CustomerReceiptData | Json object as returned from terminal, containing receipt data. Prefere using the ReceiptBlob.|
| ErrorCondition | Is valid if `ResponseResult` is `Failure` and describes the reason for failure.
| FormattedReceipt | comma separated strings with receipt lines that may be used. |
| IsCVMSignature | Indicates whether the receipt need customer signing or not. |
| MerchantReceiptData | Json object as returned from terminal, containing receipt data. Prefere using the ReceiptBlob.|
| OriginalTransaction | Identifier to for the transaction to be used if reversal must be made. |
| PAN | Masked card number. |
| PaymentType | Indicates if result regards a payment, refund. |
| ProductName | Card Product Name. |
| ReceiptBlob | A string with a well formatted receipt. |
| ReceiptBlobNoHeader | A string with a well formatted receipt excluding header information that is usually printed by the sale system. |
| ReceiptNumber | An identifier of the transaction set by the terminal and that may track the transaction in other central systems. |
| ReferenceNumber | An identifier of the transaction that may be set by the sale system using the `TransactionSetup` |
| ResponseContent | The complete message as returned from the terminal. |
| ResponseResult | `Success` - approved transaction. `Failure` - Refused transaction |
| ResponseText | May describes the reason of a `ResponseResult` `Failure`.
| SettlementData | Only used if host system is using SPDH protocol. (Not used) |
| TimeStamp | TimeStamp of the transaction |
