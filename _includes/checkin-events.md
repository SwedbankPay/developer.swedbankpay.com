{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

## Checkin Events

The Checkin Seamless View can inform about events that occur during Checkin
through JavaScript event callbacks which can be implemented in the
`configuration` object passed to the `payex.hostedView.consumer(configuration)`
object.

```mermaid
sequenceDiagram
  participant Consumer
  participant Merchant
  participant SwedbankPay as Swedbank Pay
  Consumer ->> Merchant: visit
  Merchant ->> Merchant: Prepare, Embed ClientScript
  Merchant ->> SwedbankPay: payex.hostedView.consumer().open()
  alt Configuration validation failure
    SwedbankPay -->> Merchant: onError
  end
  alt Identified consumer
      SwedbankPay->>Merchant: onConsumerIdentified
      alt Depending on backend response
        SwedbankPay->>Merchant: onShippingDetailsAvailable
        SwedbankPay->>Merchant: onBillingDetailsAvailable
      end
  end
  alt Change shipping address
    Consumer->>SwedbankPay: Click change shipping address button
    SwedbankPay->>Merchant: OnShippingDetailsAvailable
  end
```

## `onConsumerIdentified`

This event triggers when a consumer has performed Checkin and is identified,
if the Payment Menu is not loaded and in the DOM. The `onConsumerIdentified`
event is raised with the following event argument object:

{% capture response_content %}{
  "actionType": "OnConsumerIdentified",
  "consumerProfileRef": "{{ page.payment_token }}"
}{% endcapture %}

{% include code-example.html
    title='onConsumerIdentified event object'
    header=response_header
    json= response_content
    %}

## `onShippingDetailsAvailable`

Triggered when a consumer has been identified or shipping address has been
updated.
{% include alert.html type="informative" icon="info" body= "The Checkin must be
completed before any shipping details are finalized, as the Checkin component
provides shipping address via the `onShippingDetailsAvailable` event." %}

{% capture response_content %}{
  "actionType": "OnShippingDetailsAvailable",
  "url": "/psp/consumers/{{ page.payment_token }}/shipping-details"
}{% endcapture %}

{% include code-example.html
    title='onShippingDetailsAvailable event object'
    header=response_header
    json= response_content
    %}

## `onBillingDetailsAvailable`

Triggered when a consumer has been identified.

{% capture response_content %}{
  "actionType": "OnBillingDetailsAvailable",
  "url":"/psp/consumers/{{ page.payment_token }}/billing-details"
}{% endcapture %}

{% include code-example.html
    title='onBillingDetailsAvailable event object'
    header=response_header
    json= response_content
    %}
