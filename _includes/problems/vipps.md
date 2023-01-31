### Vipps Problems

There are a few problems specific to the `vipps` resource that you may want to
guard against in your integrations. All Vipps problem types will have the
following URL structure:

`https://api.payex.com/psp/errordetail/vipps/<error-type>`

#### Problem Types from Vipps (Init-call)

{% capture collapsible_table %}
{:.table .table-striped}
| Type          | Status | Note       |
| :------------ | :----- | :--------- |
| `vipps_error` | `403`  | All errors |
{% endcapture %}
{% include accordion-table.html content = collapsible_table %}

#### Problem Types from Vipps (Callback)

{% capture collapsible_table %}
{:.table .table-striped}
| Type             | Status | Note                              |
| :--------------- | :----- | :-------------------------------- |
| `vipps_declined` | `400`  | Any status that is not successful |
{% endcapture %}
{% include accordion-table.html content = collapsible_table %}

#### Problem Types from Acquirer

{% capture collapsible_table %}
{:.table .table-striped}
| Type                          | Status |
| :---------------------------- | :----- |
| `card_blacklisted`            | `400`  |
| `acquirer_card_blacklisted`   | `403`  |
| `acquirer_card_expired`       | `403`  |
| `acquirer_card_stolen`        | `403`  |
| `acquirer_error`              | `403`  |
| `acquirer_insufficient_funds` | `403`  |
| `acquirer_invalid_amount`     | `403`  |
| `acquirer_possible_fraud`     | `403`  |
| `card_declined`               | `403`  |
| `fraud_detected`              | `403`  |
| `payment_token_error`         | `403`  |
| `bad_request`                 | `500`  |
| `internal_server_error`       | `500`  |
| `unknown_error`               | `500`  |
| `acquirer_gateway_error`      | `502`  |
| `bad_gateway`                 | `502`  |
| `acquirer_gateway_timeout`    | `504`  |
{% endcapture %}
{% include accordion-table.html content = collapsible_table %}
