{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

{% if api_resource == "paymentorders" %}
    {% assign product="Payment Menu" %}
{% else %}
    {% assign product="Seamless View" %}
{% endif %}

## {{ product }} Events

During operation in the {{ product }}, several events can occur. They are
described below.

{% include alert.html type="warning" icon="info" header="Event Overrides"
body="Adding an event handler to one of the following events **overrides** the
default event handler, meaning your custom event handler will have to do what
the default event handler did. If you don’t, the behavior of the event is going
to be undefined. Just adding an event handler for logging purposes is therefore
not possible, the event handler will have to perform some functionality similar
to the event handler you are overriding." %}

## `onApplicationConfigured`

This event triggers whenever a reconfiguration leads to resizing of the payment
menu. No action will be done if callback is not set. The
`onApplicationConfigured` event is raised with the following event argument
object:

{% capture response_content %}{
    "actionType": "OnApplicationConfigured",
    "bodyHeight": "[clientHeight of iframe content]",
    "paymentOrderId": "/psp/paymentorders/{{ page.payment_id }}",
    "source": "PaymentMenuCore"
}{% endcapture %}

{% include code-example.html
    title='onApplicationConfigured event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field     | Type     | Description                                                          |
| :-------- | :------- | :------------------------------------------------------------------- |
| `actionType` | `string` | The type of event that was raised.                                  |
| `bodyHeight` | `string` | The height of the client's iframe content.                          |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}              |
| `source` | `string` | The source of the reconfiguration                                       |

## `onError`

This event triggers during terminal errors or if the configuration fails
validation. The `onError` event will be raised with the following event argument
object:

{% capture response_content %}{
    "bodyType": "OnError",
    "details": "English descriptive text of the error",
    "origin": "{{ api_resource }}",
    "paymentOrderId:": "/psp/paymentorders/{{ page.payment_id }}"
}{% endcapture %}

{% include code-example.html
    title='onError event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field       | Type     | Description                                                    |
| :---------- | :------- | :------------------------------------------------------------- |
| `bodyType` | `string` | The type of event that was raised.                                      |
| `details`   | `string` | A human readable and descriptive text of the error.                    |
| `origin`    | `string` | `{{ api_resource }}`, identifies the system that originated the error. |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}                |

## `onExternalRedirect`

This event triggers when a user is redirected to a separate web page, like
3D-Secure or BankID signing.

Subscribe to this event if it's not possible to redirect the payer directly from
within Swedbank Pay's payment frame.

If no callback method is set, you will be redirected to the relevant url. It
will be raised with the following event argument object:

{% capture response_content %}{
    "actionType": "OnExternalRedirect",
    "paymentOrderId:": "/psp/paymentorders/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/external"
}{% endcapture %}

{% include code-example.html
    title='onExternalRedirect event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `actionType` | `string` | The type of event that was raised.                                    |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}                |
| `redirectUrl` | `string` | The external URL where the user will be redirected.                  |

## `onOutOfViewOpen`

{% include events/on-out-of-view-open.md %}

The event cannot be opened as a modal since the payer needs to see that this is
a link on Swedbank Pay's domain.

Subscribe to this event if you do not want the default handling of these links.
But e.g. want to redirect the payer to a new page, and not just another tab
within the same browser.

If no callback method is set, the url will be opened in a
new tab. It will be raised with the following event argument object:

{% capture response_content %}{
    "actionType": "OnOutOfViewOpen",
    "openUrl": "https://example.com/external",
    "paymentOrderId:": "/psp/paymentorders/{{ page.payment_id }}"
}{% endcapture %}

{% include code-example.html
    title='onOutOfViewOpen event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `actionType` | `string` | The type of event that was raised.                                    |
| `openUrl`    | `string` | The external URL where the user will be redirected.                   |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}                |

## `onPaymentCanceled`

This event triggers when the payer aborts the purchase from the payment menu. As
the Seamless View payment menu doesn't have a cancel button (present in the
Redirect integration), you need to provide this button for the payer at your
end. When the payer presses the cancel button, we recommend sending an API
request aborting the payment so it can't be completed at a later time. When we
receive the request, an abort event will be raised the next time the UI fetches
information from the server. Because of that, you should also refresh after
aborting, as this will trigger the event.

It will be raised with the following event argument object:

{% capture response_content %}{
    "actionType": "OnPaymentCanceled",
    "id": "/psp/{instrument}/payments/{{ page.payment_id }}",
    "paymentOrderId": "/psp/paymentorders/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/cancelled"
}{% endcapture %}

{% include code-example.html
    title='onPaymentCanceled event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field         | Type     | Description                                                     |
| :------------ | :------- | :-------------------------------------------------------------  |
| `actionType` | `string` | The type of event that was raised.                               |
| `id`         | `string` | {% include fields/id.md %}                                       |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}           |
| `redirectUrl` | `string` | The URL the user will be redirect to after a cancelled payment. |

## `onPaymentCompleted`

This event triggers when the payer successfully completes or cancels the
payment.

Subscribe to this event if actions are needed on you side other than the default
handling of redirecting the payer to your `completeUrl`. Call GET on the
`paymentOrder` to receive the actual payment status, and take appropriate
actions according to it.

It will be raised with the following event argument object:

{% capture response_content %}{
    "actionType": "OnPaymentCompleted",
    "id": "/psp/{instrument}/payments/{{ page.payment_id }}",
    "paymentOrderId": "/psp/paymentorders/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/success"
}{% endcapture %}

{% include code-example.html
    title='onPaymentCompleted event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field         | Type     | Description                                                         |
| :------------ | :------- | :-------------------------------------------------------------      |
| `actionType` | `string` | The type of event that was raised.                                   |
| `id`         | `string` | {% include fields/id.md %}                                           |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}               |
| `redirectUrl` | `string` | The URL the user will be redirect to after completing the payment.  |

## `onPaymentCreated`

{% include events/on-payment-created.md %}

The `onPaymentCreated` event is raised with the following event argument object:

{% capture response_content %}{
    "bodyType": "OnPaymentCreated",
    "id": "/psp/{instrument}/payments/{{ page.payment_id }}",
    "instrument": "creditcard",
    "paymentOrderId": "/psp/paymentorders/{{ page.payment_id }}"
}{% endcapture %}

{% include code-example.html
    title='onPaymentCreated event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field        | Type     | Description                                                                                     |
| :----------- | :------- | :---------------------------------------------------------------------------------------------- |
| `bodyType` | `string` | The type of event that was raised.                                                                |
| `id`         | `string` | {% include fields/id.md %}                                                                      |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The payment method selected when initiating the payment. |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}                                          |

## `onPaymentFailed`

{% include events/on-payment-failed.md %}

The `onPaymentFailed` event is raised with the following event argument object:

{% capture response_content %}{
    "actionType": "OnPaymentFailed",
    "id": "/psp/{instrument}/payments/{{ page.payment_id }}",
    "paymentOrderId": "/psp/paymentorders/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/failed"
}{% endcapture %}

{% include code-example.html
    title='onPaymentFailed event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field         | Type     | Description                                                  |
| :------------ | :------- | :----------------------------------------------------------- |
| `actionType` | `string` | The type of event that was raised.                            |
| `id`         | `string` | {% include fields/id.md %}                                    |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}        |
| `redirectUrl` | `string` | The URL the user will be redirect to after a failed payment. |

## `onPaymentMenuInstrumentSelected`

This event triggers when a user actively changes payment method in the
Payment Menu.

Subscribe to this event if actions, e.g. showing an information text, are
required on your side if the payer changes payment method.

If no callback method is set, no handling action will be done. It
will be raised with the following event argument object:

{% capture response_content %}{
    "bodyType": "OnPaymentMenuInstrumentSelected",
    "paymentOrderId": "/psp/paymentorders/{{ page.payment_id }}",
    "instrument": "creditcard | vipps | swish | invoice"
}{% endcapture %}

{% include code-example.html
    title='onPaymentMenuInstrumentSelected event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field        | Type     | Description                                                                     |
| :----------- | :------- | :-----------------------------------------------------------------------------  |
| `bodyType` | `string` | The type of event that was raised.                                                |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}                          |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The payment method selected by the user. |

## `onPaymentPending`

{% include events/on-payment-pending.md %}

Read more about these events below.

{% capture response_content %}{
    "bodyType": "OnPaymentPending",
    "id": "/psp/{instrument}/payments/{{ page.payment_id }}",
    "paymentOrderId": "/psp/paymentorders/{{ page.payment_id }}"
}{% endcapture %}

{% include code-example.html
    title='onPaymentPending event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field         | Type     | Description                                                     |
| :------------ | :------- | :-------------------------------------------------------------- |
| `bodyType` | `string` | The type of event that was raised.                                 |
| `id`          | `string` | {% include fields/id.md %}                                      |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}           |

## `onPaymentToS`

This event triggers when the user clicks on the "Display terms and conditions"
link. The `onPaymentToS` event is raised with the following event
argument object:

{% capture response_content %}{
    "actionType": "OnPaymentToS",
    "openUrl": "https://example.com/terms-of-service",
    "origin": "Merchant",
    "paymentOrderId": "/psp/paymentorders/{{ page.payment_id }}"
}{% endcapture %}

{% include code-example.html
    title='onPaymentToS event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field     | Type     | Description                                                                             |
| :-------- | :------- | :-------------------------------------------------------------------------------------- |
| `actionType` | `string` | The type of event that was raised.                                                   |
| `openUrl` | `string` | The URL containing Terms of Service and conditions.                                     |
| `origin`  | `string` | `owner`, `merchant`. The value is always `Merchant` unless Swedbank Pay hosts the view. |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %}                               |

## `onPaymentTransactionFailed`

{% include events/on-payment-transaction-failed.md %}

An error message will appear in the payment UI, and the payer will be able to
try again or choose another payment method. The `onPaymentTransactionFailed`
event is raised with the following event argument object:

{% capture response_content %}{
    "bodyType": "OnPaymentTransactionFailed",
    "id": "/psp/{instrument}/payments/{{ page.payment_id }}",
    "paymentOrderId": "/psp/paymentorders/{{ page.payment_id }}",
    "details": "[HttpCode ProblemTitle]"
}{% endcapture %}

{% include code-example.html
    title='onPaymentTransactionFailed event object'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field     | Type     | Description                                         |
| :-------- | :------- | :-------------------------------------------------- |
| `bodyType` | `string` | The type of event that was raised.                       |
| `id`          | `string` | {% include fields/id.md %}                            |
| `paymentOrderId` | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `details` | `string` | A human readable and descriptive text of the error.       |

## Updating Payment Menu

When the contents of the shopping cart changes or anything else that affects
the amount occurs, the `paymentorder` must be updated and the Payment Menu
must be `refresh`ed.
