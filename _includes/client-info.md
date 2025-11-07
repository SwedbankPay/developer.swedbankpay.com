The `clientInfo` resource contains information about the client used for a specific payment.

## GET Request

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/clientInfo HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='GET Request'
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

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f clientInfo, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The <code>clientInfo</code> object.
      </div>
    </div>

    <div class="api-children" data-level="1">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f clientType, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Can be <code>WEB</code> or <code>NATIVE</code>. Identifies the client type used to process the payment. This value is set by the app SDK code or the javascript UI code.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f platformName, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Identifies the commercial platform used to process the payment. This value is set by the merchant. Examples can be <code>ORACLE</code>, <code>OPTIMIZELY</code>, <code>SALESFORCE</code> etc.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f presentationSdkName, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Can be <code>IOS</code>, <code>WEB</code> or <code>ANDROID</code>. Identifies the kind of SDK used to process the payment. This value is set by the frontend SDK.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f presentationSdkVersion, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Identifies which version of the SDK that is used to process the payment. This value is set by the frontend SDK.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integrationModuleName, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Can be <code>WOOCOMMERCE</code>. Identifies the kind of module used to process the payment. This value is set by the module.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integrationModuleVersion, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Identifies which version of the module that is used to process the payment. This value is set by the frontend.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integrationSdkName, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Can be <code>DOTNET</code> or <code>PHP</code>. Identifies which kind of SDK that is used to process the payment. This value is set by the integration SDK.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integrationSdkVersion, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Identifies which version of the SDK that is used to process the payment. This value is set by the integration SDK.
          </div>
        </div>
      </details>
    </div>
  </details>
</div>
