#### Capture

{:.table .table-striped}
| XLSX                            | XLM       | Request API    |    Response API
|
|:--------------------------------|:-----------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------|
| `Swedbank Pay Batch Number`     | `SwedbankbatchNo`       |                                                                |
| `Transaction Number`            | `TransactionNo`         |                            | transaction.number                |
| `Order id`                      | `OrderId`               | transaction.payeeReference | transaction.payeeReference        | 
| `Date Created`                  | `DateCreated`           |                            | transaction.created               |
| `Date Modified`                 | `DateModified`          |                            | {% unless documentation_section=="vipps" %}transaction.created {% endunless %}                                  |
| `Provider`                      | `Provider`              |                                                                |
| `Type`                          | `Type`                  |                                                                |
| `Amount`                        | `Amount`                | transaction.amount  |  transaction.amount                      |
| `Currency`                      | `Currency`              |                                                                |
| `Product Number`                | `MerchantProductNo`     |                                                                |
| `Description`                   | `Description`           |  transaction.description | transaction.description             |
| `VAT Amount`                    | `VATAmount`             |  transaction.vatAmount | transaction.vatAmount                 |
| `VAT Percentage`                | `VatoPercentage`        |                                                                |
| `Credit Card Batch Number`      | `CreditCardBatchNo`     |                                                                |
| `Direct Debit Bank Reference`   | `DirectDebitbankRef`    |{% if documentation_section == "card" or "payment-menu" } transaction.number if
DirectDebit {% endif %}|
| `Reference`                     | `Reference`             | {% if documentation_section == "card" or "payment-menu" } transaction.number if
DirectDebit {% endif %}|
| `Swedbank Account Number`       | `SwedbankAccountNo`     |                                                                |
| `Referenced Transaction Number` | `ReferencedTransaction` | {% unless documentation_section=="swish" %}transaction.number if reversed later       {% endunless %} |
| `Sales Channel`                 | `SalesChannel`          |                                                                |
| `Brand`                         |                         |                                                                |
| `Point Of Sale`                 |                         |                                                                |
