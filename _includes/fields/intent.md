{%- capture features_url -%}{%- include utils/documentation-section-url.md href='/features' -%}{%- endcapture -%}
{%- capture cancel_url -%}
    {%- if features_url contains "checkout-v3" -%}
        {%- include utils/documentation-section-url.md
        href='/features/payment-operations/cancel' -%}
    {%- else -%}
    {%- include utils/documentation-section-url.md
        href='/features/core/cancel' -%}
    {%- endif -%}
{%- endcapture -%}
{%- capture capture_url -%}
    {%- if features_url contains "checkout-v3" -%}
        {%- include utils/documentation-section-url.md
        href='/features/payment-operations/' -%}
    {%- else -%}
    {%- include utils/documentation-section-url.md
        href='/features/core/' -%}
    {%- endif -%}
    {%- if features_url contains "payment-instruments" -%}
        capture
    {%- else -%}
        payment-order-capture
    {%- endif -%}
{%- endcapture -%}
{%- capture text -%}
The intent of the payment identifies how and when the charge will be
effectuated. This determines the transactions types used during the payment
process.

`Authorization`. Reserves the amount, and is followed by a {% clink cancellation
%}{{ cancel_url }}{% endclink %} or {% clink capture %}{{ capture_url }}{%
endclink %} of funds.

`AutoCapture` is a one phase-option that enable capture of funds automatically
after authorization.
{%- endcapture -%}
{%- comment -%}
The following chain of Liquid filters converts newlines to spaces and removes
extranous spaces.
{%- endcomment -%}
{{- text | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%} The dashes in the Liquid code tags remove output space.
More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
