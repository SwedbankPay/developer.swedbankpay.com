## Items

The `items` field of the `paymentOrder` is an `array` containing items that will
affect how the payment is performed.

{% include alert.html type="warning" icon="warning" header="MobilePay"
body="Please note that by adding the `shoplogoUrl` field, the default logo-url configured during contract setup will be overridden for this transaction. If logo-url is missing in the contract setup, it must be provided as an input parameter." %}

{% capture table %}
{:.table .table-striped .mb-5}
| Required | Field                          | Type      | Description                                                                                                                                           |
| :------: | :----------------------------- | :-------- | :---------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | `creditCard`                   | `object`  | The card object.                                                                                                                               |
|          | {% f rejectDebitCards %}     | `bool`    | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.     |
|          | {% f rejectDebitCards %}     | `bool`    | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.     |
|          | {% f rejectCreditCards %}    | `bool`    | `true` if credit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.    |
|          | {% f rejectConsumerCards %}  | `bool`    | `true` if consumer cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.  |
|          | {% f rejectCorporateCards %} | `bool`    | `true` if corporate cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request. |
|          | `swish`                        | `object`  | The Swish object.                                                                                                                                     |
|          | {% f enableEcomOnly %}       | `bool`    | `true` to enable Swish in e-commerce view only.                                                                                                |
|          | `mobilePay`                    | `object`  | The MobilePay object.                                                                                                                                     |
|          | {% f shoplogoUrl %}       | `string`    | URI to the logo that will be visible at MobilePay Online. For it to be displayed correctly in the MobilePay app, the image must be 250x250 pixels, a png or jpg served over a secure connection using https, and be publicly available. This URI will override the value configured in the contract setup.                                                |
{% endcapture %}
{% include accordion-table.html content=table %}
