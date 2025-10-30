
undefined behavior or, at worst, a broken payment flow." %}

## `onAborted`

{% include events/on-aborted.md %}

{% capture response_content %}{
    "event": "OnAborted",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "redirectUrl": "https://example.com/cancelled"
}{% endcapture %}

    %}

{:.table .table-striped}

| Field         | Type     | Description                                                     |
| :------------ | :------- | :-------------------------------------------------------------  |
| `event`       | `string` | The name of the event raised.                                            |
| {% f paymentOrder.id, 0 %}          | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `redirectUrl` | `string` | The URL the user will be redirect to after a cancelled payment.          |

## `onCheckoutLoaded`

{% include events/on-checkout-loaded.md %}

{% capture response_content %}{
    "event": "OnCheckoutLoaded",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "bodyHeight": "[clientHeight of iframe content]"
}{% endcapture %}


    %}

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                                  |
| `event`      | `string` | The name of the event raised.                                            |
| {% f paymentOrder.id, 0 %}         | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `bodyHeight` | `string` | The height of the client's iframe content.                               |

## `onCheckoutResized`

{% include events/on-checkout-resized.md %}

{% capture response_content %}{
    "event": "OnCheckoutResized",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "bodyHeight": "[clientHeight of iframe content]"
}{% endcapture %}


    json= response_content
    %}

{:.table .table-striped}

| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                         |
| {% f paymentOrder.id, 0 %}     | `string` | {% include fields/id.md resource="paymentOrder" %}  |
| `bodyHeight` | `string` | The height of the client's iframe content.                            |

## `onError`

{% include events/on-error.md %}

{% capture response_content %}{
    "event": "OnError",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "details": "English descriptive text of the error"
}{% endcapture %}


    %}

{:.table .table-striped}

| Field       | Type     | Description                                                            |
| :---------- | :------- | :-------------------------------------------------------------         |
| `event`     | `string` | The name of the event raised.                                            |
| {% f paymentOrder.id, 0 %}        | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `details`   | `string` | A human readable and descriptive text of the error.                      |

## `onEventNotification`

{% include events/on-event-notification.md %}

 {% capture response_content %}{
     "event": "OnEventNotification",
     "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
     "sourceEvent": "OnPaid | OnFailed | OnAborted | OnPaymentAttemptAborted |
      OnOutOfViewReidrect | OnTermsOfServiceRequested | OnCheckoutResized |
      OnCheckoutLoaded | OnConsumerGuestSelected | OnInstrumentSelected |
      OnError | OnPaymentAttemptStarted | OnPaymentAttemptFailed"
 }{% endcapture %}


    %}

{:.table .table-striped}

| Field         | Type     | Description                                                |
| :--------     | :------- | :--------------------------------------------------------- |
| `event`     | `string` | The name of the event raised.                                            |
| {% f paymentOrder.id, 0 %}        | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `sourceEvent` | `string` | A human readable and descriptive text with the event name.             |

## `onInstrumentSelected`

{% include events/on-instrument-selected.md %}

{% capture response_content %}{
    "event": "OnInstrumentSelected",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "instrument": "creditcard | vipps | swish | invoice",
}{% endcapture %}


    %}

{:.table .table-striped}

| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`     | `string` | The name of the event raised.                                                    |
| {% f paymentOrder.id, 0 %}        | `string` | {% include fields/id.md resource="paymentOrder" %}         |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The payment method selected by the user. |

## `onOutOfViewOpen`

{% include events/on-out-of-view-open.md %}

{% capture response_content %}{
    "event": "OnOutOfViewOpen",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "openUrl": "https://example.com/external"
}{% endcapture %}

    %}

{:.table .table-striped}

| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                            |
| {% f paymentOrder.id, 0 %}         | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `openUrl`    | `string` | The external URL where the user will be redirected.                      |

## `onOutOfViewRedirect`

{% include events/on-out-of-view-redirect.md %}

{% capture response_content %}{
    "event": "OnOutOfViewRedirect",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "redirectUrl": "https://example.com/external"
}{% endcapture %}

    %}

{:.table .table-striped}

| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                                  |
| `event`      | `string` | The name of the event raised.                                            |
| {% f paymentOrder.id, 0 %}         | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `redirectUrl` | `string` | The external URL where the user will be redirected.                     |

## `onPaid`

{% include events/on-paid.md %}

{% capture response_content %}{
    "event": "OnPaid",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "redirectUrl": "https://example.com/success"
}{% endcapture %}

    %}

{:.table .table-striped}

| Field         | Type     | Description                                                         |
| :------------ | :------- | :-------------------------------------------------------------      |
| `event`       | `string` | The name of the event raised.                                            |
| {% f paymentOrder.id, 0 %}          | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `redirectUrl` | `string` | The URL the user will be redirected to after completing the payment.       |

## `onPaymentAttemptAborted`

This event mirrors `onPaymentAborted` from Checkout v2.

{% capture response_content %}{
    "event": "OnPaymentAttemptAborted",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "redirectUrl": "https://example.com/cancelled"
}{% endcapture %}

    %}

{:.table .table-striped}

| Field         | Type     | Description                                                    |
| :------------ | :------- | :------------------------------------------------------------- |
| `event`       | `string` | The name of the event raised.                                            |
| {% f paymentOrder.id, 0 %}          | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `redirectUrl` | `string` | The URL the user will be redirected to after a cancelled payment.          |

## `onPaymentAttemptFailed`

This event mirrors `onPaymentTransactionFailed` from Checkout v2.

{% capture response_content %}{
    "event": "OnPaymentAttemptFailed",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "details": "[HttpCode ProblemTitle]"
}{% endcapture %}


    %}

{:.table .table-striped}

| Field     | Type     | Description                                         |
| :-------- | :------- | :-------------------------------------------------- |
| `event`       | `string` | The name of the event raised.                                            |
| {% f paymentOrder.id, 0 %}          | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `details` | `string` | A human readable and descriptive text of the error.                          |

## `onPaymentAttemptStarted`

This event mirrors `onPaymentCreated` from Checkout v2.

{% capture response_content %}{
    "event": "OnPaymentAttemptStarted",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "instrument": "creditcard",
}{% endcapture %}


    %}

{:.table .table-striped}

| Field        | Type     | Description                                                                                     |
| :----------- | :------- | :---------------------------------------------------------------------------------------------- |
| `event`       | `string` | The name of the event raised.                                                                  |
| {% f paymentOrder.id, 0 %}          | `string` | {% include fields/id.md resource="paymentOrder" %}                       |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The payment method selected when initiating the payment. |

## `onTermsOfServiceRequested`

{% include events/on-terms-of-service-requested.md %}

 {% capture response_content %}{
     "event": "OnTermsOfServiceRequested",
     "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}"},
     "termsOfServiceUrl": "https://example.org/terms.html"
 }{% endcapture %}

    %}

{:.table .table-striped}

| Field                | Type     | Description                                         |
| :--------            | :------- | :---------------------------------------------------|
| `event`              | `string` | The name of the event raised.                                  |
| {% f paymentOrder.id, 0 %}       | `string` | {% include fields/id.md resource="paymentOrder" %} |
| `termsOfServiceUrl`  | `string` | The URL containing Terms of Service and conditions.            |
