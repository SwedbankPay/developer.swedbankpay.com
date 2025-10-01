{%- assign prices_kind=include.kind | default: 'CreditCard' -%}
{%- capture url -%}
    {%- include utils/documentation-section-url.md
        href='/technical-reference/prices' -%}
{%- endcapture -%}
{%- capture text -%}
{%- case kind -%}
{%- when 'CreditCard' -%}
Use the generic type `CreditCard` if you want to enable all card brands
supported by merchant contract. Use card brands like `Visa` (for card type
Visa), `MasterCard` (for card type MasterCard) and others if you want to specify
different amount for each card brand. If you want to use more than one amount
you must have one instance in the `prices` field for each card brand. You will
not be allowed to both specify card brands and CreditCard at the same time in
this field.
{%- when 'MobilePay' -%}
`MobilePay` (for supporting all card types configured at Swedbank Pay). If you
need to specify what card brands you want to support you may specify this by
sending in the card brand, e.g `Dankort` (for card type Dankort), `Visa` (for
card type Visa), `MasterCard` (for card type Mastercard) and `Maestro` (for card
type Maestro).
{%- else -%}
Use the value `{{ kind }}`.
{%- endcase -%}
See the [`prices` resource]({{ url }}) for more information.
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
