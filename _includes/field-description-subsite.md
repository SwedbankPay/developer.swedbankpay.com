{%- capture text -%}
The `subsite` field can be used to perform split settlement on the payment. The
`subsite`s must be resolved with Swedbank Pay reconciliation before being used.
If you send in an unknown `subsite` value, it will be ignored and the payment
will be settled using the merchant's default settlement account.
{%- endcapture -%}
{{- text | strip_newlines -}}
