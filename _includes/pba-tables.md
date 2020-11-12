{% assign operation_title = include.operation_title %}
{% assign documentation_section = include.documentation_section  %}

{%- assign operation_title_field_name = operation_title | capitalize -%}

### **{{ operation_title_field_name }}**

{:.table .table-striped}
| API                                                                                               | XLSX                            | XML                     |
| :-------------------------------------------------------------------------------------------------| :-------------------------------| :---------------------- |
|                                                                                                   | `Swedbank Pay Batch Number`     | `SwedbankbatchNo`       |
| `transaction.number`                                                                              | `Transaction Number`            | `TransactionNo`         |
| `transaction.payeeReference`                                                                      | `Order id`                      | `OrderId`               |
| `transaction.created`                                                                             | `Date Created`                  | `DateCreated`           |
|{% if documentation_section=="swish" or documentation_section=="invoice" %}`transaction.created`{% endif %}| `Date Modified`          | `DateModified`         |
|                                                                                                   | `Provider`                      | `Provider`              |
|                                                                                                   | `Type`                          | `Type`                  |
| `transaction.amount`                                                                              | `Amount`                        | `Amount`                |
|                                                                                                   | `Currency`                      | `Currency`              |
|                                                                                                   | `Product Number`                | `MerchantProductNo`     |
|{% unless documentation_section=="mobile-pay" %} `transaction.description` {% endunless %}         | `Description`                   | `Description`           |
|{% unless operation_title == "sale" %} `transaction.vatAmount` {% endunless %}                     | `VAT Amount`                    | `VATAmount`             |
|                                                                                                   |  `VAT Percentage`               | `VatoPercentage`        |
|                                                                                                   | `Credit Card Batch Number`      | `CreditCardBatchNo`     |
|{% if documentation_section=="card" or documentation_section=="payment-menu" or documentation_section=="checkout" %}`transaction.number` if DirectDebit {% endif%}| `Direct Debit Bank Reference`   | `DirectDebitbankRef`    |                                                            |
|{% if documentation_section=="card" or documentation_section=="payment-menu" or documentation_section=="checkout" %}`transaction.number` if DirectDebit {%endif%}| `Reference`                     | `Reference`             |                                                             |
|                                                                                                   | `Swedbank Account Number`       | `SwedbankAccountNo`     |
|{% unless operation_title=="reversal" %}`transaction.number` if reversed later{% endunless %}      | `Referenced Transaction Number` |`ReferencedTransaction`  |
|                                                                                                   | `Sales Channel`                 | `SalesChannel`          |
|                                                                                                   | `Brand`                         |                         |
|                                                                                                   | `Point Of Sale`                 |                         |
