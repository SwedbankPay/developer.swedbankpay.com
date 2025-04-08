{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% assign operation_title = include.operation_title %}
{% assign checkout = include.checkout %}

## Settlement And Reconciliation

{% include jumbotron.html body="Reconciliation is an important step in an
economic transaction. When a payment is reconciled, captured amounts for the
payment are matched against the corresponding settlement." %}

The information needed to reconcile captured funds - the balance report and
transactions list - are available for all merchants using Swedbank Pay.

*   By default, the settlement files will be sent to you by via e-mail.
*   We also have the option to send it via SFTP as well. If this is something
    you'd like, please inform your sales representative. They will in turn let
    the setup team know.
*   The settlement frequency is defined in your agreement, but the default is
*   monthly or weekly.
*   You do not need to subscribe, the files will be delivered by default.

Please contact [kundsupport@swedbankpay.se][omni-client-email] for further
inquiries regarding this.

## Settlement

There are two main alternatives for settlement - either we handle the settlement
process for you, or you handle the process yourself:

### If Swedbank Pay Handles The Settlement Process

Swedbank Pay handles the settlement process on your behalf, (_called
“Redovisningsservice”_). Swedbank Pay transfers the net amount to you directly.

{% if documentation_section contains "checkout-v3" %}

When choosing [Swedbank Pay Checkout][checkout-v3] we will always handle the
settlement process for you, gathering all your e-commerce payments in one place.
Straighforward and time efficient.

{% else %}

When choosing [Swedbank Pay Checkout][checkout-v2] we will always handle the
settlement process for you, gathering all your e-commerce payments in one place.
Straighforward and time efficient.

{% endif %}

### You Handle The Settlement Process Yourself

If you will handle the settlement yourself, then Swedbank Pay will send you an
invoice with the relevant fees, in addition to the report and transactions
lists. Your acquirer will transfer settled funds to you.

## Balance Report

The Balance Report (a _.pdf file_) specifies the total sales for a specific
period, including fees and VAT. The report contains three parts: a payment
summary and specifications for sales and for fees.

Two versions of the balance report are currently in production, **v1** and
**v2**. **All new customers are set up with v2**, so if you are a new
customer or have joined us within the last year, the v2 sections should be your
focus. **V1 will be phased out during 2023.**

The main differences are in the [transaction list][transaction-list].

### Payment Summary

Provides a summary of the `Amount` sold, `Fees` and `VAT`. **If Swedbank Pay**
**handles the settlement process**, the `Transferred amount` shown in the
balance report summary is equivalent to the disbursement on the bank statement
(the remaining total amount after fees).

### Sales Specification

Provides a specification over sales for the given period. The sales total is
specified per payment area (`CreditCard`, `Invoice`) and underlying payment
methods. Each sales row specify Quantity, Sum sales and Amount to pay out,
the last one is only eligble **if Swedbank Pay handles the Settlement process**.

A summary of payments through the last date of the report is also provided.

### Fees Specification

Provides a specification of the fees in the given period. The fees total is
specified per payment area (`CreditCard`, `Invoice`) and underlying payment
methods. Each fees row specify `Quantity` (sales), `Amount` (sales),
`Unit price`, `Provision` and `fee Amount`. **If you handle the settlement**
**process yourself, you will receive a separate invoice for fees**.

## Transaction List

The Transaction List (also called Sales Accounted Transactions) is provided in
`.xlsx` and `.xml` formats and specifies all transactions for a specific period,
including a summary of transactions grouped by payment method. Both formats
contain the same information, but the xml file is meant for computer processing,
while the excel workbook is meant for human interaction.

The first row contains the name of the Swedbank Pay company (e.g. Swedbank Pay
Solutions AB) that the merchant has the contract with, and the balance report
number. The header fields contain a summary of the transactions displayed in the
body.

As with the Balance Report there are two versions of the Transaction List, and
**v1 will be phased out during 2023**.

## V1 Header Fields

{:.table .table-striped}
| Field         | Type       | Description                                                                |
| :------------ | :--------- | :------------------------------------------------------------------------- |
| `Prefix`      | `string`   | The `Prefix` used for transactions, only eligible if merchant uses prefix. |
| `Currency`    | `ISO 4217` | Settlement currency (e.g. `SEK, NOK, EUR`).                                |
| `ServiceType` | `string`   | The service type of the service used (e.g. `Creditcard`).                  |
| `Service`     | `string`   | The service used (e.g. `Creditcard`).                                      |
| `NoOfDebet`   | `Decimal`  | Total number of debit transactions for the given service.                  |
| `NoOfCredit`  | `Decimal`  | Total number of credit transactions for the given service.                 |
| `Amount`      | `Decimal`  | Total amount for the given service (e.g 100.00).                           |
| `FromDate`    | `ISO 8601` | The earliest transaction date, `YYYY-MM-DD`.                               |
| `ToDate`      | `ISO 8601` | The latest transaction date, `YYYY-MM-DD`.                                 |

## V1 Body Fields

{:.table .table-striped}
| Field                           | Type       | Description                                                                                                                                               |
| :------------------------------ | :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Swedbank Pay Batch Number`     | `Decimal`  | A batch number common to all types of transactions processed by Swedbank Pay.                                                                             |
| `Transaction Number`            | `Decimal`  | A unique identifier of the transaction, can be traced in the Merchant Portal user interface.                                                               |
| `Order id`                      | `string`   | A unique identifier of the order, as sent from the merchant to Swedbank Pay. Transactions that are related to the same order are associated with this ID. |
| `Date Created`                  | `ISO 8601` | Transaction capture date/time. YYYY-MM-DD hh:mm:ss.                                                                                                       |
| `Date Modified`                 | `ISO 8601` | Transaction settle date/time. YYYY-MM-DD hh:mm:ss.                                                                                                        |
| `Provider`                      | `string`   | The service provider (e.g. Babs, Swedbank).                                                                                                               |
| `Type`                          | `string`   | The service type of the related transaction (e.g. `Creditcard`).                                                                                          |
| `Amount`                        | `Decimal`  | Total amount of the related transaction (e.g 100.00).                                                                                                     |
| `Currency`                      | `ISO 4217` | Settlement currency (e.g. `SEK, NOK, EUR`).                                                                                                               |
| `Product Number`                | `string`   | A product number, as sent by merchant to Swedbank Pay.                                                                                                    |
| `Description`                   | `string`   | A textual description of the transaction, as sent by merchant to Swedbank Pay.                                                                            |
| `VAT Amount`                    | `Decimal`  | VAT Amount for the given transaction (e.g 100.00).                                                                                                        |
| `VAT Percentage`                | `Decimal`  | VAT Percentage for the given transaction.                                                                                                                 |
| `Credit Card Batch Number`      | `Decimal`  | The reference number from the credit card processor.                                                                                                      |
| `Reference`                     | `Decimal`  | The transaction reference from processor.                                                                                                                 |
| `Swedbank Pay Account Number`   | `Decimal`  | The Account number given, shown in the Merchant Portal.                                                                                                    |
| `Referenced Transaction Number` | `Decimal`  | Transaction number for the Authoriation transaction for a two-stage transaction or the number of the debit transaction if it is a credit transaction.     |
| `Sales Channel`                 | `string`   | The channel through which the transaction was sent to Swedbank Pay (e.g Transaction via eCommerce APIs).                                                  |
| `Brand`                         | `string`   | No longer populated when using Online Payments integrations.                                                                                    |
| `Point Of Sale`                 | `string`   | If eligible, POS information as sent by merchant to Swedbank Pay.                                                                                         |

## V2 Header Fields

{:.table .table-striped}
| Field                     | Type       | Description                                                                  |
| :-------------------------| :--------- | :--------------------------------------------------------------------------- |
| `Subsite`                 | `string`   | The `Subsite` used for transactions, only eligible if merchant uses subsite. |
| `SubsiteDescription`      | `string`   | Description of the `Subsite`, only eligible if merchant uses subsite.        |
| `Currency`                | `ISO 4217` | Settlement currency (e.g. `SEK, NOK, EUR`).                                  |
| `ServiceType`             | `string`   | The service type of the service used (e.g. `Creditcard`).                    |
| `ServiceName`             | `string`   | The service used (e.g. `Corporate Cards EU`).                                |
| `NoOfDebet`               | `Decimal`  | Total number of debit transactions for the given service.                    |
| `NoOfCredit`              | `Decimal`  | Total number of credit transactions for the given service.                   |
| `Amount`                  | `Decimal`  | Total amount for the given service (e.g 100.00).                             |
| `FromDate`                | `ISO 8601` | The earliest transaction date, `YYYY-MM-DD`.                                 |
| `ToDate`                  | `ISO 8601` | The latest transaction date, `YYYY-MM-DD`.                                   |

## V2 Body Fields

{:.table .table-striped}
| Field                           | Type       | Description                                                                                                                                               |
| :------------------------------ | :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PayExAccountNo`                | `Decimal`  | The Account number given, shown the Merchant Portal..                                                                             |
| `OrderIdentity`                 | `string`   | A unique identifier of the order, as sent from the merchant to Swedbank Pay. Transactions that are related to the same order are associated with this ID. |
| `TransactionIdentity`           | `string`   | A unique guid identifier of the transaction, can be traced in the Merchant Portal user interface.                                                          |
| `Amount`                        | `Decimal`  | Total amount of the related transaction (e.g 100.00).                                                                                                     |
| `Currency`                      | `ISO 4217` | Settlement currency (e.g. `SEK, NOK, EUR`).                                                                                                               |
| `VAT Amount`                    | `Decimal`  | VAT Amount for the given transaction (e.g 100.00).                                                                                                        |
| `VAT Percentage`                | `Decimal`  | VAT Percentage for the given transaction.                                                                                                                 |
| `Date Created`                  | `ISO 8601` | Transaction capture date/time. YYYY-MM-DD hh:mm:ss.                                                                                                       |
| `Date Modified`                 | `ISO 8601` | Transaction settle date/time. YYYY-MM-DD hh:mm:ss.                                                                                                        |
| `ServiceName`                   | `string`   | The service used (e.g. `Corporate Cards EU`).                                                                                                             |
| `Provider`                      | `string`   | The service provider (e.g. Swedbank Pay, PayEx, Swish).                                                                                                   |
| `PayExTransactionNo`            | `Decimal`  | A unique identifier of the transaction, can be traced in the Merchant Portal user interface.                                                               |
| `PayExBatchNo`                  | `Decimal`  | A batch number common to all types of transactions processed by Swedbank Pay.                                                                             |
| `Subsite`                       | `string`   | The `Subsite` used for transactions, only eligible if merchant uses subsite.                                                                              |
| `SubsiteDescription`            | `string`   | Description of the `Subsite`, only eligible if merchant uses subsite.                                                                                     |
| `ReferencedTransaction`         | `Decimal`  | Transaction number for the authorization transaction for a two-stage transaction, or the number of the debit transaction if it is a credit transaction.   |
| `ExternalTransactionReference`  | `Decimal`  | The transaction reference from processor.   |
| `CreditCardBatchNo`             | `Decimal`  | The reference number from the credit card processor.                                                                                                      |
| `Description`                   | `string`   | A textual description of the transaction, as sent by merchant to Swedbank Pay.                                                                            |
| `ProductCategory`               | `string`   | A product number, as sent by merchant to Swedbank Pay.                                                                                                    |
| `Sales Channel`                 | `string`   | The channel through which the transaction was sent to Swedbank Pay (e.g Transaction via eCommerce APIs).                                                  |
| `Brand`                         | `string`   | No longer populated when using Online Payments integrations.                |
| `Point Of Sale`                 | `string`   | If eligible, POS information as sent by merchant to Swedbank Pay.                                                                                         |

## Reconciliation

To do the reconciliation, you need to match the information in your system
against the information provided by Swedbank Pay in the balance report and
transaction list. Below is a sequence diagram detailing the interaction.

## Reconciliation Sequence Diagram

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    activate Merchant
    activate SwedbankPay
    Merchant-->>SwedbankPay: Online payment transactions
    deactivate Merchant

    deactivate SwedbankPay

    activate Merchant

    SwedbankPay->>Merchant: Balance Report (PDF-file)
    note left of Merchant: files are sent by e-mail or file transfer
    SwedbankPay->>Merchant: Transaction list (XLSX-file)
    SwedbankPay->>Merchant: Transaction list (XML-file)
    deactivate Merchant
```

**There are two ways** for you to match the information from your system with
the information given in the reconciliation files from Swedbank Pay:

1.  You can use information **generated by your** system (you will have to set a
    unique payeeReference when you make the transaction), or
2.  You can use the transaction number **generated by Swedbank Pay** (this is
    called transaction number and is returned from Swedbank Pay after you have
    created the transaction).

A credit card transaction is made when you either make a capture or a reversal.
In the input data for making a capture, you will set the `payeeReference`. The
unique value of this field is the same as the field called `OrderID` in the
reconciliation file.

{% capture request_content %}{
    "transaction": {
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Reversal",
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

When you receive the response from Swedbank Pay, the response will include
`transaction.number`. This is the same as the field called `TransactionNo` in
the reconciliation file.

{% capture response_content %}{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "capture": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/captures/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Capture",
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1500,
            "vatAmount": 250,
            "description": "Test Capture",
            "payeeReference": "ABC123",
            "failedReason": "",
            "isOperational": false,
            "operations": []
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

*   `payeeReference` sent to Swedbank Pay is equal to `OrderId` in the
    reconciliation file.
*   `capture.transaction.number` returned from Swedbank Pay is equal to
    `TransactionNo` in reconciliation file.

Below you will see the API mapping tables to the fields in the settlement
report for
{% if documentation_section == "swish" %}`Sale` {% else %} `Capture` {% endif %}
and `Reversal`.

{% if documentation_section == "swish" %}
{% include pba-tables.md operation_title="sale" %}
{% else %}
{% include pba-tables.md operation_title="capture" %}
{% endif %}
{% include pba-tables.md operation_title="reversal" %}

## Report Samples

The content of the files depends on the type of agreement you have made with
Swedbank Pay. For some payment methods, only option A is available, while
for other payment methods, only option B is available. The sample files can
be downloaded below. **Make sure that you choose the examples from your**
**current version of the balance report (v1 or v2).**

### V1 Option A: Swedbank Pay Handles The Settlement Process

*   [PDF Balance Report][balance-report-sbp-pdf]
*   [XLSX Transaction List][trans-list-sbp-xlsx]
*   [XML Transaction List][trans-list-sbp-xml]

### V1 Option B: You Handle The Settlement Process Yourself

*   [PDF Balance Report][balance-report-pdf]
*   [XLSX Transaction List][trans-list-xlsx]
*   [XML Transaction List][trans-list-xml]

### V2 Option A: Swedbank Pay Handles The Settlement Process

*   [PDF Balance Report][v2-balance-report-sbp-pdf]
*   [XLSX Transaction List][v2-trans-list-sbp-xlsx]
*   [XML Transaction List][v2-trans-list-sbp-xml]

### V2 Option B: You Handle The Settlement Process Yourself

*   [PDF Balance Report][v2-balance-report-pdf]
*   [XLSX Transaction List][v2-trans-list-xlsx]
*   [XML Transaction List][v2-trans-list-xml]

[balance-report-sbp-pdf]: /assets/documents/r1234-0001-redov.service.pdf
[checkout-v2]: /old-implementations/{{ checkout_version }}
[checkout-v3]: /{{ checkout_version }}
[trans-list-sbp-xlsx]: /assets/documents/transaktionsstatistik-redovisningsservice.xlsx
[trans-list-sbp-xml]: /assets/documents/transaktionsstatistik-redovisningsservice.xml
[transaction-list]: #transaction-list
[balance-report-pdf]: /assets/documents/balance-report.pdf
[trans-list-xlsx]: /assets/documents/transaction-list.xlsx
[trans-list-xml]: /assets/documents/transaction-list.xml
[omni-client-email]: mailto:kundsupport@swedbankpay.se
[v2-balance-report-sbp-pdf]: /assets/documents/R1234-0001-Redovisningsservice.pdf
[v2-trans-list-sbp-xlsx]: /assets/documents/R1234-0001-Redovisningsservice.xlsx
[v2-trans-list-sbp-xml]: /assets/documents/R1234-0001-Redovisningsservice.xml
[v2-balance-report-pdf]: /assets/documents/R1234-0002-Eget-konto.pdf
[v2-trans-list-xlsx]: /assets/documents/R1234-0002-Eget-konto.xlsx
[v2-trans-list-xml]: /assets/documents/R1234-0002-Eget-konto.xml
