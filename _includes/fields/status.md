{%- capture url -%}
    {%- include documentation-section-url.md
        href='/technical-reference/resource-sub-models' -%}
{%- endcapture -%}

{%- capture text -%}
Indicates the payment order's current status. `Initialized` is returned when the
payment is created and still ongoing.

The request example above has this status. `Paid` is returned when the payer has
completed the payment successfully. [See the `Paid` section for further
information]({{ url }}#paid).

`Failed` is returned when a payment has failed. You will find an error message
in the failed section. [Further information here]({{ url }}#failed). `Cancelled`
is returned when an authorized amount has been fully cancelled. [See the cancel
feature section for further information]({{ url }}#cancelled).

It will contain fields from both the cancelled description and paid section.
`Aborted` is returned when the merchant has aborted the payment or if the payer
cancelled the payment in the redirect integration (on the redirect page). [See
the Abort feature section for further information]({{ url }}#aborted).
{%- endcapture -%}
{%- comment -%}
The following chain of Liquid filters converts newlines to spaces and removes
extranous spaces.
{%- endcomment -%}
{{- text | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
