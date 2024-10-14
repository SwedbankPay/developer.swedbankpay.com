{%- capture url -%}
    {%- include utils/documentation-section-url.md
        href='/features/technical-reference/resource-sub-models' -%}
{%- endcapture -%}

The `status` field indicates the payment order's current status. `Initialized`
is returned when the payment is created and still ongoing.

The request example above has this status. `Paid` is returned when the payer has
completed the payment successfully. See the [`Paid` section for further
information]({{ url }}#paid).

`Failed` is returned when a payment has failed. You will find an error message
in the failed section. [Further information here]({{ url }}#failed). `Cancelled`
is returned when an authorized amount has been fully cancelled. See the [`Cancel`
feature section for further information]({{ url }}#cancelled).

`Reversed` is returned when the full amount of a sale transaction or a captured
transaction has been reversed. The transaction will now have status `Reversed`
instead of `Paid`.
See the [`Reversed` section for further information]({{ url }}#reversed).

It will contain fields from both the cancelled description and paid section.
`Aborted` is returned when the merchant has aborted the payment or if the payer
cancelled the payment in the redirect integration (on the redirect page). [See
the Abort feature section for further information]({{ url }}#aborted).
