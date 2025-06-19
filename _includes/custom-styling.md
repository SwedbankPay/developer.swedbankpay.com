{% include alert.html type="warning" icon="warning" body="This feature is only
available for merchants who have a specific agreement with Swedbank Pay." %}

Custom styling allows you to make adjustments to the payment UI so it blends
with your online store's existing design. It is available for all
implementations, but only when using Seamless View.

Please note that it is your responsibility that a custom styled payment UI still
meets the accessibility requirements (read more about WCAG by clicking the link
below).

## Customizable Elements

Our [accessibility compliant payment UI][wcag-presentation]{:target="_blank"}
follows the guidelines of [WCAG v2.2][wcag-documentation], so the elements you
can adjust are limited to the CTA button. Available changes are:

### The background color of the CTA button

The CTA button has three different states with different colors during the
payment process. They are all adjustable.

The states are **disabled** (before the payer has entered all their (valid)
details), **enabled** (after all details have been entered and they are valid)
and **hover** (when the payer hovers above the enabled button).

The default color will be light gray for **disabled**, black for **enabled** and
light brown for **hover**.

### CTA button text color

You can also change the button text so it blends well with the new background
color. The default is white (light gray for disabled).

### Border radius of the buttons

The border radius of the buttons are adjustable to create a harder rectangle or
a softer rounded shape, and better match your existing design.

The default value will be 8px, the minimum is 0px, and the maximum is 30px. We
also allow different values for each corner of the button.

Please note that we do not allow percentages as input. The value has to be in
`px`, `rem` or `em`.

## How To Customize

You can make the adjustments you want in the `style` object and include it in
the `style` node of the script that loads the UI.

Do you want to see the changes live before you put them to use? Stop by the
[Swedbank Pay Playground][playground]{:target="_blank"} and give it a go!

{:.code-view-header}
**Payment UI loading script**

```javascript
script.onload = function () {
     payex.hostedView.checkout({
          container: {
            checkout: '<<your-container-id>>'
          },
          culture: '<<your-culture>>',
          style: <<your-style-object>>
     }).open();
};
```

{:.code-view-header}
**Custom styling object**

```javascript
{
  "style": {
    "button": {
      "borderRadius": "8px",
       "enabled": {
        "backgroundColor": "#2F2424",
        "color": "#FFFFFF",
        "outline": "1px solid transparent",
        "hover": {
          "backgroundColor": "#72605E",
          "color": "#FFFFFF"
        }
      },
      "disabled": {
        "backgroundColor": "#EBE7E2",
        "color": "#72605E",
        "outline": "1px solid transparent"
      }
    },
    "secondaryButton": {
      "borderRadius": "8px",
      "enabled": {
        "backgroundColor": "#FFFFFF",
        "color": "#2f2424",
        "outline": "1px solid #72605e",
        "hover": {
          "backgroundColor": "#72605E"
        }
      },
      "disabled": {
        "backgroundColor": "#FFFFFF",
        "color": "#c0bebe"
      }
    }
  }
}
```

[contact]: mailto:sales.swedbankpay@swedbank.se
[playground]: https://playground.swedbankpay.com
[wcag-documentation]: https://www.w3.org/WAI/WCAG22/quickref/
[wcag-presentation]: https://www.swedbankpay.com/information/wcag
