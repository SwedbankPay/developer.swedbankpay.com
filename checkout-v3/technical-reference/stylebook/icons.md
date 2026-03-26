---
title: Icons
permalink: /:path/icons/
description: |
 Defines general rules for icon usage across the payment UI.
menu_order: 3400
---

# Icons

Icons support recognition and comprehension. They are used sparingly and never
as the sole carrier of information.

This section defines general rules for icon usage across the payment UI.
Component-specific icon usage is described in the relevant component sections.

---

## Icon style

- Flat icons
- No shadows or decorative effects
- Clear, recognizable shapes

---

## Sizes

Icon sizes are defined per usage context to ensure consistent alignment and
touch target behavior.

Icons must not be resized outside of these definitions.

### Payment method icons
- Fixed height: `40px`
- Width: auto (maintain aspect ratio)

### Inline / action icons
- Fixed size: `24×24px`

---

## Color usage

Icon colors follow functional color roles:
- Default: text color
- Muted: muted text color
- Interactive: primary color

Icons must meet non-text contrast requirements (3:1).

---

### Accessibility

Icons are designed to support comprehension and must not replace text. Icons may be decorative or interactive. Decorative icons do not receive focus
and do not convey essential information.

- Interactive icons are operable using a keyboard.
- Interactive icons have visible focus indicators.
- Decorative icons are hidden from assistive technology.

For general accessibility requirements, see [Design Foundations](../design-foundations)
