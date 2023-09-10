## Custom Styling

{% include alert.html type="warning" icon="warning" body="This feature is only
available for merchants who have a specific agreement with Swedbank Pay." %}

Custom styling allows you to make adjustments to the payment UI for an even
better fit with your company's profile. The arrival of our WCAG compliant
payment UI (LINK TO PRESENTATION PAGE) gives you fewer customization options
than before, but there are still some adjustments you can do.

WHICH IMPLEMENTATIONS SUPPORT CUSTOM STYLING??

*   **The background color of the primary button**

The primary button has several different states with different colors during the
payment process. They are all adjustable.

The states are **disabled** (before the payer has entered all their (valid)
details), **enabled** (after all details have been entered and they are valid),
**hover** (when the payer hovers above the button), **enabled-focus** (similar
to enabled, but with a border) and **enabled-loading-focus** (when the button is
in focus and clicked, so the payment is processing).

(HIGH RES SCREENSHOT OF BUTTONS)

The default color will be light gray for **disabled**, and
**enabled-loading-focus**, black for **enabled** and **enabled-focus**, and
light brown for **hover**. Your styling options are limited to... (NEEDS VERIFICATION FOR BOTH COLORS AND LIMITATIONS)

*   **Primary button text color**

You can also change the button text so it blends well with the new button color.

The default is white (gray for disabled), and your are limited to.... (NEEDS VERIFICATION FOR BOTH COLORS AND LIMITATIONS)

(HIGH RES SCREENSHOT OF TEXT COLORS)

*   **Border radius of the buttons**

The border radius of the buttons are adjustable to make it a harder rectangle or
a softer rounded shape, so it fits better with your company profile.

The default value will be 8px, the minimum is 0px, and the maximum is 30px,
giving these results respectively.

(HIGH RES SCREENSHOT)

We also allow different values for the same button, so the result can look like
this.

(HIGH RES SCREENSHOT)

Please note that we do not allow percentages as input. The value has to be in px
(rem or em). (REM OR EM MUST BE EXPLAINED)

## How To Customize

Contact us (CONTACT/MAIL LINK) to get the agreement needed to do custom styling.
When that is done, all you have to do is make the adjustments you want in the
styling object below and include it in your request.

Do you want to see the changes live before you put them to use? Stop by our
playground (LINK TO PLAYGROUND) and have a go!

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

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
