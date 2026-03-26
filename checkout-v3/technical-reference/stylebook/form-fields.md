---
title: Form Fields
permalink: /:path/form-fields/
description: |
  Defines general behavior and requirements for form fields.
menu_order: 3300
---

# Form Fields

Form fields are used to collect user input and must be clear, accessible, and
forgiving.

This section defines general behavior and requirements for form fields.
Component-specific implementations are described in the relevant component
sections.

These guidelines apply to all form fields, including text inputs, selects, and
other input controls.

---

## Label placement

Form field labels are placed above the input field.

-   Labels are always visible.
-   Labels are not placed inside the input field.
-   Placeholder text must not be used as a replacement for labels.

Labels clearly describe the purpose of the field and remain visible when the
field is focused, filled, or in an error state.

---

### Vertical spacing

Form fields use consistent vertical spacing to maintain a clear visual hierarchy
and improve readability.

-   Spacing between label and input: `8px`
-   Spacing within a form field (error and help text): visually grouped with the input

The spacing between form fields follows the card content spacing.

---

## Text input

Text inputs are full-width and clearly defined using borders and spacing.

Inputs must:

-   Have visible labels
-   Provide clear focus indicators
-   Clearly communicate error states

### Visual properties

-   Background color: `#FFFFFF`
-   Text color: `#2F2424`
-   Border: `1px solid #A38B80`
-   Padding: `16px`
-   Border radius: `8px` (default)

### Validation success state

**Input**

-   Border color: `#31a3ae`
-   Success icon color: `#31a3ae`
-   A success icon is displayed inside the input on the right side

### Typography

Text inputs use the standard body text style defined in
[Typography](/checkout-v3/technical-reference/stylebook/typography/).

### Joined input pattern

Inputs may be visually joined to an adjacent element (for example an icon
container or action area). In this pattern, the adjacent border and radius
are removed to create a continuous combined control.

---

## Error handling

Validation errors are communicated using **multiple cues**:

-   A red input border
-   An error message below the field
-   A warning icon inside the field (right side)

Error states must not rely on color alone.

### Validation error state

When a field has a validation error:

**Input**

-   Border color: `#D82E2A`
-   A warning icon is displayed inside the input on the right side

**Error message**

-   The error message is displayed directly below the field.

**Error message typography**

-   Color: `#D82E2A`
-   Font: `0.875rem Arial`
-   Line height: `1.25rem`
-   Spacing above message: `8px`

The warning icon is supplementary; the error message text is required and must
be clear and specific.

---

## Disabled fields

Disabled fields are:

-   Clearly distinguishable
-   Readable
-   Not focusable or editable

---

### Accessibility

Form fields are designed to comply with WCAG 2.2 AA.

-   All fields and controls are operable using a keyboard only.
-   Focus order follows a logical reading order.
-   All fields have visible labels.
-   Error states are communicated using text in addition to visual styling.
-   Focus indicators are clearly visible during keyboard navigation.
-   Text remains readable when resized up to 200%.

For general accessibility requirements, see [Design Foundations](../design-foundations)
