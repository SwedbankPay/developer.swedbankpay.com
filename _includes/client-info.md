The `clientInfo` resource contains information about the client used for a
specific payment.

## GET Request

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_id }}/clientInfo HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

## GET Response Excerpt

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "clientInfo": {
      "clientType": "NATIVE",
      "platformName": "SALESFORCE",
      "presentationSdkName": "IOS",
      "presentationSdkVersion": "5.0.0",
      "integrationModuleName": "WOOCOMMERCE",
      "integrationModuleVersion": "1.0.0",
      "integrationSdkName": "DOTNET",
      "integrationSdkVersion": "3.0.0"
    }
}{% endcapture %}

{% include code-example.html
    title='Response clientInfo Excerpt'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field                     | Type                 | Description                                                                                                                                                                                                                                                                       |
| :------------------------ | :------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f clientInfo, 0 %}           | `object`     | The `clientInfo` object.                                                                                                                                                                                                 |
| {% f clientType %}           | `string`     | Can be `WEB` or `NATIVE`. Identifies the client type used to process the payment. This value is set by the app SDK code or the javascript UI code.                                                                                                                                                                               |
| {% f platformName %}           | `string`     | Identifies the commercial platform used to process the payment. This value is set by the merchant. Examples can be `ORACLE`, `OPTIMIZELY`, `SALESFORCE` etc.                                                                                                                          |
| {% f presentationSdkName %}           | `string`     | Can be `IOS`, `WEB` or `ANDROID`. Identifies the kind of SDK used to process the payment. This value is set by the frontend SDK.                                                                                                                                      |
| {% f presentationSdkVersion %}           | `string`     | Identifies which version of the SDK that is used to process the payment. This value is set by the frontend SDK.                                                                                                                                      |
| {% f integrationModuleName %}           | `string`     | Can be `WOOCOMMERCE`. Identifies the kind of module use used to process the payment. This value is set by the module.                                                                                                                                      |
| {% f integrationModuleVersion %}           | `string`     |  Identifies which version of the module that is used to process the payment. This value is set by the frontend.                                                                                                                                      |
| {% f integrationSdkName %}           | `string`     |  Can be `DOTNET` or `PHP`. Identifies which kind of SDK that is used to process the payment. This value is set by the integration SDK.                                                                                                                                      |
| {% f integrationSdkVersion %}           | `string`     |  Identifies which version of the SDK that is used to process the payment. This value is set by the integration SDK.                                                                                                                                      |
