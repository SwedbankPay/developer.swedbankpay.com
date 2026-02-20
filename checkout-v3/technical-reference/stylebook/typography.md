---
title: Typography
permalink: /:path/typography/
description: |
  Defines typographic styles used across the payment UI.
menu_order: 1200
---

# Typography

This section defines typographic styles used across the payment UI.
Typography styles are applied consistently through components and states.

Font sizes are defined using `rem` units to ensure that text scales according to
user browser settings and accessibility requirements. Pixel values are provided
as a visual reference based on the original design specifications.

---

## Font families

- Headings: `Swedbank Headline`
- Body text: `Arial`

Ligatures are disabled:
- `'liga' off`
- `'clig' off`

---

## Title

Used for:
- Card titles
- Section headers in mobile layouts

**Properties**
- Font family: `Swedbank Headline`
- Font size: `1.25rem` (20px)
- Font weight: `700`
- Line height: `1.4` (28px)
- Color: `#2F2424`

---

## Body text

Used for:
- Descriptions
- Instructions
- Supporting text

**Properties**
- Font family: `Arial`
- Font size: `1rem` (16px)
- Font weight: `400`
- Line height: `1.5` (24px)
- Color: `#2F2424`

---

## Links

Links are visually distinguishable from body text and clearly indicate
interactivity.

Links must:
- Meet contrast requirements
- Have visible focus indicators
- Not rely on color alone where ambiguity could occur
