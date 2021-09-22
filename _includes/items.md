## Items

The `items` field of the `paymentOrder` is an array containing items that will affect how the payment is performed.

{% include alert.html type="warning" icon="warning" header="MobilePay"
body="Please note that the MobilePay `shoplogoUrl` is mandatory. If you don't want to include it in your payment order request it needs to be configured in the contract setup." %}

{:.table .table-striped}
| Required | Field                          | Type      | Description                                                                                                                                           |
| :------: | :----------------------------- | :-------- | :---------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | `creditCard`                   | `object`  | The card object.                                                                                                                               |
|          | └➔&nbsp;`rejectDebitCards`     | `bool`    | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.     |
|          | └➔&nbsp;`rejectDebitCards`     | `bool`    | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.     |
|          | └➔&nbsp;`rejectCreditCards`    | `bool`    | `true` if credit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.    |
|          | └➔&nbsp;`rejectConsumerCards`  | `bool`    | `true` if consumer cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.  |
|          | └➔&nbsp;`rejectCorporateCards` | `bool`    | `true` if corporate cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request. |
|          | `swish`                        | `object`  | The Swish object.                                                                                                                                     |
|          | └➔&nbsp;`enableEcomOnly`       | `bool`    | `true` to enable Swish in e-commerce view only.                                                                                                |
|          | `mobilePay`                    | `object`  | The MobilePay object.                                                                                                                                     |
|          | └➔&nbsp;`shoplogoUrl`       | `string`    | URI to the logo that will be visible at MobilePay Online. For it to be displayed correctly in the MobilePay app, the image must be 250x250 pixels, a png or jpg served over a secure connection using https, and be publicly available. This URI can also be configured in the contract setup.                                                |
