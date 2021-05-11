## Items

The `items` field of the `paymentOrder` is an array containing items that will affect how the payment is performed.

{% include alert.html type="warning" icon="warning" header="MobilePay"
body="Please note that the MobilePay `shoplogoUrl` is mandatory. If you have an
existing integration and wish to add MobilePay, you need to include this field in
your payment order request." %}

{:.table .table-striped}
| Required | Field                          | Type      | Description                                                                                                                                           |
| :------: | :----------------------------- | :-------- | :---------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | `creditCard`                   | `object`  | The card object.                                                                                                                               |
|          | └➔&nbsp;`rejectDebitCards`     | `bool`    | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.     |
|          | └➔&nbsp;`rejectDebitCards`     | `bool`    | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.     |
|          | └➔&nbsp;`rejectCreditCards`    | `bool`    | `true` if credit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.    |
|          | └➔&nbsp;`rejectConsumerCards`  | `bool`    | `true` if consumer cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.  |
|          | └➔&nbsp;`rejectCorporateCards` | `bool`    | `true` if corporate cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request. |
|          | `invoice`                      | `object`  | The invoice object.                                                                                                                                   |
|          | └➔&nbsp;`feeAmount`            | `integer` | The fee amount in the lowest monetary unit. Applied if the payer chooses to pay with invoice.                                                      |
|          | `swish`                        | `object`  | The Swish object.                                                                                                                                     |
|          | └➔&nbsp;`enableEcomOnly`       | `bool`    | `true` to enable Swish in e-commerce view only.                                                                                                |
|          | `mobilePay`                    | `object`  | The MobilePay object.                                                                                                                                     |
| {% icon check %} | └➔&nbsp;`shoplogoUrl`       | `string`    | Mandatory if MobilePay is to be included as an option. URI to the logo that will be visible at MobilePay Online. For it to be displayed correctly in the MobilePay app, the image must be 250x250 pixels, a png or jpg served over a secure connection using https, and be publicly available.                                                 |
