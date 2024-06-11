---
permalink: /:path/transactionsetup/
description: TransactionSetup may be used as a parameter when starting a transaction.
---
TransactionSetup holds properties for a transaction and may be passed as an input parameter to functions that start a transaction sequence. All properties are not relevant depending on which function that is called.

```c#
 public interface ITransactionSetup
    {
        string AcquirerData { get; set; }
        decimal Amount { get; set; }
        string APMReference { get; set; }
        decimal CashBack { get; set; }
        string Currency { get; set; }
        string PaymentInstrument { get; set; }
        List<SaleItem> SaleItems { get; set; }
        bool SplitPayment { get; set; }
        string TransactionID { get; set; }
        PaymentTypes type { get; set; }

        string ToString();
    }
```

{:.table .table-striped}
| :--- | :--- |:--- |:--- |
| string |[AcquirerData][acquirerdata] | Additional data to be sent to host. Used for sending special data to PosPay and that may be forwarded to other systems for customer purpose. JSON format. Content need to be agreed on | Optional |
| decimal |Amount |Total amount | Mandatory |
| string |APMReference |Used only if refund of a transaction made using an alternative payment instrument. The reference originates from the response of the APM transaction | Only for Refund of APM transaction |
| decimal |CashBack |included in Amount | Optional |
| string |Currency |As a 3 letter abbrivation - ISO-4217. Available are `SEK`, `NOK`, `DKK`, `EUR`. Needs to be configured in terminal. | Optional. Default currency of current culture. |
| string |PaymentInstrument |A non PCI regulated payment instrument. Prefix and supplied PAN must be registred in the terminal setup. The normal usage is for giftcards or card numbers that are created on site such as financing.| Optional |
| List\<[SaleItem][saleitem]\> | SaleItems | Product details for fuel functionality | Optional |
| bool | SplitPayment | Just a flag sent to host to indicate this sale in part of a complete sale made in the sale system. Does only make sense for certain host. | Optional |
string |TransactionID |A transaction id that may be set by sale system for tracking. If a transaction is started by calling `GetPayementInstrument`, the transaction id must be set in that call and cannot be changed when later calling `Payment` or `Refund` | Optional |
| Nexo.PaymentTypes |type |Normal or Refund | Mandatory if used with `GetPaymentInstrument` or `GetPaymentInstrumentAsync`. Overridden when used with `Refund` or `RefundAsync` |

{:.code-view-header}
**Example creating a list of sale items**

```c#

    NexoPayementResult r = await PAX.Payment(new TransactionSetup(){
        Amount = 70,
        TransactionID = ATransactionIDFromSaleSystem
    });

```

[saleitem]: /pax-terminal/NET/includes/saleitem
[acquirerdata]: /pax-terminal/NET/includes/acquirerdata
